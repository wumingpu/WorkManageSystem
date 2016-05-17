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

    [Serializable]
    public partial class LabelData
    {
        public string LabelName { set; get; }
        public int iData { set; get; }
    }

    [Serializable]
    public partial class LabelDataPercent
    {
        public string LabelName { set; get; }
        public int iData { set; get; }
        public string Percent { set; get; }
    }

    [Serializable]
    public partial class LabelReleaseData
    {
        public string LabelName { set; get; }
        public string Release { set; get; }
        public int iData { set; get; }
    }
}
