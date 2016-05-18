using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial class ChartReport
    {
        private readonly DAL.ChartReport dal = new DAL.ChartReport();
        public ChartReport()
        { }

        public DataSet BarMonthTasknumber(string Year)
        {
            return dal.BarMonthTasknumber(Year);
        }

        public DataSet BarTaskstyleCaseno(string strDateTime)
        {
            return dal.BarTaskstyleCaseno(strDateTime);
        }
        public DataSet LineMonthCasenoRelease(string Year)
        {
            return dal.LineMonthCasenoRelease(Year);
        }
        public DataSet PieReleaseCaseno(string strDateTime)
        {
            return dal.PieReleaseCaseno(strDateTime);
        }

        public DataSet PieIssuetypeIssueno(string strDateTime)
        {
            return dal.PieIssuetypeIssueno(strDateTime);
        }

        public DataSet LineMonthBugnoRelease(string Year)
        {
            return dal.LineMonthBugnoRelease(Year);
        }
    }
}
