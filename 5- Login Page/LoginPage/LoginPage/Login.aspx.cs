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
            if (string.IsNullOrWhiteSpace(txtUsername.Text) || string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblMessage.Text = "Username and Password are required.";
                return;
            }

          
            if (txtUsername.Text == "admin" && txtPassword.Text == "Password123")
            {
                lblMessage.Text = "Login Successful.";
            }
            else
            {
                lblMessage.Text = "Invalid username or password.";
            }
        }
    }
}