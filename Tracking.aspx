<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tracking.aspx.cs" Inherits="MasaheKingWellnessSpa.Tracking" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Track Booking</title>
    
    <!-- SITE ICON -->
    <link rel="icon" href="images/MK.png">

    <!-- GOOGLE FONTS -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Just+Me+Again+Down+Here&family=Kotta+One&display=swap" rel="stylesheet">

    <!-- STYLESHEET -->
    <link rel="stylesheet" href="Tracking.css" />

    <!-- JAVASCRIPT para gumana navbar burger -->
    <script src="burgerFunctionality.js" defer></script>

</head>
<body>

    <!--==== HEADER ====-->
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

                    <span class="menu-item">
                        <img src="images/search.png" class="menu-icon" alt="Search icon">
                        <a href="Tracking.aspx">Track Booking</a>
                    </span>
                </div>
            </div>
        </div>
    </header>

    <!--==== TRACKING SECTION ====-->
    <div class="tracking-container">
        <h2 class="title">Track Appointment</h2>
    
    <div class="search-bar-container">
        <label>Enter Tracking ID:</label>
        <form id="form1" runat="server">
            <div class="input-wrapper">
                <asp:TextBox ID="txtTrackingId" runat="server" placeholder="MK00001"></asp:TextBox>
                <asp:LinkButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" CssClass="search-btn">
                    <img src="images/searchIcon.png" alt="Search" />
                </asp:LinkButton>
            </div>
        </form>
    </div>

    <div class="error-msg" id="errorMsg" runat="server">No records found for that ID...</div>

    <div class="tracking-card" id="trackingResult" runat="server">
        <div class="tracking-item">
            <span class="label">Schedule:</span>
            <asp:Label ID="lblTime" runat="server" CssClass="value"></asp:Label>
        </div>
        <div class="tracking-item">
            <span class="label">Service:</span>
            <asp:Label ID="lblServiceName" runat="server" CssClass="value"></asp:Label>
        </div>
        <div class="tracking-item">
            <span class="label">Estimated Price:</span>
            <asp:Label ID="lblPrice" runat="server" CssClass="value"></asp:Label>
        </div>
        <div class="tracking-item">
            <span class="label">Status:</span>
            <asp:Label ID="lblStatus" runat="server" CssClass="value status-text"></asp:Label>
        </div>
        <p class="tracking-footer">
            "Please contact us if you want to modify or cancel the appointment"
        </p>
    </div>
</div>
</body>
</html>
