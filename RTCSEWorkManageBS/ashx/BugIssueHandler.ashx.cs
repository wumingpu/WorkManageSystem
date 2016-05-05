using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;

namespace RTCSEWorkManageBS.ashx
{
    /// <summary>
    /// Summary description for BugIssueHandler
    /// </summary>
    public class BugIssueHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            if (context.Request["mode"] != null)
            {
                string mode = context.Request["mode"].ToString();
                switch (mode)
                {
                    case "TetFunction":
                        TestFunction(context);
                        break;
                    // BugIssue Manage
                    case "GetDDLTaskTotalInprogress":
                        GetDDLTaskTotalInprogress(context);
                        break;
                    case "GetDDLTaskTotalSearch":
                        GetDDLTaskTotalSearch(context);
                        break;
                    case "GetDDLScenario":
                        GetDDLScenario(context);
                        break;
                    case "GetDDLScenarioRole":
                        GetDDLScenarioRole(context);
                        break;
                }
            }
        }



        private void GetDDLScenarioRole(HttpContext context)
        {
            throw new NotImplementedException();
        }

        private void GetDDLScenario(HttpContext context)
        {
            throw new NotImplementedException();
        }

        private void GetDDLTaskTotalSearch(HttpContext context)
        {
            //throw new NotImplementedException();
            string keyWord = context.Request["query"];
            BLL.TaskTotal bll = new BLL.TaskTotal();
            DataSet ds = bll.GetList("");//TT_TaskStatus='InProgress'
            //List<Model.TaskTotalForDLL> list = new List<Model.TaskTotalForDLL>();
            StringBuilder strTaskTotal = new StringBuilder();
            strTaskTotal.Append("{rows:[");
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                //list.Add(new Model.TaskTotalForDLL()
                //{
                //    //TT_ID = Convert.ToInt32(dr["TT_ID"]),
                //    TT_Title = string.Format("{0}#{1}", dr["TT_Title"].ToString(), dr["TT_ID"])
                //});
                strTaskTotal.Append(string.Format("\"{0} #{1}\",", dr["TT_Title"].ToString(), dr["TT_ID"]));
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(strTaskTotal.ToString().TrimEnd(',') + "]}").TrimStart('[').TrimEnd(']');//
            context.Response.Write(strJson);
        }

        private void GetDDLTaskTotalInprogress(HttpContext context)
        {
            BLL.TaskTotal bll = new BLL.TaskTotal();
            DataSet ds = bll.GetList("TT_TaskStatus='InProgress'");
            List<Model.TaskTotalForDLL> list = new List<Model.TaskTotalForDLL>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.TaskTotalForDLL()
                {
                    TT_ID = Convert.ToInt32(dr["TT_ID"]),
                    TT_Title = dr["TT_Title"].ToString()
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list).TrimStart('[').TrimEnd(']');
            context.Response.Write(strJson);
        }

        private void TestFunction(HttpContext context)
        {
            //throw new NotImplementedException();
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