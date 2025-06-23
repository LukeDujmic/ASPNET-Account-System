<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MemberPage.aspx.cs" Inherits="ProjectA6.MemberPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
    body
    {
        padding: 0em;
        margin: 0em;
    }
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
        margin: 0.2em;
    }
    header
    {
        background-color: deepskyblue;
        color: white;
        padding: 1em;
        font-size: 2em;
    }
    #planeBackdrop
    {
        background-image: url("Images/planeBackdrop.png");
        padding: 15em;
        background-size: cover;
        background-repeat: no-repeat;
        background-position-y: -10em;
    }
    #AirportLabel
    {
        font-size: 1.2em;
    }

</style>
</head>
<body>
    <form id="form1" runat="server">

    <header>

        <asp:Label ID="AccountInfo" runat="server" Text="Account: Guest | Status: Unregistered"></asp:Label>

        <asp:Button ID="LogoutBtn" runat="server" Text="Logout" OnClick="Logout" />
    </header>

        <div id="planeBackdrop"></div>
        <br />
        <asp:Button ID="HomeBtn" runat="server" Text="Return to Home Page" OnClick="HomeBtn_Click" />
        <br />

        <!--CHEAP FLIGHT TO ANYWHERE!!!  (made by Luke Dujmic) -->
    <div class="serviceBox">
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


        <!--FLIGHT PRICE RANGE SERVICE (made by Luke Dujmic)-->
        <div class="serviceBox">
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

        <!--AIRPORT FINDER SERVICE (made by Heinric Alfred)-->
        <div class="serviceBox">
            <h1>Airport Search</h1>
            <p>Need to find a nearby Airport? Check here.
            </p>

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

    </form>
</body>
</html>
