using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial class V_TaskTotalScenarioScenarioRole
    {
        DAL.V_TaskTotalScenarioScenarioRole dal = new DAL.V_TaskTotalScenarioScenarioRole();

        public V_TaskTotalScenarioScenarioRole()
        { }

        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }
    }
}
