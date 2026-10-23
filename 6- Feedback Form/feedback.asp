
<%@ Language="VBScript" %>
<%
Option Explicit

Dim requestMethod, username, feedback

requestMethod = UCase(Request.ServerVariables("REQUEST_METHOD"))
username = ""
feedback = ""

If requestMethod = "POST" Then
    username = Trim(Request.Form("username"))
    feedback = Trim(Request.Form("feedback"))
End If
%>

<!DOCTYPE html>
<html>
<head>
    <title>Feedback Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 40px;
        }

        .container {
            max-width: 400px;
            margin: auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
        }

        input, textarea, button {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            box-sizing: border-box;
        }

        button {
            background: #2563eb;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Feedback Form</h2>

    <form method="POST" action="feedback.asp">
        <label for="username">Name</label>
        <input type="text" id="username" name="username" required />

        <label for="feedback">Feedback</label>
        <textarea id="feedback" name="feedback"
                  rows="4" required></textarea>

        <button type="submit">Submit</button>
    </form>

    <% If requestMethod = "POST" Then %>
        <% If Len(username) > 0 And Len(feedback) > 0 Then %>

            <h3>Feedback Received</h3>

            <p>Name:
                <% Response.Write(Server.HTMLEncode(username)) %>
            </p>

            <p>Feedback:
                <% Response.Write(Server.HTMLEncode(feedback)) %>
            </p>

            <p>Server Time:
                <% Response.Write(Now()) %>
            </p>

        <% Else %>
            <p>Please enter your name and feedback.</p>
        <% End If %>
    <% End If %>
</div>

</body>
</html>
