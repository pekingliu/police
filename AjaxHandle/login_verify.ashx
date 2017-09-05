<%@ WebHandler Language="C#" Class="julia.web.login_verify" %>
using System;
using System.Web;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using System.IO;


namespace julia.web
{
    public class login_verify : IHttpHandler
    {
        private DataTable dt_tree = new DataTable();
        private DataSet ds_tree = new DataSet();
        private String userName = "";
        private String userPwd = "";
        public static LinkDataBase linkdb = new LinkDataBase();
        //获取网页传递参数，生成jason数据
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.ContentType = "application/json";
            userName = context.Request.Form["login"].ToString();
            userPwd = context.Request.Form["password"].ToString();
            context.Response.ContentType = "text/plain";
            String result_string = CheckLogin(userName,userPwd);
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.Append("{\"flag\":\"" + result_string + "\",\"username\":\"" + userName + "\"}");
            context.Response.Write(jsonBuilder);

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }        
        //根据用户名和密码判断是否登录成功
        private string CheckLogin(string uname, string upwd)
        {

            DataTable dt = getname(uname, upwd);        
            if (dt.Rows.Count > 0)
            {
                return "0";//登录成功
            }
            else
                return "1";
        }
        //获取用户名和登录密码
        private static DataTable getname(String loginid,String pass)
        {
            string sql = "SELECT * FROM USERS where username = '"+ loginid  +"' and userpassword = '"+ pass +"'";
            DataTable dt_temp = linkdb.SelectDataBase(sql);
            return dt_temp;
        }

    }
}