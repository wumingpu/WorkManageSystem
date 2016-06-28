using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RTCSEWorkManageBS.TaskManage
{
    public partial class TaskListTotalNew : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public static string Signature(Dictionary<string, string> map)
        {
            List<mapclass> param = new List<mapclass>();
            foreach (var mapitem in map)
            {
                param.Add(new mapclass() {
                    mapitem = mapitem.Key
                });
            }
            param.OrderBy(i => i.mapitem);

            StringBuilder temp = new StringBuilder ();
            foreach (var listitem in param)
            {
                temp.Append(listitem.mapitem);
                temp.Append('=');
                temp.Append(map[listitem.mapitem]);
                temp.Append('&');
            }

            // log.v("sliontek","md5="+temp.ToString());
            // strMD5 = getMD5(temp.ToString());
            return "strMD5: getMD5(temp.ToString())";
        }

        class mapclass
        {
            public string mapitem { set; get; }
        }
    }
}