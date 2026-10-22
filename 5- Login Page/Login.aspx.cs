
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoginPage
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrWhiteSpace(username) ||
                string.IsNullOrWhiteSpace(password))
            {
                lblMessage.Text = "Username and Password are required.";
                lblMessage.CssClass = "error";
                return;
            }

            if (username == "admin" && password == "Password123")
            {
                lblMessage.Text = "Login Successful";
                lblMessage.CssClass = "success";
                txtPassword.Text = "";
            }
            else
            {
                lblMessage.Text = "Invalid username or password";
                lblMessage.CssClass = "error";
                txtPassword.Text = "";
            }
        }
    }
}
