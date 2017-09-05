<%@ WebHandler Language="C#" Class="julia.web.Handler_getfilecontent" %>


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
using System.Windows.Forms;
using System.Reflection;

namespace julia.web
{

    public class Handler_getfilecontent : IHttpHandler
    {

        private String pathf = "";
        private String filec = "";
        public String dir_path = "";
        
        
        
        public void ProcessRequest(HttpContext context)
        {
            
            pathf = context.Request.QueryString["path"];
            pathf = getdir(pathf);
            if (CheckFile(pathf))
            {
               filec = ReadLog(pathf);
            }
            if (filec == "")
            {
                context.Response.Write("//this is you first julia text example! ");
            }
            else
            {
                context.Response.Write(filec);
            }
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
        /// <summary>
        /// 读文件
        /// </summary>
        /// <param name="FilePath">文件路劲</param>
        /// <returns></returns>
        /// 
        public static string ReadLog(string FilePath){ 
            System.IO.StreamReader sr = new System.IO.StreamReader(FilePath , System.Text.Encoding.UTF8);
            String temos = sr.ReadToEnd();
            sr.Close();
            sr.Dispose();
            return temos;
            
        }
        /// <summary>
        /// 检查文件是否存在
        /// </summary>
        /// <param name="FilePath">文件路径</param>
        /// <returns></returns>
        /// 
        public static bool CheckFile(string FilePath){ 
            FileInfo Fi = new FileInfo(FilePath); 
            return Fi.Exists;
        }
        
        public static string ShareRead(string file, Encoding encoding) 
        { 
            string content = string.Empty; 
            FileStream fs = new FileStream(file, FileMode.Open, FileAccess.Read, FileShare.ReadWrite); 
            try 
            { 
                if (fs.CanRead) 
                { 
                    byte[] buffer = new byte[fs.Length]; 
                    fs.Read(buffer, 0, buffer.Length); 
                    content = encoding.GetString(buffer); 
                } 
            } 
            finally 
            { 
                fs.Close(); 
                fs.Dispose(); 
            } 
            return content; 
        } 



        #region 获取当前路径
        private String getdir(string path)
        {
            dir_path = path;
            //获取当前进程的完整路径，包含文件名(进程名)。

            string str = this.GetType().Assembly.Location;
            //result: X:\xxx\xxx\xxx.exe (.exe文件所在的目录+.exe文件名)

            //获取新的 Process 组件并将其与当前活动的进程关联的主模块的完整路径，包含文件名(进程名)。
            str = System.Diagnostics.Process.GetCurrentProcess().MainModule.FileName;
            //result: X:\xxx\xxx\xxx.exe (.exe文件所在的目录+.exe文件名)

            //获取和设置当前目录（即该进程从中启动的目录）的完全限定路径。
            str = System.Environment.CurrentDirectory;
            //result: X:\xxx\xxx (.exe文件所在的目录)

            //获取当前 Thread 的当前应用程序域的基目录，它由程序集冲突解决程序用来探测程序集。
            dir_path = System.AppDomain.CurrentDomain.BaseDirectory + "" + dir_path;
            //result: X:\xxx\xxx\ (.exe文件所在的目录+"\")

            //获取和设置包含该应用程序的目录的名称。
            str = System.AppDomain.CurrentDomain.SetupInformation.ApplicationBase;
            //result: X:\xxx\xxx\ (.exe文件所在的目录+"\")

            //获取启动了应用程序的可执行文件的路径，不包括可执行文件的名称。
            str = System.Windows.Forms.Application.StartupPath;
            //result: X:\xxx\xxx (.exe文件所在的目录)

            //获取启动了应用程序的可执行文件的路径，包括可执行文件的名称。
            str = System.Windows.Forms.Application.ExecutablePath;
            //result: X:\xxx\xxx\xxx.exe (.exe文件所在的目录+.exe文件名)

            //获取应用程序的当前工作目录(不可靠)。
            str = System.IO.Directory.GetCurrentDirectory();
            //result: X:\xxx\xxx (.exe文件所在的目录)
            return dir_path;

        }
        #endregion

    }
}