using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Xml;
//using DBLayer;


namespace julia.web
{
    public partial class welcome_print : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string userID = Request.QueryString["name"].ToString();
            string userPassword = Request.QueryString["pass"].ToString();
            //  Server.UrlDecode(Request.QueryString["name"]).ToString();  
            //string name = Context.Request.QueryString["pass"].ToString();    //Server.UrlDecode(Request.QueryString["pass"]).ToString();   
            this.Label2.Text = userID;
            this.Label3.Text = userPassword;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //Response.Write("<script>alert('密码：123456')<script>");
        }
    }
}
