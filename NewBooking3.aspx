<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="NewBooking3.aspx.cs" Inherits="MasaheKingWellnessSpa.NewBooking3" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MasaheKing Wellness Spa - Step 3</title>
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
        .success-message {
            color: #2e7d32;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            display: block;
            text-align: center;
            background-color: #e8f5e9;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #c8e6c9;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }
        .tracking-id-display {
            font-size: 24px;
            color: #1565c0;
            font-weight: 700;
            background-color: #e3f2fd;
            padding: 10px;
            border-radius: 4px;
            display: inline-block;
            margin: 10px 0;
            letter-spacing: 2px;
        }
        .tracking-link {
            display: inline-block;
            margin-top: 15px;
            padding: 12px 22px;
            background-color: #dcb36d;
            color: white !important;
            text-decoration: none !important;
            border-radius: 6px;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .tracking-link:hover {
            background-color: #c99f5b;
        }

        /* Modal / Success Overlay styles */
        .success-overlay {
            position: fixed;
            left: 0;
            top: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.35);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }
        .success-modal {
            width: 720px;
            max-width: 92%;
            background: #fff;
            border-radius: 14px;
            padding: 40px 36px;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }
        .success-icon {
            width: 88px;
            height: 88px;
            border-radius: 50%;
            margin: 0 auto 18px auto;
            border: 4px solid #2ecc71;
            color: #2ecc71;
            font-size: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .success-modal h2 {
            margin: 4px 0 6px 0;
            font-size: 28px;
            font-weight: 700;
        }
        .success-modal p.lead {
            margin: 0 0 18px 0;
            color: #444;
            font-size: 16px;
        }
        .tracking-box {
            border-radius: 8px;
            padding: 20px 28px;
            margin: 18px auto;
            display: inline-block;
            background: #fff9f2;
            border: 2px dashed #e6b656;
            min-width: 340px;
        }
        .tracking-box .label {
            font-size: 12px;
            color: #9e9e9e;
            letter-spacing: 2px;
        }
        .tracking-box .value {
            margin-top: 10px;
            font-weight: 700;
            letter-spacing: 6px;
            font-size: 20px;
            color: #222;
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
                    <asp:Label ID="lblSuccess" runat="server" CssClass="success-message" Visible="false"></asp:Label>

                    <!-- Success Modal -->
                    <asp:Panel ID="pnlSuccessModal" runat="server" CssClass="success-overlay" Visible="false">
                        <div class="success-modal">
                            <div class="success-icon">&#10004;</div>
                            <h2>Success!</h2>
                            <p class="lead">Your appointment request has been submitted.</p>

                            <div class="tracking-box">
                                <div class="label">YOUR TRACKING ID</div>
                                <div class="value"><asp:Label ID="lblModalTrackingId" runat="server" /></div>
                            </div>
                            <br />
                            <asp:HyperLink ID="hlTrack" runat="server" CssClass="tracking-link">Track Your Appointment</asp:HyperLink>
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlForm" runat="server" CssClass="form-group">
                            <label>Preferred Date</label>
                            <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date" AutoPostBack="true" OnTextChanged="txtDate_TextChanged"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="txtDate" 
                                ErrorMessage="* Date is required" CssClass="error-message" Display="Dynamic" />

                        <div class="form-group">
                            <label>Preferred Time</label>
                            <asp:DropDownList ID="ddlTime" runat="server" CssClass="form-control" Enabled="false">
                                <asp:ListItem Text="-- Select a Date First --" Value="" />
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvTime" runat="server" ControlToValidate="ddlTime" 
                                InitialValue="" ErrorMessage="* Time is required" CssClass="error-message" Display="Dynamic" />
                        </div>

                        <div class="form-group">
                            <label>Preferred Therapist Gender</label>
                            <asp:RadioButtonList ID="rblTherapistGender" runat="server" RepeatDirection="Horizontal" CssClass="gender-options">
                                <asp:ListItem Value="Any" Selected="True"> Any</asp:ListItem>
                                <asp:ListItem Value="Female"> Female</asp:ListItem>
                                <asp:ListItem Value="Male"> Male</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>

                        <div class="form-group">
                            <label>Special Requests / Notes (Optional)</label>
                            <asp:TextBox ID="txtNotes" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Any special requests?"></asp:TextBox>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        
        <div class="next-container">
            <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="next-btn" style="background-color: #555;" OnClick="btnBack_Click" CausesValidation="false" />
            <asp:Button ID="btnSubmit" runat="server" Text="Submit Booking" CssClass="next-btn" OnClick="btnSubmit_Click" />
        </div>
    </form>
</body>
</html>