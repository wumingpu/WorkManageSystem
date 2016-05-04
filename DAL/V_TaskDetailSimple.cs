using Maticsoft.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public partial class V_TaskDetailSimple
    {
        public DataSet GetList(string strWhere,int CompleteCaseNum)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            if (CompleteCaseNum >=0)
            {
                strSql.Append(" top ((select count(*) from V_TaskDetailSimple where TD_Status in ('Pending','InProgress')");
                if (strWhere != "")
                {
                    strSql.Append(" and ");
                    strSql.Append(strWhere);
                }
                strSql.Append(string.Format(")+{0})", CompleteCaseNum));
            }
            strSql.Append(" * from V_TaskDetailSimple where TD_IsDelete='0' ");
            if (strWhere != "")
            {
                strSql.Append(" and ");
                strSql.Append(strWhere);
            }
            strSql.Append(" Order by CHARINDEX(TD_Status,'Pending,InProgress,Complete'),TD_CardType DESC,TD_TimeEnd DESC");
            return DbHelperSQL.Query(strSql.ToString());
        }
        public bool UpdateCaseNumTotalDaily(int TT_ID, string PassedGrow, string FailedGrow, string NAGrow, string RedmondGrow)
        {
            DAL.TaskDaily dal = new DAL.TaskDaily();
            string DateNow = DateTime.Now.ToString("yyyy-MM-dd");
            string DateTimeNow = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            int SumGrow = int.Parse(PassedGrow) + int.Parse(FailedGrow) + int.Parse(NAGrow) + int.Parse(RedmondGrow);
            int ExistRes = dal.Exist(string.Format("TD_FK_TaskTotalID={0} and TD_Date='{1}'", TT_ID, DateNow));
            StringBuilder strSql = new StringBuilder();
            if (ExistRes == 0)
            {
                strSql.Append("insert into TaskDaily (TD_FK_TaskTotalID,TD_Date,TD_CaseShouldRunNum,TD_CaseRealRunNum,TD_CasePassNum,TD_CaseNANum,TD_CaseFailNum,TD_CaseRunInRedmond,TD_CreateDate,TD_TaskProgress,TD_TaskStatus) values (");
                strSql.Append(string.Format("{0},'{1}',(select AVG(cast(TD_CaseShouldRunNum as int)) from TaskDaily where TD_FK_TaskTotalID={2}),'{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}');", TT_ID, DateNow, TT_ID, SumGrow, PassedGrow, NAGrow, FailedGrow, RedmondGrow, DateTimeNow, 0, "InProgress"));
                strSql.Append(string.Format("declare @TD_Count int; set @TD_Count = (select COUNT(*) from TaskDaily where TD_FK_TaskTotalID={0});", TT_ID));
                strSql.Append("declare @TD_AvgCaseNum int; set @TD_AvgCaseNum = ((select AVG(cast(TD_CaseShouldRunNum as int)) from TaskDaily));");
                strSql.Append(string.Format("update TaskDaily set TD_CaseShouldRunNum=(((@TD_AvgCaseNum)*(@TD_Count - 1))/(@TD_Count)) where TD_FK_TaskTotalID={0};", TT_ID));
                strSql.Append(string.Format("update TaskDaily set TD_TaskProgress=cast((cast(TD_CaseRealRunNum as decimal)/cast(TD_CaseShouldRunNum as decimal))*100 as int) where TD_FK_TaskTotalID={0};", TT_ID));
            }
            else
            {
                strSql.Append(string.Format("update TaskDaily set TD_CasePassNum=cast(TD_CasePassNum as int)+{0},TD_CaseFailNum=cast(TD_CaseFailNum as int)+{1},TD_CaseNANum=cast(TD_CaseNANum as int)+{2},TD_CaseRunInRedmond=cast(TD_CaseRunInRedmond as int)+{3},TD_CaseRealRunNum=cast(TD_CaseRealRunNum as int)+{4},TD_TaskProgress=CAST(((CAST(TD_CaseRealRunNum+{4} as decimal))/(CAST(TD_CaseShouldRunNum as decimal)))*100 as int) where TD_FK_TaskTotalID={5} and TD_Date='{6}';", PassedGrow, FailedGrow, NAGrow, RedmondGrow, SumGrow, TT_ID, DateNow));
            }
            strSql.Append(string.Format("update TaskTotal set TT_CaseRealRunNum=cast(TT_CaseRealRunNum as int)+{0}, TT_TaskProgress=cast((cast(cast(TT_CaseRealRunNum as int)+{0} as decimal)/cast(TT_CaseTotalNum as decimal))*100 as int) where TT_ID={1};", SumGrow, TT_ID));
            int updateRes = DbHelperSQL.ExecuteSql(strSql.ToString());
            if (updateRes > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public bool AddProgressNum(int TD_ID, string TD_CardType, string CasePassed, string CaseFailed, string CaseNA, string CaseRedmond, string Progress)
        { // 只更新任务数
            StringBuilder strSql = new StringBuilder();
            if (TD_CardType == "public")
            {
                strSql.Append(string.Format("update ScenarioRole set SR_CasePassed='{0}',SR_CaseFailed='{1}',SR_CaseNA='{2}',SR_CaseRedmond='{3}',SR_CompleteProgress='{4}' where SR_ID={5}", CasePassed, CaseFailed, CaseNA, CaseRedmond, Progress, TD_ID));
            }
            else if (TD_CardType == "private")
            {
                strSql.Append(string.Format("update TaskPersonal set TP_Progress='{0}' where TP_ID={1}", Progress, TD_ID));
            }
            int UpdateRes = DbHelperSQL.ExecuteSql(strSql.ToString());
            if (UpdateRes > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        //, string CasePassed, string CaseFailed, string CaseNA, string CaseRedmond
        //SR_CasePassed=CAST(SR_CasePassed as int)+{2},SR_CaseFailed=CAST(SR_CaseFailed as int)+{3},SR_CaseNA=CAST(SR_CaseNA as int)+{4},SR_CaseRedmond=CAST(SR_CaseRedmond as int)+{5},
        public bool TaskToDo2Doing(int TD_ID, string TD_CardType)
        {
            StringBuilder strSql = new StringBuilder();
            string DateTimeNow = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            if (TD_CardType == "public")
            {
                strSql.Append(string.Format("update ScenarioRole set SR_TimeStart='{0}',SR_Status='InProgress' where SR_ID={1}", DateTimeNow, TD_ID));
            }
            else if (TD_CardType == "private")
            {
                strSql.Append(string.Format("update TaskPersonal set TP_TimeStart='{0}',TP_Status='InProgress' where TP_ID={1}", DateTimeNow, TD_ID));
            }
            int UpdateRes = DbHelperSQL.ExecuteSql(strSql.ToString());
            if (UpdateRes > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public bool TaskDoing2Done(int TD_ID, string TD_CardType, string CasePassed, string CaseFailed, string CaseNA, string CaseRedmond, string Progress, string TD_CompleteReason)
        { // 增加任务数更新
            StringBuilder strSql = new StringBuilder();
            string DateTimeNow = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            if (TD_CardType == "public")
            {
                strSql.Append(string.Format("update ScenarioRole set  SR_CasePassed='{2}',SR_CaseFailed='{3}',SR_CaseNA='{4}',SR_CaseRedmond='{5}',SR_TimeEnd='{0}',SR_TimeUsed=DATEDIFF(minute,SR_TimeStart,'{0}'),SR_Status='Complete',SR_CompleteProgress='{6}',SR_CompleteReason='{7}' where SR_ID={1}", DateTimeNow, TD_ID, CasePassed, CaseFailed, CaseNA, CaseRedmond,Progress,TD_CompleteReason));
            }
            else if (TD_CardType == "private")
            {
                strSql.Append(string.Format("update TaskPersonal set TP_TimeEnd='{0}',TP_TimeUsed=DATEDIFF(minute,TP_TimeStart,'{0}'),TP_Status='Complete',TP_Progress='{2}',TP_CompleteReason='{3}' where TP_ID={1}", DateTimeNow, TD_ID,Progress,TD_CompleteReason));
            }
            int UpdateRes = DbHelperSQL.ExecuteSql(strSql.ToString());
            if (UpdateRes > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public bool TaskToDo2Done(int TD_ID, string TD_CardType, string TimeStart, string TimeEnd, string CasePassed, string CaseFailed, string CaseNA, string CaseRedmond, string Progress, string TD_CompleteReason)
        { // 增加更新任务数
            StringBuilder strSql = new StringBuilder();
            if (TD_CardType == "public")
            {
                strSql.Append(string.Format("update ScenarioRole set SR_CasePassed='{3}',SR_CaseFailed='{4}',SR_CaseNA='{5}',SR_CaseRedmond='{6}',SR_TimeStart='{0}',SR_TimeEnd='{1}',SR_TimeUsed=DATEDIFF(minute,'{0}','{1}'),SR_Status='Complete',SR_CompleteProgress='{7}',SR_CompleteReason='{8}' where SR_ID={2}", TimeStart, TimeEnd, TD_ID, CasePassed, CaseFailed, CaseNA, CaseRedmond, Progress, TD_CompleteReason));
            }
            else if (TD_CardType == "private")
            {
                strSql.Append(string.Format("update TaskPersonal set TP_TimeStart='{0}',TP_TimeEnd='{1}',TP_TimeUsed=DATEDIFF(minute,'{0}','{1}'),TP_Status='Complete',TP_Progress='{3}',TP_CompleteReason='{4}' where TP_ID={2}", TimeStart, TimeEnd, TD_ID, Progress, TD_CompleteReason));
            }
            int UpdateRes = DbHelperSQL.ExecuteSql(strSql.ToString());
            if (UpdateRes > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
