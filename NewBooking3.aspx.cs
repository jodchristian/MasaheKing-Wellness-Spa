using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;

namespace MasaheKingWellnessSpa
{
    public partial class NewBooking3 : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["MKWellnessSpaDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["FinalServiceID"] == null)
            {
                Response.Redirect("NewBooking1.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Set the min attribute to today's date
                txtDate.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");

                // If user came with tracking query, auto-fill and search (Tracking.aspx handles direct searches)
                // nothing for this page
            }
        }

        protected void txtDate_TextChanged(object sender, EventArgs e)
        {
            try
            {
                lblError.Text = "";

                if (string.IsNullOrEmpty(txtDate.Text))
                {
                    ddlTime.Items.Clear();
                    ddlTime.Items.Add(new System.Web.UI.WebControls.ListItem("-- Select a Date First --", ""));
                    ddlTime.Enabled = false;
                    return;
                }

                if (!DateTime.TryParse(txtDate.Text, out DateTime selectedDate))
                {
                    lblError.Text = "Invalid date format.";
                    return;
                }

                if (selectedDate.Date < DateTime.Now.Date)
                {
                    lblError.Text = "Cannot select a date in the past.";
                    txtDate.Text = "";
                    ddlTime.Items.Clear();
                    ddlTime.Enabled = false;
                    return;
                }

                PopulateAvailableTimes(selectedDate);
            }
            catch (Exception ex)
            {
                lblError.Text = "An error occurred fetching times: " + ex.Message;
            }
        }

        private void PopulateAvailableTimes(DateTime date)
        {
            ddlTime.Items.Clear();
            ddlTime.Items.Add(new System.Web.UI.WebControls.ListItem("-- Select Time --", ""));

            // Operating Hours: 2pm (14:00) to 1am (01:00 next day)
            // Generate hours (14 to 24 for today, then 0 for next day, but simplify for 1 hour increments block logic)
            // Display friendly text: "2:00 PM", "3:00 PM" ... "12:00 AM"

            List<TimeSpan> allTimeSlots = new List<TimeSpan>();
            for (int i = 14; i <= 25; i++) // 2 PM to 1 AM next day
            {
                allTimeSlots.Add(new TimeSpan(i, 0, 0)); 
            }
            
            // Note: 1 AM is the closing time, so the last bookable 1-hour slot is typically 1:00 AM.
            
            // Fetch conflicting appointments for the selected date
            List<TimeSpan> bookedSlots = new List<TimeSpan>();
            
            if (!string.IsNullOrEmpty(connString))
            {
                using (SqlConnection con = new SqlConnection(connString))
                {
                    string qry = @"SELECT ApptDateTime, s.DurationMinutes 
                                   FROM tbl_Appointments a
                                   INNER JOIN tbl_Services s ON a.ServiceID = s.ServiceID
                                   WHERE CAST(ApptDateTime AS DATE) = @Date 
                                   AND ApptStatus = 2";

                    using (SqlCommand cmd = new SqlCommand(qry, con))
                    {
                        cmd.Parameters.AddWithValue("@Date", date.Date);
                        con.Open();
                        using (SqlDataReader rd = cmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                DateTime dt = rd.GetDateTime(0);
                                int duration = rd.GetInt32(1);
                                
                                // Business Rule: Round up to 1 hr (60 mins) or 2 hrs (120 mins)
                                int roundedDurationMins = (duration <= 60) ? 60 : 120;
                                int hoursTaken = roundedDurationMins / 60;
                                
                                TimeSpan startTime = dt.TimeOfDay;
                                
                                for (int h = 0; h < hoursTaken; h++)
                                {
                                    TimeSpan blockedSlot = startTime.Add(new TimeSpan(h, 0, 0));
                                    bookedSlots.Add(blockedSlot);
                                }
                            }
                        }
                    }
                }
            }

            // Filter
            foreach (var slot in allTimeSlots)
            {
                DateTime dtRepresentation = DateTime.Today.Add(slot);
                // If the selected date is today, block past times
                if (date.Date == DateTime.Now.Date && dtRepresentation <= DateTime.Now) 
                    continue;

                // Check conflict
                if (!bookedSlots.Contains(slot))
                {
                    string displayTime = new DateTime(dtRepresentation.Ticks).ToString("hh:mm tt");
                    // Value is stored as default TimeSpan string for safe parsing of values >= 24h
                    string valueTime = slot.ToString();
                    ddlTime.Items.Add(new System.Web.UI.WebControls.ListItem(displayTime, valueTime));
                }
            }
            
            ddlTime.Enabled = ddlTime.Items.Count > 1;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    if (string.IsNullOrEmpty(txtDate.Text) || string.IsNullOrEmpty(ddlTime.SelectedValue))
                    {
                        lblError.Text = "Please complete the date and time selection.";
                        return;
                    }

                    DateTime selectedDate = DateTime.Parse(txtDate.Text);
                    TimeSpan selectedTime = TimeSpan.Parse(ddlTime.SelectedValue);
                    DateTime appointmentDateTime = selectedDate.Date.Add(selectedTime);

                    // Registration & Booking Logic
                    using (SqlConnection con = new SqlConnection(connString))
                    {
                        con.Open();
                        using (SqlTransaction trans = con.BeginTransaction())
                        {
                            try
                            {
                                // 1. Handle Customer
                                int customerId = GetOrInsertCustomer(con, trans);

                                // 2. Insert Appointment
                                int serviceId = Convert.ToInt32(Session["FinalServiceID"]);
                                string gender = rblTherapistGender.SelectedValue;
                                string notes = txtNotes.Text.Trim();

                                // Removed ApptID from INSERT and added SCOPE_IDENTITY() to grab the auto-generated ID
                                string insertAppt = @"
                                    INSERT INTO tbl_Appointments (CustomerID, ServiceID, ProcessedByAdmin, ApptDateTime, ApptStatus, PreferredTherapistGender, Notes, EntryDate)
                                    VALUES (@CustID, @ServiceID, @AdminID, @DateTime, 1, @Gender, @Notes, GETDATE());
                                    SELECT CAST(SCOPE_IDENTITY() AS INT);";

                                int newApptId;

                                using (SqlCommand apptCmd = new SqlCommand(insertAppt, con, trans))
                                {
                                    apptCmd.Parameters.AddWithValue("@CustID", customerId);
                                    apptCmd.Parameters.AddWithValue("@ServiceID", serviceId);
                                    apptCmd.Parameters.AddWithValue("@AdminID", 1); // Mock Default Admin
                                    apptCmd.Parameters.AddWithValue("@DateTime", appointmentDateTime);
                                    apptCmd.Parameters.AddWithValue("@Gender", gender);
                                    apptCmd.Parameters.AddWithValue("@Notes", string.IsNullOrEmpty(notes) ? "None" : notes);

                                    // ExecuteScalar runs the insert and returns the new ApptID
                                    newApptId = (int)apptCmd.ExecuteScalar();
                                }

                                string trackingId = "";
                                using (SqlCommand trkCmd = new SqlCommand("SELECT TrackingID FROM tbl_Appointments WHERE ApptID = @ApptID", con, trans))
                                {
                                    trkCmd.Parameters.AddWithValue("@ApptID", newApptId);
                                    trackingId = trkCmd.ExecuteScalar()?.ToString();
                                }

                                // 3. Insert Add-ons
                                InsertAddOnIfSelected(con, trans, newApptId, "SelectedAddOn1");
                                InsertAddOnIfSelected(con, trans, newApptId, "SelectedAddOn2");

                                trans.Commit();

                                // Show modal-style success box and provide link that includes tracking ID as query string parameter
                                pnlForm.Visible = false;
                                btnSubmit.Visible = false;
                                btnBack.Text = "Return Home";

                                // Populate modal values and show it
                                if (!string.IsNullOrEmpty(trackingId))
                                {
                                    lblModalTrackingId.Text = trackingId;
                                    hlTrack.NavigateUrl = "Tracking.aspx?tracking=" + Server.UrlEncode(trackingId);
                                }
                                else
                                {
                                    lblModalTrackingId.Text = "N/A";
                                    hlTrack.NavigateUrl = "Tracking.aspx";
                                }

                                pnlSuccessModal.Visible = true;
                            }
                            catch (Exception dbEx)
                            {
                                trans.Rollback();
                                throw new Exception("Database error: " + dbEx.Message);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "An error occurred processing your booking: " + ex.Message;
            }
        }

        private int GetOrInsertCustomer(SqlConnection con, SqlTransaction trans)
        {
            string name = Session["CustomerName"]?.ToString() ?? "Unknown";
            string phone = Session["CustomerPhone"]?.ToString() ?? "Unknown";
            string email = Session["CustomerEmail"]?.ToString() ?? "";
            string gender = Session["CustomerGender"]?.ToString() ?? "";

            // Removed CustomerID from the INSERT columns and values.
            // Added SELECT SCOPE_IDENTITY() to fetch the newly auto-generated ID.
            string insertCust = @"INSERT INTO tbl_CustomerInformation (CustomerName, Phone, Email, Gender, CustomerStatus)
                                  VALUES (@Name, @Phone, @Email, @Gender, 1);
                                  SELECT CAST(SCOPE_IDENTITY() AS INT);";
                                  
            using (SqlCommand cmd = new SqlCommand(insertCust, con, trans))
            {
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Phone", phone);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Gender", gender);
                
                // ExecuteScalar will run the insert and immediately return the new SCOPE_IDENTITY()
                return (int)cmd.ExecuteScalar();
            }
        }

        private void InsertAddOnIfSelected(SqlConnection con, SqlTransaction trans, int apptId, string sessionKey)
        {
            if (Session[sessionKey] != null && int.TryParse(Session[sessionKey].ToString(), out int addonId))
            {
                using (SqlCommand cmd = new SqlCommand("INSERT INTO tbl_AddOnAppointment (ApptID, AddOnID) VALUES (@Appt, @Addon)", con, trans))
            {
                    cmd.Parameters.AddWithValue("@Appt", apptId);
                    cmd.Parameters.AddWithValue("@Addon", addonId);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            if (btnBack.Text == "Return Home")
            {
                Session.Clear();
                Response.Redirect("HomeCustomer.aspx", false);
            }
            else
            {
                Response.Redirect("NewBooking2.aspx", false);
            }
        }
    }
}