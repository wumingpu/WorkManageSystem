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
        public int BI_FK_TT_ID { set; get; }
        public string BI_Title { set; get; }
        public string BI_Time { set; get; }
        public string BI_Type { set; get; }
        public string BI_Content { set; get; }
        public string BI_EnvironmentServer { set; get; }
        public string BI_Remark { set; get; }
        public string BI_FailedCaseNum { set; get; }
        public string BI_CreateDate { set; get; }
    }
}
