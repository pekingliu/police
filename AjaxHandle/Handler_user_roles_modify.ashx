<%@ WebHandler Language="C#" Class="julia.web.Handler_user_roles_modify" %>

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
    public class Handler_user_roles_modify : IHttpHandler
    {

        public static LinkDataBase linkdb = new LinkDataBase();
        private DataTable dt_tree = new DataTable();
        private DataSet ds_tree = new DataSet();
        private String func_rownum_user = "";
        private String func_rowname_role = "";
        private String func_flag = "";
        private String[] id;
        
        
        public void ProcessRequest(HttpContext context)
        {
            //获取传递来的参数
            func_rownum_user = context.Request.Form["userid"].ToString();
            func_rowname_role = context.Request.Form["roleid"].ToString();
            func_flag = context.Request.Form["flag"].ToString();


            if (func_rowname_role != "")
            {
                id = func_rowname_role.Split(',');
                try
                {
                    checkdg();
                    checkdb(id);
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
            else
            {
                updatedb(func_rownum_user, "all", "delall");
                string content = "[{\"flag\":\"success\"},{\"result\":\"ok\"}]";
                context.Response.ContentType = "text/plain";
                context.Response.Write(content);
            
            }
        }
        /// <summary>
        /// 判定是否添加了rolefunc
        /// </summary>
        private void checkdg()
        {

            for (int i = 0; i < id.Length; i++)
            {
                string ttt = id[i];
                if (!ifexit(func_rownum_user, id[i]))
                {
                    updatedb(func_rownum_user, id[i], "insert");
                }
            }
        }
        /// <summary>
        /// 判定是否删除了rolefunc
        /// </summary>
        private void checkdb(String[] delid)
        {

            DataTable dt_getrolefunc = getuserroles(func_rownum_user);
            if (dt_getrolefunc.Rows.Count > 0)
            {
                for (int i = 0; i < dt_getrolefunc.Rows.Count; i++)
                {
                    String tempid = dt_getrolefunc.Rows[i]["ROLENUM"].ToString(); ;
                    if (!ifexitid(tempid, delid))
                    {
                        updatedb(func_rownum_user, tempid, "del");
                    }
                }
            }
        }
        private static DataTable getuserroles(String num)
        {
            string sql = " SELECT * FROM USERROLES  WHERE USERNUM = " + num;
            DataTable dt_temp = linkdb.SelectDataBase(sql);
            return dt_temp;
        }
            

        /*
         判定'功能树'<->'角色树'是否存在         
         */
        private static bool ifexitid(String funcid, String[] id)
        {
            int countnum = 0;
            for (int i = 0; i < id.Length; i++)
            {
                if (id[i] == funcid) countnum++;
            }
            if (countnum > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        /*
        /*
         判定'功能树'<->'角色树'是否存在         
         */
        private static bool ifexit(String usernum, String id)
        {
            string sql = " SELECT * FROM USERROLES  WHERE USERNUM = " + usernum + " AND ROLENUM = " + id;
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
        private static void updatedb(String rolenum, String id,String flag)
        {
            String sql="";            
            if (flag == "insert") { sql = " INSERT INTO USERROLES   (USERNUM, ROLENUM)  VALUES (" + rolenum + "," + id + ")"; }
            if (flag == "del") { sql = " DELETE FROM USERROLES WHERE (USERNUM =" + rolenum + ") AND (ROLENUM = " + id + ")"; }
            if (flag == "delall") { sql = " DELETE FROM USERROLES WHERE (USERNUM =" + rolenum + " ) "; }
            //if (flag == "update") { sql = " UPDATE ROLES SET ROLENAME = '" + id + "' WHERE (ROLENUM  = " + rolenum + ") "; }
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