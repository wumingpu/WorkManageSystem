using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial class V_BugDetail
    {
        private readonly DAL.BugIssue dal = new DAL.BugIssue();
        public V_BugDetail()
        { }

        public DataSet GetList(string Fields, string strWhere)
        {
            return dal.GetList(Fields, strWhere);
        }
    }
}
