using Maticsoft.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public partial class QBR
    {
        public DataSet GetHFSeasonReleaseCaseno(string Year)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(string.Format("select DATENAME(QUARTER,TT_TimeEnd) as SeasonNum,TT_Release,sum(convert(int,TT_CaseRealRunNum)) as CaseNo from TaskTotal where TT_TimeEnd between '{0}-01-01 00:00:00' and '{0}-12-31 24:59:59' and TT_TaskType like '%HotFix%' and TT_ServerClient='Server' group by TT_Release,DATENAME(QUARTER,TT_TimeEnd)", Year));
            strSql.Append(" union all ");
            strSql.Append(string.Format("select DATENAME(QUARTER,TT_TimeEnd) as SeasonNum,'',sum(convert(int,TT_CaseRealRunNum)) as CaseNo from TaskTotal where  TT_TimeEnd between '{0}-01-01 00:00:00' and '{0}-12-31 24:59:59' and TT_TaskType like '%HotFix%' and TT_ServerClient='Server' group by DATENAME(QUARTER,TT_TimeEnd);", Year));
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet GetMUSeasonReleaseCaseno(string Year)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(string.Format("select DATENAME(QUARTER,TT_TimeEnd) as SeasonNum,TT_Release,sum(convert(int,TT_CaseRealRunNum)) as CaseNo from TaskTotal where TT_TimeEnd between '{0}-01-01 00:00:00' and '{0}-12-31 24:59:59' and TT_TaskType like '%MU%' and TT_ServerClient='Server' group by TT_Release,DATENAME(QUARTER,TT_TimeEnd)", Year));
            strSql.Append(" union all ");
            strSql.Append(string.Format("select DATENAME(QUARTER,TT_TimeEnd) as SeasonNum,'',sum(convert(int,TT_CaseRealRunNum)) as CaseNo from TaskTotal where  TT_TimeEnd between '{0}-01-01 00:00:00' and '{0}-12-31 24:59:59' and TT_TaskType like '%MU%' and TT_ServerClient='Server' group by DATENAME(QUARTER,TT_TimeEnd);", Year));
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet GetE2ESeasonReleaseCaseno(string Year)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(string.Format("select DATENAME(QUARTER,TT_TimeEnd) as SeasonNum,TT_Release,sum(convert(int,TT_CaseRealRunNum)) as CaseNo from TaskTotal where TT_TimeEnd between '{0}-01-01 00:00:00' and '{0}-12-31 24:59:59' and TT_TaskType like '%E2E%' and TT_ServerClient='Server' group by TT_Release,DATENAME(QUARTER,TT_TimeEnd)", Year));
            //strSql.Append(" union all ");
            //strSql.Append(string.Format("select DATENAME(QUARTER,TT_TimeEnd) as SeasonNum,'',sum(convert(int,TT_CaseRealRunNum)) as CaseNo from TaskTotal where  TT_TimeEnd between '{0}-01-01 00:00:00' and '{0}-12-31 24:59:59' and TT_TaskType like '%E2E%' and TT_ServerClient='Server' group by DATENAME(QUARTER,TT_TimeEnd);", Year));
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet GetClientE2ESeasonReleaseCaseno(string Year)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(string.Format("select DATENAME(QUARTER,TT_TimeEnd) as SeasonNum,TT_Release,sum(convert(int,TT_CaseRealRunNum)) as CaseNo from TaskTotal where TT_TimeEnd between '{0}-01-01 00:00:00' and '{0}-12-31 24:59:59' and TT_TaskType like '%E2E%' and TT_ServerClient='Client' group by TT_Release,DATENAME(QUARTER,TT_TimeEnd)", Year));
            //strSql.Append(" union all ");
            //strSql.Append(string.Format("select DATENAME(QUARTER,TT_TimeEnd) as SeasonNum,'',sum(convert(int,TT_CaseRealRunNum)) as CaseNo from TaskTotal where  TT_TimeEnd between '{0}-01-01 00:00:00' and '{0}-12-31 24:59:59' and TT_TaskType like '%E2E%' and TT_ServerClient='Client' group by DATENAME(QUARTER,TT_TimeEnd);", Year));
            return DbHelperSQL.Query(strSql.ToString());
        }

        public DataSet GetLMSeasonReleaseCaseno(string Year)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(string.Format("select DATENAME(QUARTER,TT_TimeEnd) as SeasonNum,'LM',sum(convert(int,TT_CaseRealRunNum)) as CaseNo from TaskTotal where TT_TimeEnd between '{0}-01-01 00:00:00' and '{0}-12-31 24:59:59' and TT_Release='LM' group by TT_Release,DATENAME(QUARTER,TT_TimeEnd)", Year));
            //strSql.Append(" union all ");
            //strSql.Append(string.Format("select DATENAME(QUARTER,TT_TimeEnd) as SeasonNum,'',sum(convert(int,TT_CaseRealRunNum)) as CaseNo from TaskTotal where  TT_TimeEnd between '{0}-01-01 00:00:00' and '{0}-12-31 24:59:59' and TT_Release='LM' group by DATENAME(QUARTER,TT_TimeEnd);", Year));
            return DbHelperSQL.Query(strSql.ToString());
        }
    }
}
