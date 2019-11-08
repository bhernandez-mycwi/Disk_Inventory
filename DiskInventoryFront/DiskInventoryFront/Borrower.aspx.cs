using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DiskInventoryFront
{
    public partial class Borrower : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                
                lblMessage.Text = "The following information has been submitted:" +
                    "</br>" + "First Name: " + txtFirst.Text +
                    "</br>" + "Last Name: " + txtLast.Text +
                    "</br>" + "Phone Name: " + txtPhone.Text;

                txtFirst.Text = "";
                txtLast.Text = "";
                txtPhone.Text = "";
            }
        }
    }
}