<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LoginPage.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Page</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }

        .login-box {
            width: 320px;
            margin: 100px auto;
            padding: 25px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px #bfbfbf;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .textbox {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 15px;
            box-sizing: border-box;
        }

        .button {
            width: 100%;
            padding: 10px;
            background-color: #0078D7;
            color: white;
            border: none;
            cursor: pointer;
        }

        .button:hover {
            background-color: #005fa3;
        }

        #lblMessage {
            font-weight: bold;
        }
    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="login-box">

    <h2>Login</h2>

    <label>Username</label>

    <asp:TextBox
        ID="txtUsername"
        runat="server"
        CssClass="textbox"
        required="required">
    </asp:TextBox>

    <label>Password</label>

    <asp:TextBox
        ID="txtPassword"
        runat="server"
        TextMode="Password"
        CssClass="textbox"
        required="required">
    </asp:TextBox>

    <asp:Button
        ID="btnLogin"
        runat="server"
        Text="Login"
        CssClass="button"
        OnClick="btnLogin_Click" />

    <br /><br />

    <asp:Label
        ID="lblMessage"
        runat="server">
    </asp:Label>

</div>

</form>

</body>
</html>