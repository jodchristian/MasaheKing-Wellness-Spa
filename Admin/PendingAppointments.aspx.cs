using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace MasaheKingWellnessSpa.Admin
{
    public partial class PendingAppointments : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["MKWellnessSpaDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPendingAppointments();
            }
        }



        private void LoadPendingAppointments()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
                    SELECT 
                        a.ApptID, 
                        CAST(a.ApptDateTime AS DATE) AS ApptDate,
                        LTRIM(RIGHT(CONVERT(VARCHAR(20), a.ApptDateTime, 100), 7)) AS ApptTime,
                        s.ServiceName
                    FROM tbl_Appointments a
                    INNER JOIN tbl_Services s ON a.ServiceID = s.ServiceID
                    WHERE a.ApptStatus = 1
                    ORDER BY a.ApptDateTime ASC, a.EntryDate ASC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvAppointments.DataSource = dt;
                        gvAppointments.DataBind();
                    }
                }
            }
        }

        protected void gvAppointments_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (gvAppointments.SelectedDataKey != null)
            {
                int apptID = Convert.ToInt32(gvAppointments.SelectedDataKey.Value);
                ViewState["SelectedApptID"] = apptID;

                // Clear any previous results
                actionResult.Text = "";

                LoadAppointmentDetails(apptID);
                LoadAddOns(apptID);
                pnlDetails.Visible = true;
            }
        }

        private void LoadAppointmentDetails(int apptID)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
                    SELECT 
                        a.TrackingID,
                        a.ApptDateTime,
                        a.PreferredTherapistGender,
                        a.Notes,
                        c.CustomerID,
                        c.CustomerName,
                        c.Phone,
                        ISNULL(c.Email, 'N/A') AS Email,
                        ISNULL(c.Gender, 'N/A') AS Gender,
                        s.ServiceName,
                        s.Price AS ServicePrice
                    FROM tbl_Appointments a
                    INNER JOIN tbl_CustomerInformation c ON a.CustomerID = c.CustomerID
                    INNER JOIN tbl_Services s ON a.ServiceID = s.ServiceID
                    WHERE a.ApptID = @ApptID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ApptID", apptID);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblTrackingID.Text = reader["TrackingID"].ToString();

                            // Output Bindings mapped closely to your requested IDs
                            lblFullName_OUT.Text = reader["CustomerName"].ToString();
                            lblMobileNumber_OUT.Text = reader["Phone"].ToString();
                            lblEmail_OUT.Text = reader["Email"].ToString();
                            lblGender_OUT.Text = reader["Gender"].ToString();
                            lblService_OUT.Text = reader["ServiceName"].ToString();

                            DateTime apptDt = Convert.ToDateTime(reader["ApptDateTime"]);
                            lblDate_OUT.Text = apptDt.ToString("MMM dd, yyyy");
                            lblTime_OUT.Text = apptDt.ToString("hh:mm tt");

                            lblPreferredTherapist_OUT.Text = reader["PreferredTherapistGender"].ToString();
                            lblNote.Text = reader["Notes"].ToString();

                            // Temporarily store base service price for total calculation
                            ViewState["ServicePrice"] = Convert.ToDecimal(reader["ServicePrice"]);
                        }
                    }
                }
            }
        }

        private void LoadAddOns(int apptID)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
                    SELECT 
                        ao.AddOnName,
                        ao.Price
                    FROM tbl_AddOnAppointment aoa
                    INNER JOIN tbl_AddOn ao ON aoa.AddOnID = ao.AddOnID
                    WHERE aoa.ApptID = @ApptID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ApptID", apptID);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dtAddOns = new DataTable();
                        sda.Fill(dtAddOns);

                        if (dtAddOns.Rows.Count > 0)
                        {
                            rptAddOns.DataSource = dtAddOns;
                            rptAddOns.DataBind();
                            rptAddOns.Visible = true;
                            lblNoAddOns_OUT.Visible = false;

                            // Calculate Total Price
                            decimal totalPrice = Convert.ToDecimal(ViewState["ServicePrice"]);
                            foreach (DataRow row in dtAddOns.Rows)
                            {
                                totalPrice += Convert.ToDecimal(row["Price"]);
                            }
                            lblTotalPrice_OUT.Text = "P" + totalPrice.ToString("0.00");
                        }
                        else
                        {
                            rptAddOns.Visible = false;
                            lblNoAddOns_OUT.Visible = true;
                            lblTotalPrice_OUT.Text = "P" + Convert.ToDecimal(ViewState["ServicePrice"]).ToString("0.00");
                        }
                    }
                }
            }
        }

        // --- MODAL & ACTION LOGIC ---

        protected void btnOpenConfirm_Click(object sender, EventArgs e)
        {
            ViewState["IntendedAction"] = 2;
            lblModalTitle.Text = "Approve Appointment";
            lblModalMessage.Text = "Are you sure you want to approve this appointment?";
            btnFinalizeAction.CssClass = "btn-modal btn-confirm";
            pnlModal.Visible = true;
        }

        protected void btnOpenDeny_Click(object sender, EventArgs e)
        {
            ViewState["IntendedAction"] = 3;
            lblModalTitle.Text = "Deny Appointment";
            lblModalMessage.Text = "Are you sure you want to deny and cancel this appointment?";
            btnFinalizeAction.CssClass = "btn-modal btn-deny";
            pnlModal.Visible = true;
        }

        protected void btnCancelAction_Click(object sender, EventArgs e)
        {
            pnlModal.Visible = false;
        }

        protected void btnFinalizeAction_Click(object sender, EventArgs e)
        {
            if (ViewState["SelectedApptID"] != null && ViewState["IntendedAction"] != null)
            {
                int apptID = Convert.ToInt32(ViewState["SelectedApptID"]);
                int newStatus = Convert.ToInt16(ViewState["IntendedAction"]);

                // Set to current AdminID (Using 1 for example)
                int adminID = 1;

                UpdateAppointmentStatus(apptID, newStatus, adminID);

                // Reset page UI state
                pnlModal.Visible = false;
                pnlDetails.Visible = false;
                ViewState["SelectedApptID"] = null;
                ViewState["IntendedAction"] = null;

                // Refresh list
                LoadPendingAppointments();
            }
        }

        private void UpdateAppointmentStatus(int apptID, int status, int adminID)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "UPDATE tbl_Appointments SET ApptStatus = @ApptStatus, ProcessedByAdmin = @AdminID WHERE ApptID = @ApptID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ApptStatus", status);
                    cmd.Parameters.AddWithValue("@AdminID", adminID);
                    cmd.Parameters.AddWithValue("@ApptID", apptID);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}