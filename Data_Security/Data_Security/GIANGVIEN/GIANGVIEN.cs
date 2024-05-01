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

namespace Data_Security.GIANGVIEN
{
    public partial class GIANGVIEN : Form
    {
        string StrConnecting = string.Empty;
        string current = string.Empty;
        public GIANGVIEN(string strconnect)
        {
            StrConnecting = strconnect;
            InitializeComponent();
        }

        private void GIANGVIEN_Load(object sender, EventArgs e)
        {
            load_NV();
        }
        private void load_NV()
        {
            try
            {
                using (OracleConnection con = new OracleConnection(StrConnecting))
                {

                    var STDquery = "select * from ADMINLC.V_NHANSU";
                    OracleDataAdapter adapter = new OracleDataAdapter(STDquery, con);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    dataGridView1.DataSource = dt;
                    if (dt.Rows.Count > 0)
                    {
                        // Ví dụ: giả sử cột đầu tiên là mã nhân viên, cột thứ hai là tên nhân viên
                        label2.Text = dt.Rows[0]["MANV"].ToString();
                        label10.Text = dt.Rows[0]["HOTEN"].ToString();
                        label11.Text = dt.Rows[0]["PHAI"].ToString();
                        label12.Text = dt.Rows[0]["NGSINH"].ToString();
                        label13.Text = dt.Rows[0]["PHUCAP"].ToString();
                        label15.Text = dt.Rows[0]["VAITRO"].ToString();
                        label16.Text = dt.Rows[0]["MADV"].ToString();
                        label14.Text = dt.Rows[0]["DT"].ToString();
                        // Tương tự cho các cột khác nếu cần
                    }
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show("Đã có lỗi xáy ra " + ex.Message, "lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
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
                using (OracleConnection con = new OracleConnection(StrConnecting))
                {

                    var STDquery = "select * from ADMINLC.SINHVIEN";
                    OracleDataAdapter adapter = new OracleDataAdapter(STDquery, con);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    dataGridView1.DataSource = dt;

                }

            }
            catch (Exception ex)
            {
                MessageBox.Show("Đã có lỗi xáy ra " + ex.Message, "lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                using (OracleConnection con = new OracleConnection(StrConnecting))
                {

                    var STDquery = "select * from ADMINLC.DONVI";
                    OracleDataAdapter adapter = new OracleDataAdapter(STDquery, con);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    dataGridView1.DataSource = dt;

                }

            }
            catch (Exception ex)
            {
                MessageBox.Show("Đã có lỗi xáy ra " + ex.Message, "lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            try
            {
                using (OracleConnection con = new OracleConnection(StrConnecting))
                {

                    var STDquery = "select * from ADMINLC.HOCPHAN";
                    OracleDataAdapter adapter = new OracleDataAdapter(STDquery, con);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    dataGridView1.DataSource = dt;

                }

            }
            catch (Exception ex)
            {
                MessageBox.Show("Đã có lỗi xáy ra " + ex.Message, "lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            try
            {
                using (OracleConnection con = new OracleConnection(StrConnecting))
                {

                    var STDquery = "select * from ADMINLC.KHMO";
                    OracleDataAdapter adapter = new OracleDataAdapter(STDquery, con);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    dataGridView1.DataSource = dt;

                }

            }
            catch (Exception ex)
            {
                MessageBox.Show("Đã có lỗi xáy ra " + ex.Message, "lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            try
            {
                using (OracleConnection con = new OracleConnection(StrConnecting))
                {
                    var STDquery = "UPDATE ADMINLC.V_NHANSU SET DT = " + textBox1.Text.ToUpper() + " WHERE MANV = '" + label2.Text + "'";
                    OracleDataAdapter adapter = new OracleDataAdapter(STDquery, con);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    dataGridView1.DataSource = dt;
                    if (dt.Rows.Count > 0)
                    {
                        // Ví dụ: giả sử cột đầu tiên là mã nhân viên, cột thứ hai là tên nhân viên
                        label2.Text = dt.Rows[0]["MANV"].ToString();
                        label10.Text = dt.Rows[0]["HOTEN"].ToString();
                        label11.Text = dt.Rows[0]["PHAI"].ToString();
                        label12.Text = dt.Rows[0]["NGSINH"].ToString();
                        label13.Text = dt.Rows[0]["PHUCAP"].ToString();
                        label15.Text = dt.Rows[0]["VAITRO"].ToString();
                        label16.Text = dt.Rows[0]["MADV"].ToString();
                        label14.Text = dt.Rows[0]["DT"].ToString();
                        // Tương tự cho các cột khác nếu cần
                    }
                }
            }
            catch
            {
                MessageBox.Show("THÔNG BÁO LỖI ", "LỖI", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            load_NV();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            
            string[] mark = textBox1.Text.ToString().Split(';');

            using (OracleConnection con = new OracleConnection(StrConnecting))
            {
                var STDquery = "update ADMINLC.V_DANGKY_GV set DIEMTHI = " + mark[0] + ", DIEMQT = "+mark[1] +", DIEMCK = " + mark[3] +", DIEMTK = "+ mark[4] +" where MAHP = '" + current +"'";
                OracleDataAdapter adapter = new OracleDataAdapter(STDquery, con);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                dataGridView1.DataSource = dt;
            }
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        private void dataGridView1_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            current = dataGridView1.Rows[e.RowIndex].Cells["MAHP"].Value.ToString();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            try
            {
                using (OracleConnection con = new OracleConnection(StrConnecting))
                {

                    var STDquery = "select * from ADMINLC.V_DANGKY_GV ";
                    OracleDataAdapter adapter = new OracleDataAdapter(STDquery, con);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    dataGridView1.DataSource = dt;

                }

            }
            catch (Exception ex)
            {
                MessageBox.Show("Đã có lỗi xáy ra " + ex.Message, "lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button8_Click(object sender, EventArgs e)
        {
            try
            {
                using (OracleConnection con = new OracleConnection(StrConnecting))
                {

                    var STDquery = "select * from ADMINLC.V_PHANCONG_GV ";
                    OracleDataAdapter adapter = new OracleDataAdapter(STDquery, con);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    dataGridView1.DataSource = dt;

                }

            }
            catch (Exception ex)
            {
                MessageBox.Show("Đã có lỗi xáy ra " + ex.Message, "lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
