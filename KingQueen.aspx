<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KingQueen.aspx.cs" Inherits="MasaheKingWellnessSpa.KingQueen" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Service List</title>

        <!-- SITE ICON -->
        <link rel="icon" href="images/MK.png">

        <!-- STYLESHEET -->
        <link rel="stylesheet" href="KingQueen.css">

        <!-- GOOGLE FONTS -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Just+Me+Again+Down+Here&family=Kotta+One&display=swap" rel="stylesheet">    

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
        <h1 id="PP">The King & Queen Royale</h1>
    </div>
    
    <div class="Details">
        <p id="info">Experience the grandeur of the King & Queen Royale, a 2.5-hour royal treatment designed for ultimate luxury and rejuvenation. This premium package combines revitalizing scrubs, signature massages, soothing therapies, and exclusive wellness rituals—perfectly crafted to restore balance and leave you feeling truly regal.</p>
    </div>

    <!-- Green Container -->
    <div class="green-container">
    <h2>The King & Queen Royale Menu</h2>
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
        <span class="item-name">Sauna</span>
    </div>
    
    <div class="menu-item">
        <span class="item-name">Body Wash</span>
        <span class="price-note">add P150 only</span>
    </div>
    
    <div class="menu-item">
        <span class="item-name">Signature Massage with Arnis ver. 2 with massage gun</span>
        <span class="price-note">add P50 only</span>
    </div>

    <div class="menu-item">
        <span class="item-name">Crown Massage (Cranio-Sacral)</span>
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
        <p class="original-price">P2, 298</p>
        <p class="discount-price">P1, 498</p>
    </div>
    <!-- END --> 
    

    
    
    
</body>
</html>
