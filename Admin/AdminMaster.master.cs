using System;

namespace MasaheKingWellnessSpa.Admin
{
    public partial class AdminMaster : System.Web.UI.MasterPage
    {
        protected global::System.Web.UI.WebControls.Panel pnlLogoutModal;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null || !(bool)Session["Admin"])
            {
                Response.Redirect("~/HomeCustomer.aspx");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            pnlLogoutModal.Visible = true;
        }

        protected void btnConfirmLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/HomeCustomer.aspx");
        }

        protected void btnCancelLogout_Click(object sender, EventArgs e)
        {
            pnlLogoutModal.Visible = false;
        }
    }
}
