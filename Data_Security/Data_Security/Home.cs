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
                if (id.ToLower() == "sys")
                {
                    connectString = $"Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=" + SERVICE_NAME + ")));User Id=" + id + ";Password=" + password + ";DBA Privilege = SYSDBA;";
                }
                else
                {
                    //connectString = $"Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=" + SERVICE_NAME + ")));User Id=" + id + ";Password=" + password + ";";
                    MessageBox.Show("Chỉ quản trị viên mới được đăng nhập ", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
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
                        SuccessLogin successLogin = new SuccessLogin(connectString);
                        successLogin.ShowDialog();
                        this.Show();
                    }
                    else
                    {
                        MessageBox.Show("Kết nối không thành công!", "Thông Báo", MessageBoxButtons.OK, MessageBoxIcon.Error);

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