
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EmployeeDirectory
{
    public partial class Employees : System.Web.UI.Page
    {
        private string ConnectionString
        {
            get
            {
                ConnectionStringSettings settings =
                    ConfigurationManager.ConnectionStrings["InternTrainingConnection"];

                if (settings == null)
                {
                    throw new ConfigurationErrorsException(
                        "InternTrainingConnection is missing from Web.config.");
                }

                return settings.ConnectionString;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEmployees();
            }
        }

        // READ: Display all employees or search by name/department.
        private void LoadEmployees(string search = "")
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT EmployeeID, Name, Email, Position, Department, HireDate
                    FROM dbo.Employees
                    WHERE Name LIKE @Search OR Department LIKE @Search
                    ORDER BY EmployeeID DESC;", con))
                {
                    cmd.Parameters.Add("@Search", SqlDbType.NVarChar, 202)
                        .Value = "%" + search + "%";

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvEmployees.DataSource = dt;
                        gvEmployees.DataBind();
                    }
                }
            }
            catch (SqlException)
            {
                ShowMessage("Unable to load employees. Check the database connection and table.", false);
            }
            catch (ConfigurationErrorsException)
            {
                ShowMessage("Please check the database connection string in Web.config.", false);
            }
        }

        // CREATE / UPDATE: Save employee details.
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string position = txtPosition.Text.Trim();
            string department = txtDepartment.Text.Trim();
            string hireDateText = txtHireDate.Text.Trim();

            if (string.IsNullOrWhiteSpace(name) ||
                string.IsNullOrWhiteSpace(email) ||
                string.IsNullOrWhiteSpace(position) ||
                string.IsNullOrWhiteSpace(department) ||
                string.IsNullOrWhiteSpace(hireDateText))
            {
                ShowMessage("All fields are required.", false);
                return;
            }

            if (name.Length > 100 || email.Length > 254 ||
                position.Length > 100 || department.Length > 100)
            {
                ShowMessage("Please check the maximum field lengths.", false);
                return;
            }

            try
            {
                MailAddress parsedEmail = new MailAddress(email);

                if (!string.Equals(parsedEmail.Address, email,
                    StringComparison.OrdinalIgnoreCase))
                {
                    ShowMessage("Please enter a valid email address.", false);
                    return;
                }
            }
            catch (FormatException)
            {
                ShowMessage("Please enter a valid email address.", false);
                return;
            }

            DateTime hireDate;

            if (!DateTime.TryParseExact(
                hireDateText,
                "yyyy-MM-dd",
                CultureInfo.InvariantCulture,
                DateTimeStyles.None,
                out hireDate))
            {
                ShowMessage("Please enter a valid hire date.", false);
                return;
            }

            if (hireDate.Date > DateTime.Today)
            {
                ShowMessage("Hire Date cannot be in the future.", false);
                return;
            }

            bool isUpdate = !string.IsNullOrWhiteSpace(hfEmployeeID.Value);
            int employeeID = 0;

            if (isUpdate &&
                (!int.TryParse(hfEmployeeID.Value, out employeeID) || employeeID <= 0))
            {
                ShowMessage("Invalid employee ID.", false);
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = con;

                    if (isUpdate)
                    {
                        cmd.CommandText = @"
                            UPDATE dbo.Employees
                            SET Name = @Name,
                                Email = @Email,
                                Position = @Position,
                                Department = @Department,
                                HireDate = @HireDate
                            WHERE EmployeeID = @EmployeeID;";

                        cmd.Parameters.Add("@EmployeeID", SqlDbType.Int)
                            .Value = employeeID;
                    }
                    else
                    {
                        cmd.CommandText = @"
                            INSERT INTO dbo.Employees
                                (Name, Email, Position, Department, HireDate)
                            VALUES
                                (@Name, @Email, @Position, @Department, @HireDate);";
                    }

                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 100).Value = name;
                    cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 254).Value = email;
                    cmd.Parameters.Add("@Position", SqlDbType.NVarChar, 100).Value = position;
                    cmd.Parameters.Add("@Department", SqlDbType.NVarChar, 100).Value = department;
                    cmd.Parameters.Add("@HireDate", SqlDbType.Date).Value = hireDate.Date;

                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (isUpdate && rowsAffected == 0)
                    {
                        ShowMessage("Employee not found. Refresh the list and try again.", false);
                        ClearForm();
                        LoadEmployees(txtSearch.Text.Trim());
                        return;
                    }
                }

                ClearForm();

                ShowMessage(
                    isUpdate ? "Employee updated successfully." : "Employee added successfully.",
                    true);

                LoadEmployees(txtSearch.Text.Trim());
            }
            catch (SqlException ex) when (ex.Number == 2601 || ex.Number == 2627)
            {
                ShowMessage("This email address already exists.", false);
            }
            catch (SqlException)
            {
                ShowMessage("Unable to save the employee. Check the database setup.", false);
            }
            catch (ConfigurationErrorsException)
            {
                ShowMessage("Please check the database connection string in Web.config.", false);
            }
        }

        // EDIT: Load selected employee into the form.
        protected void gvEmployees_RowEditing(object sender, GridViewEditEventArgs e)
        {
            e.Cancel = true;

            int id = Convert.ToInt32(gvEmployees.DataKeys[e.NewEditIndex].Value);

            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT EmployeeID, Name, Email, Position, Department, HireDate
                    FROM dbo.Employees
                    WHERE EmployeeID = @ID;", con))
                {
                    cmd.Parameters.Add("@ID", SqlDbType.Int).Value = id;

                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            hfEmployeeID.Value = dr["EmployeeID"].ToString();
                            txtName.Text = dr["Name"].ToString();
                            txtEmail.Text = dr["Email"].ToString();
                            txtPosition.Text = dr["Position"].ToString();
                            txtDepartment.Text = dr["Department"].ToString();

                            txtHireDate.Text = Convert.ToDateTime(dr["HireDate"])
                                .ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);

                            btnSave.Text = "Update";
                            ShowMessage("Edit the details and click Update.", true);
                        }
                        else
                        {
                            ShowMessage("Employee not found.", false);
                        }
                    }
                }
            }
            catch (SqlException)
            {
                ShowMessage("Unable to load the selected employee.", false);
            }
            catch (ConfigurationErrorsException)
            {
                ShowMessage("Please check the database connection string in Web.config.", false);
            }
        }

        // DELETE: Delete the selected employee.
        protected void gvEmployees_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvEmployees.DataKeys[e.RowIndex].Value);
            e.Cancel = true;

            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                using (SqlCommand cmd = new SqlCommand(
                    "DELETE FROM dbo.Employees WHERE EmployeeID = @ID;", con))
                {
                    cmd.Parameters.Add("@ID", SqlDbType.Int).Value = id;

                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        if (hfEmployeeID.Value == id.ToString())
                        {
                            ClearForm();
                        }

                        ShowMessage("Employee deleted successfully.", true);
                    }
                    else
                    {
                        ShowMessage("Employee not found.", false);
                    }
                }

                LoadEmployees(txtSearch.Text.Trim());
            }
            catch (SqlException)
            {
                ShowMessage("Unable to delete the employee.", false);
            }
            catch (ConfigurationErrorsException)
            {
                ShowMessage("Please check the database connection string in Web.config.", false);
            }
        }

        // Show JavaScript confirmation for the GridView Delete command.
        protected void gvEmployees_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                foreach (Control control in e.Row.Cells[e.Row.Cells.Count - 1].Controls)
                {
                    LinkButton link = control as LinkButton;

                    if (link != null && link.CommandName == "Delete")
                    {
                        link.OnClientClick =
                            "return confirm('Are you sure you want to delete this employee?');";
                    }
                }
            }
        }

        // SEARCH: Filter employees.
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            string search = txtSearch.Text.Trim();

            if (search.Length > 100)
            {
                ShowMessage("Search text cannot exceed 100 characters.", false);
                return;
            }

            LoadEmployees(search);
        }

        protected void btnShowAll_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            LoadEmployees();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
            ShowMessage("Form cleared.", true);
        }

        private void ClearForm()
        {
            hfEmployeeID.Value = "";
            txtName.Text = "";
            txtEmail.Text = "";
            txtPosition.Text = "";
            txtDepartment.Text = "";
            txtHireDate.Text = "";
            btnSave.Text = "Save";
        }

        private void ShowMessage(string message, bool success)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = success
                ? System.Drawing.Color.Green
                : System.Drawing.Color.DarkRed;
        }
    }
}
