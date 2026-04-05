<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookNow.aspx.cs" Inherits="MasaheKingWellnessSpa.BookNow" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<head runat="server">
    <title>MasaheKing Wellness Spa</title>
    <link rel="stylesheet" href="BookNow.css" />

        <!-- SITE ICON -->
    <link rel="icon" href="images/MK.png">

    <!-- Inter Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400&display=swap" rel="stylesheet">

        <!-- JAVASCRIPT para gumana navbar burger -->
    <script src="burgerFunctionality.js" defer></script>

    <style>
        .gender-options {
            display: flex;
            gap: 50px;
            margin-top: 10px;
        }

        .radio {
            display: flex;
            align-items: center;
            font-size: 18px;
            font-family: 'Inter', sans-serif;
        }

        .radio input {
            margin-right: 8px;
            vertical-align: middle;
            position: relative;
            top: -1px;
        }
    </style>
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
                    
                    <span class="menu-item">
                         <img src="images/search.png" class="menu-icon" alt="Search icon">
                        <a href="Tracking.aspx">Track Booking</a>
                    </span>

                </div>
            </div>
        </div>
    </header>
    <!-- End Header -->

    <!-- Hero Section -->
    <div class="hero">
        <h1 class="title-main">MASAHEKING</h1>
        <h2 class="title-sub">WELLNESS SPA</h2>
        <p class="tagline">It’s not just a massage, it’s an experience</p>
    </div>

    <!-- Booking Form -->
    <div class="booking-wrapper">
        <div class="booking-card">
            <div class="booking-form">
                <div class="form-group">
                    <label>Full Name</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Ex. John Doe"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" 
                        ErrorMessage="* Required" ForeColor="Red" Display="Dynamic" />
                </div>

                <div class="form-group">
                    <label>Email <span class="optional">(Optional)</span></label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Ex. johndoe@gmail.com"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Mobile No.</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" 
                    MaxLength="11" 
                    minlength="11" 
                    TextMode="Phone" 
                    oninput="this.value = this.value.replace(/[^0-9]/g, '');" 
                    placeholder="11-digit no. (e.g., 09XXXXXXXXX)">
                </asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" 
                        ErrorMessage="* Required" ForeColor="Red" Display="Dynamic"/>

                    <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone"
                        ValidationExpression="^\d{11}$" 
                        ErrorMessage="* Phone number must be exactly 11 digits" 
                        ForeColor="Red" Display="Dynamic" />
                </div>

                <div class="form-group">
                    <label>Gender <span class="optional">(Optional)</span></label>
                    <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" CssClass="gender-options">
                        <asp:ListItem Value="Female"> Female</asp:ListItem>
                        <asp:ListItem Value="Male"> Male</asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <div class="form-group1">
                     <div class="service-header">
                         <label>Want to see the services? </label>
                         <a href="Services.aspx" class="view-services">View Services</a>
                 </div>

                <div class="form-group">
                    <label>Service Chosen</label>

                    <asp:RadioButtonList ID="rblService" runat="server" CssClass="service-options">
                        <asp:ListItem Value="Royal Services"> Royal Services</asp:ListItem>
                        <asp:ListItem Value="The Prince & Princess Deluxe"> The Prince & Princess Deluxe</asp:ListItem>
                        <asp:ListItem Value="The King & Queen Royale"> The King & Queen Royale</asp:ListItem>
                        <asp:ListItem Value="Duke Majestic Package"> Duke Majestic Package</asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID="rfvService" runat="server" ControlToValidate="rblService" 
                        InitialValue="" ErrorMessage="* Please select a service" ForeColor="Red" Display="Dynamic" />
                </div>

            </div>
        </div>
    </div>
    <div class="next-container">
    <asp:Button 
    ID="btnNext" 
    runat="server" 
    Text="Next" 
    CssClass="next-btn" 
    OnClick="btnNext_Click" />
</form>
</body>
</html>