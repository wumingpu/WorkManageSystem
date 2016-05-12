using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web;
using System.Web.SessionState;
using System.Web.Script.Serialization;

namespace RTCSEWorkManageBS.ashx
{
    /// <summary>
    /// Summary description for TaskHandler
    /// </summary>
    public class TaskHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //设置服务器响应的结果为纯文本格式
            context.Response.ContentType = "text/plain";
            if (context.Request["mode"] != null)
            {
                string mode = context.Request["mode"].ToString();
                switch (mode)
                {
                    // Test
                    case "QueryTestJQTable":
                        QueryTestJQTable(context);
                        break;
                    // TaskTotal
                    case "QueryTaskListTotal":
                        QueryTaskListTotal(context);
                        break;
                    case "QueryTaskListTotalSimple":
                        QueryTaskListTotalSimple(context);
                        break;
                    case "AddTaskListTotal":
                        AddTaskListTotal(context);
                        break;
                    case "GetTaskTotalInfoSingle":
                        GetTaskTotalInfoSingle(context);
                        break;
                    case "UpdateTaskListTotal":
                        UpdateTaskListTotal(context);
                        break;
                    case "DeleteTaskListTotal":
                        DeleteTaskListTotal(context);
                        break;
                    case "StartTaskTotal":
                        StartTaskTotal(context);
                        break;
                    case "EndTaskTotal":
                        EndTaskTotal(context);
                        break;
                    // TaskDaily
                    case "QueryTaskListDaily":
                        QueryTaskListDaily(context);
                        break;

                    // Scenario
                    case "AddScenarios":
                        AddScenarios(context);
                        break;
                    case "QueryScenario":
                        QueryScenario(context);
                        break;
                    case "AddScenarioInfo":
                        AddScenarioInfo(context);
                        break;
                    case "UpdateScenarioInfo":
                        UpdateScenarioInfo(context);
                        break;
                    case "DeleteScenarioInfo":
                        DeleteScenarioInfo(context);
                        break;
                    case "AddScenarioRoleBatch":
                        AddScenarioRoleBatch(context);
                        break;

                    // Scenario Role
                    case "QueryScenarioRole":
                        QueryScenarioRole(context);
                        break;
                    case "AddScenarioRole":
                        AddScenarioRole(context);
                        break;
                    case "UpdateScenarioRole":
                        UpdateScenarioRole(context);
                        break;
                    case "DeleteScenarioRole":
                        DeleteScenarioRole(context);
                        break;

                    //TaskBoard
                    case "GetTaskBoardPersonal":
                        GetTaskBoardPersonal(context);
                        break;
                    //case "GetTaskBoardPersonalToDo":
                    //    GetTaskBoardPersonalToDo(context);
                    //    break;
                    case "GetTaskDetailPersonal":
                        GetTaskDetailPersonal(context);
                        break;
                    case "AddTaskPersonal":
                        AddTaskPersonal(context);
                        break;
                    case "UpdateTaskStatus":
                        UpdateTaskStatus(context);
                        break;
                    case "UpdataTaskProgress":
                        UpdataTaskProgress(context);
                        break;
                }
            }
        }

        private void UpdataTaskProgress(HttpContext context)
        {
            int TD_ID = Convert.ToInt32(context.Request["TD_ID"]);
            string TD_CardType = context.Request["TD_CardType"];
            string dragFrom = context.Request["dragFrom"];
            string dropTo = context.Request["dropTo"];
            string TimeStart = context.Request["TimeStart"];
            if (!string.IsNullOrEmpty(TimeStart))
            {
                TimeStart = Convert.ToDateTime(TimeStart).ToString("yyyy-MM-dd HH:mm:ss");
            }
            string TimeEnd = context.Request["TimeEnd"];
            if (!string.IsNullOrEmpty(TimeEnd))
            {
                TimeEnd = Convert.ToDateTime(TimeEnd).ToString("yyyy-MM-dd HH:mm:ss");
            }

            string SR_CasePassed = context.Request["SR_CasePassed"];
            string SR_CaseFailed = context.Request["SR_CaseFailed"];
            string SR_CaseNA = context.Request["SR_CaseNA"];
            string SR_CaseRedmond = context.Request["SR_CaseRedmond"];

            string TD_Progress = context.Request["TD_Progress"];
            string TD_CompleteReason = context.Request["TD_CompleteReason"];
            string ResourcesID = context.Request["User_ID"];

            BLL.V_TaskDetailSimple bll = new BLL.V_TaskDetailSimple();
            // Refresh:刷新Middle和RightPanel; TaskStart：任务开始；SaveSuccess：进度保存成功
            // Update Fail：数据库更新错误；Data Fail:数据参数错误
            string UpdateRes = bll.UpdateTaskProgress(dragFrom, dropTo, TD_ID, TD_CardType, TimeStart, TimeEnd, SR_CasePassed, SR_CaseFailed, SR_CaseNA, SR_CaseRedmond, TD_Progress, TD_CompleteReason);
            if (TD_CardType == "private" || (dragFrom == "LeftPanel" && dropTo == "MiddlePanel"))
            { }
            else
            { // 当public的任务且不是ToDo到Doing的时候，更新Case的进度。
                int TT_ID = Convert.ToInt32(context.Request["TT_ID"]);
                string SR_CasePassedGrow = context.Request["SR_CasePassedGrow"];
                string SR_CaseFailedGrow = context.Request["SR_CaseFailedGrow"];
                string SR_CaseNAGrow = context.Request["SR_CaseNAGrow"];
                string SR_CaseRedmondGrow = context.Request["SR_CaseRedmondGrow"];
                bll.UpdateCaseNumTotalDaily(TT_ID, SR_CasePassedGrow, SR_CaseFailedGrow, SR_CaseNAGrow, SR_CaseRedmondGrow);
            }

            // Add Daily Report
            BLL.V_DailyReport bllDR = new BLL.V_DailyReport();
            bllDR.Add(ResourcesID, TD_ID, TD_CardType == "private" ? "TP" : "TT");

            context.Response.Write(UpdateRes);
        }

        private void UpdateTaskStatus(HttpContext context)
        {
            int TD_ID = Convert.ToInt32(context.Request["TD_ID"]);
            string TD_CardType = context.Request["TD_CardType"];
            string dragFrom = context.Request["dragFrom"];
            string dropTo = context.Request["dropTo"];
            string TimeStart = context.Request["TimeStart"];
            if (TimeStart != "") { TimeStart = Convert.ToDateTime(TimeStart).ToString("yyyy-MM-dd HH:mm:ss"); }
            string TimeEnd = context.Request["TimeEnd"];
            if (TimeEnd != "") { Convert.ToDateTime(TimeEnd).ToString("yyyy-MM-dd HH:mm:ss"); }
            BLL.V_TaskDetailSimple bll = new BLL.V_TaskDetailSimple();
            bool updateRes = bll.UpdateTaskStatus(dragFrom, dropTo, TD_ID, TD_CardType, TimeStart, TimeEnd);
            if (updateRes)
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void GetTaskDetailPersonal(HttpContext context)
        {
            string TD_CardType = context.Request["TD_CardType"];
            string TD_ID = context.Request["TD_ID"];
            //StringBuilder strSql = new StringBuilder();
            BLL.V_TaskDetail bll = new BLL.V_TaskDetail();
            DataSet ds = bll.GetList(string.Format("TD_CardType='{0}' and TD_ID={1}", TD_CardType, TD_ID));
            DataRow dr = ds.Tables[0].Rows[0];
            List<Model.V_TaskDetail> list = new List<Model.V_TaskDetail>();
            list.Add(new Model.V_TaskDetail()
            {
                TT_ID = Convert.ToInt32(dr["TT_ID"]),
                TD_TaskTitle = dr["TD_TaskTitle"].ToString(),
                TT_Release = dr["TT_Release"].ToString(),
                TT_BuildType = dr["TT_BuildType"].ToString(),
                TT_TaskType = dr["TT_TaskType"].ToString(),
                TT_TaskStyle = dr["TT_TaskStyle"].ToString(),
                TT_CU = dr["TT_CU"].ToString(),
                TT_BuildNum = dr["TT_BuildNum"].ToString(),
                TD_ScenarioTitle = dr["TD_ScenarioTitle"].ToString(),
                TD_RoleTitle = dr["TD_RoleTitle"].ToString(),
                SR_CaseNum = dr["SR_CaseNum"].ToString(),
                SR_CasePassed = dr["SR_CasePassed"].ToString(),
                SR_CaseNA = dr["SR_CaseNA"].ToString(),
                SR_CaseFailed = dr["SR_CaseFailed"].ToString(),
                SR_CaseRedmond = dr["SR_CaseRedmond"].ToString(),
                TD_DateStart = Convert.ToDateTime(dr["TD_DateStart"]).ToString("dd/MM/yyyy"),
                TD_DateEnd = Convert.ToDateTime(dr["TD_DateEnd"]).ToString("dd/MM/yyyy"),
                TD_Owner = dr["TD_Owner"].ToString(),
                TD_AssignedUserName = dr["TD_AssignedUserName"].ToString(),
                TD_Comments = dr["TD_Comments"].ToString(),
                TD_Progress = dr["TD_Progress"].ToString(),
                TD_TimeStart = dr["TD_TimeStart"].ToString(),
                TD_TimeEnd = dr["TD_TimeEnd"].ToString(),
                TD_TimeUsed = dr["TD_TimeUsed"].ToString(),
                TD_CompleteReason = dr["TD_CompleteReason"].ToString()
            });
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list).TrimStart('[').TrimEnd(']');
            context.Response.Write(strJson);
        }

        //private void GetTaskBoardPersonalToDo(HttpContext context)
        //{

        //}

        private void AddTaskPersonal(HttpContext context)
        {
            BLL.TaskPersonal bll = new BLL.TaskPersonal();
            Model.TaskPersonal model = new Model.TaskPersonal();
            model.TP_Title = context.Request["TP_Title"];
            model.TP_DateStart = Convert.ToDateTime(context.Request["TP_DateStart"]).ToString("yyyy-MM-dd");
            model.TP_DateEnd = Convert.ToDateTime(context.Request["TP_DateEnd"]).ToString("yyyy-MM-dd");
            model.TP_Owner = context.Request["TP_Owner"];
            model.TP_Comments = context.Request["TP_Comments"];
            model.TP_Status = "Pending";
            model.TP_IsDelete = "0";
            model.TP_CreateUser = context.Request["User_ID"];
            model.TP_Progress = "0";
            model.TP_CreateDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

            int AddRes = bll.Add(model);
            if (AddRes > 0)
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void GetTaskBoardPersonal(HttpContext context)
        {
            BLL.V_TaskDetailSimple bll = new BLL.V_TaskDetailSimple();
            DataSet ds = bll.GetList(string.Format("TD_AssignedUserID like '%,{0},%' and TD_Status!=''", context.Request["User_ID"]), 8);
            List<Model.V_TaskDetailSimple> list = new List<Model.V_TaskDetailSimple>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.V_TaskDetailSimple()
                {
                    TD_ID = Convert.ToInt32(dr["TD_ID"]),
                    TD_Status = dr["TD_Status"].ToString(),
                    TD_TaskTitle = dr["TD_TaskTitle"].ToString(),
                    TD_ScenarioTitle = dr["TD_ScenarioTitle"].ToString(),
                    TD_RoleTitle = dr["TD_RoleTitle"].ToString(),
                    TD_AssignedUserName = dr["TD_AssignedUserName"].ToString(),
                    TD_CardType = dr["TD_CardType"].ToString(),
                    TD_Date = Convert.ToDateTime(dr["TD_DateStart"]).ToString("MM/dd/yyyy") + '-' + Convert.ToDateTime(dr["TD_DateEnd"]).ToString("MM/dd/yyyy"),
                    TD_Owner = dr["TD_Owner"].ToString(),
                    TD_TaskType = dr["TD_TaskType"].ToString(),
                    TD_OwnerID = dr["TD_OwnerID"].ToString()
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list);//.TrimStart('[').TrimEnd(']');
            context.Response.Write(strJson);
        }

        private void DeleteScenarioRole(HttpContext context)
        {
            BLL.ScenarioRole bll = new BLL.ScenarioRole();
            if (bll.Delete(Convert.ToInt32(context.Request["SR_ID"]), Convert.ToInt32(context.Request["SR_FK_S_ID"])))
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void UpdateScenarioRole(HttpContext context)
        {
            Model.ScenarioRole model = new Model.ScenarioRole();
            BLL.ScenarioRole bll = new BLL.ScenarioRole();
            model.SR_ID = Convert.ToInt32(context.Request["SR_ID"]);
            //model.SR_FK_S_ID = Convert.ToInt32(context.Request["SR_FK_S_ID"]);
            //model.SR_FK_TT_ID = Convert.ToInt32(context.Request["SR_FK_TT_ID"]);
            model.SR_RoleTitle = context.Request["SR_RoleTitle"];
            model.SR_CaseNum = context.Request["SR_CaseNum"];
            model.SR_AssignedUser = context.Request["SR_AssignedUser"];
            model.SR_AssignedUserName = context.Request["SR_AssignedUserName"];
            if (bll.Update(model))
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void AddScenarioRole(HttpContext context)
        {
            //SR_RoleTitle: SR_RoleTitle, SR_CaseNum: SR_CaseNum,
            //        SR_SR_AssignedUser: SR_SR_AssignedUser, SR_AssignedUserName: SR_AssignedUserName,
            //        SR_FK_S_ID: SR_FK_S_ID, SR_FK_TT_ID: SR_FK_TT_ID
            Model.ScenarioRole model = new Model.ScenarioRole();
            BLL.ScenarioRole bll = new BLL.ScenarioRole();
            model.SR_FK_S_ID = Convert.ToInt32(context.Request["SR_FK_S_ID"]);
            model.SR_FK_TT_ID = Convert.ToInt32(context.Request["SR_FK_TT_ID"]);
            model.SR_RoleTitle = context.Request["SR_RoleTitle"];
            model.SR_CaseNum = context.Request["SR_CaseNum"];
            model.SR_AssignedUser = context.Request["SR_AssignedUser"];
            model.SR_AssignedUserName = context.Request["SR_AssignedUserName"];
            model.SR_CreateUser = context.Request["User_ID"];
            model.SR_CreateDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            if (context.Request["TT_TaskStatus"] != "Pending")
            {
                model.SR_Status = "Pending";
            }
            else
            {
                model.SR_Status = "";
            }
            model.SR_IsDelete = "0";
            if (bll.Add(model) > 0)
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void QueryScenarioRole(HttpContext context)
        {
            BLL.V_TaskTotalScenarioScenarioRole bll = new BLL.V_TaskTotalScenarioScenarioRole();
            DataSet ds = new DataSet();
            if (context.Request["SR_FK_S_ID"] == null)
            {
                ds = bll.GetList("");
            }
            else
            {
                ds = bll.GetList("SR_FK_S_ID=" + context.Request["SR_FK_S_ID"]);
            }
            List<Model.V_TaskTotalScenarioScenarioRole> list = new List<Model.V_TaskTotalScenarioScenarioRole>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.V_TaskTotalScenarioScenarioRole()
                {
                    SR_ID = Convert.ToInt32(dr["SR_ID"]),
                    SR_FK_S_ID = Convert.ToInt32(dr["SR_FK_S_ID"]),
                    SR_FK_TT_ID = Convert.ToInt32(dr["SR_FK_TT_ID"]),
                    TT_Title = dr["TT_Title"].ToString(),
                    S_ScenarioName = dr["S_ScenarioName"].ToString(),
                    SR_RoleTitle = dr["SR_RoleTitle"].ToString(),
                    SR_AssignedUser = dr["SR_AssignedUser"].ToString(),
                    SR_AssignedUserName = dr["SR_AssignedUserName"].ToString(),
                    SR_CaseNum = dr["SR_CaseNum"].ToString(),
                    SR_CasePassed = dr["SR_CasePassed"].ToString(),
                    SR_CaseFailed = dr["SR_CaseFailed"].ToString(),
                    SR_CaseNA = dr["SR_CaseNA"].ToString(),
                    SR_CaseRedmond = dr["SR_CaseRedmond"].ToString(),
                    SR_CompleteProgress = dr["SR_CompleteProgress"].ToString(),
                    SR_CreateUser = dr["SR_CreateUser"].ToString(),
                    U_nickname = dr["U_nickname"].ToString(),
                    TT_TaskStatus = dr["TT_TaskStatus"].ToString()
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = string.Format("{{\"rows\":{0}}}", jss.Serialize(list));
            context.Response.Write(strJson);
        }

        private void AddScenarioRoleBatch(HttpContext context)
        {
            int SR_FK_S_ID = int.Parse(context.Request["SR_FK_S_ID"]);
            int SR_FK_TT_ID = int.Parse(context.Request["SR_FK_TT_ID"]);
            int User_ID = int.Parse(context.Request["User_ID"]);
            string JsonScenarioRole = context.Request["JsonSenarioRole"].ToString();
            string strJson = string.Format("[{0}]", JsonScenarioRole);
            JavaScriptSerializer jss = new JavaScriptSerializer();
            List<Model.ScenarioRoleForJson> list = jss.Deserialize<List<Model.ScenarioRoleForJson>>(strJson);

            BLL.ScenarioRole bll = new BLL.ScenarioRole();
            bool AddRes = bll.AddBatch(list, SR_FK_S_ID, SR_FK_TT_ID, User_ID);
            if (AddRes)
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void DeleteScenarioInfo(HttpContext context)
        {
            BLL.Scenario bll = new BLL.Scenario();
            bool DeleteRes = bll.Delete(int.Parse(context.Request["S_ID"]), int.Parse(context.Request["S_FK_TT_ID"]));
            if (DeleteRes)
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void UpdateScenarioInfo(HttpContext context)
        {
            BLL.Scenario bll = new BLL.Scenario();
            Model.Scenario model = new Model.Scenario();
            model.S_ScenarioName = context.Request["S_ScenarioName"];
            model.S_ID = int.Parse(context.Request["S_ID"]);
            bool EditRes = bll.Edit(model);
            if (EditRes)
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void AddScenarioInfo(HttpContext context)
        {
            BLL.Scenario bll = new BLL.Scenario();
            Model.Scenario model = new Model.Scenario();
            model.S_FK_TT_ID = int.Parse(context.Request["S_FK_TT_ID"]);
            model.S_ScenarioName = context.Request["S_ScenarioName"];
            model.S_CreateDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            model.S_IsDelete = 0;
            model.S_HaveRole = "No";
            int AddRes = bll.Add(model, false);
            if (AddRes > 0)
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void QueryScenario(HttpContext context)
        {
            BLL.V_TaskTotalScenario bll = new BLL.V_TaskTotalScenario();
            DataSet ds = new DataSet();
            if (context.Request["S_FK_TT_ID"] == null)
            {
                ds = bll.GetList("");
            }
            else
            {
                ds = bll.GetList("S_FK_TT_ID=" + context.Request["S_FK_TT_ID"]);
            }
            List<Model.V_TaskTotalScenario> list = new List<Model.V_TaskTotalScenario>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.V_TaskTotalScenario()
                {
                    S_ID = Convert.ToInt32(dr["S_ID"]),
                    S_FK_TT_ID = Convert.ToInt32(dr["S_FK_TT_ID"]),
                    S_CreateDate = Convert.ToDateTime(dr["S_CreateDate"]).ToString("dd/MM/yyyy"),
                    S_ScenarioName = dr["S_ScenarioName"].ToString(),
                    TT_Title = dr["TT_Title"].ToString(),
                    S_HaveRole = dr["S_HaveRole"].ToString(),
                    TT_TaskStatus = dr["TT_TaskStatus"].ToString()
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = string.Format("{{\"rows\":{0}}}", jss.Serialize(list));
            context.Response.Write(strJson);
        }

        private void AddScenarios(HttpContext context)
        {
            BLL.Scenario bll = new BLL.Scenario();
            Model.Scenario model = new Model.Scenario();
            int S_ScenarioNumber = int.Parse(context.Request["S_ScenarioNumber"]);
            model.S_FK_TT_ID = int.Parse(context.Request["S_FK_TT_ID"]);
            model.S_ScenarioNames = context.Request["S_ScenarioNames"];
            model.S_CreateDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            model.S_IsDelete = 0;
            model.S_HaveRole = "No";
            int AddRes = bll.AddBatch(S_ScenarioNumber, model);
            if (AddRes > 0)
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void QueryTaskListDaily(HttpContext context)
        {
            BLL.TaskDaily bll = new BLL.TaskDaily();
            string TD_FK_TaskTotalID = context.Request["TD_FK_TaskTotalID"];
            DataSet ds = new DataSet();
            if (!string.IsNullOrEmpty(TD_FK_TaskTotalID))
            {
                ds = bll.GetList("TD_FK_TaskTotalID=" + TD_FK_TaskTotalID);
            }
            else
            {
                ds = bll.GetList("TD_FK_TaskTotalID=0");
            }
            List<Model.TaskDaily> list = new List<Model.TaskDaily>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.TaskDaily()
                {
                    TD_ID = Convert.ToInt32(dr["TD_ID"]),
                    TD_Date = dr["TD_Date"].ToString(),
                    TD_CaseShouldRunNum = dr["TD_CaseShouldRunNum"].ToString(),
                    TD_CaseRealRunNum = dr["TD_CaseRealRunNum"].ToString(),
                    TD_CasePassNum = dr["TD_CasePassNum"].ToString(),
                    TD_CaseFailNum = dr["TD_CaseFailNum"].ToString(),
                    TD_CaseNANum = dr["TD_CaseNANum"].ToString(),
                    TD_CaseRunInRedmond = dr["TD_CaseRunInRedmond"].ToString(),
                    TD_TaskProgress = dr["TD_TaskProgress"].ToString() + '%',
                    TD_TaskStatus = dr["TD_TaskStatus"].ToString()
                });
            }

            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = string.Format("{{\"rows\":{0}}}", jss.Serialize(list));
            context.Response.Write(strJson);
        }

        private void StartTaskTotal(HttpContext context)
        {
            BLL.TaskTotal bll = new BLL.TaskTotal();
            bool UpdateRes = bll.StartTaskTotal(Convert.ToInt32(context.Request["TT_ID"]));
            if (UpdateRes)
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void EndTaskTotal(HttpContext context)
        {
            int TT_ID = Convert.ToInt32(context.Request["TT_ID"]);
            string TT_TaskProgress = context.Request["TT_TaskProgress"];
            string TT_CompleteReason = context.Request["TT_CompleteReason"];
            BLL.TaskTotal bll = new BLL.TaskTotal();
            bool UpdateRes = bll.EndTaskTotal(TT_ID, TT_TaskProgress, TT_CompleteReason);
            if (UpdateRes)
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void DeleteTaskListTotal(HttpContext context)
        {
            BLL.TaskTotal bll = new BLL.TaskTotal();
            bool DelResult = bll.Delete(Convert.ToInt32(context.Request["TT_ID"]));
            if (DelResult)
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void UpdateTaskListTotal(HttpContext context)
        {
            BLL.TaskTotal bll = new BLL.TaskTotal();
            Model.TaskTotal model = new Model.TaskTotal();
            model = bll.GetModel(Convert.ToInt32(context.Request["TT_ID"]));
            model.TT_ID = Convert.ToInt32(context.Request["TT_ID"]);
            model.TT_Release = context.Request["TT_Release"];
            model.TT_BuildType = context.Request["TT_BuildType"];
            model.TT_TaskStyle = context.Request["TT_TaskStyle"];
            model.TT_TaskType = context.Request["TT_TaskType"];
            model.TT_CU = context.Request["TT_CU"];
            model.TT_BuildNum = context.Request["TT_BuildNum"];
            model.TT_CaseTotalNum = context.Request["TT_CaseTotalNum"];
            model.TT_DateStart = Convert.ToDateTime(context.Request["TT_DateStart"]).ToString("yyyy-MM-dd");
            model.TT_DateEnd = Convert.ToDateTime(context.Request["TT_DateEnd"]).ToString("yyyy-MM-dd");
            model.TT_Comments = context.Request["TT_Comments"];
            model.TT_ServerClient = context.Request["TT_ServerClient"];
            bool UpdateResult = bll.Update(model);
            if (UpdateResult)
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }

        }

        private void GetTaskTotalInfoSingle(HttpContext context)
        {
            BLL.TaskTotal bll = new BLL.TaskTotal();
            Model.TaskTotal model = new Model.TaskTotal();
            model = bll.GetModel(Convert.ToInt32(context.Request["id"]));
            List<Model.TaskTotal> list = new List<Model.TaskTotal>();
            list.Add(new Model.TaskTotal
            {
                TT_ID = model.TT_ID,
                TT_Release = model.TT_Release,
                TT_CU = model.TT_CU,
                TT_BuildType = model.TT_BuildType,
                TT_BuildNum = model.TT_BuildNum,
                TT_TaskType = model.TT_TaskType,
                TT_CaseTotalNum = model.TT_CaseTotalNum,
                TT_CaseRealRunNum = model.TT_CaseRealRunNum,
                TT_DateStart = Convert.ToDateTime(model.TT_DateStart).ToString("MM/dd/yyyy"),
                TT_DateEnd = Convert.ToDateTime(model.TT_DateEnd).ToString("MM/dd/yyyy"),
                TT_Date = Convert.ToDateTime(model.TT_DateStart).ToString("dd/MM/yyyy") + " - " + Convert.ToDateTime(model.TT_DateEnd).ToString("dd/MM/yyyy"),
                TT_TaskStyle = model.TT_TaskStyle,
                TT_BugIssueNum = model.TT_BugIssueNum,
                TT_ReportLink = model.TT_ReportLink,
                TT_Comments = model.TT_Comments,
                TT_CreateDate = model.TT_CreateDate,
                TT_TaskProgress = model.TT_TaskProgress + '%',
                TT_TaskStatus = model.TT_TaskStatus,
                TT_HaveScenario = model.TT_HaveScenario,
                TT_TimeStart = string.IsNullOrEmpty(model.TT_TimeStart) ? "Task Not Start" : model.TT_TimeStart,
                TT_TimeEnd = string.IsNullOrEmpty(model.TT_TimeEnd) ? "Task Not End" : model.TT_TimeEnd,
                TT_TimeUsed = Minute2Day(model.TT_TimeUsed),
                TT_Title = model.TT_Title,
                TT_CompleteReason = model.TT_CompleteReason,
                TT_ServerClient = model.TT_ServerClient
            });
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list);
            strJson = strJson.Replace("[", "").Replace("]", "");
            context.Response.Write(strJson);
        }
        private string Minute2Day(string minutes)
        {
            if (string.IsNullOrEmpty(minutes))
            {
                return "Task is In Progress...";
            }
            else
            {
                TimeSpan ts = new TimeSpan(0, Convert.ToInt32(minutes), 0);
                return ts.Days.ToString() + "Days " + ts.Hours.ToString() + "Hours " + ts.Minutes.ToString() + "Minutes";
            }
        }

        private void QueryTaskListTotal(HttpContext context)
        {
            BLL.TaskTotal bll = new BLL.TaskTotal();
            string keyWord = context.Request["keyWord"];
            DataSet ds = new DataSet();
            if (keyWord == "OnlyHaveScenario")
            {
                ds = bll.GetList("TT_HaveScenario='Yes'");
            }
            else
            {
                ds = bll.GetList("");
            }

            List<Model.TaskTotalForDisplay> list = new List<Model.TaskTotalForDisplay>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.TaskTotalForDisplay()
                {
                    TT_ID = Convert.ToInt32(dr["TT_ID"]),
                    TT_Title = dr["TT_Title"].ToString(),
                    //TT_Release = dr["TT_Release"].ToString(),
                    //TT_CU = dr["TT_CU"].ToString(),
                    //TT_BuildType = dr["TT_BuildType"].ToString(),
                    //TT_BuildNum = dr["TT_BuildNum"].ToString(),
                    //TT_TaskType = dr["TT_TaskType"].ToString(),
                    //TT_CaseTotalNum = dr["TT_CaseTotalNum"].ToString(),
                    //TT_CaseRealRunNum = dr["TT_CaseRealRunNum"].ToString(),
                    //TT_Date = ((DateTime)dr["TT_DateStart"]).ToString("dd/MM/yyyy") + " - " + ((DateTime)dr["TT_DateEnd"]).ToString("dd/MM/yyyy"),
                    TT_Date = Convert.ToDateTime(dr["TT_DateStart"]).ToString("dd/MM/yyyy") + " - " + Convert.ToDateTime(dr["TT_DateEnd"]).ToString("dd/MM/yyyy"),
                    TT_TaskStyle = dr["TT_TaskStyle"].ToString(),
                    //TT_BugIssueNum = dr["TT_BugIssueNum"].ToString(),
                    //TT_ReportLink = dr["TT_ReportLink"].ToString(),
                    //TT_Comments = dr["TT_Comments"].ToString(),
                    TT_HaveScenario = dr["TT_HaveScenario"].ToString(),
                    //TT_CreateDate = ((DateTime)dr["TT_CreateDate"]).ToString("yyyy-MM-dd HH:mm:ss")
                    TT_TaskProgress = dr["TT_TaskProgress"].ToString() + "%",
                    TT_TaskStatus = dr["TT_TaskStatus"].ToString()
                });
            }

            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = string.Format("{{\"rows\":{0}}}", jss.Serialize(list));
            context.Response.Write(strJson);
        }
        private void QueryTaskListTotalSimple(HttpContext context)
        {
            BLL.TaskTotal bll = new BLL.TaskTotal();
            int ListItemNum = Convert.ToInt32(context.Request["ListItemNum"]);
            string keyWord = context.Request["keyWord"];
            DataSet ds = bll.GetList(ListItemNum, string.Format("TT_Title like '%{0}%'", keyWord));
            List<Model.TaskTotalForDisplay> list = new List<Model.TaskTotalForDisplay>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.TaskTotalForDisplay()
                {
                    TT_ID = Convert.ToInt32(dr["TT_ID"]),
                    TT_Title = dr["TT_Title"].ToString(),
                    TT_Date = Convert.ToDateTime(dr["TT_DateStart"]).ToString("dd/MM/yyyy") + " - " + Convert.ToDateTime(dr["TT_DateEnd"]).ToString("dd/MM/yyyy"),
                    TT_TaskStatus = dr["TT_TaskStatus"].ToString()
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list);
            context.Response.Write(strJson);
        }
        private void AddTaskListTotal(HttpContext context)
        {
            //throw new NotImplementedException();
            BLL.TaskTotal bll = new BLL.TaskTotal();
            Model.TaskTotal model = new Model.TaskTotal();

            model.TT_Release = context.Request["TT_Release"].ToString();
            model.TT_CU = context.Request["TT_CU"].ToString();
            model.TT_BuildType = context.Request["TT_BuildType"].ToString();
            model.TT_BuildNum = context.Request["TT_BuildNum"].ToString();
            model.TT_TaskType = context.Request["TT_TaskType"].ToString();
            model.TT_CaseTotalNum = context.Request["TT_CaseTotalNum"].ToString();
            model.TT_CaseRealRunNum = "0";
            model.TT_DateStart = Convert.ToDateTime(context.Request["TT_DateStart"]).ToString("yyyy-MM-dd");
            model.TT_DateEnd = Convert.ToDateTime(context.Request["TT_DateEnd"]).ToString("yyyy-MM-dd");
            model.TT_TaskStyle = context.Request["TT_TaskStyle"].ToString();
            model.TT_BugIssueNum = "999999,888888,777777";
            model.TT_ReportLink = "http://TestLink.com";
            model.TT_Comments = context.Request["TT_Comments"].ToString();
            model.TT_CreateDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            model.TT_Title = context.Request["TT_Title"].ToString();
            model.TT_TaskProgress = "0";
            model.TT_TaskStatus = "Pending";
            model.TT_HaveScenario = "No";
            model.TT_ServerClient = context.Request["TT_ServerClient"].ToString();

            int iRows = bll.Add(model);
            if (iRows > 0)
            {
                context.Response.Write(iRows);
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void QueryTestJQTable(HttpContext context)
        {
            //JavaScriptSerializer jss = new JavaScriptSerializer();
            //string strJson = jss.Serialize(GetTestData2());
            context.Response.Write(GetTestData2());
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        #region GetTestData

        private string GetTestData2()
        {
            StringBuilder sb = new StringBuilder();
            string[] arrJson = File.ReadAllLines(HttpContext.Current.Server.MapPath("../") + "TaskManage\\JsonDataCity.txt");
            foreach (string item in arrJson)
            {
                sb.Append(item);
            }
            return sb.ToString();
        }

        private string GetTestData()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("{\"data\": [[\"Tiger Nixon\",\"System Architect\",\"Edinburgh\",\"5421\",\"2011/04/25\",\"$320,800\"],");
            sb.Append("[\"Garrett Winters\",\"Accountant\",\"Tokyo\",\"8422\",\"2011/07/25\",\"$170,750\"],");
            sb.Append("[\"Ashton Cox\",\"Junior Technical Author\",\"San Francisco\",\"1562\",\"2009/01/12\",\"$86,000\"],");
            sb.Append("[\"Cedric Kelly\",\"Senior Javascript Developer\",\"Edinburgh\",\"6224\",\"2012/03/29\",\"$433,060\"],");
            sb.Append("[\"Airi Satou\",\"Accountant\",\"Tokyo\",\"5407\",\"2008/11/28\",\"$162,700\"],");
            sb.Append("[\"Brielle Williamson\",\"Integration Specialist\",\"New York\",\"4804\",\"2012/12/02\",\"$372,000\"],");
            sb.Append("[\"Herrod Chandler\",\"Sales Assistant\",\"San Francisco\",\"9608\",\"2012/08/06\",\"$137,500\"],");
            sb.Append("[\"Ashton Cox\",\"Junior Technical Author\",\"San Francisco\",\"1562\",\"2009/01/12\",\"$86,000\"],");
            sb.Append("[\"Cedric Kelly\",\"Senior Javascript Developer\",\"Edinburgh\",\"6224\",\"2012/03/29\",\"$433,060\"],");
            sb.Append("[\"Airi Satou\",\"Accountant\",\"Tokyo\",\"5407\",\"2008/11/28\",\"$162,700\"],");
            sb.Append("[\"Brielle Williamson\",\"Integration Specialist\",\"New York\",\"4804\",\"2012/12/02\",\"$372,000\"],");
            sb.Append("[\"Herrod Chandler\",\"Sales Assistant\",\"San Francisco\",\"9608\",\"2012/08/06\",\"$137,500\"],");
            sb.Append("[\"Rhona Davidson\",\"Integration Specialist\",\"Tokyo\",\"6200\",\"2010/10/14\",\"$327,900\"]]}");
            #region DataFailed
            //sb.Append("{'data': [['Tiger Nixon','System Architect','Edinburgh','5421','2011/04/25','$320,800'],");
            //sb.Append("['Garrett Winters','Accountant','Tokyo','8422','2011/07/25','$170,750'],");
            //sb.Append("['Ashton Cox','Junior Technical Author','San Francisco','1562','2009/01/12','$86,000'],");
            //sb.Append("['Cedric Kelly','Senior Javascript Developer','Edinburgh','6224','2012/03/29','$433,060'],");
            //sb.Append("['Airi Satou','Accountant','Tokyo','5407','2008/11/28','$162,700'],");
            //sb.Append("['Brielle Williamson','Integration Specialist','New York','4804','2012/12/02','$372,000'],");
            //sb.Append("['Herrod Chandler','Sales Assistant','San Francisco','9608','2012/08/06','$137,500'],");
            //sb.Append("['Rhona Davidson','Integration Specialist','Tokyo','6200','2010/10/14','$327,900']]}");
            #endregion

            return sb.ToString();
        }


        #endregion
    }
}