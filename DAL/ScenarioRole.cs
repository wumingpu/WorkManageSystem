using Maticsoft.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public partial class ScenarioRole
    {
        public ScenarioRole()
        { }
        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * from ScenarioRole");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by SR_ID asc");
            return DbHelperSQL.Query(strSql.ToString());
        }
        public int Exist(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(*) from ScenarioRole ");
            if (strWhere != "")
            {
                strSql.Append(" where ");
                strSql.Append(strWhere);
            }
            object obj = DbHelperSQL.GetSingle(strSql.ToString());
            if (obj == null)
            {
                return -1;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }

        public bool AddBatch(List<Model.ScenarioRoleForJson> list, int SR_FK_S_ID, int SR_FK_TT_ID, int User_ID)
        {
            StringBuilder strSql = new StringBuilder();
            string DateTimeNow = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            foreach (Model.ScenarioRoleForJson model in list)
            {
                strSql.Append("insert into ScenarioRole (SR_FK_S_ID,SR_FK_TT_ID,SR_RoleTitle,SR_CaseNum,SR_AssignedUser,SR_AssignedUserName,SR_CasePassed,SR_CaseNA,SR_CaseFailed,SR_CaseRedmond,SR_CompleteProgress,SR_CreateUser,SR_Comments,SR_CreateDate,SR_Status,SR_IsDelete) values (");
                strSql.Append(string.Format("{0},{1},'{2}',{3},'{4}','{5}','0','0','0','0','0','{7}','','{6}','','0');", SR_FK_S_ID, SR_FK_TT_ID, model.SR_RoleTitle, model.SR_CaseNum, model.SR_AssignedUser, model.SR_AssignedUserName, DateTimeNow, User_ID));
            }
            int AddRes = DbHelperSQL.ExecuteSql(strSql.ToString());
            if (AddRes == list.Count)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public int Add(Model.ScenarioRole model)
        {
            StringBuilder strSql = new StringBuilder();
            string DateTimeNow = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            strSql.Append("insert into ScenarioRole (SR_FK_S_ID,SR_FK_TT_ID,SR_RoleTitle,SR_CaseNum,SR_AssignedUser,SR_AssignedUserName,SR_CasePassed,SR_CaseNA,SR_CaseFailed,SR_CaseRedmond,SR_CompleteProgress,SR_CreateUser,SR_Comments,SR_CreateDate,SR_Status,SR_IsDelete) values (");
            strSql.Append(string.Format("{0},{1},'{2}',{3},'{4}','{5}','0','0','0','0','0','{6}','{7}','{8}','{9}','{10}');", model.SR_FK_S_ID, model.SR_FK_TT_ID, model.SR_RoleTitle, model.SR_CaseNum, model.SR_AssignedUser, model.SR_AssignedUserName, model.SR_CreateUser, model.SR_Comments, model.SR_CreateDate, model.SR_Status, model.SR_IsDelete));
            return DbHelperSQL.ExecuteSql(strSql.ToString());
        }

        public bool Update(Model.ScenarioRole model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update ScenarioRole set ");
            strSql.Append(string.Format("SR_AssignedUser='{0}',SR_AssignedUserName='{1}',SR_RoleTitle='{2}',", model.SR_AssignedUser, model.SR_AssignedUserName, model.SR_RoleTitle));
            strSql.Append(string.Format("SR_CaseNum='{0}' where SR_ID={1}", model.SR_CaseNum, model.SR_ID));
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

        public bool Delete(int SR_ID)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from ScenarioRole where SR_ID=");
            strSql.Append(SR_ID);
            int DelRes = DbHelperSQL.ExecuteSql(strSql.ToString());
            if (DelRes > 0)
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
