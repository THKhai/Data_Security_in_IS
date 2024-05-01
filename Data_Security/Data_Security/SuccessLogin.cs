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
namespace Data_Security
{
    public partial class SuccessLogin : Form
    {
        string connectString = null;
        public SuccessLogin(string conStr)
        {
            connectString = conStr;
            InitializeComponent();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void SuccessLogin_Load(object sender, EventArgs e)
        {
            try
            {
                using (OracleConnection con = new OracleConnection(connectString))
                {
                    var query = "select * from dba_users order by USERNAME";
                    OracleDataAdapter adapter = new OracleDataAdapter(query, con);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    dataGridView1.DataSource = dt;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Không đủ quyền hạn để truy vấn " + ex.Message, "lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
                this.Hide();
                Privilege pr = new Privilege(connectString);
                pr.ShowDialog();
                this.Show();
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
           Audit au = new Audit(connectString);
            au.ShowDialog();
        }
    }
}
