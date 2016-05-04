using Maticsoft.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public partial class V_TaskTotalScenario
    {
        public V_TaskTotalScenario()
        { }

        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * from V_TaskTotalScenario ");
            if (strWhere!="")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by S_FK_TT_ID DESC;");
            return DbHelperSQL.Query(strSql.ToString());
        }
    }
}
