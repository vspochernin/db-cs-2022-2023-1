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
    public partial class log_in : Form
    {
        DataBase database = new DataBase();
        public log_in()
        {
            InitializeComponent();
            StartPosition = FormStartPosition.CenterScreen;
        }

        private void log_in_Load(object sender, EventArgs e)
        {
            textBox_password.PasswordChar = '*';
            textBox_login.MaxLength = 50;
            textBox_password.MaxLength = 50;
        }

        private void button_enter_Click(object sender, EventArgs e)
        {
            string login = textBox_login.Text;
            string password = Hashing.hashPassword(textBox_password.Text);

            SqlDataAdapter adapter = new SqlDataAdapter();
            string loginsQueryString = $"select login_id, login, password from logins where login = '{login}' and password = '{password}'";
            SqlCommand loginsCommand = new SqlCommand(loginsQueryString, database.getConnection());
            adapter.SelectCommand = loginsCommand;

            DataTable loginsTable = new DataTable();
            adapter.Fill(loginsTable);
            if (loginsTable.Rows.Count > 0)
            {
                string loginId = loginsTable.Rows[0][0].ToString();

                DataTable clientsTable = new DataTable();
                DataTable employeesTable = new DataTable();
                string clientsQueryString = $"select * from clients where login_id = '{loginId}'";
                string employeesQueryString = $"select * from employees where login_id = '{loginId}'";
                SqlCommand clientsCommand = new SqlCommand(clientsQueryString, database.getConnection());
                SqlCommand employeesCommand = new SqlCommand(employeesQueryString, database.getConnection());

                adapter.SelectCommand = clientsCommand;
                adapter.Fill(clientsTable);

                adapter.SelectCommand = employeesCommand;
                adapter.Fill(employeesTable);


                if (loginId == "1")
                {
                    MessageBox.Show("Здравствуйте, Администратор!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else if (employeesTable.Rows.Count > 0)
                {
                    MessageBox.Show($"Здравствуйте, {employeesTable.Rows[0][1].ToString()}!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                } else if (clientsTable.Rows.Count > 0)
                {
                    MessageBox.Show($"Здравствуйте, {clientsTable.Rows[0][1].ToString()}!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            else
            {
                MessageBox.Show("Не удалось авторизироваться!", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
