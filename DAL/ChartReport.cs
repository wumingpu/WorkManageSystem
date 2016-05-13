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
            strSql.Append(" group by MONTH(TT_DateStart) order by CR_Month ASC");
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet BarTaskstyleCaseno(string strDateTime)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select TaskType,ISNULL(CaseNo,0) as CaseNo from (");
            strSql.Append(string.Format("select 'E2E' as TaskType, sum(convert(int, TT_CaseRealRunNum)) as CaseNo from TaskTotal where DATENAME(quarter, TT_TimeEnd) = DATENAME(QUARTER, '{0}') and TT_TaskType like 'E2E%'", strDateTime));
            strSql.Append(" union all ");
            strSql.Append(string.Format("select 'Hotfix' as TaskType, sum(convert(int, TT_CaseRealRunNum)) as CaseNo from TaskTotal where DATENAME(quarter, TT_TimeEnd) = DATENAME(QUARTER, '2016-05-13 11:37:25') and TT_TaskType like 'HotFix%'", strDateTime));
            strSql.Append(" union all ");
            strSql.Append(string.Format("select 'MU' as TaskType, sum(convert(int, TT_CaseRealRunNum)) as CaseNo from TaskTotal where DATENAME(quarter, TT_TimeEnd) = DATENAME(QUARTER, '2016-05-13 11:37:25') and TT_TaskType like 'MU%'", strDateTime));
            strSql.Append(" union all ");
            strSql.Append(string.Format("select 'Total' as TaskType, sum(convert(int, TT_CaseRealRunNum)) as CaseNo from TaskTotal where DATENAME(quarter, TT_TimeEnd) = DATENAME(QUARTER, '2016-05-13 11:37:25')) as T", strDateTime));
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet LineMonthCasenoRelease(string Year)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(string.Format("select Year(TT_TimeEnd) as YearNum,MONTH(TT_TimeEnd) as MonthNum,TT_Release,sum(convert(int,TT_CaseRealRunNum)) as CaseNo from TaskTotal where TT_TimeEnd between '{0}-01-01 00:00:00' and '{0}-12-31 24:59:59' group by TT_Release,MONTH(TT_TimeEnd),Year(TT_TimeEnd) order by YearNum ASC,MonthNum ASC,TT_Release ASC", Year));
            return DbHelperSQL.Query(strSql.ToString());
        }
    }
}
