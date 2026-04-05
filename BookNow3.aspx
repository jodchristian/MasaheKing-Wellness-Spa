<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookNow3.aspx.cs" Inherits="MasaheKingWellnessSpa.BookNow3" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
        <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<head runat="server">
<title>MasaheKing</title>

<link rel="stylesheet" href="BookNow.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400&display=swap" rel="stylesheet">

        <!-- Inter Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400&display=swap" rel="stylesheet">

        <!-- JAVASCRIPT para gumana navbar burger -->
    <script src="burgerFunctionality.js" defer></script>
</head>

<body style="background-image: url('images/bg.jpg'); background-size: cover; background-repeat: no-repeat; background-position: center; background-attachment: fixed;">

<form id="form1" runat="server">

<!-- Header -->
<header class="header">   
    <div class="logo-area">
        <img src="images/MK.png" alt="MK Spa Logo" class="logo" />
        <span class="brand-name">MasaheKing Wellness Spa</span>
    </div>

    <div class="menu-area">
    <nav class="navA">
        <a href="HomeCustomer.aspx">Home</a>
        <a href="NewBooking1.aspx" class="book">Book Now</a>            
    </nav>

    <div class="navbar">
        <div class="burger"> 
            <span></span> 
            <span></span> 
            <span></span> 
        </div>

        <div id="dropdownContent">
            <span class="menu-item">
                <img src="images/home.png" class="menu-icon" alt="Home icon">
                <a href="HomeCustomer.aspx">Home</a>
            </span>

            <span class="menu-item">
                <img src="images/info.png" class="menu-icon" alt="About icon">
                <a href="AboutUs.aspx">About Us</a>
            </span>

            <span class="menu-item">
                <img src="images/services.png" class="menu-icon" alt="Services icon">
                <a href="Services.aspx">Services</a>
            </span>

            <span class="menu-item">
                <img src="images/therapists.png" class="menu-icon" alt="Therapist icon">
                <a href="Therapist.aspx">Therapist</a>
            </span>

            <span class="menu-item">
                <img src="images/contacts.png" class="menu-icon" alt="Contact icon">
                <a href="Contacts.aspx">Contact Us</a>
            </span>
        </div>
    </div>
</div>
</header>

<!-- Hero -->
<div class="hero">
    <h1 class="title-main">MASAHEKING</h1>
    <h2 class="title-sub">WELLNESS SPA</h2>
    <p class="tagline">It’s not just a massage, it’s an experience</p>
</div>

<!-- Booking Form -->
<div class="booking-wrapper">
    <div class="booking-card">
        <div class="booking-form">
            <asp:Label ID="lblError" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic"></asp:Label>

            <div class="form-group">
                <label>Service Chosen</label>
                <asp:TextBox ID="txtService" runat="server" ReadOnly="true" CssClass="form-input"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Service Type</label>
                <asp:TextBox ID="txtType" runat="server" ReadOnly="true" CssClass="form-input"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Service Duration</label>
                <asp:TextBox ID="txtDuration" runat="server" ReadOnly="true" CssClass="form-input"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Date</label>
                <asp:TextBox ID="dtAppt" runat="server" CssClass="form-input" TextMode="Date" AutoPostBack="true" OnTextChanged="dtAppt_TextChanged"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="dtAppt" 
                    ErrorMessage="* Select date" ForeColor="Red" Display="Dynamic" Font-Size="Small" />
            </div>

            <div class="form-group">
                <label>Time</label>
                <asp:DropDownList ID="txtApptTime" runat="server" CssClass="form-input-time" Enabled="false">
                    <asp:ListItem Text="-- Select a Date First --" Value="" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvTime" runat="server" ControlToValidate="txtApptTime" 
                    InitialValue="" ErrorMessage="* Select time" ForeColor="Red" Display="Dynamic" Font-Size="Small" />
            </div>

            <div class="form-group">
                <label>Preferred Therapist Gender</label>
                <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" CssClass="gender-options">
                    <asp:ListItem Value="Female"> Female</asp:ListItem>
                    <asp:ListItem Value="Male"> Male</asp:ListItem>
                </asp:RadioButtonList>
            </div>

            <div class="form-group">
                <label>Notes</label>
                <textarea id="txtNotes" runat="server" rows="4" placeholder="Enter notes..." class="form-input"></textarea>
            </div>
        </div>
    </div>
</div>

<div class="next-container">
    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="next-btn" OnClick="btnSubmit_Click" />
</div>

<asp:Panel ID="overlay" runat="server" Visible="false" CssClass="confirm-overlay"></asp:Panel>
<asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="success-dialog">
    <div class="dialog-content">
        <div class="check-icon">
            <img src="images/success.png" alt="Success" />
        </div>
        <h2>Success!</h2>
        <p class="msg-main">Your appointment request has been submitted.</p>
        
        <div class="id-container">
            <span>YOUR TRACKING ID</span>
            <asp:Label ID="lblID" runat="server" CssClass="tracking-id-text"></asp:Label>
        </div>

        <p class="msg-sub">Redirecting you to the Home Page in <span id="seconds">5</span> seconds...</p>
    </div>
</asp:Panel>


</form>
</body>
</html>
