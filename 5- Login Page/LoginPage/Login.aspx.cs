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
            try
            {
                if (string.IsNullOrWhiteSpace(txtUsername.Text) ||
                    string.IsNullOrWhiteSpace(txtPassword.Text))
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Username and Password are required.";
                    return;
                }

                string username = Server.HtmlEncode(txtUsername.Text.Trim());
                string password = Server.HtmlEncode(txtPassword.Text.Trim());

               
                if (username == "admin" && password == "Password123")
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Login Successful.";
                }
                else
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Invalid username or password.";
                }
            }
            catch (Exception)
            {
           

                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "An unexpected error occurred. Please try again.";
            }
        }
    }
}