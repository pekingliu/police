using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using julia.web;

namespace julia.web
{

    public partial class menutree : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //获得此cookie对象 

            HttpCookie cookie = Request.Cookies["username"];
            //检验Cookie是否已经存在 
            if (null == cookie)
            {
                Response.Write("登录违法!!<br><hr>");
                Response.Redirect("login_main.aspx", true);
                return;
            }
        }
    }

}
