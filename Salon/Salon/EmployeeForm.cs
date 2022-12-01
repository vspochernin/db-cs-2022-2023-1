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
    public partial class EmployeeForm : Form
    {
        DataBase dataBase = new DataBase();
        public EmployeeForm()
        {
            InitializeComponent();
        }

        private void EmployeeForm_Load(object sender, EventArgs e)
        {
            // TODO: данная строка кода позволяет загрузить данные в таблицу "salonDataSet.showAllRecords". При необходимости она может быть перемещена или удалена.
            this.showAllRecordsTableAdapter.Fill(this.salonDataSet.showAllRecords);

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (recordIdBox.SelectedValue != null)
            {
                dataBase.openConnection();
                SqlDataAdapter adapter = new SqlDataAdapter();

                string recordQuery = $"select * from records where record_id = {(int)recordIdBox.SelectedValue}";
                SqlCommand recordCommand = new SqlCommand(recordQuery, dataBase.getConnection());
                DataTable recordTable = new DataTable();

                adapter.SelectCommand = recordCommand;
                adapter.Fill(recordTable);

                if (recordTable.Rows.Count > 0)
                {
                    textBox_title.Text = recordTable.Rows[0][1].ToString();
                    textBox_author.Text = recordTable.Rows[0][2].ToString();
                    textBox_price.Text = recordTable.Rows[0][3].ToString();
                    numericUpDown_count.Value = decimal.Parse(recordTable.Rows[0][4].ToString());
                }

                dataBase.closeConnection();
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            int recordId = 0;
            if (recordIdBox.SelectedValue != null)
            {
                recordId = (int)recordIdBox.SelectedValue;

                string removeRecordQuerry = $"removeRecord {recordId}";
                SqlCommand removeRecordCommand = new SqlCommand(removeRecordQuerry, dataBase.getConnection());

                if (removeRecordCommand.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Музыкальная запись успешно удалена!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.showAllRecordsTableAdapter.Fill(this.salonDataSet.showAllRecords);
                }
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

            string title = textBox_title.Text;
            string author = textBox_author.Text;
            string price = textBox_price.Text.Replace(",", ".");
            int count = (int)numericUpDown_count.Value;

            string addRecordQuery = $"addRecord '{title}', '{author}', {price}, {count}";
            SqlCommand addRecordCommand = new SqlCommand(addRecordQuery, dataBase.getConnection());

            if (addRecordCommand.ExecuteNonQuery() > 0)
            {
                MessageBox.Show("Музыкальная запись успешно добавлена!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.showAllRecordsTableAdapter.Fill(this.salonDataSet.showAllRecords);
            }

            dataBase.closeConnection();
        }

        private void updateRecordButton_Click(object sender, EventArgs e)
        {
            if (recordIdBox.SelectedValue != null)
            {
                dataBase.openConnection();

                int recordId = (int)recordIdBox.SelectedValue;
                string title = textBox_title.Text;
                string author = textBox_author.Text;
                string price = textBox_price.Text.Replace(",", ".");
                int count = (int)numericUpDown_count.Value;

                string updateRecordQuery = $"updateRecord {recordId}, '{title}', '{author}', {price}, {count}";
                SqlCommand updateRecordCommand = new SqlCommand(updateRecordQuery, dataBase.getConnection());

                if (updateRecordCommand.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Музыкальная запись успешно изменена!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.showAllRecordsTableAdapter.Fill(this.salonDataSet.showAllRecords);
                }

                dataBase.closeConnection();
            }
        }
    }
}
