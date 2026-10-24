# Employee Directory

## Project Overview

Employee Directory is an ASP.NET Web Forms application that performs CRUD (Create, Read, Update, Delete) operations on employee records stored in a SQL Server database.

## Technologies Used

- ASP.NET Web Forms (.NET Framework 4.8)
- C#
- SQL Server
- HTML
- CSS
- JavaScript
- ADO.NET

## Features

- Add Employee
- View Employee List
- Search Employee by Name or Department
- Edit Employee
- Update Employee Details
- Delete Employee with Confirmation
- Client-side Validation
- Server-side Validation
- Parameterized SQL Queries for SQL Injection Prevention
- Duplicate Email Handling

---

# Database Setup

## Prerequisites

- Visual Studio with ASP.NET Web Forms development support
- SQL Server Express
- SQL Server Management Studio (SSMS)
- IIS (Internet Information Services) for deployment

## Create Database

1. Open SQL Server Management Studio.
2. Connect to your SQL Server instance.
3. Open the `EmployeeDirectory.sql` script included in this project.
4. Execute the script to create the `InternTraining` database and the `Employees` table.

The database table contains the following columns:

| Column | Data Type |
|---|---|
| EmployeeID | INT IDENTITY, Primary Key |
| Name | NVARCHAR(100) |
| Email | NVARCHAR(254), Unique |
| Position | NVARCHAR(100) |
| Department | NVARCHAR(100) |
| HireDate | DATE |

No sample employee records are required. Employees can be added through the application.

---

# Connection String

Update the connection string in `Web.config` to match your SQL Server instance.

```xml
<connectionStrings>
    <add name="InternTrainingConnection"
         connectionString="Data Source=PRASANNA\SQLEXPRESS;Initial Catalog=InternTraining;Integrated Security=True"
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

If your SQL Server instance has a different name, update `Data Source` accordingly.

---

# Running the Project

1. Open the `EmployeeDirectory` solution in Visual Studio.
2. Ensure the `InternTraining` database and `Employees` table have been created.
3. Verify the connection string in `Web.config`.
4. Build the solution.
5. Set `Employees.aspx` as the Start Page.
6. Press **Ctrl + F5** to run the application.
7. Use the form to add, edit, search, and delete employee records.

---

# IIS Deployment

1. Enable Internet Information Services (IIS) and the required ASP.NET features in Windows Features.
2. Build the project in Visual Studio.
3. Publish the application to a deployment folder using the appropriate ASP.NET Web Application publishing option.
4. Open IIS Manager.
5. Right-click **Sites** and select **Add Website**.
6. Enter the following details:

   - **Site Name:** EmployeeDirectory
   - **Physical Path:** Select the published application folder
   - **Port:** 8085, or another available port

7. Configure the application pool to use the appropriate .NET CLR version for .NET Framework 4.8.
8. Ensure the IIS application pool identity has the required SQL Server database permissions.
9. Start the website and browse to `http://localhost:8085/Employees.aspx`.

The SQL Server instance must be accessible from the IIS application, and the connection string must match the deployment environment.

---

# Validation

## Client-side Validation

JavaScript validates:

- Required employee fields
- Email format
- Maximum field lengths
- Hire date validity
- Hire dates not being in the future
- Delete confirmation before removing an employee

## Server-side Validation

C# validates:

- Required fields
- Maximum field lengths
- Email format
- Hire date format and date restrictions
- Employee ID for update operations
- Duplicate email errors

Server-side validation is performed independently of JavaScript validation.

---

# CRUD Operations

### Create

Add a new employee by entering the employee's name, email, position, department, and hire date.

### Read

Display employee records in an ASP.NET GridView.

### Update

Select **Edit** beside an employee to load the existing details into the form. Modify the fields and select **Update** to save changes.

### Delete

Select **Delete** beside an employee and confirm the action to remove the record.

### Search

Search employee records by name or department.

---

# SQL Injection Prevention

All database operations use parameterized SQL commands.

- INSERT uses parameters for employee details.
- SELECT uses parameters for employee IDs and search terms.
- UPDATE uses parameters for employee details and employee IDs.
- DELETE uses a parameterized employee ID.

User input is never concatenated directly into SQL command text.

---

# Screenshots

Create a `Screenshots` folder inside the project directory.

```text
Screenshots/
├── ListView.png
├── AddEmployee.png
├── EditEmployee.png
├── SearchEmployee.png
└── DeleteEmployee.png
```

Add screenshots of the actual running application in the sections below.

## List View

_Insert the List View screenshot here._

## Add Employee

_Insert the Add Employee form screenshot here._

## Edit Employee

_Insert the Edit Employee form screenshot here._

## Search Employee

_Insert the Search results screenshot here._

## Delete Employee

_Insert the Delete confirmation screenshot here._

---

# Security

- Parameterized SQL commands
- Client-side input validation
- Server-side input validation
- Unique email constraint
- SQL injection prevention
- JavaScript confirmation before deletion

---

# Author

**Name:** Prasanna
