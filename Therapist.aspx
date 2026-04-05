<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Therapist.aspx.cs" Inherits="MasaheKingWellnessSpa.Therapist" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Therapists</title>
    
    <!-- SITE ICON -->
    <link rel="icon" href="images/MK.png">

    <!-- GOOGLE FONTS -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Josefin+Sans:wght@400;600&family=Meow+Script&display=swap" rel="stylesheet" />

    <!-- STYLESHEET -->
    <link href="therapist.css" rel="stylesheet" type="text/css" />

    <!-- JAVASCRIPT para gumana navbar burger -->
    <script src="burgerFunctionality.js" defer></script>
</head>

<body>
<form id="form1" runat="server">
<div class="page">

    <!-- HEADER -->
    <header class="header">
        <div class="logo-area">
            <img src="images/MK.png" class="logo" alt="MasaheKing Logo" />
            <span class="brand-name">MasaheKing Wellness Spa</span>
        </div>

        <div class="menu-area">
            <nav class="navA">
                <a href="HomeCustomer.aspx">Home</a>
                <a href="NewBooking1.aspx" class="book">Book Now</a>
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

    <!-- TITLE -->
    <div class="title">
        <span class="the-word">The</span>
        <span class="therapist-word">Therapists</span>
    </div>

    <!-- GENDER SELECTOR -->
    <div class="therapist-toggle">
        <asp:Button ID="btnFemale" runat="server" Text="Female" 
            CssClass="toggle-btn active" OnClientClick="filterTherapists('female'); return false;" 
            ClientIDMode="Static" />
    
        <asp:Button ID="btnMale" runat="server" Text="Male" 
            CssClass="toggle-btn" OnClientClick="filterTherapists('male'); return false;" 
            ClientIDMode="Static" />
    </div>

    <!-- FEMALE -->
    <div class="female-section">
        <div class="section-title">Female Therapists</div>
        <div class="female-grid">
            <div class="female-card">
                <img src="images/Kim.jpg" alt="Kim">
                <div class="name">Kim</div>
                <div class="desc">Soft glam look with natural tones and polished finish.</div>
            </div>
            <div class="female-card">
                <img src="images/ruby.jpg" alt="Ruby">
                <div class="name">Ruby</div>
                <div class="desc">Fresh everyday makeup style with warm highlights.</div>
            </div>
            <div class="female-card">
                <img src="images/Lyn.jpg" alt="Lyn">
                <div class="name">Lyn</div>
                <div class="desc">Elegant natural makeup emphasizing clean skin and glow.</div>
            </div>
        </div>
    </div>

    <!-- MALE -->
    <div class="male-section" style="display: none;">
        <div class="section-title">Male Therapists</div>
        <div class="male-grid">
            <div class="male-card"><img src="images/Arnel.jpg" alt="Arnel"><div class="name">Arnel</div><div class="desc">Neat professional grooming with a clean and sharp look.</div></div>
            <div class="male-card"><img src="images/Junell.jpg" alt="Junell"><div class="name">Junell</div><div class="desc">Minimal natural styling for a calm and approachable appearance.</div></div>
            <div class="male-card"><img src="images/Justin.jpg" alt="Justin"><div class="name">Justin</div><div class="desc">Well-balanced grooming with subtle skin refinement.</div></div>
            <div class="male-card"><img src="images/KheeMC.jpg" alt="KheeMC"><div class="name">KheeMC</div><div class="desc">Clean modern look highlighting natural features.</div></div>
            <div class="male-card"><img src="images/Macky.jpg" alt="Macky"><div class="name">Macky</div><div class="desc">Simple polished appearance with natural tone finish.</div></div>
            <div class="male-card"><img src="images/Paul.jpg" alt="Paul"><div class="name">Paul</div><div class="desc">Fresh and neat styling with relaxed professional vibe.</div></div>
            <div class="male-card"><img src="images/Russel.jpg" alt="Russel"><div class="name">Russel</div><div class="desc">Natural grooming with clean and confident presentation.</div></div>
            <div class="male-card"><img src="images/Zordick.jpg" alt="Zordick"><div class="name">Zordick</div><div class="desc">Sharp tidy look with subtle enhancement for camera-ready style.</div></div>
        </div>
    </div>

</div>
</form>
</body>
</html>
