using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace MasaheKingWellnessSpa.Admin
{
    public partial class DaySchedule : System.Web.UI.Page
    {
        // Centralized connection string pulled securely from web.config
        private string connectionString = ConfigurationManager.ConnectionStrings["MKWellnessSpaDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DateTime dateToLoad = DateTime.Today;

                if (Request.QueryString["date"] != null)
                {
                    string dateString = Request.QueryString["date"];
                    DateTime parsedDate;

                    if (DateTime.TryParse(dateString, out parsedDate))
                    {
                        dateToLoad = parsedDate;
                    }
                }

                ViewState["SelectedDate"] = dateToLoad;
                lblMonthDay.Text = dateToLoad.ToString("MMMM dd, yyyy");
                LoadDayAppointments(dateToLoad);
            }
        }

        private void LoadDayAppointments(DateTime date)
        {
            string query = @"
                SELECT 
                    a.ApptID,
                    LTRIM(RIGHT(CONVERT(VARCHAR(20), a.ApptDateTime, 100), 7)) AS ApptTime,
                    c.CustomerName,
                    s.ServiceName
                FROM tbl_Appointments a
                INNER JOIN tbl_CustomerInformation c ON a.CustomerID = c.CustomerID
                INNER JOIN tbl_Services s ON a.ServiceID = s.ServiceID
                WHERE CAST(a.ApptDateTime AS DATE) = @Date
                AND a.ApptStatus = 2
                ORDER BY a.ApptDateTime";

            // The 'using' statements ensure database connections are properly closed and disposed
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Parameterized query to prevent SQL injection
                    cmd.Parameters.AddWithValue("@Date", date.Date);

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            rptSchedule.DataSource = dt;
                            rptSchedule.DataBind();
                            rptSchedule.Visible = true;
                            
                            // Find the label in the MasterPage's ContentPlaceHolder
                            // or access it directly since it's now accessible in the code-behind
                            System.Web.UI.WebControls.Label lblNoRecords = (System.Web.UI.WebControls.Label)Page.Master.FindControl("MainContent").FindControl("lblNoRecords");
                            if (lblNoRecords != null)
                            {
                                lblNoRecords.Visible = false;
                            }
                        }
                        else
                        {
                            rptSchedule.Visible = false;
                            
                            System.Web.UI.WebControls.Label lblNoRecords = (System.Web.UI.WebControls.Label)Page.Master.FindControl("MainContent").FindControl("lblNoRecords");
                            if (lblNoRecords != null)
                            {
                                lblNoRecords.Visible = true;
                            }
                        }
                    }
                }
            }
        }

        // This event fires whenever a LinkButton inside the Repeater is clicked
        protected void rptSchedule_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                // Grab the ID we passed via CommandArgument in the HTML
                int apptID = Convert.ToInt32(e.CommandArgument);

                // Store it in ViewState so our Modify/Delete buttons know which record to target
                ViewState["SelectedApptID"] = apptID;

                LoadAppointmentDetails(apptID);
                LoadAddOns(apptID);

                // Reveal the right-side information panel
                pnlDetails.Visible = true;
            }
        }

        private void LoadAppointmentDetails(int apptID)
        {
            string query = @"
                SELECT 
                    a.TrackingID,
                    a.ApptDateTime,
                    a.PreferredTherapistGender,
                    a.Notes,
                    c.CustomerName,
                    c.Email,
                    c.Phone,
                    c.Gender,
                    s.ServiceName,
                    s.Price AS ServicePrice
                FROM tbl_Appointments a
                INNER JOIN tbl_CustomerInformation c ON a.CustomerID = c.CustomerID
                INNER JOIN tbl_Services s ON a.ServiceID = s.ServiceID
                WHERE a.ApptID = @ApptID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ApptID", apptID);
                    conn.Open();

                    // SqlDataReader is a fast, forward-only way to read a single record
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblTrackingID.Text = reader["TrackingID"].ToString();
                            lblFullName_OUT.Text = reader["CustomerName"].ToString();
                            lblEmail_OUT.Text = reader["Email"] != DBNull.Value ? reader["Email"].ToString() : "N/A";
                            lblMobileNumber_OUT.Text = reader["Phone"].ToString();
                            lblGender_OUT.Text = reader["Gender"] != DBNull.Value ? reader["Gender"].ToString() : "N/A";
                            lblService_OUT.Text = reader["ServiceName"].ToString();

                            DateTime apptDt = Convert.ToDateTime(reader["ApptDateTime"]);
                            lblDate_OUT.Text = apptDt.ToString("MMM dd, yyyy");
                            lblTime_OUT.Text = apptDt.ToString("hh:mm tt");

                            lblPreferredTherapist_OUT.Text = reader["PreferredTherapistGender"].ToString();
                            lblNote.Text = reader["Notes"] != DBNull.Value ? reader["Notes"].ToString() : "";

                            // Keep track of the base price to calculate totals later
                            ViewState["ServicePrice"] = Convert.ToDecimal(reader["ServicePrice"]);
                        }
                    }
                }
            }
        }

        private void LoadAddOns(int apptID)
        {
            string query = @"
                SELECT ao.AddOnName, ao.Price
                FROM tbl_AddOnAppointment aoa
                INNER JOIN tbl_AddOn ao ON aoa.AddOnID = ao.AddOnID
                WHERE aoa.ApptID = @ApptID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ApptID", apptID);

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            rptAddOns.DataSource = dt;
                            rptAddOns.DataBind();
                            rptAddOns.Visible = true;
                            lblNoAddOns_OUT.Visible = false;

                            decimal totalPrice = Convert.ToDecimal(ViewState["ServicePrice"]);
                            foreach (DataRow row in dt.Rows)
                            {
                                totalPrice += Convert.ToDecimal(row["Price"]);
                            }
                            lblTotalPrice_OUT.Text = totalPrice.ToString("0.00");
                        }
                        else
                        {
                            rptAddOns.Visible = false;
                            lblNoAddOns_OUT.Visible = true;
                            lblTotalPrice_OUT.Text = Convert.ToDecimal(ViewState["ServicePrice"]).ToString("0.00");
                        }
                    }
                }
            }
        }

        // --- Action Buttons Copied from Appointments.aspx.cs ---

        protected void btnModify_Click(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect("ModifyAppointment.aspx?id=" + ViewState["SelectedApptID"]);
            }
            catch (Exception ex)
            {
                actionResult.Text = "Error navigating to Modify Page: " + ex.Message;
                actionResult.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ViewState["IntendedAction"] = 3;
            lblModalTitle.Text = "Delete Appointment";
            lblModalMessage.Text = "Are you sure you want to delete this appointment?";
            btnFinalizeAction.CssClass = "btn-modal btn-deny";
            pnlModal.Visible = true;
        }

        protected void btnComplete_Click(object sender, EventArgs e)
        {
            ViewState["IntendedAction"] = 4;
            lblModalTitle.Text = "Complete Appointment";
            lblModalMessage.Text = "Are you sure you want to mark this appointment as completed?";
            btnFinalizeAction.CssClass = "btn-modal btn-confirm";
            pnlModal.Visible = true;
        }

        protected void btnCancelAction_Click(object sender, EventArgs e)
        {
            pnlModal.Visible = false;
        }

        protected void btnFinalizeAction_Click(object sender, EventArgs e)
        {
            try
            {
                if (ViewState["SelectedApptID"] != null && ViewState["IntendedAction"] != null)
                {
                    int apptID = Convert.ToInt32(ViewState["SelectedApptID"]);
                    int newStatus = Convert.ToInt32(ViewState["IntendedAction"]);

                    if (newStatus == 3)
                    {
                        DeleteAppointment(apptID);
                    }
                    else
                    {
                        UpdateAppointmentStatus(apptID, newStatus);
                    }

                    // Reset UI
                    pnlModal.Visible = false;
                    pnlDetails.Visible = false;
                    ViewState["SelectedApptID"] = null;
                    ViewState["IntendedAction"] = null;

                    // Reload day appointments to reflect changes on the left side
                    DateTime selDate = (DateTime)ViewState["SelectedDate"];
                    LoadDayAppointments(selDate);

                    actionResult.Text = "Action completed successfully.";
                    actionResult.ForeColor = System.Drawing.Color.Green;
                }
            }
            catch (Exception ex)
            {
                actionResult.Text = "An error occurred: " + ex.Message;
                actionResult.ForeColor = System.Drawing.Color.Red;
            }
        }

        private void UpdateAppointmentStatus(int apptID, int status)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("UPDATE tbl_Appointments SET ApptStatus = @ApptStatus WHERE ApptID = @ApptID", conn))
                {
                    cmd.Parameters.AddWithValue("@ApptStatus", status);
                    cmd.Parameters.AddWithValue("@ApptID", apptID);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void DeleteAppointment(int apptID)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string deleteAddOnsQuery = "DELETE FROM tbl_AddOnAppointment WHERE ApptID = @ApptID";
                string deleteApptQuery = "DELETE FROM tbl_Appointments WHERE ApptID = @ApptID";

                conn.Open();

                // Transactions ensure atomicity. If deleting the appointment fails, 
                // the add-on deletion is rolled back to prevent orphaned data.
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        using (SqlCommand cmdAddOn = new SqlCommand(deleteAddOnsQuery, conn, transaction))
                        {
                            cmdAddOn.Parameters.AddWithValue("@ApptID", apptID);
                            cmdAddOn.ExecuteNonQuery();
                        }

                        using (SqlCommand cmdAppt = new SqlCommand(deleteApptQuery, conn, transaction))
                        {
                            cmdAppt.Parameters.AddWithValue("@ApptID", apptID);
                            cmdAppt.ExecuteNonQuery();
                        }

                        transaction.Commit();
                    }
                    catch
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            }
        }

        // New: navigate to previous day
        protected void btnPrev_Click(object sender, EventArgs e)
        {
            DateTime selDate = DateTime.Today;
            if (ViewState["SelectedDate"] != null)
            {
                selDate = (DateTime)ViewState["SelectedDate"];
            }
            DateTime prev = selDate.AddDays(-1);
            Response.Redirect($"DaySchedule.aspx?date={prev:yyyy-MM-dd}");
        }

        // New: navigate to next day
        protected void btnNext_Click(object sender, EventArgs e)
        {
            DateTime selDate = DateTime.Today;
            if (ViewState["SelectedDate"] != null)
            {
                selDate = (DateTime)ViewState["SelectedDate"];
            }
            DateTime next = selDate.AddDays(1);
            Response.Redirect($"DaySchedule.aspx?date={next:yyyy-MM-dd}");
        }
    }
}