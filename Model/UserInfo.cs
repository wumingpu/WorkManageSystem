using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [Serializable]
    public partial class UserInfo
    {
        public UserInfo()
        { }

        public int U_ID { set; get; }
        public string U_username { set; get; }
        public string U_password { set; get; }
        public string U_power { set; get; }
        public string U_PowerDisplay { set; get; }
        public string U_nickname { set; get; }
        public string U_mailbox { set; get; }
        public string U_Role { set; get; }
        public string U_Comments { set; get; }
        public string U_CreateDate { set; get; }
        public int U_IsDelete { set; get; }
    }

    [Serializable]
    public partial class UserForJson
    {
        public UserForJson()
        { }

        public int U_ID { set; get; }
        public string U_nickname { set; get; }
    }
}
