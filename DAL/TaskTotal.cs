using Maticsoft.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public partial class TaskTotal
    {
        public TaskTotal()
        {

        }

        public bool StartTaskTotal(int TT_ID)
        {
            StringBuilder strSql = new StringBuilder();
            string DateTimeNow = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            strSql.Append(string.Format("update TaskTotal set TT_TimeStart='{0}',TT_TaskStatus='InProgress' where TT_ID={1};", DateTimeNow, TT_ID));
            strSql.Append(string.Format("update ScenarioRole set SR_Status='Pending' where SR_FK_TT_ID={0}", TT_ID));
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
        public bool EndTaskTotal(int TT_ID, string TT_Progress, string TT_CompleteReason)
        {
            StringBuilder strSql = new StringBuilder();
            string DateTimeNow = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            strSql.Append(string.Format("update TaskTotal set TT_TaskProgress='{0}',TT_CompleteReason='{1}',TT_TaskStatus='Complete',TT_TimeEnd='{3}',TT_TimeUsed=DATEDIFF(minute,TT_TimeStart,'{3}') where TT_ID={2}", TT_Progress, TT_CompleteReason, TT_ID, DateTimeNow));
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

        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * from TaskTotal");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by TT_ID desc");
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet GetList(int ListItemNumber, string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            if (ListItemNumber > 0)
            {
                strSql.Append("top ");
                strSql.Append(ListItemNumber);
            }
            strSql.Append(" * from TaskTotal");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by TT_ID desc");
            return DbHelperSQL.Query(strSql.ToString());
        }

        public Model.TaskTotal GetModel(int ID)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select top 1 * from TaskTotal ");
            strSql.Append("where TT_ID=@TT_ID");
            SqlParameter[] parameters = {
                                        new SqlParameter("@TT_ID",SqlDbType.Int,4)
                                        };
            parameters[0].Value = ID;
            Model.TaskTotal model = new Model.TaskTotal();
            DataSet ds = DbHelperSQL.Query(strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow dr = ds.Tables[0].Rows[0];
                model.TT_ID = Convert.ToInt32(dr["TT_ID"]);
                model.TT_Release = dr["TT_Release"].ToString();
                model.TT_CU = dr["TT_CU"].ToString();
                model.TT_BuildType = dr["TT_BuildType"].ToString();
                model.TT_BuildNum = dr["TT_BuildNum"].ToString();
                model.TT_TaskType = dr["TT_TaskType"].ToString();
                model.TT_CaseTotalNum = dr["TT_CaseTotalNum"].ToString();
                model.TT_CaseRealRunNum = dr["TT_CaseRealRunNum"].ToString();
                model.TT_DateStart = dr["TT_DateStart"].ToString();
                model.TT_DateEnd = dr["TT_DateEnd"].ToString();
                model.TT_TaskStyle = dr["TT_TaskStyle"].ToString();
                model.TT_BugIssueNum = dr["TT_BugIssueNum"].ToString();
                model.TT_ReportLink = dr["TT_ReportLink"].ToString();
                model.TT_Comments = dr["TT_Comments"].ToString();
                model.TT_CreateDate = dr["TT_CreateDate"].ToString();
                model.TT_TaskProgress = dr["TT_TaskProgress"].ToString();
                model.TT_TaskStatus = dr["TT_TaskStatus"].ToString();
                model.TT_HaveScenario = dr["TT_HaveScenario"].ToString();
                model.TT_TimeStart = dr["TT_TimeStart"].ToString();
                model.TT_TimeEnd = dr["TT_TimeEnd"].ToString();
                model.TT_TimeUsed = dr["TT_TimeUsed"].ToString();
                model.TT_Title = dr["TT_Title"].ToString();
                model.TT_CompleteReason = dr["TT_CompleteReason"].ToString();
                model.TT_ServerClient = dr["TT_ServerClient"].ToString();
                return model;
            }
            else
            {
                return null;
            }
        }

        public int Add(Model.TaskTotal model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into TaskTotal(");
            strSql.Append("TT_Release,TT_CU,TT_BuildType,TT_BuildNum,TT_TaskType,TT_CaseTotalNum,TT_CaseRealRunNum,TT_DateStart,TT_DateEnd,TT_TaskStyle,TT_BugIssueNum,TT_ReportLink,TT_Comments,TT_CreateDate,TT_Title,TT_TaskProgress,TT_TaskStatus,TT_HaveScenario,TT_ServerClient)");
            strSql.Append(" values (");
            strSql.Append("@TT_Release,@TT_CU,@TT_BuildType,@TT_BuildNum,@TT_TaskType,@TT_CaseTotalNum,@TT_CaseRealRunNum,@TT_DateStart,@TT_DateEnd,@TT_TaskStyle,@TT_BugIssueNum,@TT_ReportLink,@TT_Comments,@TT_CreateDate,@TT_Title,@TT_TaskProgress,@TT_TaskStatus,@TT_HaveScenario,@TT_ServerClient)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
                        new SqlParameter("@TT_Release",SqlDbType.VarChar,10),
                        new SqlParameter("@TT_CU",SqlDbType.VarChar,10),
                        new SqlParameter("@TT_BuildType",SqlDbType.VarChar,20),
                        new SqlParameter("@TT_BuildNum",SqlDbType.VarChar,20),
                        new SqlParameter("@TT_TaskType",SqlDbType.VarChar,20),
                        new SqlParameter("@TT_CaseTotalNum",SqlDbType.VarChar,10),
                        new SqlParameter("@TT_CaseRealRunNum",SqlDbType.VarChar,10),
                        new SqlParameter("@TT_DateStart",SqlDbType.VarChar,10),
                        new SqlParameter("@TT_DateEnd",SqlDbType.VarChar,10),
                        new SqlParameter("@TT_TaskStyle",SqlDbType.VarChar,10),
                        new SqlParameter("@TT_BugIssueNum",SqlDbType.VarChar),
                        new SqlParameter("@TT_ReportLink",SqlDbType.VarChar),
                        new SqlParameter("@TT_Comments",SqlDbType.VarChar),
                        new SqlParameter("@TT_CreateDate",SqlDbType.VarChar,20),
                        new SqlParameter("@TT_Title",SqlDbType.VarChar,300),
                        new SqlParameter("@TT_TaskProgress",SqlDbType.VarChar,10),
                        new SqlParameter("@TT_TaskStatus",SqlDbType.VarChar,10),
                        new SqlParameter("@TT_HaveScenario",SqlDbType.VarChar,5),
                        new SqlParameter("@TT_ServerClient",SqlDbType.VarChar,20)
            };
            parameters[0].Value = model.TT_Release;
            parameters[1].Value = model.TT_CU;
            parameters[2].Value = model.TT_BuildType;
            parameters[3].Value = model.TT_BuildNum;
            parameters[4].Value = model.TT_TaskType;
            parameters[5].Value = model.TT_CaseTotalNum;
            parameters[6].Value = model.TT_CaseRealRunNum;
            parameters[7].Value = model.TT_DateStart;
            parameters[8].Value = model.TT_DateEnd;
            parameters[9].Value = model.TT_TaskStyle;
            parameters[10].Value = model.TT_BugIssueNum;
            parameters[11].Value = model.TT_ReportLink;
            parameters[12].Value = model.TT_Comments;
            parameters[13].Value = model.TT_CreateDate;
            parameters[14].Value = model.TT_Title;
            parameters[15].Value = model.TT_TaskProgress;
            parameters[16].Value = model.TT_TaskStatus;
            parameters[17].Value = model.TT_HaveScenario;
            parameters[18].Value = model.TT_ServerClient;

            object obj = DbHelperSQL.GetSingle(strSql.ToString(), parameters);
            if (obj == null)
            {
                return 0;
            }
            else
            {
                //return Convert.ToInt32(obj);
                int TT_ID = Convert.ToInt32(obj);
                bool resAddDailyTask = AddTaskDaily(TT_ID, model.TT_DateStart, model.TT_DateEnd, model.TT_CaseTotalNum);
                if (resAddDailyTask)
                {
                    return Convert.ToInt32(TT_ID);
                }
                else
                {
                    return 0;
                }
            }
        }
        public bool AddTaskDaily(int TT_ID, string TT_DateStart, string TT_DateEnd, string CaseNum)
        {
            DateTime DateStart = Convert.ToDateTime(TT_DateStart);
            DateTime DateEnd = Convert.ToDateTime(TT_DateEnd);
            int days = (DateEnd - DateStart).Days + 1; // 需要包含最后一天
            int CasenumEveryday = Convert.ToInt32(CaseNum) / days;
            StringBuilder sbSql = new StringBuilder();
            for (int i = 0; i < days; i++)
            {
                sbSql.Append(
                    string.Format("insert into TaskDaily(TD_FK_TaskTotalID,TD_Date,TD_CaseShouldRunNum,TD_CaseRealRunNum,TD_CasePassNum,TD_CaseNANum,TD_CaseFailNum,TD_CaseRunInRedmond,TD_Comments,TD_CreateDate,TD_TaskProgress,TD_TaskStatus) values ({0},'{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}');",
                    TT_ID, DateStart.AddDays(i).ToString("yyyy-MM-dd"), CasenumEveryday, 0, 0, 0, 0, 0, "", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), 0, "InProgress")
                    );
            }
            int resAdd = DbHelperSQL.ExecuteSql(sbSql.ToString());
            if (resAdd == days)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool Update(Model.TaskTotal model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update TaskTotal set ");
            strSql.Append("TT_Release=@TT_Release,");
            strSql.Append("TT_CU=@TT_CU,");
            strSql.Append("TT_BuildType=@TT_BuildType,");
            strSql.Append("TT_BuildNum=@TT_BuildNum,");
            strSql.Append("TT_TaskType=@TT_TaskType,");
            strSql.Append("TT_CaseTotalNum=@TT_CaseTotalNum,");
            strSql.Append("TT_CaseRealRunNum=@TT_CaseRealRunNum,");
            strSql.Append("TT_DateStart=@TT_DateStart,");
            strSql.Append("TT_DateEnd=@TT_DateEnd,");
            strSql.Append("TT_TaskStyle=@TT_TaskStyle,");
            strSql.Append("TT_BugIssueNum=@TT_BugIssueNum,");
            strSql.Append("TT_ReportLink=@TT_ReportLink,");
            strSql.Append("TT_Comments=@TT_Comments,");
            strSql.Append("TT_ServerClient=@TT_ServerClient");
            strSql.Append(" where TT_ID=@TT_ID");
            SqlParameter[] parameters = {
                        new SqlParameter("@TT_Release",SqlDbType.VarChar,10),
                        new SqlParameter("@TT_CU",SqlDbType.VarChar,10),
                        new SqlParameter("@TT_BuildType",SqlDbType.VarChar,20),
                        new SqlParameter("@TT_BuildNum",SqlDbType.VarChar,20),
                        new SqlParameter("@TT_TaskType",SqlDbType.VarChar,20),
                        new SqlParameter("@TT_CaseTotalNum",SqlDbType.VarChar,10),
                        new SqlParameter("@TT_CaseRealRunNum",SqlDbType.VarChar,10),
                        new SqlParameter("@TT_DateStart",SqlDbType.VarChar,10),
                        new SqlParameter("@TT_DateEnd",SqlDbType.VarChar,10),
                        new SqlParameter("@TT_TaskStyle",SqlDbType.VarChar,10),
                        new SqlParameter("@TT_BugIssueNum",SqlDbType.VarChar),
                        new SqlParameter("@TT_ReportLink",SqlDbType.VarChar),
                        new SqlParameter("@TT_Comments",SqlDbType.VarChar),
                        new SqlParameter("@TT_ServerClient",SqlDbType.VarChar,20),
                        new SqlParameter("@TT_ID",SqlDbType.Int,4)};
            parameters[0].Value = model.TT_Release;
            parameters[1].Value = model.TT_CU;
            parameters[2].Value = model.TT_BuildType;
            parameters[3].Value = model.TT_BuildNum;
            parameters[4].Value = model.TT_TaskType;
            parameters[5].Value = model.TT_CaseTotalNum;
            parameters[6].Value = model.TT_CaseRealRunNum;
            parameters[7].Value = model.TT_DateStart;
            parameters[8].Value = model.TT_DateEnd;
            parameters[9].Value = model.TT_TaskStyle;
            parameters[10].Value = model.TT_BugIssueNum;
            parameters[11].Value = model.TT_ReportLink;
            parameters[12].Value = model.TT_Comments;
            parameters[13].Value = model.TT_ServerClient;
            parameters[14].Value = model.TT_ID;

            int rows = DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public bool UpdateHaveScenario(int TT_ID, bool YorN)
        {
            StringBuilder strSql = new StringBuilder();
            if (YorN)
            {
                strSql.Append("update TaskTotal set TT_HaveScenario='Yes' where TT_ID=");
            }
            else
            {
                strSql.Append("update TaskTotal set TT_HaveScenario='No' where TT_ID=");
            }
            strSql.Append(TT_ID);
            int rows = DbHelperSQL.ExecuteSql(strSql.ToString());
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool Delete(int TT_ID)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from TaskTotal ");
            strSql.Append(" where TT_ID=@TT_ID");
            SqlParameter[] parameters = {
                        new SqlParameter("@TT_ID",SqlDbType.Int,4)};
            parameters[0].Value = TT_ID;

            int rows = DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
            if (rows > 0)
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
