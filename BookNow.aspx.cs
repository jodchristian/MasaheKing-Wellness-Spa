using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MasaheKingWellnessSpa
{
    public partial class BookNow : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            // Only proceed if all RequiredFieldValidators are satisfied
            if (Page.IsValid)
            {
                string name = txtName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string gender = rblGender.SelectedValue;
                string category = rblService.SelectedValue;


                // ----------------------------------

                int newCustomerId = 0;
                string connStr = ConfigurationManager.ConnectionStrings["MKWellnessSpaDB"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    // Note: We use SCOPE_IDENTITY() to get the ID for the next page
                    string sql = @"INSERT INTO tbl_CustomerInformation 
                           (CustomerName, Phone, Email, Gender, CustomerStatus) 
                           VALUES (@name, @phone, @email, @gender, 'Active');
                           SELECT SCOPE_IDENTITY();";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@name", name);
                        cmd.Parameters.AddWithValue("@phone", phone);
                        cmd.Parameters.AddWithValue("@email", string.IsNullOrEmpty(email) ? (object)DBNull.Value : email);
                        cmd.Parameters.AddWithValue("@gender", string.IsNullOrEmpty(gender) ? "Not Specified" : gender);

                        con.Open();
                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            newCustomerId = Convert.ToInt32(result);
                        }
                    }
                }

                // Redirect to Page 2 with the ID and Category
                Response.Redirect($"BookNow2.aspx?custID={newCustomerId}&service={Server.UrlEncode(category)}");
            }
        }
    }
}