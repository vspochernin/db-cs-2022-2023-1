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
    public partial class RegisterForm : Form
    {
        DataBase database = new DataBase();
        public RegisterForm()
        {
            InitializeComponent();
            StartPosition = FormStartPosition.CenterScreen;
        }

        private void RegisterForm_Load(object sender, EventArgs e)
        {
            textBox_password.PasswordChar = '*';
        }

        private void button_register_Click(object sender, EventArgs e)
        {
            database.openConnection();
            SqlDataAdapter adapter = new SqlDataAdapter();

            string login = textBox_login.Text;
            string password = Hashing.hashPassword(textBox_password.Text);
            string first_name = textBox_first_name.Text;
            string last_name = textBox_last_name.Text;
            string email = textBox_email.Text;
            string address = textBox_address.Text;
            string dob = monthCalendar_dob.SelectionRange.Start.ToString("yyyy-MM-dd");
            string phone = textBox_phone.Text;

            string addClientQuery = $"exec addClient '{first_name}', '{last_name}', '{email}', '{login}', '{password}', '{address}', '{dob}', {phone}"; ;
            SqlCommand addClientCommand = new SqlCommand(addClientQuery, database.getConnection());

            try
            {
                if (addClientCommand.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Аккаунт создан успешно!", "Успех!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    LoginForm loginForm = new LoginForm();
                    this.Hide();
                    loginForm.ShowDialog();
                }
            } catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button_back_Click(object sender, EventArgs e)
        {
            LoginForm loginForm = new LoginForm();
            this.Hide();
            loginForm.ShowDialog();
        }
    }
}
