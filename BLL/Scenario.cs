using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial class Scenario
    {
        private readonly DAL.Scenario dal = new DAL.Scenario();
        public Scenario()
        { }

        public int Add(Model.Scenario model, bool UpdateHaveScenario)
        {
            DAL.TaskTotal dalTaskTotal = new DAL.TaskTotal();
            int AddRes = dal.Add(model);
            if (UpdateHaveScenario)
            {
                bool UpdateRes = dalTaskTotal.UpdateHaveScenario(model.S_FK_TT_ID, true);
                if (AddRes > 0)
                {
                    if (UpdateRes)
                    {
                        return AddRes;
                    }
                    else
                    {
                        return 0;
                    }
                }
                else
                {
                    return 0;
                }
            }
            else
            {
                return AddRes;
            }
        }

        public int AddBatch(int ScenarioNumber, Model.Scenario model)
        {
            DAL.TaskTotal dalTaskTotal = new DAL.TaskTotal();
            int AddRes = dal.AddBatch(ScenarioNumber, model);
            bool UpdateRes = dalTaskTotal.UpdateHaveScenario(model.S_FK_TT_ID, true);
            if (AddRes > 0)
            {
                if (UpdateRes)
                {
                    return AddRes;
                }
                else
                {
                    return 0;
                }
            }
            else
            {
                return 0;
            }
        }

        public bool Edit(Model.Scenario model)
        {
            return dal.Edit(model);
        }

        public bool Delete(int S_ID)
        {
            return dal.Delete(S_ID);
        }

        public bool Delete(int S_ID, int TT_ID)
        {
            bool DeleteRes = dal.Delete(S_ID);
            if (DeleteRes)
            {
                int ExistRes = dal.Exist("S_FK_TT_ID=" + TT_ID);
                if (ExistRes == 0)
                { // 当此TT_ID在Scenario中没有值时，将此TaskTotal中的TT_HaveScenario改为No
                    DAL.TaskTotal dalTaskTotal = new DAL.TaskTotal();
                    bool UpdateTTRes = dalTaskTotal.UpdateHaveScenario(TT_ID, false);
                    if (UpdateTTRes)
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
