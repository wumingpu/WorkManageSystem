using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial class V_TaskTotalScenario
    {
        public V_TaskTotalScenario()
        { }

        DAL.V_TaskTotalScenario dal = new DAL.V_TaskTotalScenario();

        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }
    }
}
