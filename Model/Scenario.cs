using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [Serializable]
    public partial class Scenario
    {
        public Scenario()
        { }
        public int S_ID { set; get; }
        public int S_FK_TT_ID { set; get; }
        public string S_ScenarioName { set; get; }
        public string S_CreateDate { set; get; }
        public int S_IsDelete { set; get; }
        public string S_HaveRole { set; get; }

        /// <summary>
        /// 存储多个ScenarioName，以@@分隔
        /// </summary>
        public string S_ScenarioNames { set; get; }
    }

    [Serializable]
    public partial class ScenarioForDDL
    {
        public ScenarioForDDL()
        { }

        public int S_ID { set; get; }
        public string S_ScenarioName { set; get; }
    }
}
