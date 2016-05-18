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
            strSql.Append(string.Format("select 'Hotfix' as TaskType, sum(convert(int, TT_CaseRealRunNum)) as CaseNo from TaskTotal where DATENAME(quarter, TT_TimeEnd) = DATENAME(QUARTER, '{0}') and TT_TaskType like 'HotFix%'", strDateTime));
            strSql.Append(" union all ");
            strSql.Append(string.Format("select 'MU' as TaskType, sum(convert(int, TT_CaseRealRunNum)) as CaseNo from TaskTotal where DATENAME(quarter, TT_TimeEnd) = DATENAME(QUARTER, '{0}') and TT_TaskType like 'MU%'", strDateTime));
            strSql.Append(" union all ");
            strSql.Append(string.Format("select 'Total' as TaskType, sum(convert(int, TT_CaseRealRunNum)) as CaseNo from TaskTotal where DATENAME(quarter, TT_TimeEnd) = DATENAME(QUARTER, '{0}')) as T", strDateTime));
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet LineMonthBugnoRelease(string Year)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select MONTH(BI_CreateDate) as MonthNum,TT_Release,count(BI_ID) as IssueNo from V_BugIssueTaskTotal");
            strSql.Append(" where TT_Release is not null ");
            strSql.Append(string.Format(" and BI_CreateDate between '{0}-01-01 00:00:00' and '{0}-12-31 23:59:59' ", Year));
            strSql.Append(" and BI_Type = 'Bug' ");
            strSql.Append(" group by TT_Release,MONTH(BI_CreateDate)");
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet PieIssuetypeIssueno(string strDateTime)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("declare @TotalNum decimal;");
            strSql.Append(string.Format("set @TotalNum = (select count(BI_ID) from BugIssue where DATENAME(quarter, BI_CreateDate) = DATENAME(QUARTER, '{0}') and BI_Type like '%Issue%');",strDateTime));
            strSql.Append("select T.*,round((T.IssueNo / @TotalNum) * 100, 0) as IssuePercent from(");
            strSql.Append(string.Format("select 'Confirm' as BI_Type, count(BI_ID) as IssueNo from BugIssue where DATENAME(quarter, BI_CreateDate) = DATENAME(QUARTER, '{0}') and BI_Type = 'Confirm Issue'", strDateTime));
            strSql.Append(" union all ");
            strSql.Append(string.Format("select 'MU' as BI_Type, count(BI_ID) as IssueNo from BugIssue where DATENAME(quarter, BI_CreateDate) = DATENAME(QUARTER, '{0}') and BI_Type = 'MU Issue'", strDateTime));
            strSql.Append(" union all ");
            strSql.Append(string.Format("select 'Configure(W14/W15)' as BI_Type, count(BI_ID) as IssueNo from BugIssue where DATENAME(quarter, BI_CreateDate) = DATENAME(QUARTER, '{0}') and BI_Type = 'Configure Issue(W14/W15)'", strDateTime));
            strSql.Append(" union all ");
            strSql.Append(string.Format("select 'Configure(W16)' as BI_Type, count(BI_ID) as IssueNo from BugIssue where DATENAME(quarter, BI_CreateDate) = DATENAME(QUARTER, '{0}') and BI_Type = 'Configure Issue(W16)'", strDateTime));
            strSql.Append(" union all ");
            strSql.Append(string.Format("select 'Issue' as BI_Type, count(BI_ID) as IssueNo from BugIssue where DATENAME(quarter, BI_CreateDate) = DATENAME(QUARTER, '{0}') and BI_Type = 'Issue'", strDateTime));
            strSql.Append(") as T");
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet PieReleaseCaseno(string strDateTime)
        {
            StringBuilder strSql = new StringBuilder();
            //strSql.Append("select TT_Release,sum(convert(int, TT_CaseRealRunNum)) from TaskTotal where DATENAME(quarter, TT_TimeEnd) = DATENAME(QUARTER, '");
            //strSql.Append(strDateTime);
            //strSql.Append("') and TT_Release in ('W14','W15','W16','LM') group by TT_Release order by charindex(TT_Release+',','W14,W15,W16,LM,');");
            strSql.Append("declare @TotalNum decimal;");
            strSql.Append(string.Format("set @TotalNum = (select sum(convert(int, TT_CaseRealRunNum)) from TaskTotal where DATENAME(quarter, TT_TimeEnd) = DATENAME(QUARTER, '{0}') and TT_Release in('W14','W15','W16','LM'));", strDateTime));
            strSql.Append("select T.*, round((T.CaseNo / @TotalNum) * 100, 0) as CasePercent from(");
            strSql.Append(string.Format("select 'W14' as TT_Release,ISNULL(sum(convert(int, TT_CaseRealRunNum)), 0) as CaseNo from TaskTotal where DATENAME(quarter, TT_TimeEnd) = DATENAME(QUARTER, '{0}') and TT_Release = 'W14'", strDateTime));
            strSql.Append(" union all ");
            strSql.Append(string.Format("select 'W15' as TT_Release,ISNULL(sum(convert(int, TT_CaseRealRunNum)), 0) as CaseNo from TaskTotal where DATENAME(quarter, TT_TimeEnd) = DATENAME(QUARTER, '{0}') and TT_Release = 'W15'", strDateTime));
            strSql.Append(" union all ");
            strSql.Append(string.Format("select 'W16' as TT_Release,ISNULL(sum(convert(int, TT_CaseRealRunNum)), 0) as CaseNo from TaskTotal where DATENAME(quarter, TT_TimeEnd) = DATENAME(QUARTER, '{0}') and TT_Release = 'W16'", strDateTime));
            strSql.Append(" union all ");
            strSql.Append(string.Format("select 'LM' as TT_Release,ISNULL(sum(convert(int, TT_CaseRealRunNum)), 0) as CaseNo from TaskTotal where DATENAME(quarter, TT_TimeEnd) = DATENAME(QUARTER, '{0}') and TT_Release = 'LM'", strDateTime));
            strSql.Append(") as T");
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
