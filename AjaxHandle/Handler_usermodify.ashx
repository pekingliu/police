<%@ WebHandler Language="C#" Class="julia.web.Handler_usermodify" %>

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
using julia.web;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters;
using System.Collections.Generic;



namespace julia.web
{
    

    public class Handler_usermodify : IHttpHandler
    {

        //private String userPwd = ""
        public static LinkDataBase linkdb = new LinkDataBase();
        private DataTable dt_tree = new DataTable();
        private DataSet ds_tree = new DataSet();
        private String func_rownum = "";
        private String func_rowname = "";
        private String func_flag = "";
        //private String[] id;

        public void ProcessRequest(HttpContext context)
        {
            //获取传递来的参数
            func_rownum = context.Request.Form["rownum"].ToString();
            func_rowname = context.Request.Form["rolename"].ToString();
            func_flag = context.Request.Form["flag"].ToString();

            try
            {
                if (func_flag == "insert")
                {
                    if (ifexit(func_rownum))
                    {
                        updatedb(func_rownum, func_rowname, "update");
                    }
                    else
                    {
                        updatedb(func_rownum, func_rowname, "insert");
                    }

                }
                if (func_flag == "del")
                {
                    updatedb(func_rownum, func_rowname, "del");
                }
                string content = "[{\"flag\":\"success\"},{\"result\":\"ok\"}]";
                context.Response.ContentType = "text/plain";
                context.Response.Write(content);
            }
            catch (Exception ee)
            {
                string content = "[{\"flag\":\"over\"},{\"result\":\"" + ee + "\"}]";
                context.Response.ContentType = "text/plain";
                context.Response.Write(content);
            }
            
            
        }
        /*
         判定'功能树'<->'角色树'是否存在         
         */
        private static bool ifexit(String rolenum)
        {
            string sql = " SELECT * FROM USERS  WHERE USERNUM  = " + rolenum;
            DataTable dt_temp = linkdb.SelectDataBase(sql);
            if (dt_temp.Rows.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        /*
         更新'功能树'<->'角色树'rolesfunc         
         */
        private static void updatedb(String rolenum, String id, String flag)
        {
            String sql = "";
            if (flag == "insert") { sql = " INSERT INTO USERS   (USERNUM, USERNAME,USERPASSWORD )  VALUES (" + rolenum + ",'" + id + "','123456')"; }
            if (flag == "del") { sql = " DELETE FROM USERS WHERE (USERNUM =" + rolenum + ") "; }
            if (flag == "update") { sql = " UPDATE USERS SET USERNAME = '" + id + "' WHERE (USERNUM  = " + rolenum + ") "; }
            linkdb.UpdateDataBase(sql);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

    }
}