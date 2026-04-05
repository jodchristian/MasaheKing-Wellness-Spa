using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace MasaheKingWellnessSpa
{
    public partial class NewBooking1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Optional: Clear or setup initial session state
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    // Store to session to pass to next step
                    Session["CustomerName"] = txtName.Text.Trim();
                    Session["CustomerEmail"] = txtEmail.Text.Trim();
                    Session["CustomerPhone"] = txtPhone.Text.Trim();
                    Session["CustomerGender"] = rblGender.SelectedValue;

                    string selectedService = GetSelectedService();
                    Session["SelectedServiceCategory"] = selectedService;

                    // Redirect to next step based on the service selected or general next page
                    Response.Redirect("NewBooking2.aspx", false);
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "An error occurred: " + ex.Message;
            }
        }

        protected void cvService_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = !string.IsNullOrEmpty(GetSelectedService());
        }

        private string GetSelectedService()
        {
            if (rbRoyalServices != null && rbRoyalServices.Checked) return "Royal Services";
            if (rbPrinceDeluxe != null && rbPrinceDeluxe.Checked) return "Prince and Princess Deluxe";
            if (rbKingRoyale != null && rbKingRoyale.Checked) return "King and Queen Royale";
            if (rbDukeMajestic != null && rbDukeMajestic.Checked) return "Duke Majestic";
            return string.Empty;
        }
    }
}