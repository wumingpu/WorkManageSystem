using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial class V_TaskDetail
    {
        public V_TaskDetail()
        { }
        DAL.V_TaskDetail dal = new DAL.V_TaskDetail();
        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }
    }
}
