using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI.WebControls;

namespace MasaheKingWellnessSpa.Admin
{
    public partial class Calendar : System.Web.UI.Page
    {
        // Centralized connection string pulled securely from web.config
        private string connectionString = ConfigurationManager.ConnectionStrings["MKWellnessSpaDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void calendar_SelectionChanged(object sender, EventArgs e)
        {
            DateTime selectedDate = calendar.SelectedDate;
            string formattedDate = selectedDate.ToString("yyyy-MM-dd");
            Response.Redirect("DaySchedule.aspx?date=" + formattedDate);
        }

        protected void calendar_DayRender(object sender, DayRenderEventArgs e)
        {
            // Optional: Skip days from the previous/next month if desired
            if (e.Day.IsOtherMonth)
            {
                return;
            }

            // Check if appointments exist for this specific date
            if (HasAppointments(e.Day.Date))
            {
                // HIGHLIGHT: Change color if appointments exist
                e.Cell.BackColor = Color.LightGreen;
                e.Cell.ToolTip = "Appointments scheduled";

                // Optional: Make the text bold to stand out more
                e.Cell.Font.Bold = true;
            }
        }

        private bool HasAppointments(DateTime date)
        {
            bool hasAppointments = false;

            // Query to count active appointments (ApptStatus = 2 usually means confirmed/active based on your other files)
            string query = "SELECT COUNT(1) FROM tbl_Appointments WHERE CAST(ApptDateTime AS DATE) = @Date AND ApptStatus = 2";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Date", date.Date);

                    try
                    {
                        conn.Open();
                        int count = (int)cmd.ExecuteScalar();
                        if (count > 0)
                        {
                            hasAppointments = true;
                        }
                    }
                    catch (Exception)
                    {
                        // Handle or log error if needed
                        return false;
                    }
                }
            }

            return hasAppointments;
        }
    }
}