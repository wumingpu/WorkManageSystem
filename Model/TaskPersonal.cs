using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [Serializable]
    public partial class TaskPersonal
    {
        public int TP_ID { set; get; }
        public string TP_Title { set; get; }
        public string TP_DateStart { set; get; }
        public string TP_DateEnd { set; get; }
        public string TP_TimeStart { set; get; }
        public string TP_TimeEnd { set; get; }
        public string TP_TimeUsed { set; get; }
        public string TP_Progress { set; get; }
        public string TP_CreateUser { set; get; }
        public string TP_Owner { set; get; }
        public string TP_Comments { set; get; }
        public string TP_Status { set; get; }
        public string TP_IsDelete { set; get; }
        public string TP_CreateDate { set; get; }
    }
}
