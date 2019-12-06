/*************************************************************************************/
/*  Date	Name	Description                                                      */
/*  -----------------------------------------------------------------------------    */
/*                                                                                   */
/*  12/02/2019  Brian Hernandez   Initial deploy of Check Out Page  
 *  12/3/2019   Brian Hernandez   Added functionality of checkout button to update db*/
/*************************************************************************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace DiskInventoryFront.Maintenance
{
    public partial class CheckOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Name"] != null)
            {
                lblSummary.Text = "<b>" + Session["Name"].ToString()+ "</b>" + " has checked out " + "<i>" + Session["Disk"].ToString() + "</i>" ;

            }
    }

        protected void OnSelectedIndexChanged(object sender, EventArgs e)
        {
            lblDiskNameOutput.Text = GridView1.SelectedRow.Cells[0].Text;
            lblDiskIDOutput.Text = GridView1.SelectedRow.Cells[3].Text;


            foreach(GridViewRow row in GridView1.Rows)
            {
                if(row.RowIndex == GridView1.SelectedIndex)
                {
                    row.CssClass = "bg-primary";
                }
                else
                {
                    row.CssClass = "bg-light";
                }
            }

            
        }

        protected void btnCheckOut_Click(object sender, EventArgs e)
        {
            if (GridView1.SelectedRow != null){

                try
                {
                    SqlConnection con = new SqlConnection();
                    con.ConnectionString = ConfigurationManager.ConnectionStrings["disk_inventoryBHConnectionString2"].ConnectionString;
                    con.Open();


                    SqlCommand cmd = new SqlCommand("sp_Update_DiskInfo", con);
                    //cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@disk_id", lblDiskIDOutput.Text);
                    cmd.Parameters.AddWithValue("@diskName", lblDiskNameOutput.Text);
                    cmd.Parameters.AddWithValue("@diskStatus", 1);
                    cmd.Parameters.AddWithValue("@diskType", GridView1.SelectedRow.Cells[4].Text);
                    cmd.Parameters.AddWithValue("@genreID", GridView1.SelectedRow.Cells[5].Text);
                    cmd.Parameters.AddWithValue("@releaseDate", GridView1.SelectedRow.Cells[6].Text);
                    cmd.ExecuteNonQuery();


                    con.Close();
                    SqlConnection con2 = new SqlConnection();
                    con2.ConnectionString = ConfigurationManager.ConnectionStrings["disk_inventoryBHConnectionString2"].ConnectionString;
                    con2.Open();
                    SqlCommand cmd2 = new SqlCommand("sp_Insert_DiskBorrower", con2);
                    cmd2.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd2.Parameters.AddWithValue("@disk_id", lblDiskIDOutput.Text);
                    cmd2.Parameters.AddWithValue("@borrower_id", DropDownList1.SelectedValue);
                    cmd2.Parameters.AddWithValue("@borrow_date", DateTime.Now.ToShortDateString());
                    cmd2.ExecuteNonQuery();
                    con2.Close();

                    Session["Name"] = DropDownList1.SelectedItem;
                    Session["Disk"] = lblDiskNameOutput.Text;

                    Response.Redirect("CheckOut.aspx");

                }
                catch (SqlException ex)
                {
                    lblError.Text = "An Error has occured and your data was not submitted \n" + ex.Message;
                }
            }
            else
            {
                lblError.Text = "You must first select a disk to check out";
                
            }
        }
            
    }
       
}
