using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [Serializable]
    public partial class TaskTotal
    {
        public TaskTotal()
        { }

        #region model
        public int TT_ID { set; get; }
        public string TT_Release { set; get; }//
        public string TT_CU { set; get; }//
        public string TT_BuildType { set; get; }//
        public string TT_BuildNum { set; get; }//
        public string TT_TaskType { set; get; }//
        public string TT_CaseTotalNum { set; get; }//
        public string TT_CaseRealRunNum { set; get; }//
        public string TT_DateStart { set; get; }//
        public string TT_DateEnd { set; get; }//
        public string TT_TaskStyle { set; get; }//
        public string TT_BugIssueNum { set; get; }
        public string TT_ReportLink { set; get; }
        public string TT_Comments { set; get; }

        public string TT_CreateDate { set; get; }
        public string TT_Title { set; get; }//
        public string TT_TaskProgress { set; get; }//
        public string TT_TaskStatus { set; get; } // Pending InProgress Complete
        public string TT_HaveScenario { set; get; }

        public string TT_TimeStart { set; get; }//
        public string TT_TimeEnd { set; get; }//
        public string TT_TimeUsed { set; get; }

        public string TT_Date { set; get; } // only for display TT_DateStart + TT_DateEnd
        public string TT_CompleteReason { set; get; }
        #endregion
    }

    [Serializable]
    public partial class TaskTotalForDisplay
    {
        public int TT_ID { set; get; }
        public string TT_Title { set; get; }
        //public string TT_Release { set; get; }
        //public string TT_CU { set; get; }
        //public string TT_BuildType { set; get; }
        //public string TT_BuildNum { set; get; }
        //public string TT_TaskType { set; get; }
        //public string TT_CaseTotalNum { set; get; }
        //public string TT_CaseRealRunNum { set; get; }
        //public DateTime TT_DateStart { set; get; }
        //public DateTime TT_DateEnd { set; get; }
        public string TT_TaskStyle { set; get; }
        //public string TT_BugIssueNum { set; get; }
        //public string TT_ReportLink { set; get; }
        //public string TT_Comments { set; get; }

        public string TT_Date { set; get; } // only for display TT_DateStart + TT_DateEnd
        public string TT_HaveScenario { set; get; }
        //public string TT_CreateDate { set; get; }
        public string TT_TaskProgress { set; get; }
        public string TT_TaskStatus { set; get; }
    }
}
