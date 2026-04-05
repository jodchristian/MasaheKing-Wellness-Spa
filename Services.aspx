<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Services.aspx.cs" Inherits="MasaheKingWellnessSpa.Services" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Service List</title>

    <!-- SITE ICON -->
    <link rel="icon" href="images/MK.png">

    <!-- GOOGLE FONTS -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Just+Me+Again+Down+Here&family=Kotta+One&display=swap" rel="stylesheet">
  
    <!-- STYLESHEET -->
    <link rel="stylesheet" href="Services.css">

    <!-- JAVASCRIPT para gumana navbar burger -->
    <script src="burgerFunctionality.js" defer></script>

</head>
<body>
    <!-- Header -->
    <header class="header">   
    <div class="logo-area">
        <img src="images/MK.png" alt="MK Spa Logo" class="logo" />
        <span class="brand-name">MasaheKing Wellness Spa</span>
    </div>
    
    <!-- Mga nasa loob ng Header -->
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
    <!-- End of Header -->
    </header>

    <!-- SERVICE LIST -->
    <div class ="Services">
        <h1 id="ServiceList">Service List</h1>
        <nav class="navB">
            <a href="RoyalServices.aspx" class="RS">Royal Services</a>
            <a href="PrincePrincess.aspx" class="PP">The Prince & Princess Deluxe</a>
            <a href="KingQueen.aspx" class="KQ">The King & Queen Royale</a>
            <a href="DukeMajestic.aspx" class="DM">Duke Majestic Package</a>                     
        </nav>
    </div>

    <p id="intro" style="font-size: 2vh;">MasaheKing Wellness Spa, located in San Pedro, Laguna, offers a royalty-inspired relaxation experience. 
        Founded by vlogger Mark Alvee, the spa emphasizes quality service, skilled therapists, and a welcoming atmosphere designed for both comfort and rejuvenation. It operates daily from 2 PM to 2 AM, making it accessible for late-night relaxation.</p>

    <!-- PICTURES -->
    <div class="collage">
        <img src="images/S1.jpg" alt="Photo 1" />
        <img src="images/S2.jpg" alt="Photo 2" />
        <img src="images/S3.jpg" alt="Photo 3" />
        <img src="images/S4.jpg" alt="Photo 4" />
        <img src="images/S5.jpg" alt="Photo 5" />
        <img src="images/S6.jpg" alt="Photo 6" />
    </div>
    

</body>
</html>

