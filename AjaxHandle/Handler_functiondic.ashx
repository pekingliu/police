<%@ WebHandler Language="C#" Class="julia.web.Handler_functiondic" %>
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
    public class Handler_functiondic : IHttpHandler
    {
        private DataTable dt_tree = new DataTable();
        private DataSet ds_tree = new DataSet();
        //private String userName = "";
        //private String userPwd = "";
        public static LinkDataBase linkdb = new LinkDataBase();
        public void ProcessRequest(HttpContext context)
        {
            //获取传递来的参数
            //userName = context.Request.Form["username"].ToString();

            string sql =
            " SELECT * " +
            " FROM treefuncdic " +
            " WHERE parentid = -1"+
            " order by trid ";  //"+
            /*"(id IN " +
                      " (SELECT DISTINCT id AS ia " +
                     " FROM ROLESFUNC " +
                     " WHERE (ROLENUM IN " +
                               " (SELECT USERROLES.ROLENUM " +
                              " FROM USERROLES INNER JOIN " +
                                    " USERS ON USERROLES.USERNUM = USERS.USERNUM " +
                              " WHERE (USERS.USERNAME = '" + userName + "'))))) and parentid = -1";*/


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


        ///// <summary>      
        ///// DataSet转换成Json格式      
        ///// </summary>      
        ///// <param name="ds">DataSet</param>      
        ///// <returns></returns>      
        //public static string ToJson(DataSet ds)
        //{
        //    StringBuilder json = new StringBuilder();

        //    foreach (DataTable dt in ds.Tables)
        //    {
        //        json.Append("{\"");
        //        json.Append(dt.TableName);
        //        json.Append("\":");
        //        json.Append(ToJson(dt));
        //        json.Append("}");
        //    }
        //    return json.ToString();
        //}
        /// <summary>    
        /// 根据DataTable生成Json树结构    
        /// </summary>    
        /// <param name="tabel">数据源</param>   
        /// <param name="idCol">ID列</param>    
        /// <param name="txtCol">Text列</param>    
        /// <param name="rela">关系字段</param>    
        /// <param name="pId">父ID</param>    
        //StringBuilder result = new StringBuilder();
        //StringBuilder sb = new StringBuilder();
        //private void GetTreeJsonByTable(DataTable tabel, string idCol, string txtCol, string rela, object pId)
        //{

        //    //result.Append(sb.ToString());
        //    //sb.Clear();
        //    //if (tabel.Rows.Count > 0)
        //    //{
        //    //    sb.Append("[");
        //    //    string filer = string.Format("{0}='{1}'", rela, pId);
        //    //    DataRow[] rows = tabel.Select(filer);
        //    //    if (rows.Length > 0)
        //    //    {
        //    //        foreach (DataRow row in rows)
        //    //        {
        //    //            sb.Append("{\"id\":\"" + row[idCol] + "\",\"text\":\"" + row[txtCol] + "\",\"state\":\"open\"");
        //    //            if (tabel.Select(string.Format("{0}='{1}'", rela, row[idCol])).Length > 0)
        //    //            {
        //    //                sb.Append(",\"children\":");
        //    //                GetTreeJsonByTable(tabel, idCol, txtCol, rela, row[idCol]);
        //    //                result.Append(sb.ToString());
        //    //                sb.Clear();
        //    //            }
        //    //            result.Append(sb.ToString());
        //    //            sb.Clear();
        //    //            sb.Append("},");
        //    //        }
        //    //        sb = sb.Remove(sb.Length - 1, 1);
        //    //    }
        //    //    sb.Append("]");
        //    //    result.Append(sb.ToString());
        //    //    sb.Clear();
        //    //}
        //}




    }

}