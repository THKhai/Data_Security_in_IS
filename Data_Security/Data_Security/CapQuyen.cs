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
namespace Data_Security
{
    public partial class CapQuyen : Form
    {
        string connectstr;
        int formstatus = 0;
        public CapQuyen(string constr)
        {
            connectstr = constr;
            InitializeComponent();
        }
        private void TaoViewGioiHanSelect(string tendoituong,string tenbang,string caccotbihanche, OracleConnection con)
        {
            string query,query2;
            string viewname = "V_" + tendoituong + tenbang;
            query = String.Format("create or replace view {0} \r\nas\r\n    select {1} from sys.{2}", viewname,caccotbihanche,tenbang);
            //query = "create or replace view V_DEMO \r\nas\r\n    select DIACHI from sys.BH_KHACHHANG";
            query2 = String.Format("GRANT SELECT ON {0} to {1}", viewname, tendoituong);
            try
            {
             
                    con.Open();
                    OracleCommand comm = new OracleCommand(query, con);
                    comm.ExecuteNonQuery();
                    
                    con.Close();
                    con.Open();
                    OracleCommand comm2 = new OracleCommand(query2, con);
                    comm2.ExecuteNonQuery();
                    con.Close();
                
         
                MessageBox.Show("View "+ viewname +" đã được tạo");
            }
            catch (Exception ex) { MessageBox.Show(ex.Message); }
        }
        private void CapQuyen_Load(object sender, EventArgs e)
        {
            label4.Text = "Đang thực hiện cấp quyền cho User";
            label4.ForeColor = System.Drawing.Color.Red;
            formstatus = 1;
            label1.Text = "Tên User được cấp quyền";
            textBox3.Hide();
            textBox4.Hide();
            label6.Hide();
            label7.Hide();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            formstatus = 1;
            label4.Text = "Đang thực hiện cấp quyền cho User";
            label4.ForeColor = System.Drawing.Color.Red;
            label1.Text = "Tên User được cấp quyền";
            label2.Show();
            checkedListBox1.Show();
            button5.Show();
            label3.Text = "Trên bảng:";
            checkBox1.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            formstatus = 2;
            label4.Text = "Đang thực hiện cấp quyền cho Role";
            label4.ForeColor = System.Drawing.Color.Blue;
            label1.Text = "Tên Role được cấp quyền";
            label2.Show();
            checkedListBox1.Show();
            button5.Show();
            label3.Text = "Trên bảng:";
            checkBox1.Hide();
        }
        
        private void button3_Click(object sender, EventArgs e)
        {
            formstatus = 3;
            label4.Text = "Đang thực hiện cấp Role cho User";
            label4.ForeColor = System.Drawing.Color.Green;
            label1.Text = "Tên User cần được cấp Role";
            label2.Hide();
            checkedListBox1.Hide();
            button5.Hide();
            label7.Hide();
            textBox3.Hide();
            label6.Hide() ;
            textBox4.Hide();
            label3.Text = "Role sẽ được cấp cho User:";
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
                        MessageBox.Show("Không được để trống ô cấp quyền");
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
                    if(formstatus == 1)
                    {
                        using (OracleConnection con = new OracleConnection(connectstr))
                        {
                            string query;
                            if (checkBox1.Checked == false)
                            {   
                                if(String.IsNullOrEmpty(textBox3.Text.ToString()) == true && String.IsNullOrEmpty(textBox4.Text.ToString()) == true)
                                {
                                    query = String.Format("GRANT {0} ON {1} TO {2}", temp, textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                                }
                                else
                                {
                                    if(String.IsNullOrEmpty(textBox3.Text.ToString()) == false && String.IsNullOrEmpty(textBox4.Text.ToString()) == false)
                                    {
                                        temp = temp.Replace(", SELECT", "");
                                        temp = temp.Replace("SELECT,", "");
                                        temp = temp.Replace("SELECT", "");
                                        TaoViewGioiHanSelect(textBox1.Text.ToString().ToUpper(), textBox2.Text.ToString().ToUpper(), textBox3.Text.ToString().ToUpper(),con);
                                        temp = temp.Replace("UPDATE", String.Format("UPDATE({0})", textBox4.Text.ToString().ToUpper()));
                                    }
                                    else if(String.IsNullOrEmpty(textBox3.Text.ToString()) == true && String.IsNullOrEmpty(textBox4.Text.ToString()) == false)
                                    {
                                        temp = temp.Replace("UPDATE", String.Format("UPDATE({0})", textBox4.Text.ToString().ToUpper()));
                                    }
                                    else
                                    {
                                        temp = temp.Replace(", SELECT", "");
                                        temp = temp.Replace("SELECT,", "");
                                        temp = temp.Replace("SELECT", "");
                                        TaoViewGioiHanSelect(textBox1.Text.ToString().ToUpper(), textBox2.Text.ToString().ToUpper(), textBox3.Text.ToString().ToUpper(), con);
                                    }
                                    query = String.Format("GRANT {0} ON {1} TO {2}", temp, textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                                }
                            }
                            else
                            {
                                if (String.IsNullOrEmpty(textBox3.Text.ToString()) == true && String.IsNullOrEmpty(textBox4.Text.ToString()) == true)
                                {
                                    query = String.Format("GRANT {0} ON {1} TO {2} WITH GRANT OPTION", temp, textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                                }
                                else
                                {
                                    if (String.IsNullOrEmpty(textBox3.Text.ToString()) == false && String.IsNullOrEmpty(textBox4.Text.ToString()) == false)
                                    {
                                        temp = temp.Replace(", SELECT", "");
                                        temp = temp.Replace("SELECT,", "");
                                        temp = temp.Replace("SELECT", "");
                                        TaoViewGioiHanSelect(textBox1.Text.ToString().ToUpper(), textBox2.Text.ToString().ToUpper(), textBox3.Text.ToString().ToUpper(), con);
                                        temp = temp.Replace("UPDATE", String.Format("UPDATE({0})", textBox4.Text.ToString().ToUpper()));
                                    }
                                    else if (String.IsNullOrEmpty(textBox3.Text.ToString()) == true && String.IsNullOrEmpty(textBox4.Text.ToString()) == false)
                                    {
                                        temp = temp.Replace("UPDATE", String.Format("UPDATE({0})", textBox4.Text.ToString().ToUpper()));
                                    }
                                    else
                                    {
                                        temp = temp.Replace(", SELECT", "");
                                        temp = temp.Replace("SELECT,", "");
                                        temp = temp.Replace("SELECT", "");
                                        TaoViewGioiHanSelect(textBox1.Text.ToString().ToUpper(), textBox2.Text.ToString().ToUpper(), textBox3.Text.ToString().ToUpper(), con);
                                    }
                                    query = String.Format("GRANT {0} ON {1} TO {2} WITH GRANT OPTION", temp, textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                                }
                            }
                            if (temp != "")
                            {
                                con.Open();
                                OracleCommand comm = new OracleCommand(query, con);
                                comm.ExecuteNonQuery();
                                con.Close();
                            }
                            MessageBox.Show("Phân quyền thành công");
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
                                    query = String.Format("GRANT {0} ON {1} TO {2}", temp, textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                                }
                                else
                                {
                                    if (String.IsNullOrEmpty(textBox3.Text.ToString()) == false && String.IsNullOrEmpty(textBox4.Text.ToString()) == false)
                                    {
                                        temp = temp.Replace(", SELECT", "");
                                        temp = temp.Replace("SELECT,", "");
                                        temp = temp.Replace("SELECT", "");
                                        TaoViewGioiHanSelect(textBox1.Text.ToString().ToUpper(), textBox2.Text.ToString().ToUpper(), textBox3.Text.ToString().ToUpper(), con);
                                        temp = temp.Replace("UPDATE", String.Format("UPDATE({0})", textBox4.Text.ToString().ToUpper()));
                                    }
                                    else if (String.IsNullOrEmpty(textBox3.Text.ToString()) == true && String.IsNullOrEmpty(textBox4.Text.ToString()) == false)
                                    {
                                        temp = temp.Replace("UPDATE", String.Format("UPDATE({0})", textBox4.Text.ToString().ToUpper()));
                                    }
                                    else
                                    {
                                        temp = temp.Replace(", SELECT", "");
                                        temp = temp.Replace("SELECT,", "");
                                        temp = temp.Replace("SELECT", "");
                                        TaoViewGioiHanSelect(textBox1.Text.ToString().ToUpper(), textBox2.Text.ToString().ToUpper(), textBox3.Text.ToString().ToUpper(), con);
                                    }
                                    query = String.Format("GRANT {0} ON {1} TO {2}", temp, textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                                }
                            }
                            else
                            {
                                if (String.IsNullOrEmpty(textBox3.Text.ToString()) == true && String.IsNullOrEmpty(textBox4.Text.ToString()) == true)
                                {
                                    query = String.Format("GRANT {0} ON {1} TO {2} WITH ADMIN OPTION", temp, textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                                }
                                else
                                {
                                    if (String.IsNullOrEmpty(textBox3.Text.ToString()) == false && String.IsNullOrEmpty(textBox4.Text.ToString()) == false)
                                    {
                                        temp = temp.Replace(", SELECT", "");
                                        temp = temp.Replace("SELECT,", "");
                                        temp = temp.Replace("SELECT", "");
                                        TaoViewGioiHanSelect(textBox1.Text.ToString().ToUpper(), textBox2.Text.ToString().ToUpper(), textBox3.Text.ToString().ToUpper(), con);
                                        temp = temp.Replace("UPDATE", String.Format("UPDATE({0})", textBox4.Text.ToString().ToUpper()));
                                    }
                                    else if (String.IsNullOrEmpty(textBox3.Text.ToString()) == true && String.IsNullOrEmpty(textBox4.Text.ToString()) == false)
                                    {
                                        temp = temp.Replace("UPDATE", String.Format("UPDATE({0})", textBox4.Text.ToString().ToUpper()));
                                    }
                                    else
                                    {
                                        temp = temp.Replace(", SELECT", "");
                                        temp = temp.Replace("SELECT,", "");
                                        temp = temp.Replace("SELECT", "");
                                        TaoViewGioiHanSelect(textBox1.Text.ToString().ToUpper(), textBox2.Text.ToString().ToUpper(), textBox3.Text.ToString().ToUpper(), con);
                                    }
                                    query = String.Format("GRANT {0} ON {1} TO {2} WITH ADMIN OPTION", temp, textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                                }
                            }
                            if (temp != "")
                            {
                                con.Open();
                                OracleCommand comm = new OracleCommand(query, con);
                                comm.ExecuteNonQuery();
                                con.Close();
                            }
                            MessageBox.Show("Phân quyền thành công");
                            this.Close();
                        }
                    }
                    
                }
                else
                {
                    using (OracleConnection con = new OracleConnection(connectstr))
                    {
                        string query;
                        if(checkBox1.Checked == false) 
                        {
                            query = String.Format("GRANT {0} TO {1}", textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                        }
                        else
                        {
                            query = String.Format("GRANT {0} TO {1} WITH ADMIN OPTION", textBox2.Text.ToString().ToUpper(), textBox1.Text.ToString().ToUpper());
                        }
                        con.Open();
                        OracleCommand comm = new OracleCommand(query, con);
                        comm.ExecuteNonQuery();
                        con.Close();
                        MessageBox.Show("Phân quyền thành công");
                        this.Close();
                    }
                }
            }
            catch(Exception ex) 
            { 
                MessageBox.Show(ex.Message);
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            int n = checkedListBox1.CheckedItems.Count;
            int flag = 0;
            for(int i=0; i < n;i++)
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
                MessageBox.Show("Chỉ có thể phân quyền mức độ cột cho SELECT hoặc UPDATE");
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void label4_Click(object sender, EventArgs e)
        {

        }
    }
}