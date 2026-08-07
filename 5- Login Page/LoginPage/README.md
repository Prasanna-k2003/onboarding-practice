\# ASP.NET Web Forms Login Page



\## Prerequisites



\- Visual Studio 2022

\- .NET Framework 4.8

\- IIS Manager



\## IIS Setup



1\. Open IIS Manager.

2\. Right-click \*\*Sites\*\* and select \*\*Add Website\*\*.

3\. Enter a site name.

4\. Select the project folder as the \*\*Physical Path\*\*.

5\. Choose an available port (for example, 8080).

6\. Click \*\*OK\*\*.

7\. Browse the website to run the application.



\## Application Pool



Use the following Application Pool settings:



\- .NET CLR Version: \*\*v4.0\*\*

\- Managed Pipeline Mode: \*\*Integrated\*\*



\## Folder Permissions



Grant the \*\*IIS\_IUSRS\*\* group \*\*Read \& Execute\*\* permission on the project folder.



\## Test Credentials



\- \*\*Username:\*\* admin

\- \*\*Password:\*\* Password123



\## Security Note



This project uses hardcoded credentials (`admin` / `Password123`) for demonstration purposes only.



In a production application:



\- Credentials should be stored securely in a database.

\- Passwords should be hashed and salted instead of stored as plain text.

\- Proper logging and exception handling should be implemented.

\- User input should be validated and sanitized.

\- Parameterized queries should be used when accessing a database to help prevent SQL injection attacks.

