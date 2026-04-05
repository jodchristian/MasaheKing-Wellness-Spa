<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="NewBooking1.aspx.cs" Inherits="MasaheKingWellnessSpa.NewBooking1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MasaheKing Wellness Spa - Step1</title>
    <link rel="stylesheet" href="BookNow.css" />
    <link rel="icon" href="images/MK.png" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400&display=swap" rel="stylesheet" />
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
        .error-message {
            color: red;
            font-size: 14px;
        }
        /* Service option layout */
        .service-options {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }
        .service-item {
            display: flex;
            gap: 16px;
            align-items: flex-start; /* align radio with the top of the title */
        }
        .service-radio {
            margin-top: 6px; /* small offset so radio centers next to title line */
            transform: translateY(2px);
        }
        .service-content {
            flex: 1;
        }
        .service-title {
            font-weight: 700;
            font-size: 22px;
            margin: 0 0 8px 0;
        }
        .service-desc {
            font-size: 14px;
            color: #333;
            background: rgba(255,255,255,0.85);
            padding: 8px 10px;
            border-radius: 6px;
            display: block;
            margin-top: 0;
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
                    
                    <div class="form-group">
                        <label>Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Ex. John Doe"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" 
                            ErrorMessage="* Required" CssClass="error-message" Display="Dynamic" />
                    </div>

                    <div class="form-group">
                        <label>Email <span class="optional">(Optional)</span></label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Ex. johndoe@gmail.com"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Mobile No.</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" MaxLength="11" placeholder="11-digit no. (e.g., 09XXXXXXXXX)"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" 
                            ErrorMessage="* Required" CssClass="error-message" Display="Dynamic"/>
                    </div>

                    <div class="form-group">
                        <label>Gender <span class="optional">(Optional)</span></label>
                        <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" CssClass="gender-options">
                            <asp:ListItem Value="Female"> Female</asp:ListItem>
                            <asp:ListItem Value="Male"> Male</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>

                <br />

                <div class="form-group1">
                     <div class="service-header">
                         <label>Want to see the services? </label>
                         <a href="Services.aspx" class="view-services">View Services</a>
                 </div>

                    <div class="form-group">
                         <div class="service-header">
                             <label>Service Category Chosen</label>
                         </div>
                        <div class="service-options">

                            <div class="service-item">
                                <asp:RadioButton ID="rbRoyalServices" runat="server" GroupName="ServiceGroup" CssClass="service-radio" />
                                <div class="service-content">
                                    <div class="service-title">Royal Services</div>
                                    <div class="service-desc">A curated set of premium royal packages designed to deliver the ultimate pampering experience. Includes signature treatments and exclusive amenities.</div>
                                </div>
                            </div>

                            <div class="service-item">
                                <asp:RadioButton ID="rbPrinceDeluxe" runat="server" GroupName="ServiceGroup" CssClass="service-radio" />
                                <div class="service-content">
                                    <div class="service-title">Prince and Princess Deluxe</div>
                                    <div class="service-desc">A luxurious treatment designed for couples or singles seeking deep relaxation and pampering. Includes aromatherapy, full-body massage, and deluxe amenities.</div>
                                </div>
                            </div>

                            <div class="service-item">
                                <asp:RadioButton ID="rbKingRoyale" runat="server" GroupName="ServiceGroup" CssClass="service-radio" />
                                <div class="service-content">
                                    <div class="service-title">King and Queen Royale</div>
                                    <div class="service-desc">Our signature royal package featuring premium oils, hot stone therapy, and an extended massage session to rejuvenate body and mind.</div>
                                </div>
                            </div>

                            <div class="service-item">
                                <asp:RadioButton ID="rbDukeMajestic" runat="server" GroupName="ServiceGroup" CssClass="service-radio" />
                                <div class="service-content">
                                    <div class="service-title">Duke Majestic</div>
                                    <div class="service-desc">An invigorating treatment focusing on muscle relief and improved circulation, perfect for active clients or those with targeted tension.</div>
                                </div>
                            </div>

                        </div>
                        <asp:CustomValidator ID="cvService" runat="server" OnServerValidate="cvService_ServerValidate" ErrorMessage="* Please select a service" CssClass="error-message" Display="Dynamic" />
                    </div>
                </div>
            </div>
        </div>
        
        <div class="next-container">
            <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="next-btn" OnClick="btnNext_Click" />
        </div>
    </form>
</body>
</html>