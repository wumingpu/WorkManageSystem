using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial class ScenarioRole
    {
        private readonly DAL.ScenarioRole dal = new DAL.ScenarioRole();
        public ScenarioRole()
        { }
        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }
        public bool AddBatch(List<Model.ScenarioRoleForJson> list, int SR_FK_S_ID, int SR_FK_TT_ID, int User_ID)
        {
            DAL.Scenario dalScenario = new DAL.Scenario();
            if (dalScenario.UpdateHaveRole(SR_FK_S_ID, true))
            {
                return dal.AddBatch(list, SR_FK_S_ID, SR_FK_TT_ID, User_ID);
            }
            else
            {
                return false;
            }

        }

        public int Add(Model.ScenarioRole model)
        {
            return dal.Add(model);
        }

        public bool Update(Model.ScenarioRole model)
        {
            return dal.Update(model);
        }

        public bool Delete(int SR_ID, int SR_FK_S_ID)
        {
            if (dal.Delete(SR_ID))
            {
                if (dal.Exist("SR_FK_S_ID=" + SR_FK_S_ID) == 0)
                {
                    DAL.Scenario dalScenario = new DAL.Scenario();
                    if (dalScenario.UpdateHaveRole(SR_FK_S_ID, false))
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    return true;
                }
            }
            else
            {
                return false;
            }
        }
    }
}
