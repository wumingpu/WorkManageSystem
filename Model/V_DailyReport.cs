using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [Serializable]
    public partial class V_DailyReport
    {
        public V_DailyReport()
        { }

        public string DR_Resources { set; get; }
        public string DR_UpdateDate { set; get; }
        public string DR_Type { set; get; }
        public int BTT_ID { set; get; }
        public string BTT_Title { set; get; }
        public int DR_ID { set; get; }
        public string BTT_Status { set; get; }
        public string BTT_Progress { set; get; }
        public string BTT_Owner { set; get; }
        public int BTT_OwnerID { set; get; }
        public string DR_ResourcesName { set; get; }

    }
}
