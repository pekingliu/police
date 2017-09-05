using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using julia.web;
//using System.

/// <summary>
/// ExportFile 的摘要说明
/// </summary>

namespace julia.web
{
    public class ExportFile
    {
        public ExportFile()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }
        public static void GridViewtoFiles(string Model, DataSet fileDS)
        {
            try
            {
                string strFileName = DateTime.Now.ToString("yyyyMMdd-hhmmss");
                System.Web.HttpContext HC = System.Web.HttpContext.Current;
                HC.Response.Clear();
                HC.Response.Buffer = true;
                HC.Response.ContentEncoding = System.Text.Encoding.GetEncoding("gb2312");// .UTF8;//设置输出流为简体中文
                if (Model == "excel")
                {
                    //---导出为Excel文件
                    HC.Response.AddHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(strFileName, System.Text.Encoding.GetEncoding("gb2312")) + ".xls");
                    HC.Response.ContentType = "application/ms-excel";//设置输出文件类型为excel文件。
                }
                else//word
                {
                    //--- 导出为Word文件
                    HC.Response.AddHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(strFileName, System.Text.Encoding.GetEncoding("gb2312")) + ".doc");
                    HC.Response.ContentType = "application/ms-word";//设置输出文件类型为Word文件。
                }
                System.IO.StringWriter sw = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter htw = new System.Web.UI.HtmlTextWriter(sw);
                ////////////// 
                GridView nowGrid = new GridView();
                nowGrid.DataSource = fileDS.Tables[0].DefaultView;
                nowGrid.DataBind();
                nowGrid.RenderControl(htw);
                HC.Response.Write(sw.ToString());
                HC.Response.End();
            }
            catch (Exception e)
            {
                //Log.LogInfo.writeLog(e.ToString());
            }
        }
      
    }
}