<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StaffPage.aspx.cs" Inherits="ProjectA6.StaffPage" %>

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
    #MemberOutput
    {
        border: 0.05em black solid;
        padding: 0.1em;
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

        <div class="serviceBox">
            <h1>Member List (from XML file)</h1>
            <br />
            <asp:Button ID="MemberList" runat="server" Text="Get Member List" OnClick="MemberList_Click" />

            <br />
            <br />
            <asp:Label ID="MemberOutput" runat="server" Text="..."></asp:Label>

        </div>
    </form>
</body>
</html>
