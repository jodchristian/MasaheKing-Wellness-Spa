<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogIn.aspx.cs" Inherits="MasaheKingWellnessSpa.Admin.LogIn" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <title>Login Form</title>
    <link rel="stylesheet" href="LogIn.css" />
</head>
<body style="background-image: url('images/bgLogin.jpg'); background-size: cover; background-repeat: no-repeat; background-position: center; background-attachment: fixed;">

    <!--==== HEADER ====-->
    <header class="header">   
        <div class="logo-area">
            <img src="images/MK.png" alt="MK Spa Logo" class="logo" />
            <span class="brand-name">MasaheKing Wellness Spa</span>
        </div>   
    </header>

    <div class="Name">
        <h1 id="MK">MASAHEKING</h1>
        <h1 id="Wellness">WELLNESS SPA</h1>
    </div>

    <!-- Login Container -->
    <div class="login-container">
        <h2>Login</h2>
        <!-- ASP.NET server form -->
        <form id="form1" runat="server">
            <div class="form-group">
                <label for="username">Username</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="input" placeholder="For testing please enter: admin"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input" placeholder="For testing please enter: 1234"></asp:TextBox>
            </div>
            
            <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="btn" OnClick="btnLogin_Click" />

            <asp:Label ID="lblMessage" runat="server" CssClass="label" />
            
        </form>
    </div>

</body>
</html>

