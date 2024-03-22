﻿using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Data_Security
{
    public partial class Them_User : Form
    {
        string connectString = string.Empty;
        public Them_User(string connectString)
        {
            InitializeComponent();
            this.connectString = connectString; 
        }

        private void Them_User_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                using (OracleConnection conn = new OracleConnection(connectString))
                {
                    conn.Open();
                    string query = "alter session set \"_ORACLE_SCRIPT\" =true;" +  " create user " + textBox1.Text.ToString() + " identified by " + textBox2.Text.ToString() + ";";
                    OracleCommand cmd = new OracleCommand(query, conn);
                    cmd.ExecuteNonQuery(); 
                    conn.Close();
                }
                MessageBox.Show("Thêm Thành Công! ", "Thông Báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}