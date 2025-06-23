<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ProjectA6._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="assets/styles/main.css">
	<!--styling elements within the page -->
    <style>
        body
        {
            padding: 0em;
        }
        td
        {
            border: black solid 0.1em;
        }
        header
        {
            background-color: deepskyblue;
            color: white;
            padding: 1em;
            font-size: 2em;
        }
    </style>

    <header>
        
        <asp:Label ID="AccountInfo" runat="server" Text="Account: Guest | Status: Unregistered"></asp:Label>
        
        <asp:Button ID="LogoutBtn" runat="server" Text="Logout" OnClick="LogoutBtn_Click" />
    </header>
    <div id="desc">
        <h1>Flight Information Center</h1>
        <p>
            This web service will offer various forms of information regarding flights. 
            The information will include times, prices, distances and other relevant pieces of data.
            The user can search for the cheapest flights, closest airports and much more!
        </p>

        <p>To access these services, you must sign up here as a member or access the service with upper-level permissions as a staff member.</p>
    
        
    </div>

    <!--<div id="login">
        <a href="TryIt.aspx">Try Out the Services:</a>
    </div>-->

    <a>In order to try out the log-in functionality locally (and not on WebStrar) use these buttons:</a>
    <br />
    <asp:Button ID="MemberBtn" runat="server" OnClick="MemberNav" Text="Go to Member Page" />
    <br />
    <asp:Button ID="StaffBtn" runat="server" OnClick="StaffNav" Text="Go to Staff Page" />

    <br />

    <asp:Label ID="StatusLabel" runat="server" Text="..."></asp:Label>

    <!--Table to display service directory-->
    <br />
    <h1>Service Directory</h1>
    <asp:Button ID="TryItNav" runat="server" Text="Go TryIt" OnClick="TryItNav_Click" />
    <br />
    <p>Integrated Application Deployed at: <a href="http://webstrar90.fulton.asu.edu/page7/Default">http://webstrar90.fulton.asu.edu/page7/Default</a></p>
    <table>
        <tbody>
        <tr style="height: 22px;">
        <td style="height: 22px;">Provider Name</td>
        <td style="height: 22px;">Service Name</td>
        <td style="height: 22px;">Required?</td>
        <td style="height: 22px;">Difficulty</td>
        <td style="height: 22px;">TryIt Link
            
            </td>
        <td style="height: 22px;">Service Desc.</td>
        <td style="height: 22px;">Resources</td>
        </tr>
        <tr style="height: 22px;">
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Luke Dujmic</span></td>
        <td style="height: 22px;">&nbsp;Captcha</td>
        <td style="height: 22px;">&nbsp;Yes</td>
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Moderate</span></td>
        <td style="height: 22px;">&nbsp;<a class="anchor-1X4H4q anchorUnderlineOnHover-wiZFZ_" tabindex="0" title="http://webstrar90.fulton.asu.edu/page7/TryIt.aspx" href="http://webstrar90.fulton.asu.edu/page7/TryIt.aspx" target="_blank" rel="noreferrer noopener">http://webstrar90.fulton.asu.edu/page7/TryIt.aspx</a></td>
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Call upon a captcha service to generate an image captcha verifier when creating a new account.</span></td>
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Using the captcha service and implementing it as a service for the login.</span></td>
        </tr>
        <tr style="height: 22px;">
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Luke Dujmic</span></td>
        <td style="height: 22px;">&nbsp;Cheapest Origin Flight</td>
        <td style="height: 22px;">&nbsp;No</td>
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Moderate</span></td>
        <td style="height: 22px;">&nbsp;<a class="anchor-1X4H4q anchorUnderlineOnHover-wiZFZ_" tabindex="0" title="http://webstrar90.fulton.asu.edu/page7/TryIt.aspx" href="http://webstrar90.fulton.asu.edu/page7/TryIt.aspx" target="_blank" rel="noreferrer noopener">http://webstrar90.fulton.asu.edu/page7/TryIt.aspx</a></td>
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">The service will grab flight prices using respective company prices, and find the cheapest one from a certain location (using IATA code)</span></td>
        <td style="height: 22px;">&nbsp;<a href="https://developers.amadeus.com/self-service/category/flights/api-doc/flight-offers-search"><span style="font-weight: 400;">https://developers.amadeus.com/self-service/category/flights/api-doc/flight-offers-search</span></a><span style="font-weight: 400;"> use this resource to grab price specifics </span></td>
        </tr>
        <tr style="height: 22px;">
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Luke Dujmic</span></td>
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Flight prices</span></td>
        <td style="height: 22px;">&nbsp;No</td>
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Moderate</span></td>
        <td style="height: 22px;">&nbsp;<a class="anchor-1X4H4q anchorUnderlineOnHover-wiZFZ_" tabindex="0" title="http://webstrar90.fulton.asu.edu/page7/TryIt.aspx" href="http://webstrar90.fulton.asu.edu/page7/TryIt.aspx" target="_blank" rel="noreferrer noopener">http://webstrar90.fulton.asu.edu/page7/TryIt.aspx</a></td>
        <td style="height: 22px;">&nbsp;Grabs the price ranges of SPECIFIC origin-destination flight paths</td>
        <td style="height: 22px;">&nbsp;<a href="https://developers.amadeus.com/self-service/category/flights/api-doc/flight-offers-search"><span style="font-weight: 400;">https://developers.amadeus.com/self-service/category/flights/api-doc/flight-offers-search</span></a><span style="font-weight: 400;"> use this resource to grab price specifics </span></td>
        </tr>
        <tr style="height: 22px;">
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Luke Dujmic</span></td>
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Log in XML Comparison</span></td>
        <td style="height: 22px;">&nbsp;Yes</td>
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Moderate-Difficult</span></td>
        <td style="height: 22px;">&nbsp;<a class="anchor-1X4H4q anchorUnderlineOnHover-wiZFZ_" tabindex="0" title="http://webstrar90.fulton.asu.edu/page7/MemberLogin.aspx" href="http://webstrar90.fulton.asu.edu/page7/MemberLogin.aspx" target="_blank" rel="noreferrer noopener">http://webstrar90.fulton.asu.edu/page7/MemberLogin.aspx</a></td>
        <td style="height: 22px;">&nbsp;Gets the member/staff info from an XML file to verify login credentials</td>
        <td style="height: 22px;">&nbsp;Completed using XmlDocument functionality in order to create a new account object and append it to an XML file.  This was done for both the member and staff level permissions. (May or may not work on the WebStrar server due to file pathing issues)</td>
        </tr>

        <tr style="height: 22px;">
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Luke Dujmic</span></td>
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Hash DLL File</span></td>
        <td style="height: 22px;">&nbsp;Yes</td>
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Easy</span></td>
        <td style="height: 22px;">&nbsp;No Link for this.  Just look at the "References" folder and see the Hash.dll library. You can also see the line "using Hash" in the MemberLogin.aspx.cs file.</td>
        <td style="height: 22px;">&nbsp;Utilizes a Hash.dll class file to implement password hashing</td>
        <td style="height: 22px;">&nbsp;Completed using my own code to encrypt and decrypt with Base64. Imported the file and denoted a using directive to access its components</td>
        </tr>

        <tr style="height: 22px;">
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Heinric Alfred</span></td>
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Airport Locations</span></td>
        <td style="height: 22px;">&nbsp;No</td>
        <td style="height: 22px;">&nbsp;Difficult</td>
        <td style="height: 22px;">&nbsp;<a class="anchor-1X4H4q anchorUnderlineOnHover-wiZFZ_" tabindex="0" title="http://webstrar90.fulton.asu.edu/page7/TryIt.aspx" href="http://webstrar90.fulton.asu.edu/page7/TryIt.aspx" target="_blank" rel="noreferrer noopener">http://webstrar90.fulton.asu.edu/page7/TryIt.aspx</a></td>
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">This service will retrieve available airport locations and link it to the interface elements entered by the client.&nbsp; Grabs based on a RADIUS search of specific longitudes</span></td>
        <td style="height: 22px;">&nbsp;<a href="https://developers.amadeus.com/self-service/category/flights/api-doc/airport-and-city-search"><span style="font-weight: 400;">https://developers.amadeus.com/self-service/category/flights/api-doc/airport-and-city-search</span></a><span style="font-weight: 400;"> use this resource to retrieve information from various API methods.&nbsp; Requires various locational anaylsis and longitude/latitude radar checks.</span></td>
        </tr>

        <tr style="height: 22px;">
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Heinric Alfred</span></td>
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Cookies</span></td>
        <td style="height: 22px;">&nbsp;Yes</td>
        <td style="height: 22px;">&nbsp;Moderate-Difficult</td>
        <td style="height: 22px;">&nbsp;If you log in and click "stay signed in", you will remain on the account you left. (no link for testing specifically)</td>
        <td style="height: 22px;">&nbsp;This will grab user information and save it for future visits of the website.</td>
        <td style="height: 22px;">&nbsp;Applied knowledge and my own code in order to implement cookies. Used http cookies library.</td>
        </tr>

        <tr style="height: 22px;">
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Heinric Alfred</span></td>
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Global.asax Functions</span></td>
        <td style="height: 22px;">&nbsp;Yes</td>
        <td style="height: 22px;">&nbsp;Moderate</td>
        <td style="height: 22px;">&nbsp;By going to different pages when logged in, you can see that account information stays consistent. (no link for testing specifically, but you can see the account info at the top of every page!)</td>
        <td style="height: 22px;">&nbsp;Global.asax login functionality to utilize cookies and not repeat functions multiple times.</td>
        <td style="height: 22px;">&nbsp;Used knowledge of service-oriented programming and website programming to implement a function that would apply globally across all pages.</td>

        <tr style="height: 22px;">
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Heinric Alfred</span></td>
        <td style="height: 22px;">&nbsp;<span style="font-weight: 400;">Xml Filepath Manipulation</span></td>
        <td style="height: 22px;">&nbsp;Yes</td>
        <td style="height: 22px;">&nbsp;Easy-Moderate</td>
        <td style="height: 22px;">&nbsp;Check Staff page to see what's in the Member.xml file (must go to this link to log in: <a class="anchor-1X4H4q anchorUnderlineOnHover-wiZFZ_" tabindex="0" title="http://webstrar90.fulton.asu.edu/page7/MemberLogin.aspx" href="http://webstrar90.fulton.asu.edu/page7/MemberLogin.aspx" target="_blank" rel="noreferrer noopener">http://webstrar90.fulton.asu.edu/page7/MemberLogin.aspx</a>)</td>
        <td style="height: 22px;">&nbsp;Web browser compatibility with XML filepath (enables webstrar server to use XML files from project solution).</td>
        <td style="height: 22px;">&nbsp;Checked module 6 slides to gather filepath information regarding XML file retrieval in App_Data folder. Used XmlDocument library to manipulate the files. </td>
        </tr>

        
    </table>

    <br />


</asp:Content>
