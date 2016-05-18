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

        public DataSet PieFoundbyBugno(string strDateTime)
        {
            return dal.PieFoundbyBugno(strDateTime);
        }

        public DataSet PieReleaseBugno(string strDateTime)
        {
            return dal.PieReleaseBugno(strDateTime);
        }

        public DataSet PieTasktypeBugno(string strDateTime)
        {
            return dal.PieTasktypeBugno(strDateTime);
        }

        public DataSet PiePriorityBugno(string strDateTime)
        {
            return dal.PiePriorityBugno(strDateTime);
        }

        public DataSet PieResolutionBugno(string strDateTime)
        {
            return dal.PieResolutionBugno(strDateTime);
        }
    }
}
