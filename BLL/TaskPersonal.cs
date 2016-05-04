using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial class TaskPersonal
    {
        public TaskPersonal()
        { }

        DAL.TaskPersonal dal = new DAL.TaskPersonal();
        public int Add(Model.TaskPersonal model)
        {
            return dal.Add(model);
        }
    }
}
