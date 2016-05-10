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
    }
}
