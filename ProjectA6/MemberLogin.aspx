<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MemberLogin.aspx.cs" Inherits="ProjectA6.MemberLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        #WarningLabel
        {
            color: red;
        }
        .staffSection
        {
            background-color: black;
            color: white;
            padding: 1em;
        }
        #LogWarning
        {
            color: red;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Member Log-In</h1>
            <asp:Label ID="NameLabel" runat="server" Text="Enter Username:"></asp:Label>
            <asp:TextBox ID="NameInput" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="PassLabel" runat="server" Text="Enter Password:"></asp:Label>
            <asp:TextBox ID="PassInput" TextMode="Password" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="LogInBtn" runat="server" Text="Log In" OnClick="LogIn" />
            <br />
            <asp:CheckBox ID="StayIn" runat="server" Text="Stay Signed In?"/>
            <br />
            <br />
            <a>When you log in, it will check if the Member.xml file contains an element that his this exact username and password.  If it does, log in!</a>
            <br />
            <asp:Label ID="LogWarning" runat="server" Text="..."></asp:Label>
        </div>

        <div>
            <h1>Member Register</h1>
            <asp:Label ID="NewNameLabel" runat="server" Text="Enter new Username:"></asp:Label>
            <asp:TextBox ID="NewNameInput" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="NewPassLabel" runat="server" Text="Enter new Password:"></asp:Label>
            <asp:TextBox ID="NewPassInput" TextMode="Password" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="RegisterBtn" runat="server" Text="Submit" OnClick="RegisterBtn_Click" />
            <br />
            <asp:CheckBox ID="StayInReg" runat="server" Text="Stay Signed In?"/>
            <br />
            <br />
            <a>Once you register, it will check against the Member.xml file to see if the username exists.  If it doesn't it will append to the file</a>
            <br />
            <asp:Label ID="WarningLabel" runat="server" Text="..."></asp:Label>
            <asp:Panel ID="CaptchaPanel" runat="server">
                <p>
                <!--Image changes whenever user enters a new StringSize and clicks the "CapGen" button-->
                <asp:Image ID="CapImg" runat="server" />
                &nbsp;<asp:Button ID="CapGen" runat="server" Text="Generate Captcha" OnClick ="showImage" />
                </p>
                <p>Enter the text that you see from above image:
                <asp:TextBox ID="CapInput" runat="server"></asp:TextBox>
                &nbsp;<asp:Button ID="CapCheck" runat="server" Text="Submit" OnClick ="capCheck" />
                </p>
                <p>
                <asp:Label ID="CapOutput" runat="server" Text="..."></asp:Label>
                </p>
            </asp:Panel>

        </div>

        <div class="staffSection">
            <h1>Staff Login</h1>
            <asp:Label ID="StaffNameLabel" runat="server" Text="Enter Staff Username"></asp:Label>
            <asp:TextBox ID="StaffNameInput" runat="server"></asp:TextBox>
            <p>
                <asp:Label ID="StaffPassLabel" runat="server" Text="Enter Staff Password"></asp:Label>
                <asp:TextBox ID="StaffPassInput" TextMode="Password" runat="server"></asp:TextBox>
            </p>
            <br />
            <a>HINT: username="TA" password="Cse44598"</a>
            <p>
                <asp:Button ID="StaffLogIn" runat="server" Text="Log In" OnClick="StaffLogIn_Click" />
            </p>
            <asp:Label ID="StaffWarning" runat="server" Text="..."></asp:Label>
        </div>

    </form>
</body>
</html>
