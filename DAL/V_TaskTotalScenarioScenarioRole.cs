using Maticsoft.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public partial class V_TaskTotalScenarioScenarioRole
    {
        public V_TaskTotalScenarioScenarioRole()
        { }

        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * from V_TaskTotalScenarioScenarioRole");
            if (strWhere != "")
            {
                strSql.Append(" where ");
                strSql.Append(strWhere);
            }
            strSql.Append(" order by SR_FK_TT_ID DESC;");
            return DbHelperSQL.Query(strSql.ToString());
        }
    }
}
