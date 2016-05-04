using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RTCSEWorkManageBS.ashx
{
    /// <summary>
    /// Summary description for BugIssueHandler
    /// </summary>
    public class BugIssueHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            if (context.Request["mode"] != null)
            {
                string mode = context.Request["mode"].ToString();
                switch (mode)
                {
                    case "TetFunction":
                        TestFunction(context);
                        break;
                }
            }
        }

        private void TestFunction(HttpContext context)
        {
            //throw new NotImplementedException();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}