<%@ WebHandler Language="C#" Class="julia.web.Handler_rolesmodify" %>

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
using Newtonsoft.Json.Serialization;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
namespace julia.web
{
    public class Handler_rolesmodify : IHttpHandler
    {
        //private String userPwd = "";
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
                if(func_flag=="insert")
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
            string sql = " SELECT * FROM ROLES  WHERE ROLENUM = " + rolenum ;
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
        #region  解析json字符串，生成json数组，并读取数据，用于多行更新
        private void modifydb(string rownum, string roleflag)
        {
            Roles _list = JsonConvert.DeserializeObject<Roles>(rownum);
            for (int i = 0; i < _list.Count; i++)
            {
                String rolenum = "";
                String rolename = "";
                Dictionary<string, string> _dictionary = JsonConvert.DeserializeObject<Dictionary<string, string>>(_list[i].ToString());
                foreach (KeyValuePair<string, string> kp in _dictionary)
                {
                    Console.WriteLine(kp.Key + ":" + kp.Value);
                    if (kp.Key == "ROLENUM") rolenum = kp.Value;
                    if (kp.Key == "ROLENAME") rolename = kp.Value;
                }
                updatedb(rolenum, rolename, roleflag);
            }
        }
        #endregion
        /*
         更新'功能树'<->'角色树'rolesfunc         
         */
        private static void updatedb(String rolenum, String id,String flag)
        {
            String sql="";
            if (flag == "insert") { sql = " INSERT INTO ROLES   (ROLENUM, ROLENAME)  VALUES (" + rolenum + ",'" + id + "')"; }
            if (flag == "del") { sql = " DELETE FROM ROLES WHERE (ROLENUM =" + rolenum + ") "; }
            if (flag == "update") { sql = " UPDATE ROLES SET ROLENAME = '" + id + "' WHERE (ROLENUM  = " + rolenum + ") "; }
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
    [Serializable]
    [JsonObject(MemberSerialization.OptIn)] 
    public class User : List<Object>
    {
        [JsonProperty] 
        public string name{ set { name = value;} get{ return name; } }
        [JsonProperty] 
        public string age{ set{age = value;} get{ return age; }}
    }
    //定义类，用于泛型变量，List<T>,T即为类型
    public class Roles : List<Object>    {      
        public String ROLENUM { set { ROLENUM = value; } get { return ROLENUM; } }
        public String ROLENAME { set { ROLENAME = value; } get { return ROLENAME; } }
    } 

}