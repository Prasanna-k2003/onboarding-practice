<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Loginpage.aspx.cs" Inherits="LoginPage.Loginpage" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Page</title>

    <style>
        body {
            font-family: Arial;
            background: #f5f5f5;
        }

        .login-box {
            width: 350px;
            margin: 100px auto;
            background: white;
            padding: 25px;
            border-radius: 5px;
            box-shadow: 0px 0px 8px gray;
        }

        h2 {
            text-align: center;
        }

        input {
            width:100%;
            padding:8px;
            margin-top:5px;
            margin-bottom:15px;
        }

        .btn {
            width:100%;
            padding:10px;
            background:#0078d4;
            color:white;
            border:none;
        }

        .message{
            font-weight:bold;
        }
    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="login-box">

<h2>Login</h2>

<asp:Label ID="lblUser" runat="server" Text="Username"></asp:Label>

<asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>

<asp:Label ID="lblPass" runat="server" Text="Password"></asp:Label>

<asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>

<asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" OnClick="btnLogin_Click"/>

<br /><br />

<asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>

</div>

</form>

</body>
</html>