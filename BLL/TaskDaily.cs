using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial class TaskDaily
    {
        private readonly DAL.TaskDaily dal = new DAL.TaskDaily();
        public TaskDaily()
        { }

        #region method
        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }
        #endregion
    }
}
