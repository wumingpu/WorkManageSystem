using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [Serializable]
    public partial class BugIssue
    {
        public BugIssue()
        { }
        public int BI_ID { set; get; }
        public int BI_FK_SR_ID { set; get; }
        public int BI_FK_S_ID { set; get; }
        public int BI_FK_TT_ID { set; get; }
        public string BI_Title { set; get; }
        public string BI_Type { set; get; }
        public string BI_Content { set; get; }
        public string BI_EnvironmentServer { set; get; }
        public string BI_TopologyName { set; get; }
        public string BI_Remark { set; get; }
        public string BI_CaseNumber { set; get; }
        public string BI_CreateDate { set; get; }
        public string BI_Status { set; get; }
        public int BI_Owner { set; get; }
        public string BI_CloseTime { set; get; }
        public int BI_ReferenceBIID { set; get; }
        public string BI_UpdateTime { set; get; }
    }
}
