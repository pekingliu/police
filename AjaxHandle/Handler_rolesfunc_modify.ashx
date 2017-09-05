<%@ WebHandler Language="C#" Class="julia.web.Handler_rolesfunc_modify" %>


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

    public class Handler_rolesfunc_modify : IHttpHandler
    {
        //private String userPwd = "";
        public static LinkDataBase linkdb = new LinkDataBase();
        private DataTable dt_tree = new DataTable();
        private DataSet ds_tree = new DataSet();
        private String func_rownum = "";
        private String func_id = "";
        private String[] id;
        
        
        public void ProcessRequest(HttpContext context)
        {
            //获取传递来的参数
            func_rownum = context.Request.Form["rownum"].ToString();
            func_id = context.Request.Form["id"].ToString();
            if (func_id != "")
            {
                id = func_id.Split(',');
                try
                {
                    checktree();
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
                updatedb(func_rownum, "all", "delall");
                string content = "[{\"flag\":\"success\"},{\"result\":\"ok\"}]";
                context.Response.ContentType = "text/plain";
                context.Response.Write(content);
            }
            
        }
        /// <summary>
        /// 判定是否添加了rolefunc
        /// </summary>
        private void checktree()
        {

            for (int i = 0; i < id.Length; i++)
            {
                string ttt = id[i];
                if (!ifexit(func_rownum, id[i]))
                {
                    updatedb(func_rownum, id[i], "insert");
                }
            }        
        }
        /// <summary>
        /// 判定是否删除了rolefunc
        /// </summary>
        private void checkdb(String[] delid)
        {

            DataTable dt_getrolefunc = getrolefunc(func_rownum);
            if (dt_getrolefunc.Rows.Count > 0)
            {
                for (int i = 0; i < dt_getrolefunc.Rows.Count; i++)
                {
                    String tempid = dt_getrolefunc.Rows[i]["trid"].ToString(); ;
                    if (!ifexitid(tempid, delid))
                    {
                        updatedb(func_rownum, tempid, "del");
                    }
                }
            } 
        }
        private static DataTable getrolefunc(String rolenum)
        {
            string sql = " SELECT * FROM ROLESFUNC  WHERE ROLENUM = " + rolenum ;      
            DataTable dt_temp = linkdb.SelectDataBase(sql);
            return dt_temp;
        }
        /*
         判定'功能树'<->'角色树'是否存在         
         */
        private static bool ifexitid(String funcid,String[] id)
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
         判定'功能树'<->'角色树'是否存在         
         */
        private static bool ifexit(String rolenum, String id)
        {
            string sql = " SELECT * FROM ROLESFUNC  WHERE ROLENUM = " + rolenum + " AND trid = " + id;
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
            if (flag == "insert") { sql = " INSERT INTO ROLESFUNC   (ROLENUM, trid)  VALUES (" + rolenum + "," + id + ")"; }
            if (flag == "del") { sql = " DELETE FROM ROLESFUNC WHERE (ROLENUM =" + rolenum + " ) AND (trid = " + id + ") "; }
            if (flag == "delall") { sql = " DELETE FROM ROLESFUNC WHERE (ROLENUM =" + rolenum + " ) "; }
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