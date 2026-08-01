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



This approach is \*\*not safe for production\*\* because:

\- Credentials are stored directly in the source code.

\- Anyone with access to the source code can view them.

\- Real applications should store user accounts in a secure database.

\- Passwords should be hashed and salted instead of stored or compared as plain text.

