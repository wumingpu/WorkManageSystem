using Maticsoft.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public partial class V_BugDetail
    {
        public V_BugDetail()
        { }

        public DataSet GetList(string Fields, string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            if (Fields == "*")
            {
                strSql.Append("*");
            }
            else
            {
                strSql.Append(Fields);
            }
            strSql.Append(" from V_BugDetail ");
            if (strWhere != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by BI_UpdateTime DESC,BI_ID DESC");
            return DbHelperSQL.Query(strSql.ToString());
        }
    }
}
