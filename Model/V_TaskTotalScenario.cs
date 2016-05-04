using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [Serializable]
    public partial class V_TaskTotalScenario
    {
        public V_TaskTotalScenario()
        { }
        public int S_ID { set; get; }
        public int S_FK_TT_ID { set; get; }
        public string S_ScenarioName { set; get; }
        public string S_CreateDate { set; get; }
        public int S_IsDelete { set; get; }
        public string S_HaveRole { set; get; }

        public string TT_Title { set; get; }
        public string TT_TaskStatus { set; get; }
    }
}
