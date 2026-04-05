<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contacts.aspx.cs" Inherits="MasaheKingWellnessSpa.Contacts" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<head runat="server">
    <title>Contact Us</title>

    <!-- SITE ICON -->
    <link rel="icon" href="images/MK.png">

    <!-- STYLESHEET -->
    <link rel="stylesheet" href="Contacts.css" />

    <!-- GOOGLE FONTS -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Just+Me+Again+Down+Here&family=Kotta+One&display=swap" rel="stylesheet">

    <!-- JAVASCRIPT para gumana navbar burger -->
    <script src="burgerFunctionality.js" defer></script>

</head>
<body>

    <!--==== HEADER ====-->
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

    <!--==== CONTACT US SECTION ====-->
    <section class="contact-us">
        <h1>Contact Us</h1>
        <p class="tagline">Got Questions? We’d love to hear from you.</p>

        <div class="contact-details">
            <p><strong>Email:</strong> <a href="mailto:masahekingwellness@gmail.com">masahekingwellness@gmail.com</a></p>
            <p><strong>Phone:</strong> +63 992 314 9981</p>
        </div>

        <div class="social-links">
            <p><strong>Connect with us:</strong></p>
            <ul>
                <li><a href="https://www.facebook.com/profile.php?id=61554613534477" target="_blank">Facebook</a></li>
                <li><a href="https://www.instagram.com/mark_alvee/?hl=tl" target="_blank">Instagram</a></li>
                <li><a href="https://www.youtube.com/@MARKALVEETVMasaheKing" target="_blank">YouTube</a></li>
            </ul>
        </div>
    </section>

</body>
</html>
