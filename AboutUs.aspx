<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="MasaheKingWellnessSpa.AboutUs" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us</title>
    
    <!-- SITE ICON -->
    <link rel="icon" href="images/MK.png">


    <!-- GOOGLE FONTS -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Just+Me+Again+Down+Here&family=Kotta+One&display=swap" rel="stylesheet">

    <!-- STYLESHEET -->
    <link href="aboutUs.css" rel="stylesheet" type="text/css" />


    <!-- JAVASCRIPT para gumana navbar burger -->
    <script src="burgerFunctionality.js" defer></script>

</head>
<body>

<div class="page">

    <!-- HEADER -->
    <header class="header">

        <div class="logo-area">
            <img src="images/MK.png" alt="logo" class="logo" />
            <span class="brand-name">MasaheKing Wellness Spa</span>
        </div>

        <div class="menu-area">
            <nav class="navA">
                <a href="HomeCustomer.aspx">Home</a>
                <a href="#" class="book">Book Now</a>
            </nav>

        <div id="navbar">
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

    <!-- NAME -->
    <div class="name-header">
        Mark Alvin L. Vidanes
    </div>

    <!-- GREEN BAR -->
    <div class="achievement-bar">
        Most Prominent Achievement in Business &amp; Entrepreneurship
    </div>

    <!-- TOP IMAGES -->
    <div class="top-images">
        <img src="images/left.jpg" class="img-left" alt="left">

        <div class="middle-column">
            <img src="images/down.jpg" class="img-down" alt="down">
        </div>

        <img src="images/right.jpg" class="img-right" alt="right">
    </div>

    <!-- DESCRIPTION -->
    <div class="description-text">
        MasaheKing Wellness Spa is inspired by Mark Alvee, widely known as the Masahe King,
        a vlogger who features different spas in various locations. His exposure to the
        wellness industry through vlogging led him to establish his own spa.
    </div>

    <!-- 3 PORTRAIT IMAGES -->
    <div class="bottom-images">
        <img src="images/d left.jpg" class="d-img" alt="left">
        <img src="images/d middle.jpg" class="d-img" alt="middle">
        <img src="images/d right.jpg" class="d-img" alt="right">
    </div>

    <!-- AWARD -->
    <div class="award-text">
        Founded in 2024, MasaheKing Wellness Spa by Mark Alvee was recognized as the Most
        Prominent Massage Spa at the Laguna Awards.
    </div>

</div>

</body>
</html>
