using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Linq.Expressions;
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
            // TODO: данная строка кода позволяет загрузить данные в таблицу "salonDataSet.showAllStatuses". При необходимости она может быть перемещена или удалена.
            this.showAllStatusesTableAdapter.Fill(this.salonDataSet.showAllStatuses);
            // TODO: данная строка кода позволяет загрузить данные в таблицу "salonDataSet.showAllRecords". При необходимости она может быть перемещена или удалена.
            this.showAllRecordsTableAdapter.Fill(this.salonDataSet.showAllRecords);
            this.showReviewsOfRecordTableAdapter.Fill(this.salonDataSet.showReviewsOfRecord, (int)comboBox1.SelectedValue);
            this.showOrdersByClientIdTableAdapter.Fill(this.salonDataSet.showOrdersByClientId, Globals.curUserId);
            if (orderNumberBox.SelectedValue != null)
            {
                this.showOrderByIdTableAdapter.Fill(this.salonDataSet.showOrderById, (int)orderNumberBox.SelectedValue);
            }
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox1.SelectedValue != null)
            {
                this.showReviewsOfRecordTableAdapter.Fill(this.salonDataSet.showReviewsOfRecord, (int)comboBox1.SelectedValue);
            }
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

        private void orderNumberBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (orderNumberBox.SelectedValue != null)
            {
                this.showOrderByIdTableAdapter.Fill(this.salonDataSet.showOrderById, (int)orderNumberBox.SelectedValue);
            }
        }

        private void addOrderButton_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

            string addOrderQuery = $"exec addOrder {Globals.curUserId}";
            SqlCommand addOrderCommand = new SqlCommand(addOrderQuery, dataBase.getConnection());
            if (addOrderCommand.ExecuteNonQuery() > 0)
            {
                MessageBox.Show("Заказ добавлен!", "Успешно", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.showOrdersByClientIdTableAdapter.Fill(this.salonDataSet.showOrdersByClientId, Globals.curUserId);
            }

            dataBase.closeConnection();
        }

        private void cancelOrderButton_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

            string cancelOrderQuery = $"exec updateStatusByClient {orderNumberBox.SelectedValue}, 3";
            SqlCommand cancelOrderCommand = new SqlCommand(cancelOrderQuery, dataBase.getConnection());
            try
            {
                if (cancelOrderCommand.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Заказ отменен!", "Успешно", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.showOrdersByClientIdTableAdapter.Fill(this.salonDataSet.showOrdersByClientId, Globals.curUserId);
                    this.showAllRecordsTableAdapter.Fill(this.salonDataSet.showAllRecords);
                }
            }
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message, "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            dataBase.closeConnection();
        }

        private void addRecordToOrderButton_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

            int orderId = (int)orderNumberBox.SelectedValue;
            int recordId = (int)recordNumberBox.SelectedValue;
            int count = (int)countNumber.Value;
            string addRecordToOrderQuery = $"exec addRecordToOrder {orderId}, {recordId}, {count}";
            SqlCommand addRecordToOrderCommand = new SqlCommand(addRecordToOrderQuery, dataBase.getConnection());
            try
            {
                if (addRecordToOrderCommand.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Запись добавлена в заказ!", "Успешно", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.showOrdersByClientIdTableAdapter.Fill(this.salonDataSet.showOrdersByClientId, Globals.curUserId);
                    this.showAllRecordsTableAdapter.Fill(this.salonDataSet.showAllRecords);
                    this.showOrderByIdTableAdapter.Fill(this.salonDataSet.showOrderById, (int)orderNumberBox.SelectedValue);
                }
            }
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message, "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            dataBase.closeConnection();
        }
    }
}
