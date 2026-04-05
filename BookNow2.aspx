<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookNow2.aspx.cs" Inherits="MasaheKingWellnessSpa.BookNow2" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
        <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<head runat="server">
<title>MasaheKing Wellness Spa</title>

        <!-- SITE ICON -->
    <link rel="icon" href="images/MK.png">

<link rel="stylesheet" href="BookNow.css">

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400&display=swap" rel="stylesheet">

        <!-- JAVASCRIPT para gumana navbar burger -->
    <script src="burgerFunctionality.js" defer></script>
</head>

<body style="background-image: url('images/bg.jpg'); background-size: cover; background-repeat: no-repeat; background-position: center; background-attachment: fixed;">

<form id="form1" runat="server">

<!-- Header -->
<header class="header">   
    <div class="logo-area">
        <img src="images/MK.png" alt="MK Spa Logo" class="logo" />
        <span class="brand-name">MasaheKing Wellness Spa</span>
    </div>

    <div class="menu-area">
        <nav class="navA">
            <a href="#">Home</a>
            <a href="#" class="book">Book Now</a>            
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

<!-- HERO -->
<div class="hero">
    <h1 class="title-main">MASAHEKING</h1>
    <h2 class="title-sub">WELLNESS SPA</h2>
    <p class="tagline">It’s not just a massage, it’s an experience</p>
</div>

<!-- Booking Form -->
<div class="booking-wrapper">
    <div class="booking-card">
        <div class="booking-form">

            <div class="form-group">
                <label>Service Chosen</label>
                <asp:TextBox ID="txtService" runat="server" ReadOnly="true" CssClass="form-input"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>MK Combination Massage</label>
                <p class="optional">Swedish, Shiatsu, Thai</p>
                <div class="service-options">
                    <label class="service-radio"><input type="radio" name="service2" value="MK Combination - 60 minutes"> 60 minutes</label>
                    <label class="service-radio"><input type="radio" name="service2" value="MK Combination - 90 minutes"> 90 minutes</label>
                    <label class="service-radio"><input type="radio" name="service2" value="MK Combination - 120 minutes"> 120 minutes</label>
                </div>
            </div>

            <div class="form-group">
                <label>Swift Massage</label>
                <div class="service-options">
                    <label class="service-radio"><input type="radio" name="service2" value="Swift Massage - 30 minutes"> 30 minutes</label>
                </div>
            </div>

            <div class="form-group">
                <label>Kiddie Massage</label>
                <p class="optional">Age 3-10 years old</p>
                <div class="service-options">
                    <label class="service-radio"><input type="radio" name="service2" value="Kiddie Massage - 45 minutes"> 45 minutes</label>
                </div>
            </div>

            <div class="form-group">
                <label>MK Signature</label>
                <p class="optional">Massage with Arnis</p>
                <div class="service-options">
                    <label class="service-radio"><input type="radio" name="service2" value="MK Signature - 90 mins"> 1 hr 30 mins</label>
                    <label class="service-radio"><input type="radio" name="service2" value="MK Signature - 120 mins"> 2 hrs</label>
                </div>
            </div>

            <div class="form-group">
                <label>MK Signature</label>
                <p class="optional">with Percussion Massage Gun</p>
                <div class="service-options">
                    <label class="service-radio"><input type="radio" name="service2" value="Percussion Gun - 90 minutes with oil"> 90 minutes with oil</label>
                    <label class="service-radio"><input type="radio" name="service2" value="Percussion Gun - 60 minutes dry massage"> 60 minutes dry massage</label>
                </div>
            </div>

            <div class="form-group">
                <label>MK Double Dragon Twin Massage</label>
                <p class="optional">Combination massage with 2 therapists</p>
                <div class="service-options">
                    <label class="service-radio"><input type="radio" name="service2" value="Double Dragon Twin Massage - 60 minutes"> 60 minutes</label>
                </div>
            </div>

        </div>
    </div>
    <div class="next-container" style="display: flex; flex-direction: column; align-items: center;">
    <asp:CustomValidator ID="cvService2" runat="server" 
        ClientValidationFunction="validateServiceSelection" 
        ErrorMessage="* Please select a massage duration." 
        ForeColor="Red" Display="Dynamic" Font-Size="Small" />
    
    <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="next-btn" OnClick="btnNext_Click" />
</div>
</div>



<script type="text/javascript">
    function validateServiceSelection(source, args) {
        var radios = document.getElementsByName('service2');
        var isChecked = false;
        for (var i = 0; i < radios.length; i++) {
            if (radios[i].checked) {
                isChecked = true;
                break;
            }
        }
        args.IsValid = isChecked;
    }
</script>

</form>
</body>
</html>