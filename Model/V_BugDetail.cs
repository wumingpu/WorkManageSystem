using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [Serializable]
    public partial class V_BugDetail
    {
        public int BI_ID { set; get; }
        public string BI_Title { set; get; }
        public string BI_Type { set; get; }
        public string BI_Status { set; get; }
        public string BI_CreateDate { set; get; }
        public string U_nickname { set; get; }
        public string TT_Title { set; get; }
        public string S_ScenarioName { set; get; }
        public string SR_RoleTitle { set; get; }
        public string BI_CaseNumber { set; get; }
        public string BI_EnvironmentServer { set; get; }
        public string BI_TopologyName { set; get; }
        public string BI_UpdateTime { set; get; }
        public string BI_CloseTime { set; get; }
        public int BI_Owner { set; get; }
    }

    [Serializable]
    public partial class V_BugDetailForBugListGroup
    {
        public int BI_ID { set; get; }
        public string BI_Title { set; get; }
        public string BI_Type { set; get; }
        public string BI_Status { set; get; }
        public string BI_CreateDate { set; get; }
        public string U_nickname { set; get; }
    }
}
