using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.ChartReport
{
    //[Serializable]
    //public partial class ChartReport
    //{
    //    public ChartReport()
    //    { }
    //}

    [Serializable]
    public partial class MonthData
    {
        public int Month { set; get; }
        public int DataPreMonth { set; get; }
    }

    [Serializable]
    public partial class TasknameData
    {
        public string TaskName { set; get; }
        public int DataPerTask { set; get; } 
    }
}
