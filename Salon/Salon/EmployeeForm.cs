using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
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

        private void removeRecordFromRecommendationButton_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

            if (recommendationNumberBox.SelectedValue != null && recordInRecommendationNumberBox.SelectedValue != null)
            {
                int recommendationId = (int)recommendationNumberBox.SelectedValue;
                int recordId = (int)recordInRecommendationNumberBox.SelectedValue;

                string removeRecordFromRecommendationQuery = $"exec removeRecordFromRecommendation {recommendationId}, {recordId}";
                SqlCommand removeRecordFromRecommendationCommand = new SqlCommand(removeRecordFromRecommendationQuery, dataBase.getConnection());


                if (removeRecordFromRecommendationCommand.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Музыкальная запись успешно удалена из заказа!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.showRecommendationByIdTableAdapter.Fill(this.salonDataSet.showRecommendationById, recommendationId);
                }
            }

            dataBase.closeConnection();
        }

        private void removeRecommendationButton_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

            if (recommendationNumberBox.SelectedValue != null)
            {
                int recommendationId = (int)recommendationNumberBox.SelectedValue;

                string removeRecommendationQuery = $"exec removeRecommendation {recommendationId}";
                SqlCommand removeRecommendationCommand = new SqlCommand(removeRecommendationQuery, dataBase.getConnection());

                if (removeRecommendationCommand.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Рекомендация успешно удалена!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.showAllRecommendationsTableAdapter.Fill(this.salonDataSet.showAllRecommendations);
                    this.showRecommendationByIdTableAdapter.Fill(this.salonDataSet.showRecommendationById, recommendationId);
                }
            }


            dataBase.closeConnection();
        }

        private void addRecommendationButton_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

            if (clientNumberBox.SelectedValue != null)
            {
                int clientId = (int)clientNumberBox.SelectedValue;
                int employeeId = Globals.curUserId;
                string text = recommendationTextBox.Text;

                string addRecommendationQuery = $"exec addRecommendation {employeeId}, {clientId}, '{text}'";
                SqlCommand addRecommendationCommand = new SqlCommand(addRecommendationQuery, dataBase.getConnection());

                if (addRecommendationCommand.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Рекомендация успешно добавлена!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.showAllRecommendationsTableAdapter.Fill(this.salonDataSet.showAllRecommendations);
                }
            }

            dataBase.closeConnection();
        }

        private void updateTextButton_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

            if (recommendationNumberBox.SelectedValue != null)
            {
                int recommendationId = (int)recommendationNumberBox.SelectedValue;
                string text = recommendationTextBox.Text;

                string updateRecommendationTextQuery = $"updateRecommendationText {recommendationId}, '{text}'";
                SqlCommand updateRecommendationTextCommand = new SqlCommand(updateRecommendationTextQuery, dataBase.getConnection());

                if (updateRecommendationTextCommand.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Текст рекомендации успешно изменен!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.showAllRecommendationsTableAdapter.Fill(this.salonDataSet.showAllRecommendations);
                }
            }

            dataBase.closeConnection();
        }

        private void addRecordToRecommendationButton_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

            if (recommendationNumberBox.SelectedValue != null && recordToRecommendationNumberBox.SelectedValue != null)
            {
                int recommendationId = (int)recommendationNumberBox.SelectedValue;
                int recordId = (int)recordToRecommendationNumberBox.SelectedValue;

                string addRecordToRecommendationQuery = $"exec addRecordToRecommendation {recommendationId}, {recordId}";
                SqlCommand addRecordToRecommendationCommand = new SqlCommand(addRecordToRecommendationQuery, dataBase.getConnection());

                if (addRecordToRecommendationCommand.ExecuteNonQuery() > 0)
                {
                    MessageBox.Show("Запись успешно добавлена в рекомендацию!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.showAllRecommendationsTableAdapter.Fill(this.salonDataSet.showAllRecommendations);
                    this.showRecommendationByIdTableAdapter.Fill(this.salonDataSet.showRecommendationById, recommendationId);
                }
            }

            dataBase.closeConnection();
        }

        private void applyOrderButton_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

            if (orderNumberBox.SelectedValue != null)
            {
                int orderId = (int)orderNumberBox.SelectedValue;

                string updateStatusByEmployeeQuery = $"exec updateStatusByEmployee {orderId}, 2, {Globals.curUserId}";
                SqlCommand updateStatusByEmployeeCommand = new SqlCommand(updateStatusByEmployeeQuery, dataBase.getConnection());


                try
                {
                    if (updateStatusByEmployeeCommand.ExecuteNonQuery() > 0)
                    {
                        MessageBox.Show("Закз успешно обработан!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.showAllOrdersTableAdapter.Fill(this.salonDataSet.showAllOrders);
                    }
                } catch (SqlException ex)
                {
                    MessageBox.Show(ex.Message, "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }

            dataBase.openConnection();
        }

        private void cancelOrderButton_Click(object sender, EventArgs e)
        {
            dataBase.openConnection();

            if (orderNumberBox.SelectedValue != null)
            {
                int orderId = (int)orderNumberBox.SelectedValue;

                string updateStatusByEmployeeQuery = $"exec updateStatusByEmployee {orderId}, 4, {Globals.curUserId}";
                SqlCommand updateStatusByEmployeeCommand = new SqlCommand(updateStatusByEmployeeQuery, dataBase.getConnection());


                try
                {
                    if (updateStatusByEmployeeCommand.ExecuteNonQuery() > 0)
                    {
                        MessageBox.Show("Закз успешно отменен!", "Успешно!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.showAllOrdersTableAdapter.Fill(this.salonDataSet.showAllOrders);
                    }
                } catch (SqlException ex)
                {
                    MessageBox.Show(ex.Message, "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }

            dataBase.openConnection();
        }
    }
}
