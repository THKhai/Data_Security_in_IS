using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace Data_Security.TRUONGKHOA
{
    public partial class Xoa : Form
    {
        string connectstr;
        string tablename;
        public Xoa(string strconnect, string table)
        {
            connectstr = strconnect;
            tablename = table;
            InitializeComponent();
        }

        private void Xoa_Load(object sender, EventArgs e)
        {
            tablelabel.Text = tablename;

            if (tablename == "NHANSU")
            {
                label2.Hide();
                label3.Hide();
                label4.Hide();
                label5.Hide();
                label6.Hide();
                textBox2.Hide();
                textBox3.Hide();
                textBox4.Hide();
                textBox5.Hide();
                textBox6.Hide();

                label1.Text = "MANV";
            }
            if (tablename == "SINHVIEN")
            {
                label2.Hide();
                label3.Hide();
                label4.Hide();
                label5.Hide();
                label6.Hide();
                textBox2.Hide();
                textBox3.Hide();
                textBox4.Hide();
                textBox5.Hide();
                textBox6.Hide();

                label1.Text = "MASV";
            }
            if (tablename == "DONVI")
            {
                label2.Hide();
                label3.Hide();
                label4.Hide();
                label5.Hide();
                label6.Hide();
                textBox2.Hide();
                textBox3.Hide();
                textBox4.Hide();
                textBox5.Hide();
                textBox6.Hide();

                label1.Text = "MADV";
            }
            if (tablename == "HOCPHAN")
            {
                label2.Hide();
                label3.Hide();
                label4.Hide();
                label5.Hide();
                label6.Hide();
                textBox2.Hide();
                textBox3.Hide();
                textBox4.Hide();
                textBox5.Hide();
                textBox6.Hide();

                label1.Text = "MAHP";
            }
            if (tablename == "KHMO")
            {
                label5.Hide();
                label6.Hide();
                textBox5.Hide();
                textBox6.Hide();

                label1.Text = "MAHP";
                label2.Text = "HK";
                label3.Text = "NAM";
                label4.Text = "MACT";

            }
            if (tablename == "PHANCONG")
            {
                label6.Hide();
                textBox6.Hide();

                label1.Text = "MAGV";
                label2.Text = "MAHP";
                label3.Text = "HK";
                label4.Text = "NAM";
                label5.Text = "MACT";
            }
            if (tablename == "DANGKY")
            {
                label1.Text = "MASV";
                label2.Text = "MAGV";
                label3.Text = "MAHP";
                label4.Text = "HK";
                label5.Text = "NAM";
                label6.Text = "MACT";
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                using (OracleConnection conn = new OracleConnection(connectstr))
                {
                    string query = "";
                    if (tablename == "NHANSU")
                    {
                        query = "DELETE FROM ADMINLC." + tablename + " WHERE MANV = '"
                            + textBox1.Text.ToString() + "'";
                    }
                    if (tablename == "SINHVIEN")
                    {
                        query = "DELETE FROM ADMINLC." + tablename + " WHERE MASV = '"
                            + textBox1.Text.ToString() + "'";
                    }
                    if (tablename == "DONVI")
                    {
                        query = "DELETE FROM ADMINLC." + tablename + " WHERE MADV = '"
                            + textBox1.Text.ToString() + "'";
                    }
                    if (tablename == "HOCPHAN")
                    {
                        query = "DELETE FROM ADMINLC." + tablename + " WHERE MAHP = '"
                            + textBox1.Text.ToString() + "'";
                    }
                    if (tablename == "KHMO")
                    {
                        query = "DELETE FROM ADMINLC." + tablename + " WHERE MAHP = '"
                            + textBox1.Text.ToString() + "' AND HK = "
                            + textBox2.Text.ToString() + " AND NAM = "
                            + textBox2.Text.ToString() + " AND MACT = '"
                            + textBox4.Text.ToString() + "'";
                    }
                    if (tablename == "PHANCONG")
                    {
                        query = "DELETE FROM ADMINLC." + tablename + " WHERE MAGV = '"
                            + textBox1.Text.ToString() + "' AND MAHP = '"
                            + textBox2.Text.ToString() + "' AND HK = "
                            + textBox3.Text.ToString() + " AND NAM = "
                            + textBox4.Text.ToString() + " AND MACT = '"
                            + textBox5.Text.ToString() + "'";
                    }
                    if (tablename == "DANGKY")
                    {
                        query = "DELETE FROM ADMINLC." + tablename + " WHERE MASV = '"
                            + textBox1.Text.ToString() + "' AND MAGP = '"
                            + textBox2.Text.ToString() + "' AND MAHP = '"
                            + textBox3.Text.ToString() + "' AND HK = "
                            + textBox4.Text.ToString() + " AND NAM = "
                            + textBox5.Text.ToString() + " AND MACT = '"
                            + textBox6.Text.ToString() + "'";
                    }
                    OracleCommand cmd = new OracleCommand(query, conn);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
                MessageBox.Show("Xóa Thành Công! ", "Thông Báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
