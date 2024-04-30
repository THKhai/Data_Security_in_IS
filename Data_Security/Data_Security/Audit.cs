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
    public partial class Audit : Form
    {
        string conString;
        public Audit(string connectString)
        {
            InitializeComponent();
            conString = connectString; 
        }

        private void Audit_Load(object sender, EventArgs e)
        {
            try
            {
                using (OracleConnection con = new OracleConnection(conString))
                {
                  
                    var FGAquery = "SELECT db_user,TO_CHAR(extended_timestamp, 'DD/MM/YYYY HH24:MI:SS')as Time,object_name,statement_type,sql_text from DBA_FGA_AUDIT_TRAIL order by extended_timestamp DESC";
                    OracleDataAdapter adapter2 = new OracleDataAdapter(FGAquery, con);
                    DataTable dt2 = new DataTable();
                    adapter2.Fill(dt2);
                   

                    var STDquery = "select username,TO_CHAR(extended_timestamp, 'DD/MM/YYYY HH24:MI:SS')as Time,obj_name,action_name,sql_text from dba_audit_trail order by extended_timestamp DESC";
                    OracleDataAdapter adapter = new OracleDataAdapter(STDquery, con);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    dataGridView2.DataSource = dt2;
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
            this.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                using (OracleConnection con = new OracleConnection(conString))
                {

                    var FGAquery = "SELECT db_user,TO_CHAR(extended_timestamp, 'DD/MM/YYYY HH24:MI:SS')as Time,object_name,statement_type,sql_text from DBA_FGA_AUDIT_TRAIL order by extended_timestamp DESC";
                    OracleDataAdapter adapter2 = new OracleDataAdapter(FGAquery, con);
                    DataTable dt2 = new DataTable();
                    adapter2.Fill(dt2);


                    var STDquery = "select username,TO_CHAR(extended_timestamp, 'DD/MM/YYYY HH24:MI:SS')as Time,obj_name,action_name,sql_text from dba_audit_trail order by extended_timestamp DESC";
                    OracleDataAdapter adapter = new OracleDataAdapter(STDquery, con);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    dataGridView2.DataSource = dt2;
                    dataGridView1.DataSource = dt;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Không đủ quyền hạn để truy vấn " + ex.Message, "lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
