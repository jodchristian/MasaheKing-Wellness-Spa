<%@ Page Title="Day Schedule" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="DaySchedule.aspx.cs" Inherits="MasaheKingWellnessSpa.Admin.DaySchedule" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Day Schedule
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* Theme-aware accent colors */
        :root {
            --accent-color: #b4830a;      /* light-theme default (gold) */
            --accent-hover: #c99f2a;
            --arrow-size: 2.0rem;
        }

        @media (prefers-color-scheme: dark) {
            :root {
                --accent-color: #ffd28a;  /* softer gold on dark */
                --accent-hover: #ffe6b0;
            }
        }

        /* Modal + form styles (unchanged) */
        .modal-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.6); display: flex; align-items: center; justify-content: center; z-index: 1000; }
        .modal-content { background: #fff; padding: 30px; border-radius: 8px; width: 400px; text-align: center; box-shadow: 0 4px 15px rgba(0,0,0,0.2); }
        .form { display: flex; flex-direction: column; gap: 10px; text-align: left; }
        .input { margin-bottom: 5px; }
        .info-group { border: 1px solid #dee2e6; padding: 15px; border-radius: 6px; margin-bottom: 15px; background-color: #f8f9fa; }
        .info-group legend { font-weight: bold; font-size: 1.1em; color: #495057; background: #fff; padding: 0 10px; border: 1px solid #dee2e6; border-radius: 4px; width: auto; }
        .schedule-card { border: 1px solid #ccc; padding: 15px; margin-bottom: 10px; border-radius: 5px; cursor: pointer; background-color: #fff; transition: background-color 0.3s; text-align: left; display: block; text-decoration: none; color: inherit; border-radius: 2em;}
        .schedule-card:hover { background-color: #f1f1f1; }
        .time-label { font-weight: bold; color: var(--forest); font-size: 1.2em; }

        /* Repeater card — lift + left accent on hover */
        .schedule-card {
            border-left: 3px solid transparent;
            transform: translateY(0);
            transition: background-color 0.2s ease,
                        transform 0.2s ease,
                        border-left-color 0.2s ease,
                        box-shadow 0.2s ease;
        }

        .schedule-card:hover {
            background-color: #f1f1f1;
            transform: translateY(-4px);
            border-left: 5px solid var(--forest);
            box-shadow: 0 4px 12px rgba(180, 131, 10, 0.15);
        }

        .dayNavbar {
            display: flex;
            justify-content: space-around;
            align-items: center;

            margin-bottom: 1em;
        }

        /* Arrow button styles */
        .arrow-button {
            background: transparent;
            border: none;
            padding: 0.25rem;
            cursor: pointer;
            color: white;
            background-color: var(--gold);
            transition: transform 0.15s ease, color 0.15s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;

            border-radius: 2em;

            width: calc(var(--arrow-size) * 1.4);
            height: calc(var(--arrow-size) * 1.4);
        }

        .arrow-button svg {
            width: var(--arrow-size);
            height: var(--arrow-size);
            display: block;
            transition: transform 0.15s ease;
        }

        /* Left arrow flip handled on svg so hover behaves consistently */
        .arrow-button.left svg {
            transform: scaleX(-1);
        }

        .arrow-button:hover {
            transform: translateY(-3px) scale(1.05);
            color: var(--accent-hover);
        }

        /* small focus style for accessibility */
        .arrow-button:focus {
            outline: 2px solid rgba(0,0,0,0.12);
            outline-offset: 2px;
        }

        .arrow-button a {
            text-decoration: none;
            color: white;
        }

        #left {

        }

    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="upMain" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div id="main" style="display: flex; gap: 20px;">
                
                <div class="grid-container" style="flex: 1; text-align: center;">
                    <div class="dayNavbar">
                        <!-- Previous day button (flipped) -->
                        <asp:LinkButton ID="btnPrev" runat="server" CssClass="arrow-button left" OnClick="btnPrev_Click" ToolTip="Previous day" aria-label="Previous day" CausesValidation="false">
                            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false">
                                <!-- simple arrow path; uses currentColor -->
                                <path d="M8 5l8 7-8 7V5z" fill="currentColor"/>
                            </svg>
                        </asp:LinkButton>

                        <asp:Label ID="lblMonthDay" runat="server" style="font-weight: 700; font-size: 2em; display: block;"></asp:Label>

                        <!-- Next day button -->
                        <asp:LinkButton ID="btnNext" runat="server" CssClass="arrow-button" OnClick="btnNext_Click" ToolTip="Next day" aria-label="Next day" CausesValidation="false">
                            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false">
                                <path d="M8 5l8 7-8 7V5z" fill="currentColor"/>
                            </svg>
                        </asp:LinkButton>
                    </div>

                    <asp:Repeater ID="rptSchedule" runat="server" OnItemCommand="rptSchedule_ItemCommand">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkSelect" runat="server" CssClass="schedule-card" CommandName="Select" CommandArgument='<%# Eval("ApptID") %>'>
                                <div class="time-label"><%# Eval("ApptTime") %></div>
                                <div><strong>Customer:</strong> <%# Eval("CustomerName") %></div>
                                <div><strong>Service:</strong> <%# Eval("ServiceName") %></div>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:Repeater>
                    
                    <asp:Label ID="lblNoRecords" runat="server" Visible="false" Text="No records for this day..." ForeColor="Gray" Font-Italic="true" style="display: block; font-size: 2em; margin-top: 1em; text-align: center;"></asp:Label>
                </div>

                <asp:Panel ID="pnlDetails" runat="server" Visible="false" CssClass="form" style="flex: 1;">
                    <h3 style="text-align: center; color: #b4830a; font-weight: 700; font-size: 2em;">
                        Appointment #<asp:Label ID="lblTrackingID" runat="server"></asp:Label>
                    </h3>

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

                    <fieldset class="info-group">
                        <legend>Additional Notes</legend>
                        <div class="input">
                            <asp:Label ID="lblNote" runat="server"></asp:Label>
                        </div>
                    </fieldset>

                    <div id="buttonList" style="display: flex; justify-content: center; gap: 1em; margin-top: 15px;">
                        <asp:Button ID="btnModify" runat="server" Text="Modify" CssClass="btn-action btn-modify" OnClick="btnModify_Click" />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn-action btn-delete" OnClick="btnDelete_Click" />
                        <asp:Button ID="btnComplete" runat="server" Text="Mark as Complete" CssClass="btn-action btn-complete" OnClick="btnComplete_Click" />
                    </div>

                    <div style="text-align: center;">
                        <asp:Label ID="actionResult" runat="server" CssClass="result" ForeColor="Green"></asp:Label>
                    </div>
                </asp:Panel>

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