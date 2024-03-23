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
    public partial class ChinhSua_Role : Them_Role
    {
        public ChinhSua_Role(string connectString) : base(connectString) 
        {
            InitializeComponent();
        }

        private void ChinhSua_Role_Load(object sender, EventArgs e)
        {
            GetLabelText("Chỉnh Sửa Vai Trò");
            Lock_text2();
        }
    }
}
