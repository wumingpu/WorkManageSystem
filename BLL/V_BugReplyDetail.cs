using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial class V_BugReplyDetail
    {
        private readonly DAL.V_BugReplyDetail dal = new DAL.V_BugReplyDetail();
        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }
    }
}
