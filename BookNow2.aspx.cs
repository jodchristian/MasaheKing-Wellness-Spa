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
    public partial class BookNow2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve the Service Category from Page 1
                string service = Request.QueryString["service"];
                if (!string.IsNullOrEmpty(service))
                {
                    txtService.Text = service;
                }
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            // 1. Manually check the validator since we are using HTML radio buttons
            if (!Page.IsValid) return;

            // 2. Capture the selected value from the manual HTML name="service2"
            string selectedFullText = Request.Form["service2"];

            if (string.IsNullOrEmpty(selectedFullText))
            {
                // Fallback server-side check
                cvService2.IsValid = false;
                return;
            }

            // 3. Extract data for the Database lookup
            // Example: "MK Combination - 60 minutes" -> parts[0]="MK Combination", parts[1]="60 minutes"
            string[] parts = selectedFullText.Split('-');
            string serviceName = parts[0].Trim();

            // Extract only digits (e.g., "60 minutes" becomes "60")
            string durationPart = new string(parts[1].Where(char.IsDigit).ToArray());

            string custID = Request.QueryString["custID"];
            string category = txtService.Text;
            int serviceId = 0;

            // 4. Database Lookup to get the ServiceID
            string connStr = ConfigurationManager.ConnectionStrings["MKWellnessSpaDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                // We match by name and duration to get the unique ServiceID
                string sql = "SELECT ServiceID FROM tbl_Services WHERE ServiceName LIKE @name AND DurationMinutes = @dur";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@name", serviceName + "%");
                    cmd.Parameters.AddWithValue("@dur", durationPart);

                    con.Open();
                    var result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        serviceId = Convert.ToInt32(result);
                    }
                }
            }

            // 5. Pass data to BookNow3.aspx (Final Summary)
            // Use Server.UrlEncode for strings with spaces to avoid breaking the URL
            Response.Redirect($"BookNow3.aspx?custID={custID}&serviceID={Server.UrlEncode(category)}&type={Server.UrlEncode(serviceName)}&duration={durationPart}");
        }
    }
}