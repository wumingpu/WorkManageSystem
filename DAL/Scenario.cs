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
    public partial class Scenario
    {
        public Scenario()
        { }

        public bool UpdateHaveRole(int S_ID,bool HaveRole)
        {
            StringBuilder strSql = new StringBuilder();
            if (HaveRole)
            {
                strSql.Append("update Scenario set S_HaveRole='Yes' where S_ID=");
            }
            else
            {
                strSql.Append("update Scenario set S_HaveRole='No' where S_ID=");
            }
            strSql.Append(S_ID);
            int UpdateRes = DbHelperSQL.ExecuteSql(strSql.ToString());
            if (UpdateRes>0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public int Exist(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(*) from Scenario ");
            if (strWhere!="")
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

        public int Add(Model.Scenario model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into Scenario(S_FK_TT_ID,S_ScenarioName,S_CreateDate,S_IsDelete,S_HaveRole)");
            strSql.Append(" values ");
            strSql.Append("(@S_FK_TT_ID,@S_ScenarioName,@S_CreateDate,@S_IsDelete,@S_HaveRole)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = { 
                                        new SqlParameter("@S_FK_TT_ID",SqlDbType.Int,4),
                                        new SqlParameter("@S_ScenarioName",SqlDbType.VarChar,300),
                                        new SqlParameter("@S_CreateDate",SqlDbType.VarChar,20),
                                        new SqlParameter("@S_IsDelete",SqlDbType.Int,4),
                                        new SqlParameter("@S_HaveRole",SqlDbType.VarChar,5)
                                        };
            parameters[0].Value = model.S_FK_TT_ID;
            parameters[1].Value = model.S_ScenarioName;
            parameters[2].Value = model.S_CreateDate;
            parameters[3].Value = model.S_IsDelete;
            parameters[4].Value = model.S_HaveRole;

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

        public int AddBatch(int ScenarioNumber, Model.Scenario model)
        {
            string[] arrScenarioName = model.S_ScenarioNames.Split(new string[] { "@@" }, StringSplitOptions.RemoveEmptyEntries);
            StringBuilder strSql = new StringBuilder();
            foreach (string ScenarioName in arrScenarioName)
            {
                strSql.Append("insert into Scenario(S_FK_TT_ID,S_ScenarioName,S_CreateDate,S_IsDelete,S_HaveRole)");
                strSql.Append(string.Format(" values ({0},'{1}','{2}',{3},'{4}');", model.S_FK_TT_ID, ScenarioName, model.S_CreateDate,model.S_IsDelete,model.S_HaveRole));
            }
            int EffRow = DbHelperSQL.ExecuteSql(strSql.ToString());
            if (ScenarioNumber == EffRow)
            {
                return EffRow;
            }
            else
            {
                return 0;
            }
        }

        public bool Edit(Model.Scenario model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update Scenario set S_ScenarioName=@S_ScenarioName where S_ID=@S_ID");
            SqlParameter[] parameters = { 
                                        new SqlParameter("@S_ScenarioName",SqlDbType.VarChar,300),
                                        new SqlParameter("@S_ID",SqlDbType.Int,4)
                                        };
            parameters[0].Value = model.S_ScenarioName;
            parameters[1].Value = model.S_ID;
            int res = DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
            if (res > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool Delete(int S_ID)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from Scenario where S_ID=@S_ID");
            SqlParameter[] parameters = { 
                                        new SqlParameter("@S_ID",SqlDbType.Int,4)
                                        };
            parameters[0].Value = S_ID;
            int res = DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
            if (res>0)
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
