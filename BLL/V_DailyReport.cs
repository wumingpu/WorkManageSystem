using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial class V_DailyReport
    {
        private readonly DAL.V_DailyReport dal = new DAL.V_DailyReport();
        public V_DailyReport()
        { }

        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }

        public bool Add(string ResourcesID, int TableID, string DR_Type)
        {
            return dal.Add(ResourcesID, TableID, DR_Type);
        }
    }
}
