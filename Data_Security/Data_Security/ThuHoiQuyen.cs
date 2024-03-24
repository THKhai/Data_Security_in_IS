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
    public partial class ThuHoiQuyen : Form
    {

        string connectstr;
        int formstatus = 0;
        public ThuHoiQuyen(string constr)
        {
            connectstr = constr;
            InitializeComponent();
        }

        private void ThuHoiQuyen_User_Load(object sender, EventArgs e)
        {
            label4.Text = "Đang thực hiện thu hồi quyền cho User";
            label4.ForeColor = System.Drawing.Color.Red;
            formstatus = 1;
            label1.Text = "Tên User bị thu hồi quyền";
            textBox3.Hide();
            textBox4.Hide();
            label6.Hide();
            label7.Hide();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            formstatus = 1;
            label4.Text = "Đang thực hiện thu hồi quyền cho User";
            label4.ForeColor = System.Drawing.Color.Red;
            label1.Text = "Tên User bị thu hồi quyền";
            label2.Show();
            checkedListBox1.Show();
            button5.Show();
            label3.Text = "Trên bảng:";
            checkBox1.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            formstatus = 2;
            label4.Text = "Đang thực hiện thu hồi quyền cho Role";
            label4.ForeColor = System.Drawing.Color.Blue;
            label1.Text = "Tên Role bị thu hồi cấp quyền";
            label2.Show();
            checkedListBox1.Show();
            button5.Show();
            label3.Text = "Trên bảng:";
            checkBox1.Hide();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            formstatus = 3;
            label4.Text = "Đang thực hiện thu hồi Role cho User";
            label4.ForeColor = System.Drawing.Color.Green;
            label1.Text = "Tên User cần bị thu hồi Role";
            label2.Hide();
            checkedListBox1.Hide();
            button5.Hide();
            label7.Hide();
            textBox3.Hide();
            label6.Hide();
            textBox4.Hide();
            label3.Text = "Role sẽ bị thu hồi cho User:";
            checkBox1.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            try
            {
                if (formstatus == 1 || formstatus == 2)
                {
                    string temp = "";
                    int n = checkedListBox1.CheckedItems.Count;
                    if (n == 0)
                    {
                        MessageBox.Show("Không được để trống ô thu hồi quyền");
                    }
                    else
                    {


                        for (int i = 0; i < n - 1; i++)
                        {
                            temp += checkedListBox1.CheckedItems[i].ToString();
                            temp += ", ";

                        }
                        temp += checkedListBox1.CheckedItems[n - 1];

                    }
                    if (formstatus == 1)
                    {
                        using (OracleConnection con = new OracleConnection(connectstr))
                        {
                            string query;
                            string query2;
                            if (checkBox1.Checked == false)
                            {
                                if (String.IsNullOrEmpty(textBox3.Text.ToString()) == true && String.IsNullOrEmpty(textBox4.Text.ToString()) == true)
                                {
                                    query = String.Format("REVOKE {0} ON {1} FROM {2}", temp, textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());

                                }
                                else
                                {
                                    if (String.IsNullOrEmpty(textBox3.Text.ToString()) == false && String.IsNullOrEmpty(textBox4.Text.ToString()) == false)
                                    {
                                        temp = temp.Replace("SELECT", String.Format("SELECT({0})", textBox3.Text.ToString().ToUpper()));
                                        temp = temp.Replace("UPDATE", String.Format("UPDATE({0})", textBox4.Text.ToString().ToUpper()));
                                    }
                                    else if (String.IsNullOrEmpty(textBox3.Text.ToString()) == true && String.IsNullOrEmpty(textBox4.Text.ToString()) == false)
                                    {
                                        temp = temp.Replace("UPDATE", String.Format("UPDATE({0})", textBox4.Text.ToString().ToUpper()));
                                    }
                                    else
                                    {
                                        temp = temp.Replace("SELECT", String.Format("SELECT({0})", textBox3.Text.ToString().ToUpper()));
                                    }
                                    query = String.Format("REVOKE {0} ON {1} FROM {2}", temp, textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                                }
                            }
                            else
                            {
                                if (String.IsNullOrEmpty(textBox3.Text.ToString()) == true && String.IsNullOrEmpty(textBox4.Text.ToString()) == true)
                                {
                                    query = String.Format("REVOKE SELECT {0} ON {1} FROM {2}; GRANT SELECT {0} ON {1} TO {2}", temp, textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());

                                }
                                else
                                {
                                    if (String.IsNullOrEmpty(textBox3.Text.ToString()) == false && String.IsNullOrEmpty(textBox4.Text.ToString()) == false)
                                    {
                                        temp = temp.Replace("SELECT", String.Format("SELECT({0})", textBox3.Text.ToString().ToUpper()));
                                        temp = temp.Replace("UPDATE", String.Format("UPDATE({0})", textBox4.Text.ToString().ToUpper()));
                                    }
                                    else if (String.IsNullOrEmpty(textBox3.Text.ToString()) == true && String.IsNullOrEmpty(textBox4.Text.ToString()) == false)
                                    {
                                        temp = temp.Replace("UPDATE", String.Format("UPDATE({0})", textBox4.Text.ToString().ToUpper()));
                                    }
                                    else
                                    {
                                        temp = temp.Replace("SELECT", String.Format("SELECT({0})", textBox3.Text.ToString().ToUpper()));
                                    }
                                    query = String.Format("REVOKE SELECT {0} ON {1} FROM {2}; GRANT SELECT {0} ON {1} TO {2}", temp, textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                                }
                            }
                            con.Open();
                            OracleCommand comm = new OracleCommand(query, con);
                            comm.ExecuteNonQuery();
                            con.Close();
                
                            MessageBox.Show("Thu hồi quyền thành công");
                            this.Close();
                        }
                    }
                    else
                    {
                        using (OracleConnection con = new OracleConnection(connectstr))
                        {
                            string query;
                            if (checkBox1.Checked == false)
                            {
                                if (String.IsNullOrEmpty(textBox3.Text.ToString()) == true && String.IsNullOrEmpty(textBox4.Text.ToString()) == true)
                                {
                                    query = String.Format("REVOKE {0} ON {1} FROM {2}", temp, textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                                }
                                else
                                {
                                    if (String.IsNullOrEmpty(textBox3.Text.ToString()) == false && String.IsNullOrEmpty(textBox4.Text.ToString()) == false)
                                    {
                                        temp = temp.Replace("SELECT", String.Format("SELECT({0})", textBox3.Text.ToString().ToUpper()));
                                        temp = temp.Replace("UPDATE", String.Format("UPDATE({0})", textBox4.Text.ToString().ToUpper()));
                                    }
                                    else if (String.IsNullOrEmpty(textBox3.Text.ToString()) == true && String.IsNullOrEmpty(textBox4.Text.ToString()) == false)
                                    {
                                        temp = temp.Replace("UPDATE", String.Format("UPDATE({0})", textBox4.Text.ToString().ToUpper()));
                                    }
                                    else
                                    {
                                        temp = temp.Replace("SELECT", String.Format("SELECT({0})", textBox3.Text.ToString().ToUpper()));
                                    }
                                    query = String.Format("REVOKE {0} ON {1} FROM {2}", temp, textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                                }
                            }
                            else
                            {
                                if (String.IsNullOrEmpty(textBox3.Text.ToString()) == true && String.IsNullOrEmpty(textBox4.Text.ToString()) == true)
                                {
                                    query = String.Format("REVOKE ADMIN OPTION FOR {0} ON {1} FROM {2}", temp, textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                                    //UNSURE
                                }
                                else
                                {
                                    if (String.IsNullOrEmpty(textBox3.Text.ToString()) == false && String.IsNullOrEmpty(textBox4.Text.ToString()) == false)
                                    {
                                        temp = temp.Replace("SELECT", String.Format("SELECT({0})", textBox3.Text.ToString().ToUpper()));
                                        temp = temp.Replace("UPDATE", String.Format("UPDATE({0})", textBox4.Text.ToString().ToUpper()));
                                    }
                                    else if (String.IsNullOrEmpty(textBox3.Text.ToString()) == true && String.IsNullOrEmpty(textBox4.Text.ToString()) == false)
                                    {
                                        temp = temp.Replace("UPDATE", String.Format("UPDATE({0})", textBox4.Text.ToString().ToUpper()));
                                    }
                                    else
                                    {
                                        temp = temp.Replace("SELECT", String.Format("SELECT({0})", textBox3.Text.ToString().ToUpper()));
                                    }
                                    query = String.Format("REVOKE ADMIN OPTION FOR {0} ON {1} FROM {2}", temp, textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                                }
                            }
                            con.Open();
                            OracleCommand comm = new OracleCommand(query, con);
                            comm.ExecuteNonQuery();
                            con.Close();
                            MessageBox.Show("Thu hồi quyền thành công");
                            this.Close();
                        }
                    }

                }
                else
                {
                    using (OracleConnection con = new OracleConnection(connectstr))
                    {
                        string query;
                        if (checkBox1.Checked == false)
                        {
                            query = String.Format("REVOKE {0} FROM {1}", textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                        }
                        else
                        {
                            query = String.Format("REVOKE ADMIN OPTION FOR {0} FROM {1}", textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                        }
                        con.Open();
                        OracleCommand comm = new OracleCommand(query, con);
                        comm.ExecuteNonQuery();
                        con.Close();
                        MessageBox.Show("Thu hồi quyền thành công");
                        this.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            int n = checkedListBox1.CheckedItems.Count;
            int flag = 0;
            for (int i = 0; i < n; i++)
            {
                if (checkedListBox1.CheckedItems[i].ToString() == "SELECT")
                {
                    label7.Show();
                    textBox3.Show();
                    flag++;
                }
                if (checkedListBox1.CheckedItems[i].ToString() == "UPDATE")
                {
                    label6.Show();
                    textBox4.Show();
                    flag++;
                }

            }
            if (flag == 0)
            {
                MessageBox.Show("Chỉ có thể thu hồi quyền mức độ cột cho SELECT hoặc UPDATE");
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
