using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial class BugIssue
    {
        private readonly DAL.BugIssue dal = new DAL.BugIssue();
        public BugIssue()
        { }

        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }
    }
}
