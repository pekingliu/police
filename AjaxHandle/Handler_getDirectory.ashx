<%@ WebHandler Language="C#" Class="julia.web.Handler_getDirectory" %>

using System;
using System.Web;
using System.Text;

using System.Data;
using System.Configuration;

using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Collections;
using System.Collections.Generic;


namespace julia.web
{

    public class Handler_getDirectory : IHttpHandler
    {

        private String dir_path = "";
        public uint tree_id = 1;
        public void ProcessRequest(HttpContext context)
        {

            dir_path = System.AppDomain.CurrentDomain.BaseDirectory + "project\\";            
         
            string content = ToJson(dir_path, tree_id);
            context.Response.Write(content); 

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }        
    
        /// <summary>
        /// 返回指定目录下的所有文件信息，首先递归下层目录，递归返回时处理本层文件；
        /// </summary>
        /// <param name="strDirectory">目录字符串</param>
        /// <param name="jsonBuilder">全局json字符串</param>
        /// <param name="brotherid">本层第一个ID号</param>
        /// <returns></returns>
        public static List<FileInfo> GetAllFilesInDirectory(string strDirectory,StringBuilder jsonBuilder,uint brotherid)
        {
            List<FileInfo> listFiles = new List<FileInfo>(); //保存所有的文件信息  
            DirectoryInfo directory = new DirectoryInfo(strDirectory);
            DirectoryInfo[] directoryArray = directory.GetDirectories();
            FileInfo[] fileInfoArray = directory.GetFiles();            
            
            uint id_brother = brotherid;      
            jsonBuilder.Append(":[");
             
            //递归子目录文件
            if (directoryArray.Length > 0)
            {               
                foreach (DirectoryInfo _directoryInfo in directoryArray)
                {
                    id_brother++;      
                    jsonBuilder.Append("{");
                    jsonBuilder.Append("\"id\":\"" + id_brother + "\",");     
                    jsonBuilder.Append("\"text\":\"" + _directoryInfo.Name + "\",");       
                    jsonBuilder.Append("\"children\"");
                    String subdir = _directoryInfo.FullName;                    
                    DirectoryInfo directoryA = new DirectoryInfo(subdir);
                    DirectoryInfo[] directoryArrayA = directoryA.GetDirectories();
                    FileInfo[] fileInfoArrayA = directoryA.GetFiles();

                    if (directoryArrayA.Length > 0 || fileInfoArrayA.Length > 0)
                    {
                        GetAllFilesInDirectory(subdir, jsonBuilder, id_brother * 100);//如果存在子目录，首先递归到子目录
                    }
                    else
                    {
                        jsonBuilder.Append(":[");
                        jsonBuilder.Append("]");  
                        
                    }
                    //jsonBuilder.Remove(jsonBuilder.Length-1, 1);
                    jsonBuilder.Append("},");
                }
                if (fileInfoArray.Length < 1)
                {
                    jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                    jsonBuilder.Append("]");
                }                          
            }
            //添加兄弟节点的文件           
            if (fileInfoArray.Length > 0)
            {
                foreach (FileInfo _fileInfoArray in fileInfoArray)
                {
                    id_brother++;
                    jsonBuilder.Append("{");
                    jsonBuilder.Append("\"id\":\"" + id_brother + "\",");
                    jsonBuilder.Append("\"text\":\"" + _fileInfoArray.Name + "\",");
                    jsonBuilder.Append("\"attributes\":{\"url\":\"ace-master/aceeditor_julia.aspx\"}");
                    jsonBuilder.Append("},");
                }
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                jsonBuilder.Append("]");
            }

            
            return listFiles;
        }
        /// <summary>      
        /// 目录树转换成Json格式      
        /// </summary>      
        /// <param name="dt"></param>      
        /// <returns></returns>      
        public static String ToJson(String str_path,uint rootid)
        {
            
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.Append("{\"");
            jsonBuilder.Append("basic\"");
                jsonBuilder.Append(":[");
                        jsonBuilder.Append("{");
                        jsonBuilder.Append("\"id\":\"1\",");
                        jsonBuilder.Append("\"parentid\":\"-1\",");
                        jsonBuilder.Append("\"text\":\"project\",");
                        jsonBuilder.Append("\"iconCls\":\"\",");
                        jsonBuilder.Append("\"attributes\":{\"url\":\"\"},");
                        jsonBuilder.Append("\"checked\":\"\",");
                        jsonBuilder.Append("\"isFolder\":\"\",");
                        jsonBuilder.Append("\"isLeaf\":\"\",");
                        jsonBuilder.Append("\"orderNum\":\"\","); 
                        jsonBuilder.Append("\"children\""); 

                        GetAllFilesInDirectory(str_path,jsonBuilder,rootid * 100);                        
                      
                        jsonBuilder.Append("}");            
                jsonBuilder.Append("]");
            jsonBuilder.Append("}");
            return jsonBuilder.ToString();
        }
        //private 

    }
}