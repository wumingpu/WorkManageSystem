using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.QBR
{
    [Serializable]
    public partial class LSReleaseCaseNo
    {
        public string SeasonNum { set; get; }
        public string TT_Release { set; get; }
        public int CaseNo { set; get; }
    }
}
