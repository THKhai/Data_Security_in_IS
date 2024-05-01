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
    
    public partial class Them : Form
    {
        string connectstr;
        string tablename;
        public Them(string strconnect, string table)
        {
            connectstr = strconnect;
            tablename = table;
            InitializeComponent();
        }

        private void Them_Load(object sender, EventArgs e)
        {
            tablelabel.Text = tablename;

            if (tablename == "NHANSU")
            {
                label9.Hide();
                label10.Hide();
                textBox9.Hide();
                textBox10.Hide();

                label1.Text = "MANV";
                label2.Text = "HOTEN";
                label3.Text = "PHAI";
                label4.Text = "NGSINH";
                label5.Text = "PHUCAP";
                label6.Text = "DT";
                label7.Text = "VAITRO";
                label8.Text = "MADV";
            }
            if (tablename == "SINHVIEN")
            {
                label1.Text = "MASV";
                label2.Text = "HOTEN";
                label3.Text = "PHAI";
                label4.Text = "NGSINH";
                label5.Text = "DCHI";
                label6.Text = "DT";
                label7.Text = "MACT";
                label8.Text = "MANGANH";
                label9.Text = "SOTCTL";
                label10.Text = "DTBTL";
            }
            if (tablename == "DONVI")
            {
                label4.Hide();
                label5.Hide();
                label6.Hide();
                label7.Hide();
                label8.Hide();
                label9.Hide();
                label10.Hide();
                textBox4.Hide();
                textBox5.Hide();
                textBox6.Hide();
                textBox7.Hide();
                textBox8.Hide();
                textBox9.Hide();
                textBox10.Hide();

                label1.Text = "MADV";
                label2.Text = "TENDV";
                label3.Text = "TRGDV";
         
            }
            if (tablename == "HOCPHAN")
            {
                label8.Hide();
                label9.Hide();
                label10.Hide();
                textBox8.Hide();
                textBox9.Hide();
                textBox10.Hide();

                label1.Text = "MAHP";
                label2.Text = "TENHP";
                label3.Text = "SOTC";
                label4.Text = "STLT";
                label5.Text = "STTH";
                label6.Text = "SOSVTD";
                label7.Text = "MADV";
            }
            if (tablename == "KHMO")
            {
                label5.Hide();
                label6.Hide();
                label7.Hide();
                label8.Hide();
                label9.Hide();
                label10.Hide();
                textBox5.Hide();
                textBox6.Hide();
                textBox7.Hide();
                textBox8.Hide();
                textBox9.Hide();
                textBox10.Hide();

                label1.Text = "MAHP";
                label2.Text = "HK";
                label3.Text = "NAM";
                label4.Text = "MACT";

            }
            if (tablename == "PHANCONG")
            {
                label6.Hide();
                label7.Hide();
                label8.Hide();
                label9.Hide();
                label10.Hide();
                textBox6.Hide();
                textBox7.Hide();
                textBox8.Hide();
                textBox9.Hide();
                textBox10.Hide();

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
                label7.Text = "DIEMTH";
                label8.Text = "DIEMQT";
                label9.Text = "DIEMCK";
                label10.Text = "DIETK";
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
                        query = "INSERT INTO ADMINLC." + tablename + " VALUES ('"
                            + textBox1.Text.ToString() + "', '"
                            + textBox2.Text.ToString() + "', '"
                            + textBox3.Text.ToString() + "', to_date('"
                            + textBox4.Text.ToString() + "', 'YYYY-MM-DD'), "
                            + textBox5.Text.ToString() + ", '"
                            + textBox6.Text.ToString() + "', '"
                            + textBox7.Text.ToString() + "', '"
                            + textBox8.Text.ToString() + "') ";
                    }
                    if (tablename == "SINHVIEN")
                    {
                        query = "INSERT INTO ADMINLC." + tablename + " VALUES ('"
                                                    + textBox1.Text.ToString() + "', '"
                                                    + textBox2.Text.ToString() + "', '"
                                                    + textBox3.Text.ToString() + "', to_date('"
                                                    + textBox4.Text.ToString() + "', 'YYYY-MM-DD'), "
                                                    + textBox5.Text.ToString() + "', '"
                                                    + textBox6.Text.ToString() + "', '"
                                                    + textBox7.Text.ToString() + "', '"
                                                    + textBox8.Text.ToString() + "', "
                                                    + textBox9.Text.ToString() + ", "
                                                    + textBox10.Text.ToString() + ") ";
                    }
                    if (tablename == "DONVI")
                    {
                        query = "INSERT INTO ADMINLC." + tablename + " VALUES ('"
                                                                            + textBox1.Text.ToString() + "', '"
                                                                            + textBox2.Text.ToString() + "', '"
                                                                            + textBox3.Text.ToString() + "') ";
                    }
                    if (tablename == "HOCPHAN")
                    {
                        query = "INSERT INTO ADMINLC." + tablename + " VALUES ('"
                                                                            + textBox1.Text.ToString() + "', '"
                                                                            + textBox2.Text.ToString() + "', "
                                                                            + textBox3.Text.ToString() + ", "
                                                                            + textBox4.Text.ToString() + ", "
                                                                            + textBox5.Text.ToString() + ", "
                                                                            + textBox6.Text.ToString() + ", '"
                                                                            + textBox7.Text.ToString() + "') ";
                    }
                    if (tablename == "KHMO")
                    {
                        query = "INSERT INTO ADMINLC." + tablename + " VALUES ('"
                                                                            + textBox1.Text.ToString() + "', "
                                                                            + textBox2.Text.ToString() + ", "
                                                                            + textBox3.Text.ToString() + ", '"
                                                                            + textBox4.Text.ToString() + "') ";
                    }
                    if (tablename == "PHANCONG")
                    {
                        query = "INSERT INTO ADMINLC." + tablename + " VALUES ('"
                                                                            + textBox1.Text.ToString() + "', '"
                                                                            + textBox2.Text.ToString() + "', "
                                                                            + textBox3.Text.ToString() + ", "
                                                                            + textBox4.Text.ToString() + ", '"
                                                                            + textBox5.Text.ToString() + "') ";
                    }
                    if (tablename == "DANGKY")
                    {
                        query = "INSERT INTO ADMINLC." + tablename + " VALUES ('"
                                                                            + textBox1.Text.ToString() + "', '"
                                                                            + textBox2.Text.ToString() + "', '"
                                                                            + textBox3.Text.ToString() + "', "
                                                                            + textBox4.Text.ToString() + ", "
                                                                            + textBox5.Text.ToString() + ", '"
                                                                            + textBox6.Text.ToString() + "', "
                                                                            + textBox7.Text.ToString() + ", "
                                                                            + textBox8.Text.ToString() + ", "
                                                                            + textBox9.Text.ToString() + ", "
                                                                            + textBox10.Text.ToString() + ") ";
                    }
                    OracleCommand cmd = new OracleCommand(query, conn);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
                MessageBox.Show("Thêm Thành Công! ", "Thông Báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
