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
    public partial class ThuHoiQuyen_Role : Form
    {
        string connectstr;
        int formstatus = 0;
        public ThuHoiQuyen_Role(string constr)
        {
            connectstr = constr;
            InitializeComponent();
        }
    }
}
