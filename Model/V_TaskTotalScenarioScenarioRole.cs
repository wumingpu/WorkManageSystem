﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [Serializable]
    public partial class V_TaskTotalScenarioScenarioRole
    {
        public int SR_ID { set; get; }
        public int SR_FK_S_ID { set; get; }
        public int SR_FK_TT_ID { set; get; }
        public string TT_Title { set; get; }
        public string S_ScenarioName { set; get; }
        public string SR_RoleTitle { set; get; }
        public string SR_AssignedUser { set; get; }
        public string SR_AssignedUserName { set; get; }
        public string SR_CaseNum { set; get; }
        public string SR_CasePassed { set; get; }
        public string SR_CaseFailed { set; get; }
        public string SR_CaseNA { set; get; }
        public string SR_CaseRedmond { set; get; }
        public string SR_CompleteProgress { set; get; }
        public string SR_CreateUser { set; get; }
        public string U_nickname { set; get; }
        public string SR_Comments { set; get; }
        public string SR_Status { set; get; }
        public string TT_TaskStatus { set; get; }
    }
}
