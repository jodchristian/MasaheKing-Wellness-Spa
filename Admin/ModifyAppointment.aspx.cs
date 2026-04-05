using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace MasaheKingWellnessSpa.Admin
{
    public partial class ModifyAppointment : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["MKWellnessSpaDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int apptID;
                    if (int.TryParse(Request.QueryString["id"], out apptID))
                    {
                        LoadAppointmentDetails(apptID);
                    }
                    else
                    {
                        lblMessage.Text = "Invalid Appointment ID.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
                else
                {
                    lblMessage.Text = "No Appointment ID provided.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        private void LoadAppointmentDetails(int apptID)
        {
            string query = @"
                SELECT 
                    a.ApptDateTime,
                    a.PreferredTherapistGender,
                    a.Notes,
                    c.CustomerName
                FROM tbl_Appointments a
                INNER JOIN tbl_CustomerInformation c ON a.CustomerID = c.CustomerID
                WHERE a.ApptID = @ApptID";

            try
            {
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
                                lblApptID.Text = apptID.ToString();
                                
                                txtName.Text = reader["CustomerName"].ToString();

                                DateTime apptDateTime = Convert.ToDateTime(reader["ApptDateTime"]);
                                txtApptDate.Text = apptDateTime.ToString("yyyy-MM-dd");
                                txtApptTime.Text = apptDateTime.ToString("HH:mm");

                                string gender = reader["PreferredTherapistGender"].ToString();
                                if (ddlTherapistGender.Items.FindByValue(gender) != null)
                                {
                                    ddlTherapistGender.SelectedValue = gender;
                                }

                                txtNotes.Text = reader["Notes"].ToString();
                            }
                            else
                            {
                                lblMessage.Text = "Appointment not found.";
                                lblMessage.ForeColor = System.Drawing.Color.Red;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading appointment details. Please try again later.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            if (string.IsNullOrWhiteSpace(txtName.Text))
            {
                lblMessage.Text = "Please provide the customer name.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (string.IsNullOrWhiteSpace(txtApptDate.Text) || string.IsNullOrWhiteSpace(txtApptTime.Text))
            {
                lblMessage.Text = "Please provide both the appointment date and time.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            int apptID;
            if (int.TryParse(lblApptID.Text, out apptID))
            {
                try
                {
                    DateTime apptDateTime;
                    bool isValidDate = DateTime.TryParse(txtApptDate.Text + " " + txtApptTime.Text, out apptDateTime);

                    if (!isValidDate)
                    {
                        lblMessage.Text = "The provided date and time format is invalid.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    string name = txtName.Text;
                    string gender = ddlTherapistGender.SelectedValue;
                    string notes = txtNotes.Text;

                    UpdateAppointment(apptID, name, apptDateTime, gender, notes);

                    lblMessage.Text = "Appointment updated successfully.";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                }
                catch (SqlException)
                {
                    lblMessage.Text = "A database error occurred while trying to save the appointment. Please contact administrators.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
                catch (Exception)
                {
                    lblMessage.Text = "An unexpected error occurred during the update process.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblMessage.Text = "Invalid appointment identifier found during save attempt.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        private void UpdateAppointment(int apptID, string name, DateTime apptDateTime, string gender, string notes)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                using (SqlTransaction transaction = con.BeginTransaction())
                {
                    try
                    {
                        string customerQuery = @"
                            UPDATE c 
                            SET c.CustomerName = @CustomerName
                            FROM tbl_CustomerInformation c
                            INNER JOIN tbl_Appointments a ON c.CustomerID = a.CustomerID
                            WHERE a.ApptID = @ApptID";

                        using (SqlCommand cmdCust = new SqlCommand(customerQuery, con, transaction))
                        {
                            cmdCust.Parameters.Add("@CustomerName", SqlDbType.VarChar, 100).Value = name;
                            cmdCust.Parameters.Add("@ApptID", SqlDbType.Int).Value = apptID;
                            cmdCust.ExecuteNonQuery();
                        }

                        string apptQuery = @"
                            UPDATE tbl_Appointments 
                            SET 
                                ApptDateTime = @ApptDateTime,
                                PreferredTherapistGender = @PreferredTherapistGender,
                                Notes = @Notes
                            WHERE ApptID = @ApptID";

                        using (SqlCommand cmdAppt = new SqlCommand(apptQuery, con, transaction))
                        {
                            cmdAppt.Parameters.Add("@ApptDateTime", SqlDbType.DateTime).Value = apptDateTime;
                            cmdAppt.Parameters.Add("@PreferredTherapistGender", SqlDbType.VarChar, 20).Value = gender;
                            cmdAppt.Parameters.Add("@Notes", SqlDbType.VarChar, -1).Value = notes;
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

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Appointments.aspx");
        }
    }
}