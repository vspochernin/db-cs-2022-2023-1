using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Salon
{
    public partial class ClientForm : Form
    {
        DataBase dataBase = new DataBase();
        public ClientForm()
        {
            InitializeComponent();
        }

        private void ClientForm_Load(object sender, EventArgs e)
        {
            // TODO: данная строка кода позволяет загрузить данные в таблицу "salonDataSet.showAllRecords". При необходимости она может быть перемещена или удалена.
            this.showAllRecordsTableAdapter.Fill(this.salonDataSet.showAllRecords);
            this.showReviewsOfRecordTableAdapter.Fill(this.salonDataSet.showReviewsOfRecord, (int?)comboBox1.SelectedValue); ;
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.showReviewsOfRecordTableAdapter.Fill(this.salonDataSet.showReviewsOfRecord, (int?)comboBox1.SelectedValue); ;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

            string reviewText = reviewTextBox.Text;
            int recordId = (int)comboBox1.SelectedValue;
            string addReviewQuerry = $"exec addReview {recordId}, {Globals.curUserId}, '{reviewText}'";
            SqlCommand addReviewCommand = new SqlCommand(addReviewQuerry, dataBase.getConnection());
            if (addReviewCommand.ExecuteNonQuery() > 0)
            {
                MessageBox.Show("Отзыв добавлен!", "Успешно", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.showReviewsOfRecordTableAdapter.Fill(this.salonDataSet.showReviewsOfRecord, (int?)comboBox1.SelectedValue); ;
            }

            dataBase.closeConnection();
        }
    }
}
