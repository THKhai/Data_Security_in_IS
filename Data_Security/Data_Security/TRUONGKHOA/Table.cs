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

namespace Data_Security.TRUONGKHOA
{
    public partial class Table : Form
    {
        string connectstr;
        string tablename;
        public Table(string strconnect, string table)
        {
            connectstr = strconnect;
            tablename = table;
            InitializeComponent();
        }

        private void Table_Load(object sender, EventArgs e)
        {
            label1.Text = tablename;
            try
            {
                using (OracleConnection con = new OracleConnection(connectstr))
                {
                    var query = "select * from ADMINLC." + tablename;
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

        private void button1_Click(object sender, EventArgs e)
        {
            //table = "NHANSU";
            Data_Security.TRUONGKHOA.Them tb = new Them(connectstr, tablename);
            tb.ShowDialog();
            this.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Data_Security.TRUONGKHOA.Xoa tb = new Xoa(connectstr, tablename);
            tb.ShowDialog();
            this.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Data_Security.TRUONGKHOA.ChinhSua tb = new ChinhSua(connectstr, tablename);
            tb.ShowDialog();
            this.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
