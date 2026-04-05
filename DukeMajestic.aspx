<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DukeMajestic.aspx.cs" Inherits="MasaheKingWellnessSpa.DukeMajestic" %><!DOCTYPE html><html lang="en"><head>

 <!DOCTYPE html>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Service List</title>
    <head>
        <!-- SITE ICON -->
        <link rel="icon" href="images/MK.png">
    </head>
    <header class="header">   
        <div class="logo-area">
            <img src="images/MK.png" alt="MK Spa Logo" class="logo" />
            <span class="brand-name">MasaheKing Wellness Spa</span>
        </div>
        


        <!-- GOOGLE FONTS -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Just+Me+Again+Down+Here&family=Kotta+One&display=swap" rel="stylesheet">

        <!-- STYLESHEET -->
        <link rel="stylesheet" href="DukeMajestic.css"></head><body>

        <!-- JAVASCRIPT para gumana navbar burger -->
        <script src="burgerFunctionality.js" defer></script>
        
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
                    <span class="menu-item1">
                        <img src="images/home.png" class="menu-icon" alt="Home icon">
                        <a href="HomeCustomer.aspx">Home</a>
                    </span>

                    <span class="menu-item1">
                        <img src="images/info.png" class="menu-icon" alt="About icon">
                        <a href="AboutUs.aspx">About Us</a>
                    </span>

                    <span class="menu-item1">
                        <img src="images/services.png" class="menu-icon" alt="Services icon">
                        <a href="Services.aspx">Services</a>
                    </span>

                    <span class="menu-item1">
                        <img src="images/therapists.png" class="menu-icon" alt="Therapist icon">
                        <a href="Therapist.aspx">Therapist</a>
                    </span>

                    <span class="menu-item1">
                        <img src="images/contacts.png" class="menu-icon" alt="Contact icon">
                        <a href="Contacts.aspx">Contact Us</a>
                    </span>
                    
                    <span class="menu-item1">
                        <img src="images/search.png" class="menu-icon" alt="Search icon">
                        <a href="Tracking.aspx">Track Booking</a>
                    </span>
                </div>
            </div>
        </div>
    </header>

    <div class="Services">
        <h1 id="ServiceList">Service List</h1>
        <nav class="navB">
            <a href="RoyalServices.aspx" class="RS">Royal Services</a>
            <a href="PrincePrincess.aspx" class="PP">The Prince & Princess Deluxe</a>
            <a href="KingQueen.aspx" class="KQ">The King & Queen Royale</a>
            <a href="DukeMajestic.aspx" class="DM">Duke Majestic Package</a>&nbsp;                     
        </nav>
    </div>

    <div class="Title">
        <h1 id="PP">Duke Majestic Package</h1>
    </div>
    
    <div class="Details">
        <p id="info">Step into refined relaxation with the Duke Majestic Package—a 60-minute combination massage blending Swedish, Shiatsu, and Thai techniques. Elevate your experience with customizable add-ons like hot stone therapy, facial massage, or sauna, creating a tailored royal treatment that perfectly suits your wellness needs.</p>
    </div>

    <div class="package-info">
        <p class="package-desc">Combination Massage (Swedish, Shiatsu, Thai)</p>
        <p class="package-meta">60 mins. + Choose your Add Ons</p>
    </div>

    <div class="green-container">
    <h2>Duke Majestic Package Menu</h2>
    
    <div class="menu-item">
        <div class="item-details">
            <span class="item-name">Hot Pack</span>
            <span class="item-minutes">20 minutes</span>
        </div>
        <span class="price-note">P648</span>
    </div>

    <div class="menu-item">
        <div class="item-details">
            <span class="item-name">Hot Stone</span>
            <span class="item-minutes">20 minutes</span>
        </div>
        <span class="price-note">P748</span>
    </div>

    <div class="menu-item">
        <div class="item-details">
            <span class="item-name">Ventosa</span>
            <span class="item-minutes">20 minutes</span>
        </div>
        <span class="price-note">P748</span>
    </div>

    <div class="menu-item">
        <div class="item-details">
            <span class="item-name">Hair Spa and Scalp Massage</span>
            <span class="item-minutes">20 minutes</span>
        </div>
        <span class="price-note">P748</span>
    </div>

    <div class="menu-item">
        <div class="item-details">
            <span class="item-name">Gold Mask and Facial Massage</span>
            <span class="item-minutes">20 minutes</span>
        </div>
        <span class="price-note">P748</span>
    </div>
    
    <div class="menu-item">
        <div class="item-details">
            <span class="item-name">Foot Reflexology</span>
            <span class="item-minutes">30 minutes</span>
        </div>
        <span class="price-note">P898</span>
    </div>

    <div class="menu-item">
        <div class="item-details">
            <span class="item-name">Sauna and Shower</span>
            <span class="item-minutes">30 minutes</span>
        </div>
        <span class="price-note">P898</span>
    </div>

    <div class="menu-item">
        <div class="item-details">
            <span class="item-name">Body Scrub and Shower</span>
            <span class="item-minutes">30 minutes</span>
        </div>
        <span class="price-note">P898</span>
    </div>
</div>
    
    </body></html>
