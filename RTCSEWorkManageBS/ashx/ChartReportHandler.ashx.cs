using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace RTCSEWorkManageBS.ashx
{
    /// <summary>
    /// Summary description for ChartReportHandler
    /// </summary>
    public class ChartReportHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            if (context.Request["mode"] != null)
            {
                string mode = context.Request["mode"].ToString();
                switch (mode)
                {
                    // Bar Chart
                    case "BarMonthTasknumber":
                        BarMonthTasknumber(context);
                        break;

                    // Line Chart

                    // Pie Chart
                    case "TestQuery1":
                        TestQuery1(context);
                        break;
                }
            }
        }

        private void BarMonthTasknumber(HttpContext context)
        {
            BLL.ChartReport bll = new BLL.ChartReport();
            string strYear = context.Request["Year"];
            if (string.IsNullOrEmpty(strYear))
            {
                strYear = DateTime.Now.Year.ToString();
            }
            DataSet ds = bll.BarMonthTasknumber("2016");
            List<Model.ChartReport.MonthData> list = new List<Model.ChartReport.MonthData>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.ChartReport.MonthData()
                {
                    Month = Convert.ToInt32(dr["CR_Month"]),
                    DataPreMonth = Convert.ToInt32(dr["CR_TaskNumber"])
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list);
            context.Response.Write(strJson);
        }

        private void TestQuery1(HttpContext context)
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