<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TryIt.aspx.cs" Inherits="ProjectA6.WebForm1" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        main
        {
            margin: 0.25em;
            margin-bottom: 2em;
        }
        .aspLabels{
            border: black solid 0.05em;
            border-radius: 0.25em;
            margin: 1em;
            padding: 0.1em;
            background-color: rgba(240, 240, 240);
        }
        .aspBoxes
        {
            border: black solid 0.1em;
            border-radius: 0.1em;
            margin: 0.5em;
            padding: 0.3em;
            background-color: rgba(240, 240, 240);
    
        }
        .serviceBox
        {
            padding: 0.3em;
            padding-bottom: 0.5em;
            box-shadow: black 0.2em 0.2em 0.5em;
            border: black solid 0.1em;
            border-radius: 0.5em;
            margin-bottom: 2em;
            background-color: lightgray;
        }
        h1
        {
            text-shadow: black 0.01em 0.01em 0.1em;
        }
        .serviceBox > a{
            border: gray dashed 0.05em;
            padding: 0.05em;
        }
        header
        {
            background-color: deepskyblue;
            color: white;
            padding: 1em;
            font-size: 2em;
        }
        #AirportLabel
        {
            font-size: 1.2em;
        }

    </style>

    <div class="serviceBox">
            <a>Header for account information made by Heinric Alfred. Uses Global.asax functionality to maintain account info across different pages. Also uses cookies to display the account info if the user leaves and comes back.</a>
    </div>

    <header>
    
        <asp:Label ID="AccountInfo" runat="server" Text="Account: Guest | Status: Unregistered"></asp:Label>
    
        <asp:Button ID="LogoutBtn" runat="server" Text="Logout" OnClick="Logout" />
    </header>

    <!--Image captcha, uses image and form inputs similar to the rest of this page-->
    <asp:Button ID="HomeBtn" runat="server" Text="Return to Home Page" OnClick="HomeBtn_Click" />
    <br />

    <div class="serviceBox">
        <a>Image verifier for account registry. Made by Luke Dujmic</a>
        <h3>Image Captcha (Q5 Option 4)</h3>
        <p>
            <!--Image changes whenever user enters a new StringSize and clicks the "CapGen" button-->
            <asp:Image ID="CapImg" runat="server" />
            <asp:Label ID="LabelCap1" runat="server" Text="Image String Length is:"></asp:Label>
            <asp:TextBox ID="StringSize" runat="server"></asp:TextBox>
        &nbsp;<asp:Button ID="CapGen" runat="server" Text="Generate Captcha" OnClick ="showImage" />
        </p>
        <p>Enter string from above image:
            <asp:TextBox ID="CapInput" runat="server"></asp:TextBox>
        &nbsp;<asp:Button ID="CapCheck" runat="server" Text="Submit" OnClick ="capCheck" />
        </p>
        <p>
            <asp:Label ID="CapOutput" runat="server" Text="..."></asp:Label>
        </p>
    </div>
        <div class="serviceBox">
            <a>Cheapest Flight API service. Searces for the cheapest plane ticket to any location from a specified IATA code. Made by Luke Dujmic</a>
            <h1>Cheapest Flight</h1>
            <p>Ever want to find the cheapest plane ticket for any destination? Well look no further than this service, where you can enter an origin location and get the cheapest tickets to anywhere!
            </p>
            <a>If you want to find cheapest flights from Boston, you would type BOS.</a>
            <br />
            <label>Type airport (according to IATA code):</label>
            <br />
            <asp:TextBox ID="FlightCodeTB1" runat="server"></asp:TextBox>
            <br />
            <a>Once this button is pressed, JSON data is generated from the API, and parsed into the relevant info!</a>
            <br />
&nbsp;<asp:Button ID="FlightButton" runat="server" Text="Fly Away" OnClick="SearchCheapestAny" />
            <br />
            <asp:Label ID="FlightLabel" runat="server" Text="Output"></asp:Label>
        </div>


        <!--FLIGHT PRICE RANGE SERVICE-->
        <div class="serviceBox">
            <a>Top 5 cheapest flights from one location to another. Made by Luke Dujmic.</a>
            <h1>Specific Flight Price Ranges</h1>
            <p>Looking for all prices between 2 destinations? Check here.
            </p>

            <label>Type Origin (iata code):</label>
            
            <br />
            <asp:TextBox ID="OriginTB" runat="server"></asp:TextBox>
            <br />
            <label>Type Destination (iata code):</label>
            <br />
            <asp:TextBox ID="DestinationTB" runat="server"></asp:TextBox>
            <br />
            <label>Type Departure Date (YYYY-MM-DD format):</label>
            <br />
            <asp:TextBox ID="DateTB" runat="server"></asp:TextBox>
            <br />
            <a>If you want to find ranges from Syndey to Bangkok, you would put SYD in the origin and BKK in the destination. Try date 2023-11-01 for the departure date.</a>
            <br />
&nbsp;<asp:Button ID="PriceCheck" runat="server" Text="Check Prices" OnClick="FindPrice" />
            <br />
            <asp:Label ID="GoodPriceLabel" runat="server" Text="Output"></asp:Label>
        </div>

            <!--AIRPORT FINDER SERVICE-->
        <div class="serviceBox">
            <a>Airport location radius search API. Checks for aiport locations within 500km of the specified longitude and latitude. Made by Heinric Alfred.</a>
            <h1>Airport Search</h1>
            <p>Need to find a nearby Airport? Check here.
            </p>

            <a>You can try typing 33 for latitude and -112 for longitude to get some nearby airports to Arizona!</a>
            <a>If you try a coordinate like 0 0, you will get no output, in which the program lets you know there are no nearby airports.</a>
            <br />
            <label>Type latitude:</label>
            <br />
            <asp:TextBox ID="latText" runat="server"></asp:TextBox>
            <br />
            <label>Type longitude:</label>
            <br />
            <asp:TextBox ID="longText" runat="server"></asp:TextBox>
            <br />

&nbsp;<asp:Button ID="AirportSearchButton" runat="server" Text="Find Airports" OnClick="FindAiports" />
            <br />
            <asp:Label ID="AirportLabel" runat="server" Text="Output"></asp:Label>
        </div>

        <div class="serviceBox">
            <a>Any other specific services and/or programs are implicit and are detailed in the Service Directory within the Default.aspx page!</a>
            <p>There are many more services/functions that can be tested. This includes:
            </p>
            <li>Staff page that can view Member.xml file contents.  (made by Luke Dujmic)</li>
            <li>Cookies for user info using "Stay Signed in" checkbox on the login page.  (made by Heinric Alfred)</li>
            <li>Cross-page user info display using Global.asax.  (made by Heinric Alfred)</li>
        </div>

    
  


</asp:Content>
