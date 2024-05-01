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

namespace Data_Security.TRUONGDONVI
{
    public partial class TRUONGDONVI : Form
    {
        string connectString = null;
        public TRUONGDONVI(string strconnect)
        {
            InitializeComponent();
            connectString = strconnect;
        }

        private void TRUONGDONVI_Load(object sender, EventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {
            try
            {
                using (OracleConnection conn = new OracleConnection(connectString))
                {
                    conn.Open();
                    string[] queries = textBox2.Text.ToString().Split(';');
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
                MessageBox.Show("Thao tác thành công");
            }
            catch
            {
                MessageBox.Show("Thao tác thất bại");
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                using (OracleConnection con = new OracleConnection(connectString))
                {

                    var STDquery = String.Format("select * from ADMINLC.{0}", textBox1.Text.ToUpper());
                    OracleDataAdapter adapter = new OracleDataAdapter(STDquery, con);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    dataGridView1.DataSource = dt;
                }
            }
            catch
            {
                MessageBox.Show("Thao tác thất bại");
            }
        }
    }
}
