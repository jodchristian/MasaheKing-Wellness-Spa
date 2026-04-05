using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace MasaheKingWellnessSpa
{
    public partial class BookNow3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string service = Request.QueryString["serviceID"];
                string type = Request.QueryString["type"];
                string duration = Request.QueryString["duration"];

                if (service != null)
                    txtService.Text = service;

                if (type != null)
                    txtType.Text = type;

                if (duration != null)
                    txtDuration.Text = duration + " mins";
                
                TimeZoneInfo phTimeZone = TimeZoneInfo.FindSystemTimeZoneById("Singapore Standard Time");
                DateTime localTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, phTimeZone);

                dtAppt.Attributes["min"] = localTime.ToString("yyyy-MM-dd");
            }
        }

        protected void dtAppt_TextChanged(object sender, EventArgs e)
        {
            try
            {
                lblError.Text = "";

                if (string.IsNullOrEmpty(dtAppt.Text))
                {
                    txtApptTime.Items.Clear();
                    txtApptTime.Items.Add(new System.Web.UI.WebControls.ListItem("-- Select a Date First --", ""));
                    txtApptTime.Enabled = false;
                    return;
                }

                if (!DateTime.TryParse(dtAppt.Text, out DateTime selectedDate))
                {
                    lblError.Text = "Invalid date format.";
                    return;
                }

                if (selectedDate.Date < DateTime.Now.Date)
                {
                    lblError.Text = "Cannot select a date in the past.";
                    dtAppt.Text = "";
                    txtApptTime.Items.Clear();
                    txtApptTime.Enabled = false;
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
            txtApptTime.Items.Clear();
            txtApptTime.Items.Add(new System.Web.UI.WebControls.ListItem("-- Select Time --", ""));

            List<TimeSpan> allTimeSlots = new List<TimeSpan>();
            for (int i = 14; i <= 25; i++) // 2 PM to 1 AM cutoff
            {
                allTimeSlots.Add(new TimeSpan(i % 24, 0, 0));
            }

            List<TimeSpan> bookedSlots = new List<TimeSpan>();
            string connString = ConfigurationManager.ConnectionStrings["MKWellnessSpaDB"].ConnectionString;

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

            foreach (var slot in allTimeSlots)
            {
                // Business logic: Times between midnight and 2 AM belong to the end of the shift (next calendar day)
                DateTime actualApptTime = date.Date.Add(slot);
                if (slot.Hours < 14)
                {
                    actualApptTime = actualApptTime.AddDays(1);
                }

                // Properly evaluate against true timeline to prevent booking in the past
                if (actualApptTime <= DateTime.Now)
                    continue;

                if (!bookedSlots.Contains(slot))
                {
                    string displayTime = actualApptTime.ToString("hh:mm tt");
                    string valueTime = slot.ToString(@"hh\:mm");
                    txtApptTime.Items.Add(new System.Web.UI.WebControls.ListItem(displayTime, valueTime));
                }
            }

            txtApptTime.Enabled = txtApptTime.Items.Count > 1;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    if (string.IsNullOrEmpty(dtAppt.Text) || string.IsNullOrEmpty(txtApptTime.SelectedValue))
                    {
                        lblError.Text = "Please complete the date and time selection.";
                        return;
                    }

                    string customerId = Request.QueryString["custID"];
                    string serviceNameFromUrl = Request.QueryString["serviceID"];

                    int actualServiceId = 1;
                    switch (serviceNameFromUrl)
                    {
                        case "Royal Services": actualServiceId = 1; break;
                        case "The Prince & Princess Deluxe": actualServiceId = 2; break;
                        case "The King & Queen Royale": actualServiceId = 3; break;
                        case "Duke Majestic Package": actualServiceId = 4; break;
                    }

                    DateTime selectedDate = DateTime.Parse(dtAppt.Text);
                    TimeSpan selectedTime = TimeSpan.Parse(txtApptTime.SelectedValue);
                    DateTime apptDateTime = selectedDate.Date.Add(selectedTime);

                    string connStr = ConfigurationManager.ConnectionStrings["MKWellnessSpaDB"].ConnectionString;
                    using (SqlConnection con = new SqlConnection(connStr))
                    {
                        string sql = @"INSERT INTO tbl_Appointments 
                               (CustomerID, ServiceID, ProcessedByAdmin, ApptDateTime, ApptStatus, 
                                PreferredTherapistGender, Notes, EntryDate) 
                               VALUES 
                               (@cust, @service, @admin, @datetime, @status, 
                                @therapist, @notes, @entryDate);
                               SELECT TrackingID FROM tbl_Appointments WHERE ApptID = SCOPE_IDENTITY();";

                        using (SqlCommand cmd = new SqlCommand(sql, con))
                        {
                            cmd.Parameters.AddWithValue("@cust", customerId ?? (object)DBNull.Value);
                            cmd.Parameters.AddWithValue("@service", actualServiceId);
                            cmd.Parameters.AddWithValue("@admin", 1);
                            cmd.Parameters.AddWithValue("@datetime", apptDateTime);
                            cmd.Parameters.AddWithValue("@status", 1);
                            cmd.Parameters.AddWithValue("@therapist", rblGender.SelectedValue ?? "No Preference");
                            cmd.Parameters.AddWithValue("@notes", txtNotes.Value ?? "");
                            cmd.Parameters.AddWithValue("@entryDate", DateTime.Now);

                            con.Open();
                            object result = cmd.ExecuteScalar();
                            if (result != null)
                            {
                                lblID.Text = result.ToString();
                                overlay.Visible = true;
                                pnlSuccess.Visible = true;

                                string script = @"var count = 10; var interval = setInterval(function() { count--; 
                        var el = document.getElementById('seconds'); if(el) el.innerHTML = count;
                        if (count <= 0) { clearInterval(interval); window.location.href = 'Tracking.aspx'; }
                    }, 1000);";
                            ClientScript.RegisterStartupScript(this.GetType(), "PopupScript", script, true);
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
}}