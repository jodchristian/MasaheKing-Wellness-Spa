<%@ Page Title="Modify Appointment" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="ModifyAppointment.aspx.cs" Inherits="MasaheKingWellnessSpa.Admin.ModifyAppointment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Modify Appointment
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .form-container { width: 50%; margin: 0 auto; background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; font-weight: bold; margin-bottom: 5px; color: #333; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .result { font-weight: bold; margin-top: 10px; display: block; }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-container">
        <h2 style="text-align: center; color: #b4830a;">Modify Appointment</h2>
        
        <div class="form-group">
            <label>Appointment ID:</label>
            <asp:Label ID="lblApptID" runat="server" Font-Bold="true"></asp:Label>
        </div>

        <div class="form-group">
            <label>Customer Name:</label>
            <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>Appointment Date:</label>
            <asp:TextBox ID="txtApptDate" runat="server" TextMode="Date"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>Appointment Time:</label>
            <asp:TextBox ID="txtApptTime" runat="server" TextMode="Time"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>Preferred Therapist Gender:</label>
            <asp:DropDownList ID="ddlTherapistGender" runat="server">
                <asp:ListItem Text="Any" Value="Any"></asp:ListItem>
                <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="form-group">
            <label>Notes:</label>
            <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Rows="4"></asp:TextBox>
        </div>

        <div style="text-align: center; margin-top: 20px;">
            <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn-action btn-save" OnClick="btnSave_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-action btn-cancel" OnClick="btnCancel_Click" />
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="result" ForeColor="Green"></asp:Label>
    </div>
</asp:Content>
