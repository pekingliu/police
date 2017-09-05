<%@ WebHandler Language="C#" Class="julia.web.Handler_functiondic_insertdb" %>

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



namespace julia.web
{

    public class Handler_functiondic_insertdb : IHttpHandler
    {

        private DataTable dt_tree = new DataTable();
        private DataSet ds_tree = new DataSet();
        private String func_id = "";
        private String func_parentid = "";
        private String func_text = "";
        private String func_icons = "";
        private String func_attributes = "";
        private String func_state = "";
        private String func_checked = "";
        private String func_flag = "";
        private int returnfalg = 0;
        private ArrayList List = new ArrayList();
        //string[] sArray = new  string();
 

        
        //private String userPwd = "";
        public static LinkDataBase linkdb = new LinkDataBase();
        
        public void ProcessRequest(HttpContext context)
        {
            //获取传递来的参数
            func_id = context.Request.Form["id"].ToString();
            func_parentid = context.Request.Form["parentid"].ToString();
            func_text = context.Request.Form["text"].ToString();
            func_icons = context.Request.Form["icons"].ToString();
            func_attributes = context.Request.Form["attributes"].ToString();
            func_state = context.Request.Form["state"].ToString();
            func_checked = context.Request.Form["checked"].ToString();
            func_flag = context.Request.Form["flag"].ToString();

            string sql = "";
            if(func_flag=="insert"){            
                   sql =  " INSERT INTO treefuncdic "+
                          " (trid, parentid, text, state, iconCls, attributes, checked, isFolder, isLeaf, orderNum) "+
                    " VALUES (" + func_id + "," + func_parentid + ",'" + func_text + "','" + func_state + "','"
                               + func_icons + "','" + func_attributes + "',null,null,null,null)";
            }
            if (func_flag == "update") {
                sql =" UPDATE treefuncdic " +
                     " SET trid =" + func_id + ", parentid =" + func_parentid + "," +
                     //" text ='" + func_text + "', state ='" + func_state + "', " +
                     " text ='" + func_text + "', " +
                     " iconCls ='" + func_icons + "', attributes ='" + func_attributes + "', " +
                     " checked = null " + ", " +
                     " isFolder = null, isLeaf = null,orderNum = null "+
                     " where trid = " + func_id;            
            }
            if (func_flag == "delete")
            {
                int i=0;
                string tempsql="";
                string[] sArray = func_text.Split(',');
                foreach (string id in sArray){
                    i++;
                    if (i < sArray.Length)
                    {
                        tempsql = tempsql + " trid = "+id +" or ";
                    }
                    else
                    {
                        tempsql = tempsql + " trid = " +id;                    
                    }
                }
                sql = " DELETE FROM treefuncdic where" + tempsql;
                   //  " where id = " + func_id;
                //sql = "select * from treefuncdic";
            }            
            try
            {
                returnfalg = linkdb.UpdateDataBase(sql);
                string content = "[{\"flag\":\"success\"},{\"result\":\"ok\"}]";
                context.Response.ContentType = "text/plain";
                context.Response.Write(content);

            }
            catch (Exception ee)
            {
                string content = "[{\"flag\":\"false\"},{\"result\":\""+ee+"\"}]";
                context.Response.ContentType = "text/plain";
                context.Response.Write(content);
            }            
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