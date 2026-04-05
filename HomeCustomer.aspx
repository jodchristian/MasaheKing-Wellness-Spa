<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomeCustomer.aspx.cs" Inherits="MasaheKingWellnessSpa.Home__Customer_" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MasaheKing Wellness Spa</title>
    
    <!-- SITE ICON -->
    <link rel="icon" href="images/MK.png">

    <!-- GOOGLE FONTS -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Just+Me+Again+Down+Here&family=Kotta+One&display=swap" rel="stylesheet">

    <!-- STYLESHEET -->
    <link rel="stylesheet" href="HomeCustomer.css" />

    <!-- JAVASCRIPT para gumana navbar burger -->
    <script src="burgerFunctionality.js" defer></script>

</head>
<body>

    <!--==== HEADER ====-->
    <header class="header">   
        <div class="logo-area">
            <img src="images/MK.png" alt="MK Spa Logo" class="logo" />
            <span class="brand-name" style="width:100%;">MasaheKing Wellness Spa</span>
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
    <!--==== HEADER SECTION ====-->
        <div class="section-1">
            <div class="left-section">
                <asp:Label ID="Label1" runat="server" Text="Welcome To" CssClass="sub-heading"></asp:Label>
                <br />
                <asp:Label ID="Label2" runat="server" Text="MASAHEKING" CssClass="main-title"></asp:Label>
                <br />
                <asp:Label ID="Label3" runat="server" Text="WELLNESS SPA" CssClass="main-title gold-text"></asp:Label>
                <br /><br />
                <asp:Label ID="Label4" runat="server"  CssClass="body-text" Text="Feel REBORN and REVITALIZED this year! Your Wellness is our priority. We are open to make your day better."></asp:Label>
                <br />
                <asp:Label ID="Label5" runat="server"  CssClass="body-text" Text="Operating Hours: 2pm - 2am"></asp:Label>
                <asp:Label ID="Label6" runat="server"  CssClass="body-text" Text="Monday - Friday"></asp:Label>
            </div>

            <div class="right-section">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/NewBG.png" CssClass="hero-image"/>
            </div>
        </div>

    <!--==== ABOUT SECTION ====-->
    <div class="section-2">
        <div class="section-2-container">
            <div class="left-second-section">
                <asp:Image ID="Image2" runat="server" ImageUrl="~/images/SecondBG.png" CssClass="hero-image"/>
            </div>
            <div class="right-second-section">
                <h2 class="script-title">About Us</h2>
                <h3 class="brand-sub">MasaheKing Wellness Spa</h3>
                <p class="about-description">
                    MasaheKing Wellness Spa is inspired by Mark Alvee, widely known as the Masahe King, 
                a vlogger who features different spas in various locations...

                </p>
                <a href="AboutUs.aspx" class="read-more">Read More<span class="arrow">→</span></a>
            </div>
        </div>
    </div>

    <!--==== SERVICE SECTION ====-->
    <div class="service-section">
        <div class="service-section-container">
            <div class="service-header">
                <h2 class="service-title">Service<span class="cursive-text">List</span></h2>
                <p class="service-desc">Select the services that work for you, with pricing that stays flexible.</p>
            </div>

            <div class="cards-container">
                    <div class="service-card">
                        <h3>Royal Services</h3>
                        <p>Each massage is designed to harmonize body, mind, and spirit—whether you seek swift relief, holistic healing, or indulgent luxury.</p>
                    </div>

                    <div class="service-card">
                        <h3>The Prince & Princess Deluxe</h3>
                        <p>This luxurious package combines rejuvenating scrubs, soothing massages, and your choice of premium add-ons—completed with our signature special tea.</p>
                    </div>

                    <div class="service-card">
                        <h3>The King & Queen Royal</h3>
                        <p>This premium package combines revitalizing scrubs, signature massages, soothing therapies, and exquisite wellness rituals.</p>
                    </div>     
                
                    <div class="service-card">
                        <h3>Duke Majestic Package</h3>
                        <p>Elevate your experience with customizable add-ons like hot stone therapy, facial massage, or sauna, creating a tailored royal treatment that perfectly suits your wellness needs..</p>
                    </div>
              </div>

                <div class="services-footer">
                    <a href="Services.aspx" class="read-more-gold">Read More →</a>
                    <p class="community-text">Join our growing community on:</p>
                    <div class="social-buttons">
                        <a class="social-btn" href="https://www.facebook.com/profile.php?id=61554613534477">Facebook</a>
                        <a class="social-btn" href="https://www.instagram.com/mark_alvee/?hl=tl">Instagram</a>
                    </div>
                </div>
        </div>
    </div>
</body>
</html>
