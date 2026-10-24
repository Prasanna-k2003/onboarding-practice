<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Employees.aspx.cs" Inherits="EmployeeDirectory.Employees" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Employee Directory</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background: #f4f4f4;
        }

        .container {
            width: 900px;
            max-width: 100%;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-sizing: border-box;
        }

        input, select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        .btn {
            padding: 10px 18px;
            cursor: pointer;
            margin: 4px 5px 4px 0;
            width: auto;
        }

        .grid {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        .grid th, .grid td {
            padding: 8px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .grid th {
            background: #eeeeee;
        }

        .message {
            display: block;
            margin: 10px 0;
        }

        .table-wrap {
            overflow-x: auto;
        }
    </style>

    <script type="text/javascript">
        function validateEmployeeForm() {
            var name = document.getElementById('<%= txtName.ClientID %>').value.trim();
            var email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();
            var position = document.getElementById('<%= txtPosition.ClientID %>').value.trim();
            var department = document.getElementById('<%= txtDepartment.ClientID %>').value.trim();
            var hireDate = document.getElementById('<%= txtHireDate.ClientID %>').value;

            if (name === "" || email === "" || position === "" ||
                department === "" || hireDate === "") {
                alert("All fields are required.");
                return false;
            }

            if (name.length > 100 || position.length > 100 ||
                department.length > 100 || email.length > 254) {
                alert("Please check the maximum field lengths.");
                return false;
            }

            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address.");
                return false;
            }

            var selectedDate = new Date(hireDate + "T00:00:00");
            var today = new Date();
            today.setHours(0, 0, 0, 0);

            if (isNaN(selectedDate.getTime()) || selectedDate > today) {
                alert("Hire Date cannot be in the future.");
                return false;
            }

            return true;
        }

        function confirmDelete() {
            return confirm("Are you sure you want to delete this employee?");
        }
    </script>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container">

            <h2>Employee Directory</h2>

            <asp:Label ID="lblMessage" runat="server" CssClass="message" />

            <asp:HiddenField ID="hfEmployeeID" runat="server" />

            <label for="<%= txtName.ClientID %>">Name</label>
            <asp:TextBox ID="txtName" runat="server" MaxLength="100" />

            <label for="<%= txtEmail.ClientID %>">Email</label>
            <asp:TextBox ID="txtEmail" runat="server"
                TextMode="Email" MaxLength="254" />

            <label for="<%= txtPosition.ClientID %>">Position</label>
            <asp:TextBox ID="txtPosition" runat="server" MaxLength="100" />

            <label for="<%= txtDepartment.ClientID %>">Department</label>
            <asp:TextBox ID="txtDepartment" runat="server" MaxLength="100" />

            <label for="<%= txtHireDate.ClientID %>">Hire Date</label>
            <asp:TextBox ID="txtHireDate" runat="server" TextMode="Date" />

            <br />

            <asp:Button ID="btnSave" runat="server"
                Text="Save"
                CssClass="btn"
                OnClientClick="return validateEmployeeForm();"
                OnClick="btnSave_Click" />

            <asp:Button ID="btnClear" runat="server"
                Text="Clear"
                CssClass="btn"
                CausesValidation="false"
                OnClick="btnClear_Click" />

            <hr />

            <label for="<%= txtSearch.ClientID %>">Search by Name or Department</label>

            <asp:TextBox ID="txtSearch" runat="server"
                MaxLength="100"
                AutoPostBack="true"
                OnTextChanged="txtSearch_TextChanged" />

            <asp:Button ID="btnShowAll" runat="server"
                Text="Show All"
                CssClass="btn"
                CausesValidation="false"
                OnClick="btnShowAll_Click" />

            <div class="table-wrap">
                <asp:GridView ID="gvEmployees" runat="server"
                    CssClass="grid"
                    AutoGenerateColumns="False"
                    DataKeyNames="EmployeeID"
                    EmptyDataText="No employees found."
                    OnRowEditing="gvEmployees_RowEditing"
                    OnRowDeleting="gvEmployees_RowDeleting"
                    OnRowDataBound="gvEmployees_RowDataBound">

                    <Columns>
                        <asp:BoundField DataField="EmployeeID" HeaderText="ID" />
                        <asp:BoundField DataField="Name" HeaderText="Name" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="Position" HeaderText="Position" />
                        <asp:BoundField DataField="Department" HeaderText="Department" />
                        <asp:BoundField DataField="HireDate"
                            HeaderText="Hire Date"
                            DataFormatString="{0:dd-MMM-yyyy}" />

                        <asp:CommandField
                            ShowEditButton="True"
                            ShowDeleteButton="True"
                            EditText="Edit"
                            DeleteText="Delete"
                            CausesValidation="false" />
                    </Columns>
                </asp:GridView>
            </div>

        </div>
    </form>
</body>
</html>

