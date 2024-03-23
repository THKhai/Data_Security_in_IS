//using Oracle.DataAccess.Client;
//using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
//using Oracle.DataAccess.Client;
using Oracle.ManagedDataAccess.Client;
namespace Data_Security
{
    public partial class Privilege : Form
    {
        string current_chosen = null;
        bool role = false,user = false;
        string connectString = null;
        
        public Privilege(string cnStr)
        {
            connectString = cnStr;
            InitializeComponent();
        }

        private void Privilege_Load(object sender, EventArgs e)
        {

        }

        private void ROLE_Click(object sender, EventArgs e)
        {

        }
        // chỉnh sử button
        private void button1_Click(object sender, EventArgs e)
        {
            if (role)
            {
                ChinhSua_Role cs_role = new ChinhSua_Role(connectString);
                cs_role.ShowDialog();
                load_Role();
            }
            else if (user)
            {
                ChinhSua_User cs_User = new ChinhSua_User(current_chosen, connectString);
                cs_User.ShowDialog();
                load_user();
            }
            else
            {
                MessageBox.Show("Thông báo lỗi!", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            current_chosen = dataGridView1.Rows[e.RowIndex].Cells[0].Value.ToString();
            string TABLE_NAME = null;
            string Role_Tab= null;
            string User_Tab= null;
           if (role)
           {
                TABLE_NAME = dataGridView1.Rows[e.RowIndex].Cells["TABLE_NAME"].Value.ToString();
                Role_Tab = dataGridView1.Rows[e.RowIndex].Cells["ROLE"].Value.ToString() ;  
                try
                {
                    using(OracleConnection con = new OracleConnection(connectString))
                    {
                        string query = "select distinct  TABLE_NAME, PRIVILEGE from ROLE_TAB_PRIVS where ROLE = '" + Role_Tab + "' and TABLE_NAME = '" + TABLE_NAME + "'";
                        OracleDataAdapter dataAdapter = new OracleDataAdapter(query, con);
                        DataTable dt = new DataTable();
                        dataAdapter.Fill(dt);
                        dataGridView2.DataSource = dt;
                    }
                }
                catch(Exception ex)
                {
                    MessageBox.Show("Thông Báo Lỗi: " + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
           }
            else if (user)
            {

                TABLE_NAME = dataGridView1.Rows[e.RowIndex].Cells["TABLE_NAME"].Value.ToString();
                User_Tab = dataGridView1.Rows[e.RowIndex].Cells["GRANTEE"].Value.ToString();
                try
                {
                    using (OracleConnection con = new OracleConnection(connectString))
                    {
                        string query = "select distinct  GRANTEE, TABLE_NAME, PRIVILEGE from ALL_TAB_PRIVS WHERE GRANTEE = '" + User_Tab + "' and TABLE_NAME = '" + TABLE_NAME + "'";
                        OracleDataAdapter dataAdapter = new OracleDataAdapter(query, con);
                        DataTable dt = new DataTable();
                        dataAdapter.Fill(dt);
                        dataGridView2.DataSource = dt;
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Thông Báo Lỗi: " + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void label5_Click(object sender, EventArgs e)
        {
        }
        // ROLE button
        private void button2_Click(object sender, EventArgs e)
        {
            load_Role();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

            if (dataGridView1.DataSource is DataTable dataTable)
            {
                // Construct the filter expression for all columns
                string filterExpression = string.Empty;
                foreach (DataColumn column in dataTable.Columns)
                {
                    if (!string.IsNullOrEmpty(filterExpression))
                        filterExpression += " OR ";

                    // Construct the condition to check if any cell in the column contains the search text
                    filterExpression += $"CONVERT([{column.ColumnName}], 'System.String') LIKE '%{textBox1.Text}%'";
                }

                // Apply the filter to the DataTable's DefaultView
                dataTable.DefaultView.RowFilter = filterExpression;
            }
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            if (dataGridView2.DataSource is DataTable dataTable)
            {
                // Construct the filter expression for all columns
                string filterExpression = string.Empty;
                foreach (DataColumn column in dataTable.Columns)
                {
                    if (!string.IsNullOrEmpty(filterExpression))
                        filterExpression += " OR ";

                    // Construct the condition to check if any cell in the column contains the search text
                    filterExpression += $"CONVERT([{column.ColumnName}], 'System.String') LIKE '%{textBox2.Text}%'";
                }

                // Apply the filter to the DataTable's DefaultView
                dataTable.DefaultView.RowFilter = filterExpression;
            }
        }

        private void ROLE_Click_1(object sender, EventArgs e)
        {

        }

        // thêm button
        private void button4_Click(object sender, EventArgs e)
        {
            if (role)
            {
                Them_Role New_role = new Them_Role(connectString);
                New_role.ShowDialog();
                load_Role();
            }
            else if (user)
            {
                Them_User New_user = new Them_User( connectString);
                New_user.ShowDialog();
                load_user();
            }
            else
            {
                MessageBox.Show("Thông báo lỗi!","Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);    
            }
        }
        // reload_role
        void load_Role()
        {
            role = true;
            if (user)
                user = false;
            try
            {
                using (OracleConnection con = new OracleConnection(connectString))
                {
                    var query = "select distinct ROLE, TABLE_NAME from ROLE_TAB_PRIVS order by ROLE";
                    OracleDataAdapter adapter = new OracleDataAdapter(query, con);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    dataGridView1.DataSource = dt;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Có Lỗi: " + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        // reload user
        void load_user()
        {
            user = true;
            if (role)
                role = false;
            try
            {
                using (OracleConnection con = new OracleConnection(connectString))
                {
                    var query = "select distinct GRANTEE, TABLE_NAME from ALL_TAB_PRIVS order by GRANTEE";
                    OracleDataAdapter adapter = new OracleDataAdapter(query, con);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    dataGridView1.DataSource = dt;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Có Lỗi: " + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        // Xóa button
        private void button5_Click(object sender, EventArgs e)
        {
            if (role)
            {
                try
                {
                    using (OracleConnection conn = new OracleConnection(connectString))
                    {
                        conn.Open();
                        string query_01 = "alter session set \"_ORACLE_SCRIPT\"=true";
                        string query = "Drop role " + current_chosen;
                        OracleCommand comm = new OracleCommand(query, conn);
                        OracleCommand comm_01 = new OracleCommand(query_01, conn);
                        comm_01.ExecuteNonQuery();
                        comm.ExecuteNonQuery();
                        conn.Close();
                    }
                    MessageBox.Show("Xóa Thành Công", "Thông Báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Thông Báo Lỗi: " + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            else if (user)
            {
                try
                {
                    using (OracleConnection conn = new OracleConnection(connectString))
                    {
                        conn.Open();
                        string query_01 = "alter session set \"_ORACLE_SCRIPT\"=true";
                        string query = "Drop user " + current_chosen;
                        OracleCommand comm = new OracleCommand(query, conn);
                        OracleCommand comm_01 = new OracleCommand(query_01, conn);
                        comm_01.ExecuteNonQuery();
                        comm.ExecuteNonQuery();
                        conn.Close();
                    }
                    MessageBox.Show("Xóa Thành Công", "Thông Báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Thông Báo Lỗi: " + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            CapQuyen cp = new CapQuyen(connectString);
            cp.ShowDialog();
        }

        // USER button
        private void button3_Click(object sender, EventArgs e)
        {
            load_user();
        }
    }
}
