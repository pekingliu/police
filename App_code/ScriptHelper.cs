using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text;
/// <summary>
/// ScriptHelper_ 的摘要说明
/// 页面自动滚动到控件位置，
/// zhangld 20090604
/// </summary>

namespace wf.web
{

    public class ScriptHelper
    {
        //public ScriptHelper()
        //{
        //    //
        //    // TODO: 在此处添加构造函数逻辑
        //    //
        //}

        /////
        public static string GetViewControlScript(string controlName)
        {
            //创建客户端函数ViewObj 
            string script = "\n";
            script += "<script language=\"javascript\">\n";
            script += "function ViewObj(objName)\n";
            script += "{\n";
            script += "var obj = document.all.item(objName);\n";
            script += "if (obj != null)\n";
            script += "{\n";
            script += "\tobj.scrollIntoView();\n";
            script += "\tobj.focus();\n";
            script += "}\n";
            script += "}\n";

            //创建客户端函数ToDo 
            script += "function ToDo()";
            script += "{\n";
            script += string.Format("setTimeout(\"ViewObj('{0}')\",1000);\n", controlName);
            script += "}\n";

            script += "window.onload = ToDo;\n";
            script += "</script>\n";
            return script;
        }
    }
}