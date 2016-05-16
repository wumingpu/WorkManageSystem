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

        public DataSet GetSingle(int BI_ID)
        {
            return dal.GetSingle(BI_ID);
        }

        public int Add(Model.BugIssue model)
        {
            return dal.Add(model);
        }

        public DataSet GetList(string Fields, string strWhere)
        {
            return dal.GetList(Fields, strWhere);
        }

        public bool CloseBugIssue(int BI_ID,int User_ID,string BI_Resolution)
        {
            return dal.CloseBugIssue(BI_ID, User_ID, BI_Resolution);
        }

        public bool ReOpenBugIssue(int BI_ID, int User_ID)
        {
            return dal.ReOpenBugIssue(BI_ID, User_ID);
        }
    }
}
