
<!--#include file="db.asp"-->
<%
Dim objCmd, objRs, searchText, searchPattern

searchText = Trim(Request.QueryString("search"))
searchPattern = "%" & searchText & "%"

Set objCmd = Server.CreateObject("ADODB.Command")
Set objCmd.ActiveConnection = objConn

objCmd.CommandType = 1
objCmd.CommandText = "SELECT EmployeeID, Name, Email, Position, Department, HireDate " & _
                     "FROM dbo.Employees " & _
                     "WHERE Name LIKE ? OR Email LIKE ? OR Position LIKE ? OR Department LIKE ? " & _
                     "ORDER BY EmployeeID DESC"

objCmd.Parameters.Append objCmd.CreateParameter("@Name", 202, 1, 200, searchPattern)
objCmd.Parameters.Append objCmd.CreateParameter("@Email", 202, 1, 200, searchPattern)
objCmd.Parameters.Append objCmd.CreateParameter("@Position", 202, 1, 200, searchPattern)
objCmd.Parameters.Append objCmd.CreateParameter("@Department", 202, 1, 200, searchPattern)

Set objRs = objCmd.Execute
%>

<!DOCTYPE html>
<html>
<head>
    <title>Employee Directory</title>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 30px;
        }

        .container {
            max-width: 1100px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
        }

        h1 { color: #26354a; }

        .search {
            margin: 20px 0;
        }

        input {
            padding: 10px;
            width: 260px;
        }

        button, .add-btn {
            padding: 10px 15px;
            background: #2563eb;
            color: white;
            border: none;
            text-decoration: none;
            cursor: pointer;
            border-radius: 4px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background: #26354a;
            color: white;
        }

        tr:nth-child(even) {
            background: #f7f9fc;
        }

        .action a {
            margin-right: 8px;
        }
    </style>
</head>
<body>

<div class="container">

    <h1>Employee Directory</h1>
    <p>Manage your employee records.</p>

    <a class="add-btn" href="add.asp">+ Add Employee</a>

    <form method="get" action="index.asp" class="search">
        <input type="text" name="search"
               placeholder="Search employees..."
               value="<%=Server.HTMLEncode(searchText)%>">
        <button type="submit">Search</button>
        <a href="index.asp">Clear</a>
    </form>

    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Position</th>
            <th>Department</th>
            <th>Hire Date</th>
            <th>Actions</th>
        </tr>

        <% If objRs.EOF Then %>
            <tr>
                <td colspan="7">No employees found.</td>
            </tr>
        <% Else %>
            <% Do Until objRs.EOF %>
                <tr>
                    <td><%=Server.HTMLEncode(CStr(objRs("EmployeeID")))%></td>
                    <td><%=Server.HTMLEncode(CStr(objRs("Name")))%></td>
                    <td><%=Server.HTMLEncode(CStr(objRs("Email")))%></td>
                    <td><%=Server.HTMLEncode(CStr(objRs("Position")))%></td>
                    <td><%=Server.HTMLEncode(CStr(objRs("Department")))%></td>
                    <td><%=Server.HTMLEncode(CStr(objRs("HireDate")))%></td>
                    <td class="action">
                        <a href="edit.asp?id=<%=Server.URLEncode(CStr(objRs("EmployeeID")))%>">Edit</a>
                        <a href="delete.asp?id=<%=Server.URLEncode(CStr(objRs("EmployeeID")))%>">Delete</a>
                    </td>
                </tr>
                <% objRs.MoveNext %>
            <% Loop %>
        <% End If %>
    </table>

</div>

</body>
</html>

<%
objRs.Close
Set objRs = Nothing

Set objCmd = Nothing

objConn.Close
Set objConn = Nothing
%>
