using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json.Linq;

namespace ProjectA6
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CapImg.ImageUrl = "~/imageProcess.aspx";

            //check if the user had the stay signed in checkbox checked
            //if they did then use the cookie information
            HttpCookie myCookies = Request.Cookies["myCookieId"];

            if (myCookies != null && myCookies["Stay"] == "Y")
            {
                Global.loggedIn = true;
                Global.accountName = myCookies["Name"];
                Global.status = myCookies["Status"];
            }

            //using the cookie information, determine if the user should be marked as logged in or not
            if (Global.loggedIn)
            {
                AccountInfo.Text = "Account: " + Global.accountName + " | Status: " + Global.status;
            }
            else
            {
                AccountInfo.Text = "Account: Guest | Status: Unregistered";
            }
        }

        protected void showImage(object sender, EventArgs e)
        {
            ImageRef.ServiceClient fromService = new ImageRef.ServiceClient();
            // create proxy to the remote service
            // 
            
            //grab the length from the string input textbox
            string userLength = StringSize.Text;
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
                CapOutput.Text = "Great job! The text you entered matches the text from the image. You are (likely) not a robot!";
            }
            else
            {
                CapOutput.Text = "Bot detected, activating EMP protocol! (just kidding, please try again)";
            }
        }

        private static string getToken()
        {
            //API KEYS for AMADEUS FLIGHT TRAVEL API
            const string apikey = "i9EBtr2XS6aSspO6XiKRO6iNiWo6K6hx";
            const string apisecret = "vesg6JTJlGuN6QuV";
            const string tokenURL = "https://test.api.amadeus.com/v1/security/oauth2/token";

            //post the key credentials
            string postData = $"grant_type=client_credentials&client_id={apikey}&client_secret={apisecret}";
            HttpClient client = new HttpClient();
            client.BaseAddress = new Uri(tokenURL);

            HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Post, "");
            request.Content = new StringContent(postData,
                                    Encoding.UTF8,
                                    "application/x-www-form-urlencoded");

            //wait for response
            Task<HttpResponseMessage> response = client.SendAsync(request);
            //if successful, create json object (varies based on URL input)
            if (response.Result.IsSuccessStatusCode)
            {
                string myJsonResponse = Newtonsoft.Json.JsonConvert.DeserializeObject(response.Result.Content.ReadAsStringAsync().Result).ToString();
                JObject jsonObject = JObject.Parse(myJsonResponse);
                client.Dispose();

                string token = (string)jsonObject["access_token"];
                return token;
            }
            else
            {
                Console.WriteLine("{0} ({1})", (int)response.Result.StatusCode, response.Result.ReasonPhrase);
                return response.Result.ReasonPhrase;
            }
        }

        protected void SearchCheapestAny(object sender, EventArgs e)
        {
            string location = FlightCodeTB1.Text;
            string URL = $"https://test.api.amadeus.com/v1/shopping/flight-destinations?origin={location}";
            string token = getToken();
            HttpClient client = new HttpClient();
            client.BaseAddress = new Uri(URL);
            client.DefaultRequestHeaders.TryAddWithoutValidation("Authorization", "Bearer " + token);
            HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Get, "");

            Task<HttpResponseMessage> response = client.SendAsync(request);
            string myJsonResponse = Newtonsoft.Json.JsonConvert.DeserializeObject(response.Result.Content.ReadAsStringAsync().Result).ToString();
            JObject jsonObject = JObject.Parse(myJsonResponse);

            if (response.Result.IsSuccessStatusCode)
            {
                FlightLabel.Text = "Your cheapest destination (in IATA code format) is: [" + jsonObject["data"][0]["destination"] + "] \n\n The price of this ticket will be: $" + jsonObject["data"][0]["price"]["total"];
                //PRICE[1] in this case refers to the second element of the JSON object, which does denote the price
            }
            else
            {
                //if your IATA code is incorrectly inputted
                FlightLabel.Text = "Incorrect IATA code input!";
            }
            //close the http client
            client.Dispose();
        }

        protected void FindPrice(object sender, EventArgs e)
        {
            string origin = OriginTB.Text;
            string destination = DestinationTB.Text;
            string time = DateTB.Text;

            string URL = $"https://test.api.amadeus.com/v1/analytics/itinerary-price-metrics?originIataCode={origin}&destinationIataCode={destination}&departureDate={time}";
            string token = getToken();
            HttpClient client = new HttpClient();
            client.BaseAddress = new Uri(URL);
            client.DefaultRequestHeaders.TryAddWithoutValidation("Authorization", "Bearer " + token);
            HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Get, "");

            Task<HttpResponseMessage> response = client.SendAsync(request);
            string myJsonResponse = Newtonsoft.Json.JsonConvert.DeserializeObject(response.Result.Content.ReadAsStringAsync().Result).ToString();
            JObject jsonObject = JObject.Parse(myJsonResponse);

            if (response.Result.IsSuccessStatusCode)
            {

                GoodPriceLabel.Text = "";
                //GoodPriceLabel.Text = myJsonResponse + "\n\n\n";
                int maxRange = jsonObject["data"][0]["priceMetrics"].Count();
                for (var i = 0; i < maxRange; i++)
                {
                    //TimeSpan? variable.Value.TotalHours = 
                    GoodPriceLabel.Text += "Price #"+(i+1)+": $" + jsonObject["data"][0]["priceMetrics"][i]["amount"] + "<br />";
                    GoodPriceLabel.Text += "Price Ranking: " + jsonObject["data"][0]["priceMetrics"][i]["quartileRanking"] + "<br />";
                    GoodPriceLabel.Text += "<br />";
                }
            }
            else
            {
                //if your IATA code is incorrectly inputted
                GoodPriceLabel.Text = "Input error!";
            }
            //close the http client
            client.Dispose();
        }

        protected void FindAiports(object sender, EventArgs e)
        {
            string latitude = latText.Text;
            string longitude = longText.Text;

            string URL = $"https://test.api.amadeus.com/v1/reference-data/locations/airports?latitude={latitude}&longitude={longitude}";
            string token = getToken();
            HttpClient client = new HttpClient();
            client.BaseAddress = new Uri(URL);
            client.DefaultRequestHeaders.TryAddWithoutValidation("Authorization", "Bearer " + token);
            HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Get, "");

            Task<HttpResponseMessage> response = client.SendAsync(request);
            string myJsonResponse = Newtonsoft.Json.JsonConvert.DeserializeObject(response.Result.Content.ReadAsStringAsync().Result).ToString();
            JObject jsonObject = JObject.Parse(myJsonResponse);

            if (response.Result.IsSuccessStatusCode)
            {
                AirportLabel.Text = myJsonResponse + "\n\n\n";
                AirportLabel.Text = "";
                // + jsonObject["data"].Count()

                for (var i = 0; i < jsonObject["data"].Count(); i++)
                {
                    AirportLabel.Text += "Airport Name: " + jsonObject["data"][i]["name"] + "<br />";
                    AirportLabel.Text += "Location Name: " + jsonObject["data"][i]["address"]["cityName"] + "<br />";
                    AirportLabel.Text += "Distance from specified coordinates (in km): " + jsonObject["data"][i]["distance"]["value"] + "<br />";
                    AirportLabel.Text += "<br />";
                }

                if (jsonObject["data"].Count() <= 0)
                {
                    AirportLabel.Text += "No airports were found within 500km of these coordinates!!!";
                }
                //PRICE[1] in this case refers to the second element of the JSON object, which does denote the price
            }
            else
            {
                //if your IATA code is incorrectly inputted
                AirportLabel.Text = "Input error!";
            }
            //close the http client
            client.Dispose();
        }


        protected void Logout(object sender, EventArgs e)
        {
            HttpCookie myCookies = Request.Cookies["myCookieId"];
            myCookies["Stay"] = "N";
            Response.Cookies.Add(myCookies);

            Global.loggedIn = false;
            Global.accountName = "Guest";
            Global.status = "Unregistered";
            Response.Redirect("Default.aspx");
        }

        protected void HomeBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }
    }
}