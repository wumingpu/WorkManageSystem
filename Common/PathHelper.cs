using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WMSys.Common
{
    public static class PathHelper //: System.Web.UI.Page
    {
        //public static PathHelper()
        //{ }

        public static readonly string ServerPath = System.Web.HttpContext.Current.Server.MapPath(System.Web.HttpContext.Current.Request.ApplicationPath.ToString());//获取程序根目录

    }
}
