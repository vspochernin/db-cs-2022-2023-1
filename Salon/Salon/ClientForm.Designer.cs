namespace Salon
{
    partial class ClientForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.button1 = new System.Windows.Forms.Button();
            this.reviewTextBox = new System.Windows.Forms.TextBox();
            this.dataGridView2 = new System.Windows.Forms.DataGridView();
            this.showReviewsOfRecordBindingSource1 = new System.Windows.Forms.BindingSource(this.components);
            this.salonDataSet = new Salon.SalonDataSet();
            this.comboBox1 = new System.Windows.Forms.ComboBox();
            this.showAllRecordsBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.артикулDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.названиеDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.авторDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ценаDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.количествоDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.showReviewsOfRecordBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.showReviewsOfRecordTableAdapter = new Salon.SalonDataSetTableAdapters.showReviewsOfRecordTableAdapter();
            this.ordersrecordsBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.orders_recordsTableAdapter = new Salon.SalonDataSetTableAdapters.orders_recordsTableAdapter();
            this.showAllRecordsTableAdapter = new Salon.SalonDataSetTableAdapters.showAllRecordsTableAdapter();
            this.текстРекомендацииDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.tabControl1.SuspendLayout();
            this.tabPage1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.showReviewsOfRecordBindingSource1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.salonDataSet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.showAllRecordsBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.showReviewsOfRecordBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ordersrecordsBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tabPage1);
            this.tabControl1.Controls.Add(this.tabPage2);
            this.tabControl1.Location = new System.Drawing.Point(12, 12);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(1580, 1185);
            this.tabControl1.TabIndex = 0;
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.button1);
            this.tabPage1.Controls.Add(this.reviewTextBox);
            this.tabPage1.Controls.Add(this.dataGridView2);
            this.tabPage1.Controls.Add(this.comboBox1);
            this.tabPage1.Controls.Add(this.dataGridView1);
            this.tabPage1.Location = new System.Drawing.Point(8, 39);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(1564, 1138);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Каталог";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(463, 371);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(321, 55);
            this.button1.TabIndex = 4;
            this.button1.Text = "Добавить отзыв";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // reviewTextBox
            // 
            this.reviewTextBox.Location = new System.Drawing.Point(790, 376);
            this.reviewTextBox.Multiline = true;
            this.reviewTextBox.Name = "reviewTextBox";
            this.reviewTextBox.Size = new System.Drawing.Size(754, 376);
            this.reviewTextBox.TabIndex = 3;
            // 
            // dataGridView2
            // 
            this.dataGridView2.AllowUserToAddRows = false;
            this.dataGridView2.AllowUserToDeleteRows = false;
            this.dataGridView2.AutoGenerateColumns = false;
            this.dataGridView2.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView2.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.текстРекомендацииDataGridViewTextBoxColumn});
            this.dataGridView2.DataSource = this.showReviewsOfRecordBindingSource1;
            this.dataGridView2.Location = new System.Drawing.Point(6, 432);
            this.dataGridView2.Name = "dataGridView2";
            this.dataGridView2.ReadOnly = true;
            this.dataGridView2.RowHeadersWidth = 82;
            this.dataGridView2.RowTemplate.Height = 33;
            this.dataGridView2.Size = new System.Drawing.Size(778, 320);
            this.dataGridView2.TabIndex = 2;
            // 
            // showReviewsOfRecordBindingSource1
            // 
            this.showReviewsOfRecordBindingSource1.DataMember = "showReviewsOfRecord";
            this.showReviewsOfRecordBindingSource1.DataSource = this.salonDataSet;
            // 
            // salonDataSet
            // 
            this.salonDataSet.DataSetName = "SalonDataSet";
            this.salonDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // comboBox1
            // 
            this.comboBox1.DataSource = this.showAllRecordsBindingSource;
            this.comboBox1.DisplayMember = "Название";
            this.comboBox1.FormattingEnabled = true;
            this.comboBox1.Location = new System.Drawing.Point(16, 376);
            this.comboBox1.Name = "comboBox1";
            this.comboBox1.Size = new System.Drawing.Size(441, 33);
            this.comboBox1.TabIndex = 1;
            this.comboBox1.ValueMember = "Артикул";
            this.comboBox1.SelectedIndexChanged += new System.EventHandler(this.comboBox1_SelectedIndexChanged);
            // 
            // showAllRecordsBindingSource
            // 
            this.showAllRecordsBindingSource.DataMember = "showAllRecords";
            this.showAllRecordsBindingSource.DataSource = this.salonDataSet;
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToAddRows = false;
            this.dataGridView1.AllowUserToDeleteRows = false;
            this.dataGridView1.AutoGenerateColumns = false;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.артикулDataGridViewTextBoxColumn,
            this.названиеDataGridViewTextBoxColumn,
            this.авторDataGridViewTextBoxColumn,
            this.ценаDataGridViewTextBoxColumn,
            this.количествоDataGridViewTextBoxColumn});
            this.dataGridView1.DataSource = this.showAllRecordsBindingSource;
            this.dataGridView1.Location = new System.Drawing.Point(6, 6);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.ReadOnly = true;
            this.dataGridView1.RowHeadersWidth = 82;
            this.dataGridView1.RowTemplate.Height = 33;
            this.dataGridView1.Size = new System.Drawing.Size(1552, 359);
            this.dataGridView1.TabIndex = 0;
            // 
            // артикулDataGridViewTextBoxColumn
            // 
            this.артикулDataGridViewTextBoxColumn.DataPropertyName = "Артикул";
            this.артикулDataGridViewTextBoxColumn.HeaderText = "Артикул";
            this.артикулDataGridViewTextBoxColumn.MinimumWidth = 10;
            this.артикулDataGridViewTextBoxColumn.Name = "артикулDataGridViewTextBoxColumn";
            this.артикулDataGridViewTextBoxColumn.ReadOnly = true;
            this.артикулDataGridViewTextBoxColumn.Width = 200;
            // 
            // названиеDataGridViewTextBoxColumn
            // 
            this.названиеDataGridViewTextBoxColumn.DataPropertyName = "Название";
            this.названиеDataGridViewTextBoxColumn.HeaderText = "Название";
            this.названиеDataGridViewTextBoxColumn.MinimumWidth = 10;
            this.названиеDataGridViewTextBoxColumn.Name = "названиеDataGridViewTextBoxColumn";
            this.названиеDataGridViewTextBoxColumn.ReadOnly = true;
            this.названиеDataGridViewTextBoxColumn.Width = 200;
            // 
            // авторDataGridViewTextBoxColumn
            // 
            this.авторDataGridViewTextBoxColumn.DataPropertyName = "Автор";
            this.авторDataGridViewTextBoxColumn.HeaderText = "Автор";
            this.авторDataGridViewTextBoxColumn.MinimumWidth = 10;
            this.авторDataGridViewTextBoxColumn.Name = "авторDataGridViewTextBoxColumn";
            this.авторDataGridViewTextBoxColumn.ReadOnly = true;
            this.авторDataGridViewTextBoxColumn.Width = 200;
            // 
            // ценаDataGridViewTextBoxColumn
            // 
            this.ценаDataGridViewTextBoxColumn.DataPropertyName = "Цена";
            this.ценаDataGridViewTextBoxColumn.HeaderText = "Цена";
            this.ценаDataGridViewTextBoxColumn.MinimumWidth = 10;
            this.ценаDataGridViewTextBoxColumn.Name = "ценаDataGridViewTextBoxColumn";
            this.ценаDataGridViewTextBoxColumn.ReadOnly = true;
            this.ценаDataGridViewTextBoxColumn.Width = 200;
            // 
            // количествоDataGridViewTextBoxColumn
            // 
            this.количествоDataGridViewTextBoxColumn.DataPropertyName = "Количество";
            this.количествоDataGridViewTextBoxColumn.HeaderText = "Количество";
            this.количествоDataGridViewTextBoxColumn.MinimumWidth = 10;
            this.количествоDataGridViewTextBoxColumn.Name = "количествоDataGridViewTextBoxColumn";
            this.количествоDataGridViewTextBoxColumn.ReadOnly = true;
            this.количествоDataGridViewTextBoxColumn.Width = 200;
            // 
            // tabPage2
            // 
            this.tabPage2.Location = new System.Drawing.Point(8, 39);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage2.Size = new System.Drawing.Size(1564, 1138);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "tabPage2";
            this.tabPage2.UseVisualStyleBackColor = true;
            // 
            // showReviewsOfRecordBindingSource
            // 
            this.showReviewsOfRecordBindingSource.DataMember = "showReviewsOfRecord";
            this.showReviewsOfRecordBindingSource.DataSource = this.salonDataSet;
            // 
            // showReviewsOfRecordTableAdapter
            // 
            this.showReviewsOfRecordTableAdapter.ClearBeforeFill = true;
            // 
            // ordersrecordsBindingSource
            // 
            this.ordersrecordsBindingSource.DataMember = "orders_records";
            this.ordersrecordsBindingSource.DataSource = this.salonDataSet;
            // 
            // orders_recordsTableAdapter
            // 
            this.orders_recordsTableAdapter.ClearBeforeFill = true;
            // 
            // showAllRecordsTableAdapter
            // 
            this.showAllRecordsTableAdapter.ClearBeforeFill = true;
            // 
            // текстРекомендацииDataGridViewTextBoxColumn
            // 
            this.текстРекомендацииDataGridViewTextBoxColumn.DataPropertyName = "Текст рекомендации";
            this.текстРекомендацииDataGridViewTextBoxColumn.HeaderText = "Текст отзыва";
            this.текстРекомендацииDataGridViewTextBoxColumn.MinimumWidth = 10;
            this.текстРекомендацииDataGridViewTextBoxColumn.Name = "текстРекомендацииDataGridViewTextBoxColumn";
            this.текстРекомендацииDataGridViewTextBoxColumn.ReadOnly = true;
            this.текстРекомендацииDataGridViewTextBoxColumn.Width = 200;
            // 
            // ClientForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(12F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1604, 1209);
            this.Controls.Add(this.tabControl1);
            this.Name = "ClientForm";
            this.Text = "ClientForm";
            this.Load += new System.EventHandler(this.ClientForm_Load);
            this.tabControl1.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.tabPage1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.showReviewsOfRecordBindingSource1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.salonDataSet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.showAllRecordsBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.showReviewsOfRecordBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ordersrecordsBindingSource)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.BindingSource showReviewsOfRecordBindingSource;
        private SalonDataSet salonDataSet;
        private System.Windows.Forms.TabPage tabPage2;
        private SalonDataSetTableAdapters.showReviewsOfRecordTableAdapter showReviewsOfRecordTableAdapter;
        private System.Windows.Forms.BindingSource ordersrecordsBindingSource;
        private SalonDataSetTableAdapters.orders_recordsTableAdapter orders_recordsTableAdapter;
        private System.Windows.Forms.BindingSource showAllRecordsBindingSource;
        private SalonDataSetTableAdapters.showAllRecordsTableAdapter showAllRecordsTableAdapter;
        private System.Windows.Forms.DataGridViewTextBoxColumn артикулDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn названиеDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn авторDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn ценаDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn количествоDataGridViewTextBoxColumn;
        private System.Windows.Forms.ComboBox comboBox1;
        private System.Windows.Forms.DataGridView dataGridView2;
        private System.Windows.Forms.BindingSource showReviewsOfRecordBindingSource1;
        private System.Windows.Forms.TextBox reviewTextBox;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.DataGridViewTextBoxColumn текстРекомендацииDataGridViewTextBoxColumn;
    }
}