<%@ WebHandler Language="C#" Class="julia.web.Handler_userget" %>

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

    public class Handler_userget : IHttpHandler
    {
        private DataTable dt_tree = new DataTable();
        private DataSet ds_tree = new DataSet();
        private String userName = "";
        //private String userPwd = "";
        public static LinkDataBase linkdb = new LinkDataBase();
        
        
        public void ProcessRequest(HttpContext context)
        {
            string sql = " SELECT *  FROM USERS ";     
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
            string sql = " SELECT * FROM treefuncdic  WHERE parentid = -3";
            DataTable dt_temp = linkdb.SelectDataBase(sql);
            return dt_temp;
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
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
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
                    else
                    {
                        jsonBuilder.Append("\":\"");
                        jsonBuilder.Append(dt.Rows[i][j].ToString());
                        jsonBuilder.Append("\",");
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
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
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
                    else
                    {
                        jsonBuilder.Append("\":\"");
                        jsonBuilder.Append(dt.Rows[i][j].ToString());
                        jsonBuilder.Append("\",");
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
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
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
                    else
                    {
                        jsonBuilder.Append("\":\"");
                        jsonBuilder.Append(dt.Rows[i][j].ToString());
                        jsonBuilder.Append("\",");
                    }
                }
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                jsonBuilder.Append("},");
            }

        }

    }
}