using Salon.Utils;
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
            StartPosition = FormStartPosition.CenterScreen;
        }

        private void ClientForm_Load(object sender, EventArgs e)
        {
            textBox_password.PasswordChar = '*';
            textBox_old_password.PasswordChar = '*';
            // TODO: данная строка кода позволяет загрузить данные в таблицу "salonDataSet.showAllRecords". При необходимости она может быть перемещена или удалена.
            this.showAllRecordsTableAdapter.Fill(this.salonDataSet.showAllRecords);
            this.showReviewsOfRecordTableAdapter.Fill(this.salonDataSet.showReviewsOfRecord, (int)comboBox1.SelectedValue);
            this.showOrdersByClientIdTableAdapter.Fill(this.salonDataSet.showOrdersByClientId, Globals.curUserId);
            if (orderNumberBox.SelectedValue != null)
            {
                this.showOrderByIdTableAdapter.Fill(this.salonDataSet.showOrderById, (int)orderNumberBox.SelectedValue);
            }
            this.showRecommendationsOfClientTableAdapter.Fill(this.salonDataSet.showRecommendationsOfClient, Globals.curUserId);
            if (recommendationNumberBox.SelectedValue != null)
            {
                this.showRecommendationByIdTableAdapter.Fill(this.salonDataSet.showRecommendationById, (int)recommendationNumberBox.SelectedValue);
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

        private void recommendationNumberBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (recommendationNumberBox.SelectedValue != null)
            {
                this.showRecommendationByIdTableAdapter.Fill(this.salonDataSet.showRecommendationById, (int)recommendationNumberBox.SelectedValue);
            }
        }

        private void uploadCurrentButton_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();
            SqlDataAdapter adapter = new SqlDataAdapter();

            string clientQuery = $"select * from clients where client_id = {Globals.curUserId}";
            SqlCommand clientCommand = new SqlCommand(clientQuery, dataBase.getConnection());
            DataTable clientTable = new DataTable();

            adapter.SelectCommand = clientCommand;
            adapter.Fill(clientTable);

            string loginQuery = $"select * from logins where login_id = {Globals.curUserLoginId}";
            SqlCommand loginCommand = new SqlCommand(loginQuery, dataBase.getConnection());
            DataTable loginTable = new DataTable();

            adapter.SelectCommand = loginCommand;
            adapter.Fill(loginTable);

            textBox_login.Text = loginTable.Rows[0][1].ToString();
            textBox_first_name.Text = clientTable.Rows[0][1].ToString();
            textBox_last_name.Text = clientTable.Rows[0][2].ToString();
            textBox_email.Text = clientTable.Rows[0][3].ToString();
            textBox_address.Text = clientTable.Rows[0][4].ToString();
            monthCalendar_dob.SelectionStart = DateTime.Parse(clientTable.Rows[0][6].ToString());
            monthCalendar_dob.SelectionEnd = DateTime.Parse(clientTable.Rows[0][6].ToString());
            textBox_phone.Text = clientTable.Rows[0][7].ToString();


            dataBase.closeConnection();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();
            SqlDataAdapter adapter = new SqlDataAdapter();

            string oldPassword = textBox_old_password.Text;
            string hashOldPassword = Hashing.hashPassword(oldPassword);

            string newPassword = textBox_password.Text;

            string loginQuery = $"select * from logins where login_id = {Globals.curUserLoginId} and password = '{hashOldPassword}'";
            SqlCommand loginCommand = new SqlCommand(loginQuery, dataBase.getConnection());
            DataTable loginTable = new DataTable();

            adapter.SelectCommand = loginCommand;
            adapter.Fill(loginTable);

            if (loginTable.Rows.Count == 0)
            {
                MessageBox.Show("Неправильно введен старый пароль!", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else
            {

                string login = textBox_login.Text;
                string password = (newPassword != null && newPassword != "") ? Hashing.hashPassword(newPassword) : hashOldPassword;
                string first_name = textBox_first_name.Text;
                string last_name = textBox_last_name.Text;
                string email = textBox_email.Text;
                string address = textBox_address.Text;
                string dob = monthCalendar_dob.SelectionRange.Start.ToString("yyyy-MM-dd");
                string phone = textBox_phone.Text;

                string updateClientQuery = $"exec updateClient {Globals.curUserId}, '{first_name}', '{last_name}', '{email}', '{login}', '{password}', '{address}', '{dob}', {phone}"; ;
                SqlCommand updateClientCommand = new SqlCommand(updateClientQuery, dataBase.getConnection());

                try
                {
                    if (updateClientCommand.ExecuteNonQuery() > 0)
                    {
                        MessageBox.Show("Успешно изменены данные пользователя!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                }
                catch (SqlException ex)
                {
                    MessageBox.Show(ex.Message, "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }

            dataBase.closeConnection();
        }
    }
}
