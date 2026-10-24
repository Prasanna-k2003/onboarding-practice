
IF DB_ID(N'InternTraining') IS NULL
BEGIN
    CREATE DATABASE InternTraining;
END;
GO

USE InternTraining;
GO

IF OBJECT_ID(N'dbo.Employees', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Employees
    (
        EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Email NVARCHAR(254) NOT NULL UNIQUE,
        Position NVARCHAR(100) NOT NULL,
        Department NVARCHAR(100) NOT NULL,
        HireDate DATE NOT NULL
    );
END;
GO
