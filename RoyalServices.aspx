<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RoyalServices.aspx.cs" Inherits="MasaheKingWellnessSpa.RoyalServices" %>

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
        <link rel="stylesheet" href="RoyalServices.css">

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
  <h1 id="Royal">Royal</h1>
  <h1 id="Services">Services</h1>
</div>

<div class="Details">
  <p id="info">
    Each massage is designed to harmonize body, mind, and spirit—whether you seek swift relief, holistic healing, or indulgent luxury. From traditional techniques like Swedish, Shiatsu, Thai, and Hilot to innovative approaches using percussion massage guns and twin-therapist treatments, our services blend timeless wellness practices with modern enhancements.
  </p>
</div>

<!-- Transparent green container -->
<section class="green-container">
  <h2>Royal Services Menu</h2>

  <!-- MK Combination Massage -->
  <div class="service-block combi">
    <h3>MK Combination Massage</h3>
    <p><em>Swedish, Shiatsu, Thai</em></p>
    <ul class="pricing">
      <li><span>60 minutes</span><span>₱498</span></li>
      <li><span>90 minutes</span><span>₱698</span></li>
      <li><span>120 minutes</span><span>₱898</span></li>
    </ul>
  </div>

  <!-- Swift & Kiddie Massage -->
  <div class="services-row">
    <div class="service-block">
      <h3>Swift Massage</h3>
      <ul class="pricing">
        <li><span>30 minutes</span><span>₱348</span></li>
      </ul>
    </div>

    <div class="service-block">
      <h3>Kiddie Massage</h3>
      <ul class="pricing">
        <li><span>40 minutes</span><span>₱398</span></li>
      </ul>
    </div>
  </div>

  <!-- MK Signature with Arnis -->
  <div class="service-block signature">
    <h3>MK Signature</h3>
    <p id="sub"><em>Massage with Arnis</em></p>
    <p class="desc">Holistic healing experience blending Swedish, Shiatsu, Thai, and Traditional Hilot with Arnis.</p>
    <ul class="pricing">
      <li><span>1hr 30 mins</span><span>₱798</span></li>
      <li><span>2hrs</span><span>₱998</span></li>
    </ul>
  </div>

  <!-- MK Signature with Massage Gun -->
  <div class="service-block gun">
    <h3>MK Signature</h3>
    <p id="sub2"><em>w/ Percussion Massage Gun</em></p>
    <p id="info2">A unique massage combining modern technology (Massage Gun) and Traditional Massage (Shiatsu and Swedish). Improves flexibility, recovery, circulation, and relieves pain.</p>
    <ul class="pricing">
      <li><span>90 mins w/ oil</span><span>₱898</span></li>
      <li><span>60 mins Dry Massage</span><span>₱898</span></li>
    </ul>
  </div>

  <!-- MK Double Dragon -->
  <div class="service-block dragon">
    <h3>MK Double Dragon Twin Massage</h3>
    <p id="sub3"><em>Combination w/ 2 therapists</em></p>
    <ul class="pricing">
      <li><span>60 mins Dry Massage</span><span>₱1,248</span></li>
    </ul>
    <p id="add">+ ₱400 for additional 30 minutes</p>
  </div>
</section>

    
</body>
</html>
