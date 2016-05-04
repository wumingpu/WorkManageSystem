using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial class UserInfo
    {
        public UserInfo()
        { }

        private readonly DAL.UserInfo dal = new DAL.UserInfo();

        public int Exist(string strWhere)
        {
            return dal.Exist(strWhere);
        }

        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }

        public int Add(Model.UserInfo model)
        {
            return dal.Add(model);
        }

        public bool Update(Model.UserInfo model)
        {
            return dal.Update(model);
        }

        public bool Delete(int U_ID)
        {
            return dal.Delete(U_ID);
        }
    }
}
