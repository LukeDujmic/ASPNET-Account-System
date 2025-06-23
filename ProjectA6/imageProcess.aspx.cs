using System;
using System.Collections.Generic;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProjectA6
{
    public partial class imageProcess : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //when the page loads, many actions happen in regards to the captcha.
            //This page load action actually activates each time a new captcha image is needed
            Response.Clear();
            //proxy object
            ImageRef.ServiceClient fromService = new ImageRef.ServiceClient();
            string myStr, userLen;

            //if there is no captcha yet
            if (Session["generatedString"] == null)
            {
                if (Session["userLength"] == null)
                    //default length for the captcha will be 5 when the webpage FIRST loads
                    userLen = "5";
                else
                    //this will happen every time the user enters a new string size for the captcha object
                    userLen = Session["userLength"].ToString();
                myStr = fromService.GetVerifierString(userLen);
                Session["generatedString"] = myStr;
            }
            //if there is a captcha already, use whats already inputted to generate the parameters for the next captcha
            else
            {
                myStr = Session["generatedString"].ToString();
            }

            //This is where the actual image is retrieved whenever the showImage function is called
            Stream myStream = fromService.GetImage(myStr);
            System.Drawing.Image myImage = System.Drawing.Image.FromStream(myStream);
            Response.ContentType = "image/jpeg";
            myImage.Save(Response.OutputStream, ImageFormat.Jpeg);
        }
    }
}