
<!--#include file="db.asp"-->
<%
Dim employeeID, objCmd, objRs, message

employeeID = Trim(Request.QueryString("id"))
message = ""

If employeeID = "" Or Not IsNumeric(employeeID) Then
    Response.Write "Invalid employee ID."
    Response.End
End If

If Request.ServerVariables("REQUEST_METHOD") = "POST" Then

    Set objCmd = Server.CreateObject("ADODB.Command")
    Set objCmd.ActiveConnection = objConn

    objCmd.CommandType = 1
    objCmd.CommandText = "DELETE FROM dbo.Employees WHERE EmployeeID = ?"

    objCmd.Parameters.Append objCmd.CreateParameter("@EmployeeID", 3, 1, , CLng(employeeID))

    objCmd.Execute

    Set objCmd = Nothing

    objConn.Close
    Set objConn = Nothing

    Response.Redirect "index.asp"
    Response.End
End If

' Check whether the employee exists
Set objCmd = Server.CreateObject("ADODB.Command")
Set objCmd.ActiveConnection = objConn

objCmd.CommandType = 1
objCmd.CommandText = "SELECT Name FROM dbo.Employees WHERE EmployeeID = ?"

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

Dim employeeName
employeeName = objRs("Name")
%>

<!DOCTYPE html>
<html>
<head>
    <title>Delete Employee</title>
    <meta charset="UTF-8">

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            padding: 30px;
        }

        .container {
            max-width: 500px;
            margin: 80px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            text-align: center;
        }

        h1 { color: #dc2626; }

        .delete-btn {
            background: #dc2626;
            color: white;
            padding: 12px 20px;
            border: none;
            cursor: pointer;
        }

        .cancel-btn {
            display: inline-block;
            background: #64748b;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            margin-left: 10px;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>Delete Employee</h1>

    <p>
        Are you sure you want to delete
        <strong><%=Server.HTMLEncode(CStr(employeeName))%></strong>?
    </p>

    <p>This action cannot be undone.</p>

    <form method="post" action="delete.asp?id=<%=Server.URLEncode(employeeID)%>"
          onsubmit="return confirm('Are you sure you want to delete this employee?');">

        <button type="submit" class="delete-btn">Yes, Delete</button>

        <a href="index.asp" class="cancel-btn">Cancel</a>

    </form>

</div>

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
