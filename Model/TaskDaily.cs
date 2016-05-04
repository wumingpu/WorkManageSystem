using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [Serializable]
    public partial class TaskDaily
    {
        public TaskDaily()
        { }
        public int TD_ID { set; get; }
        public int TD_FK_TaskTotalID { set; get; }
        public string TD_Date { set; get; }
        public string TD_CaseShouldRunNum { set; get; }
        public string TD_CaseRealRunNum { set; get; }
        public string TD_CasePassNum { set; get; }
        public string TD_CaseNANum { set; get; }
        public string TD_CaseFailNum { set; get; }
        public string TD_CaseRunInRedmond { set; get; }
        public string TD_BugIssueNum { set; get; }
        public string TD_ReportLink { set; get; }
        public string TD_Comments { set; get; }
        public string TD_CreateDate { set; get; }
        public string TD_TaskProgress { set; get; }
        public string TD_TaskStatus { set; get; }
    }
}
