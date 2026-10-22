# Task 5 – Login Page (ASP.NET Web Forms)

## Overview

This project demonstrates a simple login page using ASP.NET Web Forms with client-side and server-side validation.

The application accepts a username and password, validates the input, checks the demo credentials, and displays appropriate success or error messages.

### Dummy Credentials

- **Username:** `admin`
- **Password:** `Password123`

> These credentials are hardcoded for learning purposes only and must not be used in a production application.

---

## IIS Setup

1. Open **IIS Manager**.
2. Right-click **Sites**.
3. Select **Add Website**.
4. Enter the following details:

   **Site Name:**
   ```
   LoginPage
   ```

   **Physical Path:**
   ```
   Select the 5- Login Page project folder.
   ```

   **Port:**
   ```
   8085 (or any available port)
   ```

5. Click **OK**.
6. Start the website if it is not already running.
7. Open the website using the configured localhost port.

---

## Application Pool

Use the following application pool settings:

```
.NET CLR Version: v4.0
Managed Pipeline Mode: Integrated
```

**Target Framework:**

```
.NET Framework 4.8
```

---

## Folder Permissions

Grant the required read and execute permissions to the application folder:

- `IIS_IUSRS`
- `IUSR`, if required by the configured IIS access model

Additional permissions should be granted only when necessary. If future features require writing files, grant the appropriate write or modify permissions to the specific folder that needs them.

---

## Validation

This application implements the following validation features:

- ASP.NET `RequiredFieldValidator` controls for the username and password fields.
- Server-side input validation in C#.
- Trims leading and trailing whitespace from the username.
- Checks for empty or whitespace-only username and password values.
- Validates the supplied demo credentials.
- Displays appropriate success and failure messages.

Client-side validation improves the user experience, while server-side validation independently checks the submitted input.

---

## Login Feedback

**Successful login:**

```
Login Successful
```

**Missing username or password:**

```
Username and Password are required.
```

**Incorrect credentials:**

```
Invalid username or password
```

The application does not display the entered password. Incorrect credentials produce a generic error message instead of identifying which credential was incorrect.

---

## Security Notes

This application is intended for learning purposes only.

Hardcoding credentials is not recommended in production applications.

A real authentication system should:

- Store user information securely in a database.
- Store passwords as salted hashes rather than plaintext.
- Use HTTPS to protect data in transit.
- Consider account lockout or rate limiting after repeated failed login attempts.
- Use ASP.NET Identity or another appropriate authentication framework.
- Log unexpected server-side errors securely without exposing sensitive information to users.
- Use parameterized queries when accessing a database.

---

## Project Files

The task submission contains the following files:

- `Login.aspx` – Login form interface and validation controls.
- `Login.aspx.cs` – C# server-side login logic.
- `Web.config` – ASP.NET application configuration.
- `README.md` – Setup instructions, validation details, and security notes.

---

## Conclusion

This project demonstrates an ASP.NET Web Forms login page with input validation, demo credential verification, password masking, and clear success and failure feedback. It also documents the IIS configuration required for local hosting.