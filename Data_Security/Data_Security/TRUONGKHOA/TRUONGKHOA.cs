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
    public partial class TRUONGKHOA : Form
    {
        string connectstr;
        string table;
        public TRUONGKHOA(string strconnect)
        {
            connectstr = strconnect;
            InitializeComponent();
        }

        private void TRUONGKHOA_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            table = "NHANSU";
            Data_Security.TRUONGKHOA.Table tb = new Table(connectstr, table);
            tb.ShowDialog();
            this.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            table = "SINHVIEN";
            Data_Security.TRUONGKHOA.Table tb = new Table(connectstr, table);
            tb.ShowDialog();
            this.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            table = "DONVI";
            Data_Security.TRUONGKHOA.Table tb = new Table(connectstr, table);
            tb.ShowDialog();
            this.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            table = "HOCPHAN";
            Data_Security.TRUONGKHOA.Table tb = new Table(connectstr, table);
            tb.ShowDialog();
            this.Show();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            table = "KHMO";
            Data_Security.TRUONGKHOA.Table tb = new Table(connectstr, table);
            tb.ShowDialog();
            this.Show();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            table = "PHANCONG";
            Data_Security.TRUONGKHOA.Table tb = new Table(connectstr, table);
            tb.ShowDialog();
            this.Show();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            table = "DANGKY";
            Data_Security.TRUONGKHOA.Table tb = new Table(connectstr, table);
            tb.ShowDialog();
            this.Show();
        }

        private void button8_Click(object sender, EventArgs e)
        {

        }

        private void button9_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
