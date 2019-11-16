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
    public partial class Artists : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            //if (e.Exception != null)
            //{
            //    lblError.Text = "An error has occured; the data was not updated: " + (e.Exception.Message);
            //    e.ExceptionHandled = true;
            //    e.KeepInEditMode = true;
            //}

         
        }

        protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            //if (e.Exception != null)
            //{
            //    lblError.Text = "An error has occured; the data was not deleted: " + (e.Exception.Message);
            //    e.ExceptionHandled = true;
            //}
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtFirst.Text = "";
            txtLast.Text = "";
            txtType.Text = "";
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection con = new SqlConnection();
                con.ConnectionString = ConfigurationManager.ConnectionStrings["disk_inventoryBHConnectionString2"].ConnectionString;
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_Insert_Artist", con);
                //cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@artist_first", txtFirst.Text);
                cmd.Parameters.AddWithValue("@artist_type_id", txtType.Text);
                cmd.Parameters.AddWithValue("@artist_last", txtLast.Text);
                // If you are passing any parameters to your Stored procedure
                // cmd.Parameters.AddWithValue("@Parameter_name", Parameter_value);

                cmd.ExecuteNonQuery();
                con.Close();

                Response.Redirect("Artists.aspx");
            }
            catch
            {
                lblError.Text = "An Error has occured and your data was not submitted \n";
            }
            
        }
    }
}