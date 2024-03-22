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

        private void button1_Click(object sender, EventArgs e)
        {
            using(OracleConnection con = new OracleConnection(connectString))
            {
                string query = "select username from dba_users;";
                con.Open();
                OracleCommand cmd = new OracleCommand(query, con);
                using(OracleDataAdapter ad =  new OracleDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    ad.Fill(dt);

                    dataGridView1.DataSource = dt;
                }
                con.Close();
            }
        }
    }
}
