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
    public partial class BugIssue
    {
        public BugIssue()
        { }

        public DataSet GetSingle(int BI_ID)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * from BugIssue where BI_ID=");
            strSql.Append(BI_ID);
            return DbHelperSQL.Query(strSql.ToString());
        }

        public int Add(Model.BugIssue model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into BugIssue (");
            strSql.Append("BI_FK_SR_ID,BI_FK_S_ID,BI_FK_TT_ID,BI_Title,BI_Type,BI_Content,BI_EnvironmentServer,BI_TopologyName,BI_Remark,BI_CaseNumber,BI_CreateDate,BI_Status,BI_Owner,BI_UpdateTime,BI_ReferenceBIID) values (");
            strSql.Append("@BI_FK_SR_ID,@BI_FK_S_ID,@BI_FK_TT_ID,@BI_Title,@BI_Type,@BI_Content,@BI_EnvironmentServer,@BI_TopologyName,@BI_Remark,@BI_CaseNumber,@BI_CreateDate,@BI_Status,@BI_Owner,@BI_UpdateTime,@BI_ReferenceBIID)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
                new SqlParameter("@BI_FK_SR_ID",SqlDbType.Int,4),
                new SqlParameter("@BI_FK_S_ID",SqlDbType.Int,4),
                new SqlParameter("@BI_FK_TT_ID",SqlDbType.Int,4),
                new SqlParameter("@BI_Title",SqlDbType.VarChar,300),
                new SqlParameter("@BI_Type",SqlDbType.VarChar,10),
                new SqlParameter("@BI_Content",SqlDbType.VarChar),
                new SqlParameter("@BI_EnvironmentServer",SqlDbType.VarChar,100),
                new SqlParameter("@BI_TopologyName",SqlDbType.VarChar,50),
                new SqlParameter("@BI_Remark",SqlDbType.VarChar),
                new SqlParameter("@BI_CaseNumber",SqlDbType.VarChar,100),
                new SqlParameter("@BI_CreateDate",SqlDbType.VarChar,20),
                new SqlParameter("@BI_Status",SqlDbType.VarChar,10),
                new SqlParameter("@BI_Owner",SqlDbType.Int,4),
                new SqlParameter("@BI_UpdateTime",SqlDbType.VarChar,20),
                new SqlParameter("@BI_ReferenceBIID",SqlDbType.Int,4)
            };
            parameters[0].Value = model.BI_FK_SR_ID;
            parameters[1].Value = model.BI_FK_S_ID;
            parameters[2].Value = model.BI_FK_TT_ID;
            parameters[3].Value = model.BI_Title;
            parameters[4].Value = model.BI_Type;
            parameters[5].Value = model.BI_Content;
            parameters[6].Value = model.BI_EnvironmentServer;
            parameters[7].Value = model.BI_TopologyName;
            parameters[8].Value = model.BI_Remark;
            parameters[9].Value = model.BI_CaseNumber;
            parameters[10].Value = model.BI_CreateDate;
            parameters[11].Value = model.BI_Status;
            parameters[12].Value = model.BI_Owner;
            parameters[13].Value = model.BI_UpdateTime;
            parameters[14].Value = model.BI_ReferenceBIID;
            object obj = DbHelperSQL.GetSingle(strSql.ToString(), parameters);
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }

        public DataSet GetList(string strWhere)
        {
            StringBuilder sbSql = new StringBuilder();
            sbSql.Append("select * from BugIssue ");
            if (strWhere != "")
            {
                sbSql.Append(" where " + strWhere);
            }
            sbSql.Append(" order by BI_ID DESC ");
            return DbHelperSQL.Query(sbSql.ToString());
        }
    }
}
