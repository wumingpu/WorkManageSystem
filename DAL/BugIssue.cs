using Maticsoft.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public partial class BugIssue
    {
        public BugIssue()
        { }

        public DataSet GetList(string strWhere)
        {
            StringBuilder sbSql = new StringBuilder();
            sbSql.Append("select * from BugIssue ");
            if (strWhere!="")
            {
                sbSql.Append(" where " + strWhere);
            }
            sbSql.Append(" order by BI_ID DESC ");
            return DbHelperSQL.Query(sbSql.ToString());
        }
    }
}
