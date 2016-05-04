using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial class TaskTotal
    {
        private readonly DAL.TaskTotal dal = new DAL.TaskTotal();
        public TaskTotal()
        { }

        #region method
        public bool StartTaskTotal(int TT_ID)
        {
            return dal.StartTaskTotal(TT_ID);
        }
        public bool EndTaskTotal(int TT_ID, string TT_Progress, string TT_CompleteReason)
        {
            return dal.EndTaskTotal(TT_ID, TT_Progress, TT_CompleteReason);
        }

        public DataSet GetList(int ListItemNumber, string strWhere)
        {
            return dal.GetList(ListItemNumber,strWhere);
        }

        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }

        public Model.TaskTotal GetModel(int ID)
        {
            return dal.GetModel(ID);
        }

        public int Add(Model.TaskTotal model)
        {
            return dal.Add(model);
        }

        public bool Update(Model.TaskTotal model)
        {
            return dal.Update(model);
        }

        public bool Delete(int TT_ID)
        {
            return dal.Delete(TT_ID);
        }
        #endregion
    }
}
