<%@ Page Title="Pending Appointments" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="PendingAppointments.aspx.cs" Inherits="MasaheKingWellnessSpa.Admin.PendingAppointments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Pending Appointments
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>        
        /* Modal Overlay styling */
        .modal-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.6); display: flex; align-items: center; justify-content: center; z-index: 1000; }
        .modal-content { background: #fff; padding: 30px; border-radius: 8px; width: 400px; text-align: center; box-shadow: 0 4px 15px rgba(0,0,0,0.2); }
        
        /* Form layout styling */
        .form { display: flex; flex-direction: column; gap: 10px; text-align: left; }
        .input { margin-bottom: 5px; }
        .noteTextbox { width: 100%; max-width: 100%; box-sizing: border-box; resize: vertical; }

        /* Detail Grouping Styling */
        .info-group { border: 1px solid #dee2e6; padding: 15px; border-radius: 6px; margin-bottom: 15px; background-color: #f8f9fa; }
        .info-group legend { font-weight: bold; font-size: 1.1em; color: #495057; background: #fff; padding: 0 10px; border: 1px solid #dee2e6; border-radius: 4px; width: auto; }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="upMain" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div id="main" style="display: flex; gap: 20px;">
                
                <!-- Left Side: GridView for Pending Appointments -->
                <div class="grid-container" style="flex: 1; text-align: center;"> <!-- We can let it expand naturally -->
                                <h2>Pending Appointments</h2>

                    <asp:GridView ID="gvAppointments" runat="server" AutoGenerateColumns="False" 
                                  DataKeyNames="ApptID" OnSelectedIndexChanged="gvAppointments_SelectedIndexChanged"
                                  CssClass="grid" Width="100%">
                        <Columns>
                            <asp:BoundField DataField="ApptDate" HeaderText="Date" DataFormatString="{0:MMM dd}" />
                            <asp:BoundField DataField="ApptTime" HeaderText="Time" />
                            <asp:BoundField DataField="ServiceName" HeaderText="Service" />
                            <asp:CommandField ShowSelectButton="True" SelectText="View Details" />
                        </Columns>
                    </asp:GridView>
                </div>

                <!-- Right Side: Detailed Information Div -->
                <asp:Panel ID="pnlDetails" runat="server" Visible="false" CssClass="form" style="flex: 1;">
                    <h3 style="text-align: center; color: #b4830a; font-weight: 700; font-size: 2em;">
                        Appointment #<asp:Label ID="lblTrackingID" runat="server"></asp:Label>
                    </h3>

                    <!-- Customer Details Group -->
                    <fieldset class="info-group">
                        <legend>Customer Details</legend>
                        <div class="input">
                            <asp:Label ID="lblFullName" runat="server" Text="Full Name: " Font-Bold="true"></asp:Label>
                            <asp:Label ID="lblFullName_OUT" runat="server"></asp:Label>
                        </div>
                        <div class="input">
                            <asp:Label ID="lblEmail" runat="server" Text="Email: " Font-Bold="true"></asp:Label>
                            <asp:Label ID="lblEmail_OUT" runat="server"></asp:Label>
                        </div>
                        <div class="input">
                            <asp:Label ID="lblMobileNumber" runat="server" Text="Mobile Number: " Font-Bold="true"></asp:Label>
                            <asp:Label ID="lblMobileNumber_OUT" runat="server"></asp:Label>
                        </div>
                        <div class="input">
                            <asp:Label ID="lblGender" runat="server" Text="Gender: " Font-Bold="true"></asp:Label>
                            <asp:Label ID="lblGender_OUT" runat="server"></asp:Label>
                        </div>
                    </fieldset>

                    <!-- Appointment Schedule Group -->
                    <fieldset class="info-group">
                        <legend>Schedule Details</legend>
                        <div class="input">
                            <asp:Label ID="lblDate" runat="server" Text="Date: " Font-Bold="true"></asp:Label>
                            <asp:Label ID="lblDate_OUT" runat="server"></asp:Label>
                        </div>
                        <div class="input">
                            <asp:Label ID="lblTime" runat="server" Text="Time: " Font-Bold="true"></asp:Label>
                            <asp:Label ID="lblTime_OUT" runat="server"></asp:Label>
                        </div>
                        <div class="input">
                            <asp:Label ID="lblPreferredTherapist" runat="server" Text="Preferred Therapist Gender: " Font-Bold="true"></asp:Label>
                            <asp:Label ID="lblPreferredTherapist_OUT" runat="server"></asp:Label>
                        </div>
                    </fieldset>

                    <!-- Ordered Services Group -->
                    <fieldset class="info-group">
                        <legend>Service Summary</legend>
                        <div class="input">
                            <asp:Label ID="lblService" runat="server" Text="Service: " Font-Bold="true"></asp:Label>
                            <asp:Label ID="lblService_OUT" runat="server"></asp:Label>
                        </div>
                        <div class="input">
                            <asp:Label ID="lblAddOnTitle" runat="server" Text="Selected Add-Ons: " Font-Bold="true"></asp:Label>
                            <asp:Repeater ID="rptAddOns" runat="server">
                                <HeaderTemplate><ul style="margin: 5px 0 5px 20px;"></HeaderTemplate>
                                <ItemTemplate>
                                    <li><%# Eval("AddOnName") %> - <%# Eval("Price", "{0:0.00}") %></li>
                                </ItemTemplate>
                                <FooterTemplate></ul></FooterTemplate>
                            </asp:Repeater>
                            <asp:Label ID="lblNoAddOns_OUT" runat="server" Text="No add-ons selected." Visible="false" Font-Italic="true"></asp:Label>
                        </div>
                        <div class="input" style="margin-top: 10px; padding-top: 10px; border-top: 1px dashed #ccc;">
                            <asp:Label ID="lblTotalPrice" runat="server" Text="Estimated Total Price: " Font-Bold="true"></asp:Label>
                            <asp:Label ID="lblTotalPrice_OUT" runat="server" Font-Bold="true" ForeColor="DarkGreen"></asp:Label>
                        </div>
                    </fieldset>

                    <!-- Extra Information Group -->
                    <fieldset class="info-group">
                        <legend>Additional Notes</legend>
                        <div class="input">
                            <asp:Label ID="lblNote" runat="server"></asp:Label>
                        </div>
                    </fieldset>

                    <!-- Action Buttons -->
                    <div id="buttonList" style="display: flex; justify-content: center; gap: 1em; margin-top: 15px;">
                        <asp:Button ID="btnApprove" runat="server" Text="Approve" CssClass="btn-action btn-confirm" OnClick="btnOpenConfirm_Click" />
                        <asp:Button ID="btnDeny" runat="server" Text="Deny" CssClass="btn-action btn-deny" OnClick="btnOpenDeny_Click" />
                    </div>

                    <div style="text-align: center;">
                        <asp:Label ID="actionResult" runat="server" CssClass="result" ForeColor="Green"></asp:Label>
                    </div>

                </asp:Panel>

                <!-- Decision Modal Overlay -->
                <asp:Panel ID="pnlModal" runat="server" CssClass="modal-overlay" Visible="false">
                    <div class="modal-content">
                        <h3><asp:Label ID="lblModalTitle" runat="server" Text="Confirm Action"></asp:Label></h3>
                        <p><asp:Label ID="lblModalMessage" runat="server" Text="Are you sure you want to proceed?"></asp:Label></p>
                        <div style="margin-top: 20px;">
                            <asp:Button ID="btnFinalizeAction" runat="server" Text="Yes, Proceed" OnClick="btnFinalizeAction_Click" />
                            <asp:Button ID="btnCancelAction" runat="server" Text="Cancel" CssClass="btn-modal btn-secondary" OnClick="btnCancelAction_Click" />
                        </div>
                    </div>
                </asp:Panel>

            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>