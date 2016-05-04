using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [Serializable]
    public partial class V_TaskDetail
    {
        public V_TaskDetail()
        { }

        public int TT_ID { set; get; }
        public string TD_TaskTitle { set; get; }
        public string TT_Release { set; get; }
        public string TT_BuildType { set; get; }
        public string TT_TaskType { set; get; }
        public string TT_TaskStyle { set; get; }
        public string TT_CU { set; get; }
        public string TT_BuildNum { set; get; }
        public string TD_ScenarioTitle { set; get; }
        public string TD_RoleTitle { set; get; }
        public string SR_CaseNum { set; get; }
        public string SR_CasePassed { set; get; }
        public string SR_CaseFailed { set; get; }
        public string SR_CaseNA { set; get; }
        public string SR_CaseRedmond { set; get; }
        public string TD_DateStart { set; get; }
        public string TD_DateEnd { set; get; }
        public string TD_Owner { set; get; }
        public string TD_AssignedUserName { set; get; }
        public string TD_Comments { set; get; }
        public int TD_ID { set; get; }
        public string TD_CardType { set; get; }
        public string TD_IsDelete { set; get; }
        public string TD_Progress { set; get; }
        public string TD_TimeStart { set; get; }
        public string TD_TimeEnd { set; get; }
        public string TD_TimeUsed { set; get; }
        public string TD_CompleteReason { set; get; }
    }
}
