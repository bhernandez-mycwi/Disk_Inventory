using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

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
                SqlConnection con = new SqlConnection();
                con.ConnectionString = ConfigurationManager.ConnectionStrings["disk_inventoryBHConnectionString2"].ConnectionString;
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_Insert_Borrower", con);
                //cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@borrower_first", txtFirst.Text);
                cmd.Parameters.AddWithValue("@borrower_phone", txtPhone.Text);
                cmd.Parameters.AddWithValue("@borrower_last", txtLast.Text);
                // If you are passing any parameters to your Stored procedure
                // cmd.Parameters.AddWithValue("@Parameter_name", Parameter_value);

                cmd.ExecuteNonQuery();
                con.Close();

                Response.Redirect("Borrower.aspx");

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