using Salon.Utils;
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
    public partial class AdminForm : Form
    {
        DataBase dataBase = new DataBase();
        public AdminForm()
        {
            InitializeComponent();
        }

        private void AdminForm_Load(object sender, EventArgs e)
        {
            // TODO: данная строка кода позволяет загрузить данные в таблицу "salonDataSet.showAllEmployees". При необходимости она может быть перемещена или удалена.
            this.showAllEmployeesTableAdapter.Fill(this.salonDataSet.showAllEmployees);
            // TODO: данная строка кода позволяет загрузить данные в таблицу "salonDataSet.showAllStatuses". При необходимости она может быть перемещена или удалена.
            this.showAllStatusesTableAdapter.Fill(this.salonDataSet.showAllStatuses);
            // TODO: данная строка кода позволяет загрузить данные в таблицу "salonDataSet.showAllRecommendations". При необходимости она может быть перемещена или удалена.
            this.showAllRecommendationsTableAdapter.Fill(this.salonDataSet.showAllRecommendations);
            // TODO: данная строка кода позволяет загрузить данные в таблицу "salonDataSet.showAllReviews". При необходимости она может быть перемещена или удалена.
            this.showAllReviewsTableAdapter.Fill(this.salonDataSet.showAllReviews);
            // TODO: данная строка кода позволяет загрузить данные в таблицу "salonDataSet.showAllClients". При необходимости она может быть перемещена или удалена.
            this.showAllClientsTableAdapter.Fill(this.salonDataSet.showAllClients);
            // TODO: данная строка кода позволяет загрузить данные в таблицу "salonDataSet.showAllOrders". При необходимости она может быть перемещена или удалена.
            this.showAllOrdersTableAdapter.Fill(this.salonDataSet.showAllOrders);
            // TODO: данная строка кода позволяет загрузить данные в таблицу "salonDataSet.showAllRecords". При необходимости она может быть перемещена или удалена.
            this.showAllRecordsTableAdapter.Fill(this.salonDataSet.showAllRecords);
            if (orderNumberBox.SelectedValue != null)
            {
                this.showOrderByIdTableAdapter.Fill(this.salonDataSet.showOrderById, (int)orderNumberBox.SelectedValue);
            }
            if (recommendationNumberBox.SelectedValue != null)
            {
                int recommendationId = (int)recommendationNumberBox.SelectedValue;
                showRecommendationByIdTableAdapter.Fill(this.salonDataSet.showRecommendationById, recommendationId);
            }
            employeePassword.PasswordChar = '*';
            adminPassword.PasswordChar = '*';
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            dataBase.openConnection();

            if (recordIdBox.SelectedValue != null)
            {
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

            }

            dataBase.closeConnection();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

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

            dataBase.closeConnection();
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

            try
            {
                if (addRecordCommand.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Музыкальная запись успешно добавлена!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.showAllRecordsTableAdapter.Fill(this.salonDataSet.showAllRecords);
                }
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Некорректно введены данные!", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            dataBase.closeConnection();
        }

        private void updateRecordButton_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

            if (recordIdBox.SelectedValue != null)
            {

                int recordId = (int)recordIdBox.SelectedValue;
                string title = textBox_title.Text;
                string author = textBox_author.Text;
                string price = textBox_price.Text.Replace(",", ".");
                int count = (int)numericUpDown_count.Value;

                string updateRecordQuery = $"updateRecord {recordId}, '{title}', '{author}', {price}, {count}";
                SqlCommand updateRecordCommand = new SqlCommand(updateRecordQuery, dataBase.getConnection());

                try
                {
                    if (updateRecordCommand.ExecuteNonQuery() > 0)
                    {
                        MessageBox.Show("Музыкальная запись успешно изменена!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.showAllRecordsTableAdapter.Fill(this.salonDataSet.showAllRecords);
                    }
                }
                catch (SqlException ex)
                {
                    MessageBox.Show("Некорректно введены данные!", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }

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

        private void showOrdersByEmailButton_Click(object sender, EventArgs e)
        {
            if (emailBox.Text != null)
            {
                string email = emailBox.Text;

                this.showOrdersByClientEmailTableAdapter.Fill(this.salonDataSet.showOrdersByClientEmail, email);
            }
        }

        private void removeReviewButton_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

            if (reviewNumberBox.SelectedValue != null)
            {
                int reviewId = (int)reviewNumberBox.SelectedValue;
                string removeReviewQuery = $"exec removeReview {reviewId}";
                SqlCommand removeReviewCommand = new SqlCommand(removeReviewQuery, dataBase.getConnection());

                if (removeReviewCommand.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Отзыв успешно удален!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.showAllReviewsTableAdapter.Fill(this.salonDataSet.showAllReviews);
                }
            }

            dataBase.closeConnection();
        }

        private void recommendationNumberBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (recommendationNumberBox.SelectedValue != null)
            {
                int recommendationId = (int)recommendationNumberBox.SelectedValue;
                showRecommendationByIdTableAdapter.Fill(this.salonDataSet.showRecommendationById, recommendationId);
            }
        }

        private void employeeNumber_SelectedIndexChanged(object sender, EventArgs e)
        {
            dataBase.openConnection();
            SqlDataAdapter adapter = new SqlDataAdapter();

            if (employeeNumber.SelectedValue != null)
            {
                int employeeId = (int)employeeNumber.SelectedValue;

                string employeeQuery = $"select * from employees where employee_id = {employeeId}";
                SqlCommand employeeCommand = new SqlCommand(employeeQuery, dataBase.getConnection());
                DataTable employeeTable = new DataTable();

                adapter.SelectCommand = employeeCommand;
                adapter.Fill(employeeTable);

                employeeFirstName.Text = employeeTable.Rows[0][1].ToString();
                employeeLastName.Text = employeeTable.Rows[0][2].ToString();
                employeeSalary.Text = employeeTable.Rows[0][3].ToString();

                int loginId = (int)employeeTable.Rows[0][4];

                string loginQuery = $"select * from logins where login_id = {loginId}";
                SqlCommand loginCommand = new SqlCommand(loginQuery, dataBase.getConnection());
                DataTable loginTable = new DataTable();

                adapter.SelectCommand = loginCommand;
                adapter.Fill(loginTable);

                employeeLogin.Text = loginTable.Rows[0][1].ToString();
            }

            dataBase.closeConnection();
        }

        private void registerEmployeeButton_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

            string login = employeeLogin.Text;
            string password = Hashing.hashPassword(employeePassword.Text);
            string firstName = employeeFirstName.Text;
            string lastName = employeeLastName.Text;
            string salary = employeeSalary.Text.Replace(",", ".");

            string addEmployeeQuery = $"exec addEmployee '{firstName}', '{lastName}', {salary}, '{login}', '{password}'";
            SqlCommand addEmployeeCommand = new SqlCommand(addEmployeeQuery, dataBase.getConnection());


            if (employeeLogin.Text == "" || employeePassword.Text == "")
            {
                MessageBox.Show("Пожалуйста, введите логин и пароль!", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            try
            {
                if (addEmployeeCommand.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Сотрудник успешно добавлен!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    showAllEmployeesTableAdapter.Fill(this.salonDataSet.showAllEmployees);
                }
            }
            catch (SqlException ex)
            {
                if (ex.Message.Contains("IX_logins"))
                {
                    MessageBox.Show("Такой логин уже существует!", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                else
                {
                    MessageBox.Show("Некорректно введены данные!", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }

            dataBase.closeConnection();
        }

        private void updateEmployeeButton_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

            if (employeeNumber.SelectedValue != null)
            {
                int employeeId = (int)employeeNumber.SelectedValue;
                string login = employeeLogin.Text;
                string password = Hashing.hashPassword(employeePassword.Text);
                string firstName = employeeFirstName.Text;
                string lastName = employeeLastName.Text;
                string salary = employeeSalary.Text.Replace(",", ".");

                string updateEmployeeQuery = $"exec updateEmployee {employeeId}, '{firstName}', '{lastName}', {salary}, '{login}', '{password}'";
                SqlCommand updateEmployeeCommand = new SqlCommand(updateEmployeeQuery, dataBase.getConnection());

                if (employeeLogin.Text == "" || employeePassword.Text == "")
                {
                    MessageBox.Show("Пожалуйста, введите логин и пароль!", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                try
                {
                    if (updateEmployeeCommand.ExecuteNonQuery() > 0)
                    {
                        MessageBox.Show("Данные сотрудника успешно изменены!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        showAllEmployeesTableAdapter.Fill(this.salonDataSet.showAllEmployees);
                    }
                }
                catch (SqlException ex)
                {
                    if (ex.Message.Contains("IX_logins"))
                    {
                        MessageBox.Show("Такой логин уже существует!", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                    else
                    {
                        MessageBox.Show("Некорректно введены данные!", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }

            dataBase.closeConnection();
        }

        private void updateAdminButton_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

            string login = adminLogin.Text;
            string password = Hashing.hashPassword(adminPassword.Text);

            string updateAdminQuery = $"exec updateAdmin '{login}', '{password}'";
            SqlCommand updateAdminCommand = new SqlCommand(updateAdminQuery, dataBase.getConnection());

            if (adminLogin.Text == "" || adminPassword.Text == "")
            {
                MessageBox.Show("Пожалуйста, введите логин и пароль!", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            try
            {
                if (updateAdminCommand.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Данные авторизации успешно изменены!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (SqlException ex)
            {
                if (ex.Message.Contains("IX_logins"))
                {
                    MessageBox.Show("Такой логин уже существует!", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                else
                {
                    MessageBox.Show("Некорректно введены данные!", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }

            dataBase.closeConnection();
        }
    }
}
