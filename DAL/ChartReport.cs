using Maticsoft.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public partial class ChartReport
    {
        public ChartReport()
        { }

        public DataSet BarMonthTasknumber(string Year)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select MONTH(TT_DateStart) CR_Month,count(TT_ID) CR_TaskNumber from TaskTotal where YEAR(TT_DateStart)=");
            strSql.Append(Year);
            strSql.Append(" group by MONTH(TT_DateStart)");
            return DbHelperSQL.Query(strSql.ToString());
        }
    }
}
