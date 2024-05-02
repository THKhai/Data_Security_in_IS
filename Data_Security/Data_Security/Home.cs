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
using System.Configuration;
using System.Xml.Linq;
using System.Security.Cryptography;
using Data_Security.TRUONGKHOA;
//using Oracle.DataAccess.Client;
namespace Data_Security
{
    public partial class Home : Form
    {
        string SERVICE_NAME = null;
        string id = null;
        string password = null;
        string connectString = null;    
        public Home()
        {
            InitializeComponent();
        }
       
        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                SERVICE_NAME = "XE";
                id = textBox1.Text;
                password = textBox2.Text;
                if (id.StartsWith("sys"))
                {
                    connectString = $"Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=" + SERVICE_NAME + ")));User Id=" + id + ";Password=" + password + ";DBA Privilege = SYSDBA;";
                }
                else if (id.StartsWith("NS05") || id.StartsWith("NS04") || id.StartsWith("NS03") || id.StartsWith("NS02") || id.StartsWith("NS01") || id.StartsWith("SV21") ||  id.StartsWith("ADMINLC"))
                {
                    connectString = $"Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=" + SERVICE_NAME + ")));User Id=" + id + ";Password=" + password ;
                }
                
                else
                {
                    //connectString = $"Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=" + SERVICE_NAME + ")));User Id=" + id + ";Password=" + password + ";";
                    MessageBox.Show("Thao tác thất bại");
                }
                //connectString = "Data Source=(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = khainehaha)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = XE)));User Id = " + id + ";password =" + password + ";";
                
                using (OracleConnection con = new OracleConnection(connectString))
                {
                    
                    con.Open();
                    if (con.State == ConnectionState.Open)
                    {
                        MessageBox.Show("Kết nối thành công!", "Thông Báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        con.Close();
                        this.Hide();
                        if (id.StartsWith("sys"))
                        {
                            SuccessLogin successLogin = new SuccessLogin(connectString);
                            successLogin.ShowDialog();
                            this.Show();
                        }
                        else if (id.StartsWith("NS05"))
                        {
                            Data_Security.TRUONGKHOA.TRUONGKHOA tk = new TRUONGKHOA.TRUONGKHOA(connectString);
                            tk.ShowDialog();
                            this.Show();
                        }
                        else if (id.StartsWith("NS04"))
                        {
                            Data_Security.TRUONGDONVI.TRUONGDONVI tdv = new TRUONGDONVI.TRUONGDONVI(connectString);
                            tdv.ShowDialog();
                            this.Show();
                        }
                        else if (id.StartsWith("NS03"))
                        {
                            Data_Security.GIAOVU.GIAOVU gvu = new GIAOVU.GIAOVU(connectString);
                            gvu.ShowDialog();
                            this.Show();
                        }
                        else if (id.StartsWith("NS02"))
                        {
                            Data_Security.GIANGVIEN.GIANGVIEN gv = new GIANGVIEN.GIANGVIEN(connectString);
                            gv.ShowDialog();
                            this.Show();
                        }
                        else if (id.StartsWith("NS01"))
                        {
                            Data_Security.NHANVIENCOBAN_.NHANVIENCB nv = new NHANVIENCOBAN_.NHANVIENCB(connectString);
                            nv.ShowDialog();
                            this.Show();
                        }
                        else if (id.StartsWith("SV21"))
                        {
                            Data_Security.SINHVIEN.SINHVIEN sv = new SINHVIEN.SINHVIEN(connectString);
                            sv.ShowDialog();
                            this.Show();
                        }
                        else 
                        {
                            SuccessLogin successLogin = new SuccessLogin(connectString);
                            successLogin.ShowDialog();
                            this.Show();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Đăng Nhập Thất Bại: " + ex.Message, "Thất Bại", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            textBox2.Clear();
        }
    }
}