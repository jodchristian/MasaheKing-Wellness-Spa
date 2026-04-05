<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="Calendar.aspx.cs" Inherits="MasaheKingWellnessSpa.Admin.Calendar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div id="main">
        <asp:Calendar ID="calendar" runat="server" CssClass="calendar" OnSelectionChanged="calendar_SelectionChanged" OnDayRender="calendar_DayRender"></asp:Calendar>
    </div>

</asp:Content>