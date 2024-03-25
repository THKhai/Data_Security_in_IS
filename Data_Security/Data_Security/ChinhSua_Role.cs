using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace Data_Security
{
    public partial class ChinhSua_Role : Form
    {
        string connectStr = string.Empty;
        public ChinhSua_Role(string connnectString)
        {

            connectStr = connnectString;
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void ChinhSua_Role_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                using (OracleConnection conn = new OracleConnection(connectStr))
                {
                    conn.Open();
                    string[] queries = textBox1.Text.ToString().Split(';');
                    foreach (string query in queries)
                    {
                        if (!string.IsNullOrEmpty(query))
                        {
                            OracleCommand comm = new OracleCommand(query, conn);
                            comm.ExecuteNonQuery();
                        }
                    }
                    conn.Close();
                }
                MessageBox.Show("Thêm Thành Công ", "Thông Báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Thông Báo Lỗi !" + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            this.Close();
        }
    }
}
