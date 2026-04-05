using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace MasaheKingWellnessSpa
{
    public partial class NewBooking2 : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["MKWellnessSpaDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SelectedServiceCategory"] == null)
            {
                Response.Redirect("NewBooking1.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (lblSelectedCategory != null)
                {
                    lblSelectedCategory.Text = Session["SelectedServiceCategory"].ToString();
                }
                LoadOptions();
            }
        }

        private void LoadOptions()
        {
            try
            {
                string category = Session["SelectedServiceCategory"].ToString();
                
                using (SqlConnection con = new SqlConnection(connString))
                {
                    if (category == "Royal Services")
                    {
                        pnlRoyal.Visible = true;
                        pnlPackages.Visible = false;

                        // Fixed the encoding issue with the Philippine Peso Sign (₱).
                        string query = "SELECT ServiceID, ServiceName + ' - P' + CAST(Price AS VARCHAR(10)) AS ServiceName FROM tbl_Services WHERE Category = 'Singular'";
                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                            {
                                DataTable dt = new DataTable();
                                da.Fill(dt);
                                rblRoyalServices.DataSource = dt;
                                rblRoyalServices.DataBind();
                            }
                        }
                    }
                    else
                    {
                        pnlRoyal.Visible = false;
                        pnlPackages.Visible = true;
                        
                        // Default to ID based on names (or fetch from DB by name)
                        int serviceId = GetServiceIdByName(category, con);
                        Session["FinalServiceID"] = serviceId; // Store Main Service ID

                        if (serviceId > 0)
                        {
                            LoadAddOnGroup(con, serviceId, 1, rblGroup1);
                            
                            // Load group 2 for Prince/Princess and King/Queen
                            if (category == "Prince and Princess Deluxe" || category == "King and Queen Royale")
                            {
                                group2Container.Visible = true;
                                rfvGroup2.Enabled = true;
                                LoadAddOnGroup(con, serviceId, 2, rblGroup2);
                            }
                            else
                            {
                                group2Container.Visible = false;
                                rfvGroup2.Enabled = false;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "An error occurred while loading options: " + ex.Message;
            }
        }

        private int GetServiceIdByName(string name, SqlConnection con)
        {
            int serviceId = 0;
            string query = "SELECT ServiceID FROM tbl_Services WHERE ServiceName = @Name";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Name", name);
                con.Open();
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    serviceId = Convert.ToInt32(result);
                }
                con.Close();
            }
            return serviceId;
        }

        private void LoadAddOnGroup(SqlConnection con, int serviceId, int groupNum, System.Web.UI.WebControls.RadioButtonList rbl)
        {
            string query = @"SELECT AddOnID, AddOnName + CASE WHEN Price > 0 THEN ' (+P' + CAST(Price AS VARCHAR(10)) + ')' ELSE '' END AS Display 
                             FROM tbl_AddOn 
                             WHERE ServiceID = @ServiceID AND InclusionGroup = @Group";
            
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ServiceID", serviceId);
                cmd.Parameters.AddWithValue("@Group", groupNum);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rbl.DataSource = dt;
                    rbl.DataBind();
                }
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    string category = Session["SelectedServiceCategory"].ToString();

                    if (category == "Royal Services")
                    {
                        Session["FinalServiceID"] = rblRoyalServices.SelectedValue;
                    }
                    else
                    {
                        // Store selected addons
                        Session["SelectedAddOn1"] = rblGroup1.SelectedValue;
                        if (group2Container.Visible)
                        {
                            Session["SelectedAddOn2"] = rblGroup2.SelectedValue;
                        }
                    }
                    
                    Response.Redirect("NewBooking3.aspx", false);
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "An error occurred: " + ex.Message;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("NewBooking1.aspx", false);
        }
    }
}