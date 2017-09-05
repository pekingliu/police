<%@ WebHandler Language="C#" Class="julia.web.Handler_rolesfunc" %>

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

///
/// Handler_rolesfunc函数从数据库读取功能树（treefuncdic表），
/// 并根据角色权限表（ROLESFUNC表），
/// 判定树的check状态，
/// 形成含check状态的树json；
///
namespace julia.web
{
    public class Handler_rolesfunc : IHttpHandler
    {

        private DataTable dt_tree = new DataTable();
        private DataSet ds_tree = new DataSet();
        //private String userName = "";
        public static String rolenum = "";
        //private String userPwd = "";
        public static LinkDataBase linkdb = new LinkDataBase();

        public void ProcessRequest(HttpContext context)
        {

            //获取传递来的参数
            rolenum = context.Request.QueryString["id"];
            //rolenum = "1";
            string sql =
            " SELECT * " +
            " FROM treefuncdic " +
            " WHERE parentid = -1"; 
            /*
            " SELECT * " +
            " FROM treefuncdic " +
            " WHERE (id IN " +
                      " (SELECT DISTINCT id AS ia " +
                     " FROM ROLESFUNC " +
                     " WHERE ROLENUM = " + rolenum + ")) and parentid = -1";
             */
            dt_tree = linkdb.SelectDataBase(sql);
            string content = ToJson(dt_tree);
            context.Response.Write(content);
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
        private static DataTable getchildtree(String id)
        {
            string sql = " SELECT * FROM treefuncdic  WHERE parentid = " + id + " ";
           /* " SELECT * " +
           " FROM treefuncdic " +       
           " WHERE (id IN " +
                     " (SELECT DISTINCT id AS ia " +
                    " FROM ROLESFUNC " +
                    " WHERE ROLENUM = " + rolenum + " )) and parentid =" + id ;*/
            DataTable dt_temp = linkdb.SelectDataBase(sql);
            return dt_temp;
        }
        /*
         判定'功能树'->'角色树'的check状态         
         */
        private static bool ifcheck(String id) 
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
        ///
        /// 判定是否有孩子节点
        ///
        private static bool haschild(String id)
        {
            string sql = " SELECT * FROM treefuncdic  WHERE parentid = " + id + " ";
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

        /// <summary>      
        /// dataTable转换成Json格式      
        /// </summary>      
        /// <param name="dt"></param>      
        /// <returns></returns>      
        public static String ToJson(DataTable dt)
        {
            StringBuilder jsonBuilder = new StringBuilder();
            // jsonBuilder.Append("{\"");
            // jsonBuilder.Append("basic");
            // jsonBuilder.Append("\":[");
            jsonBuilder.Append("[");
            childtojson_1(jsonBuilder, dt);
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("]");
            // jsonBuilder.Append("}");
            return jsonBuilder.ToString();
        }
        //父层节点
        private static void childtojson_1(StringBuilder jsonBuilder, DataTable dt)
        {
            //行数，记录数
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)   //列数，字段数
                {
                    string cname = dt.Columns[j].ColumnName;
                    jsonBuilder.Append("\"");
                    if (cname == "trid")
                    {
                        jsonBuilder.Append("id");
                    }
                    else
                    {
                        jsonBuilder.Append(cname);
                    }
                    //jsonBuilder.Append("\":\"");
                    if (dt.Columns[j].ColumnName == "attributes")
                    {
                        jsonBuilder.Append("\":\"");
                        jsonBuilder.Append(dt.Rows[i][j].ToString());
                        jsonBuilder.Append("\",");
                    }
                    else if (haschild(dt.Rows[i][0].ToString()))                        
                    {                                          
                        jsonBuilder.Append("\":\"");
                        jsonBuilder.Append(dt.Rows[i][j].ToString());
                        jsonBuilder.Append("\",");
                    }
                    else
                    {
                        if (dt.Columns[j].ColumnName == "checked")
                        {
                            string tteset = dt.Rows[i][0].ToString();
                            if (ifcheck(dt.Rows[i][0].ToString()))
                            {
                                jsonBuilder.Append("\":\"");
                                jsonBuilder.Append("true");
                                jsonBuilder.Append("\",");
                            }
                            else
                            {
                                jsonBuilder.Append("\":\"");
                                string rrtt = dt.Rows[i][j].ToString();
                                jsonBuilder.Append(dt.Rows[i][j].ToString());
                                jsonBuilder.Append("\",");
                            }
                        }
                        else {
                            jsonBuilder.Append("\":\"");
                            jsonBuilder.Append(dt.Rows[i][j].ToString());
                            jsonBuilder.Append("\",");                        
                        }
                    }
                    
                }
                DataTable dt_children = getchildtree(dt.Rows[i][0].ToString());
                if (dt_children.Rows.Count > 0)
                {
                    jsonBuilder.Append("\"children");
                    jsonBuilder.Append("\":[");
                    childtojson_2(jsonBuilder, dt_children);
                    jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                    jsonBuilder.Append("]},");
                    //jsonBuilder.Append("},");
                }
                else
                {
                    jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                    jsonBuilder.Append("},");
                }
            }

        }
        //一级子节点
        private static void childtojson_2(StringBuilder jsonBuilder, DataTable dt)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    string cname = dt.Columns[j].ColumnName;
                    jsonBuilder.Append("\"");
                    if (cname == "trid")
                    {
                        jsonBuilder.Append("id");
                    }
                    else
                    {
                        jsonBuilder.Append(cname);
                    }
                    //jsonBuilder.Append("\":\"");
                    if (dt.Columns[j].ColumnName == "attributes")
                    {
                        //jsonBuilder.Append("\":");
                        //jsonBuilder.Append("{\"url\":\"" + dt.Rows[i][j].ToString());
                        //jsonBuilder.Append("\"},");
                        jsonBuilder.Append("\":\"");
                        jsonBuilder.Append(dt.Rows[i][j].ToString());
                        jsonBuilder.Append("\",");
                    }
                    else if (haschild(dt.Rows[i][0].ToString()))
                    {
                        jsonBuilder.Append("\":\"");
                        jsonBuilder.Append(dt.Rows[i][j].ToString());
                        jsonBuilder.Append("\",");
                    }
                    else
                    {
                        if (dt.Columns[j].ColumnName == "checked")
                        {
                            string tteset = dt.Rows[i][0].ToString();
                            if (ifcheck(dt.Rows[i][0].ToString()))
                            {
                                jsonBuilder.Append("\":\"");
                                jsonBuilder.Append("true");
                                jsonBuilder.Append("\",");
                            }
                            else
                            {
                                jsonBuilder.Append("\":\"");
                                string rrtt = dt.Rows[i][j].ToString();
                                jsonBuilder.Append(dt.Rows[i][j].ToString());
                                jsonBuilder.Append("\",");
                            }
                        }
                        else
                        {
                            jsonBuilder.Append("\":\"");
                            jsonBuilder.Append(dt.Rows[i][j].ToString());
                            jsonBuilder.Append("\",");
                        }
                    }

                }
                DataTable dt_children = getchildtree(dt.Rows[i][0].ToString());
                if (dt_children.Rows.Count > 0)
                {
                    jsonBuilder.Append("\"children");
                    jsonBuilder.Append("\":[");
                    childtojson_3(jsonBuilder, dt_children);
                    jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                    jsonBuilder.Append("],");
                    //jsonBuilder.Append("},");
                }
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                jsonBuilder.Append("},");
            }
        }
        private static void childtojson_3(StringBuilder jsonBuilder, DataTable dt)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    string cname = dt.Columns[j].ColumnName;
                    jsonBuilder.Append("\"");
                    if (cname == "trid")
                    {
                        jsonBuilder.Append("id");
                    }
                    else
                    {
                        jsonBuilder.Append(cname);
                    }                    
                    if (dt.Columns[j].ColumnName == "attributes")
                    {
                        //jsonBuilder.Append("\":");
                        //jsonBuilder.Append("{\"url\":\"" + dt.Rows[i][j].ToString());
                        //jsonBuilder.Append("\"},");
                        jsonBuilder.Append("\":\"");
                        jsonBuilder.Append(dt.Rows[i][j].ToString());
                        jsonBuilder.Append("\",");
                    }
                    else if (haschild(dt.Rows[i][0].ToString()))
                    {
                        jsonBuilder.Append("\":\"");
                        jsonBuilder.Append(dt.Rows[i][j].ToString());
                        jsonBuilder.Append("\",");
                    }
                    else
                    {
                        if (dt.Columns[j].ColumnName == "checked")
                        {
                            string tteset = dt.Rows[i][0].ToString();
                            if (ifcheck(dt.Rows[i][0].ToString()))
                            {
                                jsonBuilder.Append("\":\"");
                                jsonBuilder.Append("true");
                                jsonBuilder.Append("\",");
                            }
                            else
                            {
                                jsonBuilder.Append("\":\"");
                                string rrtt = dt.Rows[i][j].ToString();
                                jsonBuilder.Append(dt.Rows[i][j].ToString());
                                jsonBuilder.Append("\",");
                            }
                        }
                        else
                        {
                            jsonBuilder.Append("\":\"");
                            jsonBuilder.Append(dt.Rows[i][j].ToString());
                            jsonBuilder.Append("\",");
                        }
                    }
                }
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                jsonBuilder.Append("},");
            }

        }


    }
}