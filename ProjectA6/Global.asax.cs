using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Net;

namespace ProjectA6
{
    public class Global : HttpApplication
    {
        //global variable functionaility for session states
        //this will locally run the session states for user login states across different pages
        //when the user is logged out, they are unregistered and need to re-login
        public static bool loggedIn = false;
        public static string accountName = "Guest";
        public static string status = "Unregistered";

        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            //startup will initialize variables 
            
        }
    }
}