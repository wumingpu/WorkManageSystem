using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial class BugIssueReply
    {
        private readonly DAL.BugIssueReply dal = new DAL.BugIssueReply();
        public BugIssueReply()
        { }

        public int Add(Model.BugIssueReply model)
        {
            return dal.Add(model);
        }
        }
}
