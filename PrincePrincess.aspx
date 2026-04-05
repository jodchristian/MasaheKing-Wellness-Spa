<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrincePrincess.aspx.cs" Inherits="MasaheKingWellnessSpa.PrincePrincess" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Service List</title>
  

        <!-- SITE ICON -->
        <link rel="icon" href="images/MK.png">

        <!-- GOOGLE FONTS -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Just+Me+Again+Down+Here&family=Kotta+One&display=swap" rel="stylesheet">

        <!-- STYLESHEET -->
        <link rel="stylesheet" href="Prince&Princess.css">

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

    <!-- SERVICE LIST -->
    <div class="Services">
        <h1 id="ServiceList">Service List</h1>
        <nav class="navB">
            <a href="RoyalServices.aspx" class="RS">Royal Services</a>
            <a href="PrincePrincess.aspx" class="PP">The Prince & Princess Deluxe</a>
            <a href="KingQueen.aspx" class="KQ">The King & Queen Royale</a>
            <a href="DukeMajestic.aspx" class="DM">Duke Majestic Package</a>&nbsp;                     
        </nav>
    </div>

    <!-- Title Logo -->
    <div class="Title">
        <h1 id="PP">The Prince & Princess Deluxe</h1>
    </div>
    
   <div class="Details">
  <p id="info">
    Step into elegance with the Prince & Princess Deluxe — a 2‑hour journey of pampering designed to refresh, restore, and delight. This exclusive package blends soothing therapies, revitalizing treatments, and signature massages, offering the perfect balance of relaxation and indulgence. Whether you seek rejuvenation or a touch of royal luxury, this experience is crafted to leave you feeling renewed and cherished.
  </p>
</div>


    <!-- Green Container -->
    <div class="green-container">
    <h2>The Prince & Princess Deluxe Menu</h2>
    <!-- END -->
    
    <!-- First Choose 1 -->
    <div class="menu-section">
        <div class="treatment-box">1st Treatment</div>
            <p class="choice-text">Choose 1:</p>
    
    <div class="menu-item">
        <span class="item-name">Hair Spa with Scalp Massage / Gold Mask with Facial Massage</span>
        <span class="price-note">add P200 if both</span>
    </div>
    
    <div class="menu-item">
        <span class="item-name">Body Wash</span>
        <span class="price-note">add P150 only</span>
    </div>
    

    <div class="menu-item">
        <span class="item-name">MK Combi Massage</span>
    </div>
    <!-- END -->

    <!-- Second Choose 1 -->
    <div class="menu-section">
        <div class="treatment-box">2nd Treatment</div>
            <p class="choice-text">Choose 1:</p>
    
        <div class="menu-item">Hot Pack</div>
        <div class="menu-item">Hot Stone</div>
        <div class="menu-item">Ventosa</div>
        <div class="menu-item">MasaheKing Special Tea</div>
    </div>
    <!-- END -->

    <!-- Pricing -->
    <div class="price-area">
        <p class="duration">2 hrs Royal Treatment</p>
        <p class="original-price">P1, 498</p>
        <p class="discount-price">P1, 298</p>
    </div>
    <!-- END --> 
    

    
    
    
</body>
</html>