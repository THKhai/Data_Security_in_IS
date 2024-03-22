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
    public partial class Them_Role : Form
    {
        string connectString = null;
        public Them_Role(string connectString)
        {
            InitializeComponent();
            this.connectString = connectString;
        }

        private void Them_Role_Load(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
          
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                using (OracleConnection conn = new OracleConnection(connectString))
                {
                    conn.Open();
                    string query_01 = "create role " + textBox2.Text;
                    string query_02 = textBox2.Text;
                    OracleCommand comm_01 = new OracleCommand(query_01, conn);
                    OracleCommand comm_02 = new OracleCommand(query_02, conn);
                    comm_01.ExecuteNonQuery();
                    comm_02.ExecuteNonQuery();
                    conn.Close();
                }
                MessageBox.Show("Thêm Thành Công ","Thông Báo",MessageBoxButtons.OK,MessageBoxIcon.Information);
            }
            catch(Exception ex)
            {
                MessageBox.Show("Thông Báo Lỗi !" + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
    }
}
