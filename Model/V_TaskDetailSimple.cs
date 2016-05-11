using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [Serializable]
    public partial class V_TaskDetailSimple
    {
        public V_TaskDetailSimple()
        { }
        public string TD_IsDelete { set; get; }
        public string TD_Status { set; get; }
        public string TD_TaskTitle { set; get; }
        public string TD_ScenarioTitle { set; get; }
        public string TD_RoleTitle { set; get; }
        public int TD_ID { set; get; }
        public string TD_AssignedUserName { set; get; }
        public string TD_CardType { set; get; }
        public string TD_TaskType { set; get; }
        public string TD_Date { set; get; }
        public string TD_DateStart { set; get; }
        public string TD_DateEnd { set; get; }
        public string TD_Owner { set; get; }
        public string TD_AssignedUserID { set; get; }
        public string TD_OwnerID { set; get; }
    }
}
