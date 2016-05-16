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
                    case "AddBugIssue":
                        AddBugIssue(context);
                        break;
                    
                    case "QueryBugIssueListGroup":
                        QueryBugIssueListGroup(context);
                        break;
                    case "GetBugIssueDetail":
                        GetBugIssueDetail(context);
                        break;
                    case "GetBugIssueContentSingle":
                        GetBugIssueContentSingle(context);
                        break;
                    case "GetBugIssueReplySingle":
                        GetBugIssueReplySingle(context);
                        break;

                    // Bug Reply
                    case "AddBugIssueReply":
                        AddBugIssueReply(context);
                        break;
                    case "CloseBugIssue":
                        CloseBugIssue(context);
                        break;
                    case "ReOpenBugIssue":
                        ReOpenBugIssue(context);
                        break;
                }
            }
        }

        private void ReOpenBugIssue(HttpContext context)
        {
            int BI_ID = Convert.ToInt32(context.Request["BI_ID"]);
            int User_ID = Convert.ToInt32(context.Request["User_ID"]);
            BLL.BugIssue bll = new BLL.BugIssue();
            bool ReOpenRes = bll.ReOpenBugIssue(BI_ID, User_ID);
            if (ReOpenRes)
            {
                // Add Daily Report
                BLL.V_DailyReport bllDR = new BLL.V_DailyReport();
                bllDR.Add(User_ID.ToString(), BI_ID, "BI");

                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void CloseBugIssue(HttpContext context)
        {
            int BI_ID = Convert.ToInt32(context.Request["BI_ID"]);
            int User_ID = Convert.ToInt32(context.Request["User_ID"]);
            string BI_Resolution = context.Request["BI_Resolution"];
            BLL.BugIssue bll = new BLL.BugIssue();
            bool CloseRes = bll.CloseBugIssue(BI_ID, User_ID, BI_Resolution);
            if (CloseRes)
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void AddBugIssueReply(HttpContext context)
        {
            BLL.BugIssueReply bll = new BLL.BugIssueReply();
            Model.BugIssueReply model = new Model.BugIssueReply();
            model.BIR_FK_BI_ID = Convert.ToInt32(context.Request["BIR_FK_BI_ID"]);
            model.BIR_Content = context.Request["BIR_Content"];
            model.BIR_CreateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            model.BIR_CreateUser = Convert.ToInt32(context.Request["BIR_CreateUser"]);
            int AddRes = bll.Add(model);
            if (AddRes>0)
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void GetBugIssueReplySingle(HttpContext context)
        {
            string BI_ID = context.Request["BI_ID"];
            if (string.IsNullOrEmpty(BI_ID))
            {
                BI_ID = "0";
            }
            BLL.V_BugReplyDetail bll = new BLL.V_BugReplyDetail();
            List<Model.V_BugReplyDetail> list = new List<Model.V_BugReplyDetail>();
            DataSet ds = bll.GetList("BIR_FK_BI_ID=" + BI_ID);
            if (ds.Tables[0].Rows.Count>0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    list.Add(new Model.V_BugReplyDetail()
                    {
                        BIR_Content = dr["BIR_Content"].ToString(),
                        BIR_CreateTime = dr["BIR_CreateTime"].ToString(),
                        U_nickname = dr["U_nickname"].ToString()
                    });
                }
                JavaScriptSerializer jss = new JavaScriptSerializer();
                string strJson = jss.Serialize(list);
                context.Response.Write(strJson);
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void GetBugIssueContentSingle(HttpContext context)
        {
            string BI_ID = context.Request["BI_ID"];
            if (string.IsNullOrEmpty(BI_ID))
            {
                BI_ID = "0";
            }
            BLL.BugIssue bll = new BLL.BugIssue();
            List<Model.BugIssue> list = new List<Model.BugIssue>();
            DataSet ds = bll.GetSingle(Convert.ToInt32(BI_ID));
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow dr = ds.Tables[0].Rows[0];
                list.Add(new Model.BugIssue()
                {
                    BI_Title = dr["BI_Title"].ToString(),
                    BI_CreateDate = dr["BI_CreateDate"].ToString(),
                    BI_Content = dr["BI_Content"].ToString()
                });
                JavaScriptSerializer jss = new JavaScriptSerializer();
                string strJson = jss.Serialize(list).TrimStart('[').TrimEnd(']');
                context.Response.Write(strJson);
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void GetBugIssueDetail(HttpContext context)
        {
            string BI_ID = context.Request["BI_ID"];
            BLL.V_BugDetail bll = new BLL.V_BugDetail();
            DataSet ds = bll.GetList("*", "BI_ID=" + BI_ID);
            List<Model.V_BugDetail> list = new List<Model.V_BugDetail>();
            DataRow dr = ds.Tables[0].Rows[0];
            list.Add(new Model.V_BugDetail() {
                TT_Title = dr["TT_Title"].ToString(),
                S_ScenarioName = dr["S_ScenarioName"].ToString(),
                SR_RoleTitle = dr["SR_RoleTitle"].ToString(),
                BI_CaseNumber = dr["BI_CaseNumber"].ToString(),
                BI_EnvironmentServer = dr["BI_EnvironmentServer"].ToString(),
                BI_TopologyName = dr["BI_TopologyName"].ToString(),
                BI_UpdateTime = dr["BI_UpdateTime"].ToString(),
                BI_CloseTime = dr["BI_CloseTime"].ToString(),
                BI_Owner = Convert.ToInt32(dr["BI_Owner"]),
                BI_Status = dr["BI_Status"].ToString(),
                BI_Priority = dr["BI_Priority"].ToString()
            });
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list).TrimStart('[').TrimEnd(']');
            context.Response.Write(strJson);
        }

        private void QueryBugIssueListGroup(HttpContext context)
        {
            string strKeyWord = context.Request["keyWord"];
            BLL.V_BugDetail bll = new BLL.V_BugDetail();
            DataSet ds = new DataSet();
            string strFields = "BI_ID,BI_Title,BI_Type,BI_Status,BI_CreateDate,BI_Priority,U_nickname";
            if (string.IsNullOrEmpty(strKeyWord))
            {
                ds = bll.GetList(strFields, "BI_Status='Open'");
            }
            else if (strKeyWord.ToLower() == "@all")
            {
                ds = bll.GetList(strFields, "");
            }
            else
            {
                ds = bll.GetList(strFields, string.Format("BI_Title like '%{0}%'", strKeyWord));
            }
            List<Model.V_BugDetailForBugListGroup> list = new List<Model.V_BugDetailForBugListGroup>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.V_BugDetailForBugListGroup() {
                    BI_ID = Convert.ToInt32(dr["BI_ID"]),
                    BI_Title = dr["BI_Title"].ToString(),
                    BI_Type = dr["BI_Type"].ToString(),
                    BI_Status = dr["BI_Status"].ToString(),
                    BI_CreateDate = dr["BI_CreateDate"].ToString(),
                    BI_Priority = dr["BI_Priority"].ToString(),
                    U_nickname = dr["U_nickname"].ToString()
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list);
            context.Response.Write(strJson);
        }

        

        private void AddBugIssue(HttpContext context)
        {
            Model.BugIssue model = new Model.BugIssue();
            BLL.BugIssue bll = new BLL.BugIssue();
            model.BI_FK_SR_ID = Convert.ToInt32(string.IsNullOrEmpty(context.Request["BI_FK_SR_ID"]) ? "0" : context.Request["BI_FK_SR_ID"]);
            model.BI_FK_S_ID = Convert.ToInt32(string.IsNullOrEmpty(context.Request["BI_FK_S_ID"]) ? "0" : context.Request["BI_FK_S_ID"]);
            model.BI_FK_TT_ID = Convert.ToInt32(string.IsNullOrEmpty(context.Request["BI_FK_TT_ID"]) ? "0" : context.Request["BI_FK_TT_ID"]);
            model.BI_Title = context.Request["BI_Title"];
            model.BI_Type = context.Request["BI_Type"];
            model.BI_Content = context.Request["BI_Content"];
            model.BI_EnvironmentServer = context.Request["BI_EnvironmentServer"];
            model.BI_TopologyName = context.Request["BI_TopologyName"];
            model.BI_Remark = "";
            model.BI_CaseNumber = context.Request["BI_CaseNumber"];
            model.BI_CreateDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            model.BI_Status = "Open";
            model.BI_Owner = Convert.ToInt32(context.Request["BI_Owner"]);
            model.BI_CloseTime = "";
            model.BI_ReferenceBIID = 0;
            model.BI_UpdateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            model.BI_Priority = context.Request["BI_Priority"];
            int AddRes = bll.Add(model);
            if (AddRes > 0)
            {
                // Add Daily Report
                BLL.V_DailyReport bllDR = new BLL.V_DailyReport();
                bllDR.Add(model.BI_Owner.ToString(), AddRes, "BI");

                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void GetDDLScenarioRole(HttpContext context)
        {
            string FK_S_ID = context.Request["S_ID"];
            BLL.ScenarioRole bll = new BLL.ScenarioRole();
            DataSet ds = new DataSet();
            if (!string.IsNullOrEmpty(FK_S_ID))
            {
                ds = bll.GetList("SR_FK_S_ID=" + FK_S_ID);
            }
            else
            {
                ds = bll.GetList("SR_FK_S_ID=0");
            }
            List<Model.ScenarioRoleForDDL> list = new List<Model.ScenarioRoleForDDL>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.ScenarioRoleForDDL()
                {
                    SR_ID = Convert.ToInt32(dr["SR_ID"]),
                    SR_RoleTitle = dr["SR_RoleTitle"].ToString()
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list);
            context.Response.Write(strJson);
        }

        private void GetDDLScenario(HttpContext context)
        {
            string FK_TT_ID = context.Request["TT_ID"];
            BLL.Scenario bll = new BLL.Scenario();
            DataSet ds = new DataSet();
            if (!string.IsNullOrEmpty(FK_TT_ID))
            {
                ds = bll.GetList("S_FK_TT_ID=" + FK_TT_ID);
            }
            else
            {
                ds = bll.GetList("S_FK_TT_ID=0");
            }
            List<Model.ScenarioForDDL> list = new List<Model.ScenarioForDDL>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.ScenarioForDDL()
                {
                    S_ID = Convert.ToInt32(dr["S_ID"]),
                    S_ScenarioName = dr["S_ScenarioName"].ToString()
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list);
            context.Response.Write(strJson);
        }

        private void GetDDLTaskTotalSearch(HttpContext context)
        {
            BLL.TaskTotal bll = new BLL.TaskTotal();
            DataSet ds = new DataSet();
            string strKeyWord = context.Request["keyword"];
            if (!string.IsNullOrEmpty(strKeyWord))
            {
                if (strKeyWord == "InProgress")
                {
                    ds = bll.GetList("TT_TaskStatus='InProgress'");
                }
                else
                {
                    ds = bll.GetList("TT_Title like '%" + strKeyWord + "%'");
                }
            }
            else
            {
                ds = bll.GetList("TT_TaskStatus='InProgress'");
            }
            List<Model.TaskTotalForDLL> list = new List<Model.TaskTotalForDLL>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.TaskTotalForDLL()
                {
                    TT_ID = Convert.ToInt32(dr["TT_ID"]),
                    TT_Title = dr["TT_Title"].ToString(),
                    TT_TaskStatus = dr["TT_TaskStatus"].ToString()
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list);
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
            string strJson = jss.Serialize(list);//.TrimStart('[').TrimEnd(']');
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