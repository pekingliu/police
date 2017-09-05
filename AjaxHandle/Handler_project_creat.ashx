<%@ WebHandler Language="C#" Class="julia.web.Handler_project_creat" %>


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

    public class Handler_project_creat : IHttpHandler
    {
        private DataTable dt_tree = new DataTable();
        private DataSet ds_tree = new DataSet();
        private String flag = "";
        private String path_in = "";
        private String path_old = "";
        private String path_new = "";
        //private String userPwd = "";
        public static LinkDataBase linkdb = new LinkDataBase();
        public String dir_path = "";
        public static string sApplicationPath = Assembly.GetExecutingAssembly().Location;

        public void ProcessRequest(HttpContext context)
        {
            //获取传递来的参数
            //userName = context.Request.Form["username"].ToString();
            flag = context.Request.QueryString["flag"];
            path_in = context.Request.QueryString["path"];
            if (flag == "4")
            {
                path_old = context.Request.QueryString["oldpath"];
                path_new = context.Request.QueryString["newpath"];
            }
            String temp_path = getdir(path_in);
            
            if(flag == "0")
            {
                createdir(temp_path);
            }else if(flag =="1")
            {
                createfile(temp_path);
            }else if(flag == "3")
            {
                delfile(temp_path);
            }else if (flag == "4")
            {
                renamefile(getdir(path_old), getdir(path_new));            
            }           
            
            //string sql = " SELECT *  FROM USERS ";
            //dt_tree = linkdb.SelectDataBase(sql);
            //string content = ToJson(dt_tree);
            //context.Response.Write(content);            

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        private void renamefile(String oldp,String newp)
        {
            if (oldp != newp)
            {
                if (Directory.Exists(oldp))//判断是否是目录        
                {
                    try
                    {
                        //第二参数为false时，只能删除空目录，否则抛出不为空异常
                        //第二参数为true时，删除目录，包括子目录和文件
                        DirectoryInfo info = new DirectoryInfo(oldp);
                        if (info != null) { info.MoveTo(newp); } 
                    }
                    catch (System.IO.IOException e)
                    {
                        Console.WriteLine(e.Message);
                    }
                }
                else if (File.Exists(oldp))//判断是否是文件        
                {
                    try
                    {
                        File.Move(oldp, newp);
                    }
                    catch (System.IO.IOException e)
                    {
                        Console.WriteLine(e.Message);
                    }
                } 
            }       
        
        }
       
        private void delfile(String path_dir)
        {
            if (Directory.Exists(path_dir))//判断是否目录存在        
            {
                try
                {
                    //第二参数为false时，只能删除空目录，否则抛出不为空异常
                    //第二参数为true时，删除目录，包括子目录和文件
                    Directory.Delete(path_dir, true);
                }
                catch (System.IO.IOException e)
                {
                    Console.WriteLine(e.Message);
                }
            }
            else if (File.Exists(path_dir))//判断是否文件存在        
            {
                try
                {
                    File.Delete(path_dir);
                }
                catch (System.IO.IOException e)
                {
                    Console.WriteLine(e.Message);
                }            
            }    
        
        }

        private void createdir(String path_dir)
        {
            if (Directory.Exists(path_dir))//判断是否存在        
            {            
                //Response.Write("已存在");        
            }        
            else        
            {            
                //Response.Write("不存在，正在创建");
                DirectoryInfo floder = Directory.CreateDirectory(path_dir);//创建新路径        
            }               
        }
        private void createfile(String path_dir)
        {
            if (File.Exists(path_dir)) 
            {
                //Response.Write("已存在");        
            }
            else
            {
                //Response.Write("不存在，正在创建");
                File.Create(path_dir);      
            }
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