using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace ProjectA6
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //check the cookies to see if the user wanted to stay logged in
            HttpCookie myCookies = Request.Cookies["myCookieId"];

            if (myCookies != null && myCookies["Stay"] == "Y")
            {
                Global.loggedIn = true;
                Global.accountName = myCookies["Name"];
                Global.status = myCookies["Status"];
            }

            AccountInfo.Text = "Account: " + Global.accountName + " | Status: " + Global.status;
        }

        protected void MemberNav(object sender, EventArgs e)
        {
            //if we try and go to the member page, see if we are logged in
            //if we aren't logged in, go to login page, otherwise skip straight to member page
            if (Global.loggedIn == false)
            {
                Response.Redirect("MemberLogin.aspx");
            }
            else
            {
                Response.Redirect("MemberPage.aspx");
            }
        }
        //This will navigate to the login page if you aren't logged in, otherwise it takes you to the staff page
        protected void StaffNav(object sender, EventArgs e)
        {
            if (Global.loggedIn == false)
            {
                Response.Redirect("MemberLogin.aspx");
            }
            //if you are logged in, but a member, then you will be denied of this page
            else if (Global.loggedIn == true && Global.status == "Member")
            {
                StatusLabel.Text = "Invalid permission level to access this page!";
            }
            else
            {
                Response.Redirect("StaffPage.aspx");
            }
        }
        //This will run the logout procedure which will take you out of whatever account you are logged into
        protected void LogoutBtn_Click(object sender, EventArgs e)
        {
            //if the user logs out, then they will not stay logged in if they leave the website after
            HttpCookie myCookies = Request.Cookies["myCookieId"];
            myCookies["Stay"] = "N";
            Response.Cookies.Add(myCookies);

            Global.loggedIn = false;
            Global.accountName = "Guest";
            Global.status = "Unregistered";
            AccountInfo.Text = "Account: Guest | Status: Unregistered";
        }

        //go to the try it page
        //we don't need to be logged in for this, just for ease of testing
        protected void TryItNav_Click(object sender, EventArgs e)
        {
            Response.Redirect("TryIt.aspx");
        }
    }
}