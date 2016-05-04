using Maticsoft.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public partial class V_TaskDetail
    {
        public V_TaskDetail()
        { }

        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * from V_TaskDetail where TD_IsDelete='0' ");
            if (strWhere != "")
            {
                strSql.Append(" and ");
                strSql.Append(strWhere);
            }
            DataSet ds = DbHelperSQL.Query(strSql.ToString());
            return ds;
        }


    }
}
