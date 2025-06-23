using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Microsoft.Ajax.Utilities;
using Hash;
using System.Net;

namespace ProjectA6
{
    public partial class MemberLogin : System.Web.UI.Page
    {
        private static XmlDocument xmlDoc;
        private static bool success = false;
        private static Hasher hashPass = new Hasher();

        //ENCRYPTION AND DECRYPTION FUNCTIONS ARE IMPLEMENTED USING THE HASH.DLL FILE (in references)

        protected void Page_Load(object sender, EventArgs e)
        {
            //hide certain elements when the page loads
            success = false;
            CapImg.ImageUrl = "~/imageProcess.aspx";
            if (!success)
            {
                CaptchaPanel.Visible = false;
            }
            WarningLabel.Visible = false;
        }

        protected void showImage(object sender, EventArgs e)
        {
            ImageRef.ServiceClient fromService = new ImageRef.ServiceClient();
            // create proxy to the remote service
            // 

            //The size of our captchas will be 5
            string userLength = "5";
            //put the length into the captcha service
            Session["userLength"] = userLength;
            //grab an image using the specified size
            string myStr = fromService.GetVerifierString(userLength);
            Session["generatedString"] = myStr;

            //change button text and regenerate image
            CapGen.Text = "Generate Another Captcha";
            CapImg.Visible = true;
        }

        //this function is called when the "Submit" button is pressed for the captcha service
        protected void capCheck(object sender, EventArgs e)
        {
            //this checks whether or not what the user inputted in the textbox for submission is equal to the actual captcha text
            if (Session["generatedString"].Equals(CapInput.Text))
            {
                //grab from the App_Data path

                string fLocation = Path.Combine(Request.PhysicalApplicationPath, @"App_Data\Member.xml");
                FileStream FS = new FileStream(fLocation, FileMode.Open);

                xmlDoc.Save(FS);
                CapOutput.Text = "Success, taking you to member page...";
                Global.loggedIn = true;
                Response.Redirect("MemberPage.aspx");
            }
            else
            {
                //tell the that the string doesn't match, preventing the XML from appending
                CapOutput.Text = "String does not match the expected output for the image!";
            }
        }

        protected void RegisterBtn_Click(object sender, EventArgs e)
        {

            success = false;
            //to check existence of a username
            bool exists = false;

            string fLocation = Path.Combine(Request.PhysicalApplicationPath, @"App_Data\Member.xml");

            using (FileStream FS = new FileStream(fLocation, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                string newUsername = NewNameInput.Text;
                string newPassword = NewPassInput.Text;

                //create xmlDOcument object
                xmlDoc = new XmlDocument();
                xmlDoc.Load(FS);

                XmlNode root = xmlDoc.SelectSingleNode("//members");
                foreach (XmlNode member in root.ChildNodes)
                {
                    if (member.SelectSingleNode("username").InnerText == newUsername)
                    {
                        exists = true;
                    }
                }



                //then there's nothing in the list of matching usernames (our username isn't a duplicate)
                if (!exists)
                {
                    //create a new XMLelement (BUT DONT APPEND IT YET)
                    XmlNode members = xmlDoc.SelectSingleNode("//members");
                    XmlElement newMember = xmlDoc.CreateElement("member");


                    XmlElement newName = xmlDoc.CreateElement("username");
                    XmlElement newPass = xmlDoc.CreateElement("password");

                    newName.InnerText = newUsername;
                    newPass.InnerText = hashPass.EncodePasswordToBase64(newPassword);

                    newMember.AppendChild(newName);
                    newMember.AppendChild(newPass);

                    members.AppendChild(newMember);

                    success = true;
                }
                //if we find something in the list, that means the username already exists
                else
                {
                    //give the user a warning that the name was found
                    WarningLabel.Visible = true;
                    WarningLabel.Text = "Specified username already exists!";
                }

                //if one of the elements is empty, deny the creation process
                if (newUsername.IsNullOrWhiteSpace() || newPassword.IsNullOrWhiteSpace())
                {
                    success = false;
                    WarningLabel.Visible = true;
                    WarningLabel.Text = "Username or password must not be empty!";
                }

                //after the account check, if we created one successfully, run this captcha sequence
                if (success)
                {
                    //on a successful register, call upon the cookie function
                    //here, we initialize all the relevant information to save
                    HttpCookie myCookies = new HttpCookie("myCookieId");
                    myCookies["Name"] = newUsername;
                    myCookies["Pass"] = newPassword;
                    myCookies["Status"] = "Member";

                    //only use the cookie information if the user wanted to stay signed in
                    if (StayInReg.Checked)
                    {
                        myCookies["Stay"] = "Y";
                    }
                    else
                    {
                        myCookies["Stay"] = "N";
                    }

                    myCookies.Expires = DateTime.Now.AddMonths(6);
                    Response.Cookies.Add(myCookies);

                    CaptchaPanel.Visible = true;
                    Global.accountName = newUsername;
                    Global.accountName = newUsername;
                    Global.status = "Member";
                }

                FS.Close();
                FS.Dispose();
            }

                

            //close filestream
            //FS.Close();

        }

        protected void LogIn(object sender, EventArgs e)
        {
            bool valid = false;
            //to check existence of a username

            string fLocation = Path.Combine(Request.PhysicalApplicationPath, @"App_Data\Member.xml");
            using (FileStream FS = new FileStream(fLocation, FileMode.Open, FileAccess.Read, FileShare.Read ))
            {
                string username = NameInput.Text;
                string password = PassInput.Text;

                //create xmlDOcument object
                xmlDoc = new XmlDocument();
                xmlDoc.Load(FS);

                XmlNode root = xmlDoc.SelectSingleNode("//members");

                foreach (XmlNode member in root.ChildNodes)
                {
                    if (member.SelectSingleNode("username").InnerText == username && hashPass.DecodeFrom64(member.SelectSingleNode("password").InnerText) == password)
                    {
                        valid = true;
                    }
                }

                //if we log in and the input matches one of the XML entries
                if (valid)
                {
                    Global.loggedIn = true;
                    Global.accountName = username;
                    Global.status = "Member";

                    //create a cookie to save login when re-accessing the page

                    HttpCookie myCookies = new HttpCookie("myCookieId");

                    myCookies["Name"] = username;
                    myCookies["Pass"] = password;
                    myCookies["Status"] = "Member";
                    //only utilize this cookie if we wanted to stay logged in
                    if (StayIn.Checked)
                    {
                        myCookies["Stay"] = "Y";
                    }
                    else
                    {
                        myCookies["Stay"] = "N";
                    }

                    myCookies.Expires = DateTime.Now.AddMonths(6);
                    Response.Cookies.Add(myCookies);

                    Response.Redirect("MemberPage.aspx");
                }

                //otherwise tell the user that the input was incorrect
                else
                {
                    LogWarning.Text = "Invalid member username or password";
                }

                FS.Close();
                FS.Dispose();
            }

                

            //close filestream
            //FS.Close();

        }

        protected void StaffLogIn_Click(object sender, EventArgs e)
        {
            bool valid = false;
            //to check existence of a username

            //filepath for staff.xml file 
            string fLocation = Path.Combine(Request.PhysicalApplicationPath, @"App_Data\Staff.xml");
            using (FileStream FS = new FileStream(fLocation, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                string username = StaffNameInput.Text;
                string password = StaffPassInput.Text;

                //create xmlDOcument object
                xmlDoc = new XmlDocument();
                xmlDoc.Load(FS);

                //search through every node (there should only be one anyways)
                XmlNode root = xmlDoc.SelectSingleNode("//staffs");

                foreach (XmlNode staff in root.ChildNodes)
                {
                    if (staff.SelectSingleNode("username").InnerText == username && staff.SelectSingleNode("password").InnerText == password)
                    {
                        valid = true;
                    }
                }

                if (valid)
                {
                    //set up a cookie object for the staff
                    HttpCookie myCookies = new HttpCookie("myCookieId");

                    myCookies["Name"] = username;
                    myCookies["Pass"] = password;
                    myCookies["Status"] = "Staff";
                    if (StayIn.Checked)
                    {
                        myCookies["Stay"] = "Y";
                    }
                    else
                    {
                        myCookies["Stay"] = "N";
                    }

                    myCookies.Expires = DateTime.Now.AddMonths(6);
                    Response.Cookies.Add(myCookies);


                    Global.loggedIn = true;
                    Global.accountName = username;
                    Global.status = "Staff";
                    Response.Redirect("StaffPage.aspx");
                }
                else
                {
                    StaffWarning.Text = "Invalid staff username or password";
                }

                FS.Close();
                FS.Dispose();
            }

                

            //FS.Close();
        }
    }
}