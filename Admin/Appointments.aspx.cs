using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace MasaheKingWellnessSpa.Admin
{
    public partial class Appointments : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["MKWellnessSpaDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }
        }

        private void BindGridView()
        {
            try
            {
                string query = @"
                    SELECT 
                        a.ApptID, 
                        CAST(a.ApptDateTime AS DATE) AS ApptDate,
                        LTRIM(RIGHT(CONVERT(VARCHAR(20), a.ApptDateTime, 100), 7)) AS ApptTime,
                        s.ServiceName,
                        c.CustomerName
                    FROM tbl_Appointments a
                    INNER JOIN tbl_Services s ON a.ServiceID = s.ServiceID
                    INNER JOIN tbl_CustomerInformation c ON a.CustomerID = c.CustomerID
                    WHERE a.ApptStatus = 2
                    ORDER BY a.ApptDateTime ASC";

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
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
            catch (Exception ex)
            {
                actionResult.Text = "Error loading appointments: " + ex.Message;
                actionResult.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void gvAppointments_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Removed direct UpdatePanel checks as upDetails is gone and upMain handles everything
            try
            {
                if (gvAppointments.SelectedDataKey != null)
                {
                    int apptID = Convert.ToInt32(gvAppointments.SelectedDataKey.Value);
                    ViewState["SelectedApptID"] = apptID;
                    actionResult.Text = "";
                    PopulateInformationDiv(apptID);
                    LoadAddOns(apptID);
                    pnlDetails.Visible = true;
                }
            }
            catch (Exception ex)
            {
                actionResult.Text = "Error selecting appointment: " + ex.Message;
                actionResult.ForeColor = System.Drawing.Color.Red;
            }
        }

        private void PopulateInformationDiv(int apptID)
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

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@ApptID", SqlDbType.Int).Value = apptID;
                    con.Open();
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
                            
                            ViewState["ServicePrice"] = Convert.ToDecimal(reader["ServicePrice"]);
                        }
                    }
                }
            }
        }

        private void LoadAddOns(int apptID)
        {
            string query = @"
                SELECT 
                    ao.AddOnName,
                    ao.Price
                FROM tbl_AddOnAppointment aoa
                INNER JOIN tbl_AddOn ao ON aoa.AddOnID = ao.AddOnID
                WHERE aoa.ApptID = @ApptID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add("@ApptID", SqlDbType.Int).Value = apptID;
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

                            decimal totalPrice = Convert.ToDecimal(ViewState["ServicePrice"]);
                            foreach (DataRow row in dtAddOns.Rows)
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
            ViewState["IntendedAction"] = 3; // Denied / Deleted equivalent if we merge logic, or we update literal.
            lblModalTitle.Text = "Delete Appointment";
            lblModalMessage.Text = "Are you sure you want to delete this appointment?";
            btnFinalizeAction.CssClass = "btn-modal btn-deny"; 
            pnlModal.Visible = true;
        }

        protected void btnComplete_Click(object sender, EventArgs e)
        {
            ViewState["IntendedAction"] = 4; // Finished
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

                    if (newStatus == 3) // Assuming 3 means deleted/denied in this context
                    {
                        DeleteAppointment(apptID);
                    }
                    else
                    {
                        UpdateAppointmentStatus(apptID, newStatus);
                    }

                    pnlModal.Visible = false;
                    pnlDetails.Visible = false;
                    ViewState["SelectedApptID"] = null;
                    ViewState["IntendedAction"] = null;

                    BindGridView();

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
                string query = "UPDATE tbl_Appointments SET ApptStatus = @ApptStatus WHERE ApptID = @ApptID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add("@ApptStatus", SqlDbType.Int).Value = status;
                    cmd.Parameters.Add("@ApptID", SqlDbType.Int).Value = apptID;

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void DeleteAppointment(int apptID)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                // Note: Consider deleting associated AddOns first depending on foreign key constraints
                string deleteAddOnsQuery = "DELETE FROM tbl_AddOnAppointment WHERE ApptID = @ApptID";
                string deleteApptQuery = "DELETE FROM tbl_Appointments WHERE ApptID = @ApptID";

                conn.Open();

                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        using (SqlCommand cmdAddOn = new SqlCommand(deleteAddOnsQuery, conn, transaction))
                        {
                            cmdAddOn.Parameters.Add("@ApptID", SqlDbType.Int).Value = apptID;
                            cmdAddOn.ExecuteNonQuery();
                        }
                        
                        using (SqlCommand cmdAppt = new SqlCommand(deleteApptQuery, conn, transaction))
                        {
                            cmdAppt.Parameters.Add("@ApptID", SqlDbType.Int).Value = apptID;
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
    }
}