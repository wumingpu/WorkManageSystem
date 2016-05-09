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
    public partial class BugIssueReply
    {
        public BugIssueReply()
        { }

        public int Add(Model.BugIssueReply model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into BugIssueReply (BIR_FK_BI_ID,BIR_Content,BIR_CreateTime,BIR_CreateUser) values (");
            strSql.Append("@BIR_FK_BI_ID,@BIR_Content,@BIR_CreateTime,@BIR_CreateUser)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
                new SqlParameter("@BIR_FK_BI_ID",SqlDbType.Int,4),
                new SqlParameter ("@BIR_Content",SqlDbType.NVarChar),
                new SqlParameter ("@BIR_CreateTime",SqlDbType.VarChar,20),
                new SqlParameter("@BIR_CreateUser",SqlDbType.Int,4)
            };
            parameters[0].Value = model.BIR_FK_BI_ID;
            parameters[1].Value = model.BIR_Content;
            parameters[2].Value = model.BIR_CreateTime;
            parameters[3].Value = model.BIR_CreateUser;

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
    }
}
