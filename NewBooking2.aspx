<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="NewBooking2.aspx.cs" Inherits="MasaheKingWellnessSpa.NewBooking2" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MasaheKing Wellness Spa - Step 2</title>
    <link rel="stylesheet" href="BookNow.css" />
    <link rel="icon" href="images/MK.png" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400&display=swap" rel="stylesheet" />
    <script src="burgerFunctionality.js" defer></script>
    <style>
        .error-message {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
            display: block;
        }
        .service-chosen-container {
            margin-bottom: 30px;
        }
        .service-chosen-title {
            font-size: 22px;
            font-weight: bold;
            color: #000;
            margin-bottom: 15px;
            font-family: 'Inter', sans-serif;
        }
        .service-chosen-value {
            font-size: 18px;
            color: #444;
            padding-bottom: 10px;
            border-bottom: 2px solid #dcb36d;
            font-family: 'Inter', sans-serif;
            display: block;
        }
        .inclusion-group {
            margin-bottom: 25px;
            background-color: #fcfcfc;
            padding: 20px;
            border-radius: 8px;
            border-left: 5px solid #dcb36d;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .inclusion-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #333;
            border-bottom: 1px solid #eaeaea;
            padding-bottom: 10px;
        }
        .addon-options {
            display: flex;
            flex-direction: column;
            gap: 12px;
            padding-left: 10px;
        }
        /* Style fixes for standardizing radio button alignment */
        .addon-options input[type=radio] {
            margin-right: 12px;
            accent-color: #dcb36d;
            vertical-align: middle;
            margin-top: -2px; /* Fine-tune radio button centering with text */
        }
        .addon-options label {
            font-size: 15px;
            cursor: pointer;
            color: #555;
            vertical-align: middle;
            display: inline-block;
        }
        /* Create a pseudo-wrapper for rows rendered by RadioButtonList to keep inputs and labels together */
        .addon-options tr, .addon-options td {
            display: block; 
        }
        .addon-options td {
            display: flex;
            align-items: center; 
        }

        .service-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
            font-family: 'Inter', sans-serif;
            font-size: 16px;
            background-color: #fcfcfc;
            padding: 20px;
            border-radius: 8px;
            border-left: 5px solid #dcb36d;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .service-list input[type=radio] {
            margin-right: 12px;
            accent-color: #dcb36d;
        }
        .service-list label {
            cursor: pointer;
            color: #444;
        }
        .category-header-display {
            font-size: 16px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #fff;
            margin-top: 10px;
        }
    </style>
</head>
<body style="background-image: url('images/bg.jpg'); background-size: cover; background-repeat: no-repeat; background-position: center; background-attachment: fixed;">
    <form id="form1" runat="server">
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

        
        <div class="hero">
            <!--
            <h1 class="title-main">MASAHEKING</h1>
            <h2 class="title-sub">WELLNESS SPA</h2>
            <p class="tagline">It’s not just a massage, it’s an experience</p>
                -->
        </div>

        <div class="booking-wrapper">
            <div class="booking-card">
                <div class="booking-form">
                    <asp:Label ID="lblError" runat="server" CssClass="error-message"></asp:Label>
                    
                    <div class="service-chosen-container">
                        <div class="service-chosen-title">Service Chosen</div>
                        <asp:Label ID="lblSelectedCategory" runat="server" CssClass="service-chosen-value"></asp:Label>
                    </div>

                    <asp:Panel ID="pnlRoyal" runat="server" Visible="false">
                        <div class="form-group inclusion-group">
                            <div class="inclusion-title">Select (1) Royal Service</div>
                            <asp:RadioButtonList ID="rblRoyalServices" runat="server" CssClass="addon-options" DataTextField="ServiceName" DataValueField="ServiceID">
                            </asp:RadioButtonList>
                            <asp:RequiredFieldValidator ID="rfvRoyal" runat="server" ControlToValidate="rblRoyalServices"
                                ErrorMessage="* Please select a service" CssClass="error-message" Display="Dynamic" />
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlPackages" runat="server" Visible="false">
                        <div class="form-group inclusion-group" id="group1Container" runat="server">
                            <div class="inclusion-title">First Treatment (Choose 1)</div>
                            <asp:RadioButtonList ID="rblGroup1" runat="server" CssClass="addon-options" DataTextField="Display" DataValueField="AddOnID">
                            </asp:RadioButtonList>
                            <asp:RequiredFieldValidator ID="rfvGroup1" runat="server" ControlToValidate="rblGroup1"
                                ErrorMessage="* Please select from Group 1" CssClass="error-message" Display="Dynamic" />
                        </div>
                        
                        <div class="form-group inclusion-group" id="group2Container" runat="server" visible="false">
                            <div class="inclusion-title">Second Treatment (Choose 1)</div>
                            <asp:RadioButtonList ID="rblGroup2" runat="server" CssClass="addon-options" DataTextField="Display" DataValueField="AddOnID">
                            </asp:RadioButtonList>
                            <asp:RequiredFieldValidator ID="rfvGroup2" runat="server" ControlToValidate="rblGroup2"
                                ErrorMessage="* Please select from Group 2" CssClass="error-message" Display="Dynamic" />
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        
        <div class="next-container">
            <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="next-btn" style="background-color: #555;" OnClick="btnBack_Click" CausesValidation="false" />
            <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="next-btn" OnClick="btnNext_Click" />
        </div>
    </form>
</body>
</html>