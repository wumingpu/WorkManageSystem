using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace RTCSEWorkManageBS.ashx
{
    /// <summary>
    /// Summary description for DailyReportHandler
    /// </summary>
    public class DailyReportHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            if (context.Request["mode"] != null)
            {
                string mode = context.Request["mode"].ToString();
                switch (mode)
                {
                    case "AddDailyReport":
                        AddDailyReport(context);
                        break;
                    case "QueryDailyReportList":
                        QueryDailyReportList(context);
                        break;
                }
            }
        }

        private void QueryDailyReportList(HttpContext context)
        {
            string U_ID = context.Request["U_ID"];
            string DR_Date = context.Request["DR_Date"];
            if (string.IsNullOrEmpty(DR_Date))
            {
                DR_Date = DateTime.Now.ToString("yyyy-MM-dd");
            }
            else
            {
                DR_Date = Convert.ToDateTime(DR_Date).ToString("yyyy-MM-dd");
            }
            BLL.V_DailyReport bll = new BLL.V_DailyReport();
            DataSet ds = bll.GetList(string.Format("DR_Resources={0} and DR_UpdateDate='{1}'", U_ID, DR_Date));
            List<Model.V_DailyReport> list = new List<Model.V_DailyReport>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.V_DailyReport()
                {
                    //DR_UpdateDate = dr["DR_UpdateDate"]
                    DR_Type = dr["DR_Type"].ToString(),
                    BTT_Title = dr["BTT_Title"].ToString(),
                    BTT_Status = dr["BTT_Status"].ToString(),
                    BTT_Progress = dr["BTT_Progress"].ToString() == "N/A" ? "N/A" : dr["BTT_Progress"].ToString() + '%',
                    BTT_Owner = dr["BTT_Owner"].ToString(),
                    DR_ResourcesName = dr["DR_ResourcesName"].ToString()
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list);
            context.Response.Write(strJson);
        }

        private void AddDailyReport(HttpContext context)
        {

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