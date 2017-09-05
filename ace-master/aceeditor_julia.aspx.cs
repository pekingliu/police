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

using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.ComponentModel;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using julia.web;
using System.Windows.Forms;
using System.Reflection;


namespace julia.web
{

    public partial class aceeditor_julia : System.Web.UI.Page
    {
        private String filename = "";
        private String filecontent = "";
        private String filepath = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            //filename = Request.QueryString["filename"];
            //filecontent = Request.QueryString["filecontent"];
            //filepath = Request.QueryString["filepath"];
        }
    }
}
