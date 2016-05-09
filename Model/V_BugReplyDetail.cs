using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [Serializable]
    public partial class V_BugReplyDetail
    {
        public V_BugReplyDetail()
        { }

        public int BIR_ID { set; get; }
        public int BIR_FK_BI_ID { set; get; }
        public string BIR_Content { set; get; }
        public string BIR_CreateTime { set; get; }
        //public int BIR_CreateUser { set; get; }
        public string U_nickname { set; get; }
    }
}
