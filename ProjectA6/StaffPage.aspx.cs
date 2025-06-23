using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Hash;

namespace ProjectA6
{
    public partial class StaffPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //check if the user had the stay signed in checkbox checked
            //if they did then use the cookie information
            HttpCookie myCookies = Request.Cookies["myCookieId"];

            if (myCookies != null && myCookies["Stay"] == "Y")
            {
                Global.loggedIn = true;
                Global.accountName = myCookies["Name"];
                Global.status = myCookies["Status"];
            }

            AccountInfo.Text = "Account: " + Global.accountName + " | Status: " + Global.status;
            //redirect the user back to the default page if they do not have permissions to be here!
            if (!Global.loggedIn || Global.status != "Staff")
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void Logout(object sender, EventArgs e)
        {
            HttpCookie myCookies = Request.Cookies["myCookieId"];
            myCookies["Stay"] = "N";
            Response.Cookies.Add(myCookies);

            //log out and return to home page (requires re-sign in to get back here)
            Global.loggedIn = false;
            Global.accountName = "Guest";
            Global.status = "Unregistered";
            Response.Redirect("Default.aspx");
        }

        protected void HomeBtn_Click(object sender, EventArgs e)
        {
            //return to the home page but stay logged in as staff
            Response.Redirect("Default.aspx");
        }

        protected void MemberList_Click(object sender, EventArgs e)
        {
            Hasher hash = new Hasher();
            int count = 1;
            //string path = Server.MapPath("/App_Data/Member.xml");

            string fLocation = Path.Combine(Request.PhysicalApplicationPath, @"App_Data\Member.xml");
            using (FileStream FS = new FileStream(fLocation, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.Load(FS);

                XmlNode root = xmlDoc.SelectSingleNode("//members");
                MemberOutput.Text = "";
                //display all the members from the xml file
                //decrypt password and show that as well
                foreach (XmlNode member in root.ChildNodes)
                {
                    MemberOutput.Text += "Member #" + count + "<br/>";
                    MemberOutput.Text += " Username: " + member.SelectSingleNode("username").InnerText + "<br/>";
                    MemberOutput.Text += " Password: " + hash.DecodeFrom64(member.SelectSingleNode("password").InnerText) + "<br/> <br/>";
                    count++;
                }

                FS.Close();
                FS.Dispose();
            }

                //create xmlDOcument object
                

            
        }
    }
}