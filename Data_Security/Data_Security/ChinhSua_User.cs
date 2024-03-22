using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Oracle.ManagedDataAccess.Client;
namespace Data_Security
{
    public partial class ChinhSua_User : Form
    {
        string current_user = null;
        string connectionString = null;
        public ChinhSua_User(string user,string connectionString)
        {
            InitializeComponent();
            this.connectionString = connectionString;
            this.current_user = user;
        }

        private void ChinhSua_User_Load(object sender, EventArgs e)
        {
            label2.Text = current_user;
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                string main_query = null;
                using (OracleConnection conn = new OracleConnection(connectionString))
                {
                    string[] queris = textBox1.Text.ToString().Split(';');
                    conn.Open();
                    foreach(string query in queris)
                    {
                        if (!string.IsNullOrEmpty(query)){
                            main_query = "alter user " + current_user + " "+ query;
                            OracleCommand comm = new OracleCommand(main_query, conn);
                            comm.ExecuteNonQuery();
                        }
                    }
                    conn.Close();
                }
                MessageBox.Show("Chỉnh Sửa Thành Công ", "Thông Báo", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            catch (Exception ex)
            {
                MessageBox.Show("Thông Báo Lỗi: " + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
    }
}
