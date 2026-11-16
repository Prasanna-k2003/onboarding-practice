
<!--#include file="db.asp"-->
<%
Dim objCmd, objRs, employeeID, message
Dim empName, empEmail, empPosition, empDepartment, hireDate

message = ""
employeeID = Trim(Request.QueryString("id"))

If employeeID = "" Or Not IsNumeric(employeeID) Then
    Response.Write "Invalid employee ID."
    Response.End
End If

If Request.ServerVariables("REQUEST_METHOD") = "POST" Then

    empName = Trim(Request.Form("Name"))
    empEmail = Trim(Request.Form("Email"))
    empPosition = Trim(Request.Form("Position"))
    empDepartment = Trim(Request.Form("Department"))
    hireDate = Trim(Request.Form("HireDate"))

    If empName = "" Or empEmail = "" Or empPosition = "" Or _
       empDepartment = "" Or hireDate = "" Then

        message = "All fields are required."

    ElseIf InStr(empEmail, "@") = 0 Or InStr(empEmail, ".") = 0 Then

        message = "Please enter a valid email address."

    ElseIf Not IsDate(hireDate) Then

        message = "Please enter a valid hire date."

    Else

        Set objCmd = Server.CreateObject("ADODB.Command")
        Set objCmd.ActiveConnection = objConn

        objCmd.CommandType = 1
        objCmd.CommandText = "UPDATE dbo.Employees SET Name=?, Email=?, Position=?, Department=?, HireDate=? WHERE EmployeeID=?"

        objCmd.Parameters.Append objCmd.CreateParameter("@Name", 202, 1, 100, empName)
        objCmd.Parameters.Append objCmd.CreateParameter("@Email", 202, 1, 254, empEmail)
        objCmd.Parameters.Append objCmd.CreateParameter("@Position", 202, 1, 100, empPosition)
        objCmd.Parameters.Append objCmd.CreateParameter("@Department", 202, 1, 100, empDepartment)
        objCmd.Parameters.Append objCmd.CreateParameter("@HireDate", 133, 1, , CDate(hireDate))
        objCmd.Parameters.Append objCmd.CreateParameter("@EmployeeID", 3, 1, , CLng(employeeID))

        On Error Resume Next
        objCmd.Execute

        If Err.Number <> 0 Then
            message = "Unable to update employee. Check whether the email already exists."
            Err.Clear
        Else
            objConn.Close
            Set objConn = Nothing
            Set objCmd = Nothing

            Response.Redirect "index.asp"
            Response.End
        End If

        On Error GoTo 0
        Set objCmd = Nothing

    End If

End If

' Retrieve employee details
Set objCmd = Server.CreateObject("ADODB.Command")
Set objCmd.ActiveConnection = objConn

objCmd.CommandType = 1
objCmd.CommandText = "SELECT * FROM dbo.Employees WHERE EmployeeID = ?"
objCmd.Parameters.Append objCmd.CreateParameter("@EmployeeID", 3, 1, , CLng(employeeID))

Set objRs = objCmd.Execute

If objRs.EOF Then
    Response.Write "Employee not found."
    objRs.Close
    Set objRs = Nothing
    Set objCmd = Nothing
    objConn.Close
    Set objConn = Nothing
    Response.End
End If

If Request.ServerVariables("REQUEST_METHOD") <> "POST" Or message <> "" Then
    empName = objRs("Name")
    empEmail = objRs("Email")
    empPosition = objRs("Position")
    empDepartment = objRs("Department")
    hireDate = Year(objRs("HireDate")) & "-" & _
        Right("0" & Month(objRs("HireDate")), 2) & "-" & _
        Right("0" & Day(objRs("HireDate")), 2)
End If
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Employee</title>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            padding: 30px;
        }

        .container {
            max-width: 550px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
        }

        h1 { color: #26354a; }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            box-sizing: border-box;
        }

        button {
            background: #2563eb;
            color: white;
            padding: 12px 20px;
            border: none;
            margin-top: 20px;
            cursor: pointer;
        }

        .message { color: #b91c1c; }
    </style>
</head>

<body>
<div class="container">

    <h1>Edit Employee</h1>

    <% If message <> "" Then %>
        <p class="message"><%=Server.HTMLEncode(message)%></p>
    <% End If %>

    <form method="post" action="edit.asp?id=<%=Server.URLEncode(employeeID)%>" onsubmit="return validateForm();">

        <label>Name</label>
        <input type="text" name="Name" maxlength="100" required
               value="<%=Server.HTMLEncode(empName)%>">

        <label>Email</label>
        <input type="email" name="Email" maxlength="254" required
               value="<%=Server.HTMLEncode(empEmail)%>">

        <label>Position</label>
        <input type="text" name="Position" maxlength="100" required
               value="<%=Server.HTMLEncode(empPosition)%>">

        <label>Department</label>
        <input type="text" name="Department" maxlength="100" required
               value="<%=Server.HTMLEncode(empDepartment)%>">

        <label>Hire Date</label>
        <input type="date" name="HireDate" required
               value="<%=Server.HTMLEncode(hireDate)%>">

        <button type="submit">Update Employee</button>
        <a href="index.asp">Cancel</a>

    </form>
</div>

<script>
function validateForm() {
    const form = document.querySelector("form");

    if (!form.checkValidity()) {
        form.reportValidity();
        return false;
    }

    const email = document.querySelector('[name="Email"]').value.trim();

    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
        alert("Please enter a valid email address.");
        return false;
    }

    return true;
}
</script>
</body>
</html>

<%
objRs.Close
Set objRs = Nothing
Set objCmd = Nothing

If Not objConn Is Nothing Then
    If objConn.State = 1 Then objConn.Close
    Set objConn = Nothing
End If
%>
