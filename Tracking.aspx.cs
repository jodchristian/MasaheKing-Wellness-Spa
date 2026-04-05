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
    public partial class Tracking : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["MKWellnessSpaDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Hide the result and error message on first load
                trackingResult.Visible = false;
                errorMsg.Visible = false;

                // If tracking id supplied in query string, prefill and run search automatically
                string trackingQuery = Request.QueryString["tracking"];
                if (!string.IsNullOrEmpty(trackingQuery))
                {
                    txtTrackingId.Text = trackingQuery;
                    // Call the search handler to populate results
                    btnSearch_Click(btnSearch, EventArgs.Empty);
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string trackingId = txtTrackingId.Text.Trim();

            if (string.IsNullOrEmpty(trackingId)) return;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
                    SELECT s.ServiceName, s.Price, a.ApptStatus, a.ApptDateTime 
                    FROM tbl_Appointments a
                    INNER JOIN tbl_Services s ON a.ServiceID = s.ServiceID
                    WHERE a.TrackingID = @ID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ID", trackingId);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        // 1. UI State: Success
                        trackingResult.Visible = true;
                        errorMsg.Visible = false;

                        // 2. Safe Mapping (Checks for nulls and correct column names)
                        lblServiceName.Text = reader["ServiceName"] != DBNull.Value ? reader["ServiceName"].ToString() : "N/A";
                        lblPrice.Text = reader["Price"] != DBNull.Value ? "P" + reader["Price"].ToString() : "P0";

                        if (reader["ApptDateTime"] != DBNull.Value)
                        {
                            DateTime apptTime = Convert.ToDateTime(reader["ApptDateTime"]);
                            lblTime.Text = apptTime.ToString("MMMM d, h:mm tt");
                        }
                        else
                        {
                            lblTime.Text = "N/A";
                        }

                        // Ensure this matches exactly what is in your SELECT statement (ApptStatus)
                        string status = reader["ApptStatus"] != DBNull.Value ? reader["ApptStatus"].ToString() : "Unknown";
                        switch (status)
                        {
                            case "1":
                                lblStatus.Text = "Pending";
                                break;
                            case "2":
                                lblStatus.Text = "Confirmed";
                                break;
                            case "3":
                                lblStatus.Text = "Denied";
                                break;
                            case "4":
                                lblStatus.Text = "Finished";
                                break;
                            default:
                                lblStatus.Text = "Unknown";
                                break;
                        }
                    }
                    else
                    {
                        // 1. UI State: No Record Found
                        trackingResult.Visible = false;
                        errorMsg.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    // If this still runs, look at the ex.Message in the alert. 
                    // It will likely say "Column 'Status' does not belong to table"
                    string cleanMessage = ex.Message.Replace("'", "\\'"); // Prevents JS syntax errors
                    Response.Write("<script>alert('Error: " + cleanMessage + "');</script>");
                }
            }
        }
    }
}