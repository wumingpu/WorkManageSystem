using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial class QBR
    {
        private readonly DAL.QBR dal = new DAL.QBR();
        public QBR()
        { }

        public DataSet GetHFSeasonReleaseCaseno(string Year)
        {
            return dal.GetHFSeasonReleaseCaseno(Year);
        }

        public DataSet GetMUSeasonReleaseCaseno(string Year)
        {
            return dal.GetMUSeasonReleaseCaseno(Year);
        }

        public DataSet GetE2ESeasonReleaseCaseno(string Year)
        {
            return dal.GetE2ESeasonReleaseCaseno(Year);
        }

        public DataSet GetClientE2ESeasonReleaseCaseno(string Year)
        {
            return dal.GetClientE2ESeasonReleaseCaseno(Year);
        }

        public DataSet GetLMSeasonReleaseCaseno(string Year)
        {
            return dal.GetLMSeasonReleaseCaseno(Year);
        }

        public DataSet GetSeasonTotalCaseno()
        {
            return dal.GetSeasonTotalCaseno();
        }
    }
}
