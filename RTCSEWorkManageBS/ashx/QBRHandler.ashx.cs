using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace RTCSEWorkManageBS.ashx
{
    /// <summary>
    /// Summary description for QBRHandler
    /// </summary>
    public class QBRHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            if (context.Request["mode"] != null)
            {
                string mode = context.Request["mode"].ToString();
                switch (mode)
                {
                    case "GetHFSeasonReleaseCaseno":
                        GetHFSeasonReleaseCaseno(context);
                        break;
                    case "GetMUSeasonReleaseCaseno":
                        GetMUSeasonReleaseCaseno(context);
                        break;
                    case "GetE2ESeasonReleaseCaseno":
                        GetE2ESeasonReleaseCaseno(context);
                        break;
                    case "GetClientE2ESeasonReleaseCaseno":
                        GetClientE2ESeasonReleaseCaseno(context);
                        break;
                    case "GetLMSeasonReleaseCaseno":
                        GetLMSeasonReleaseCaseno(context);
                        break;
                }
            }
        }

        private void GetLMSeasonReleaseCaseno(HttpContext context)
        {
            string Year = context.Request["Year"];
            if (string.IsNullOrEmpty(Year))
            {
                Year = DateTime.Now.Year.ToString();
            }
            BLL.QBR bll = new BLL.QBR();
            DataSet ds = bll.GetLMSeasonReleaseCaseno(Year);
            List<Model.QBR.LSReleaseCaseNo> list = new List<Model.QBR.LSReleaseCaseNo>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.QBR.LSReleaseCaseNo()
                {
                    SeasonNum = dr["SeasonNum"].ToString(),
                    TT_Release = dr["TT_Release"].ToString(),
                    CaseNo = Convert.ToInt32(dr["CaseNo"])
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list);
            context.Response.Write(strJson);
        }

        private void GetClientE2ESeasonReleaseCaseno(HttpContext context)
        {
            string Year = context.Request["Year"];
            if (string.IsNullOrEmpty(Year))
            {
                Year = DateTime.Now.Year.ToString();
            }
            BLL.QBR bll = new BLL.QBR();
            DataSet ds = bll.GetClientE2ESeasonReleaseCaseno(Year);
            List<Model.QBR.LSReleaseCaseNo> list = new List<Model.QBR.LSReleaseCaseNo>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.QBR.LSReleaseCaseNo()
                {
                    SeasonNum = dr["SeasonNum"].ToString(),
                    TT_Release = dr["TT_Release"].ToString(),
                    CaseNo = Convert.ToInt32(dr["CaseNo"])
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list);
            context.Response.Write(strJson);
        }

        private void GetE2ESeasonReleaseCaseno(HttpContext context)
        {
            string Year = context.Request["Year"];
            if (string.IsNullOrEmpty(Year))
            {
                Year = DateTime.Now.Year.ToString();
            }
            BLL.QBR bll = new BLL.QBR();
            DataSet ds = bll.GetE2ESeasonReleaseCaseno(Year);
            List<Model.QBR.LSReleaseCaseNo> list = new List<Model.QBR.LSReleaseCaseNo>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.QBR.LSReleaseCaseNo()
                {
                    SeasonNum = dr["SeasonNum"].ToString(),
                    TT_Release = dr["TT_Release"].ToString(),
                    CaseNo = Convert.ToInt32(dr["CaseNo"])
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list);
            context.Response.Write(strJson);
        }

        private void GetMUSeasonReleaseCaseno(HttpContext context)
        {
            string Year = context.Request["Year"];
            if (string.IsNullOrEmpty(Year))
            {
                Year = DateTime.Now.Year.ToString();
            }
            BLL.QBR bll = new BLL.QBR();
            DataSet ds = bll.GetMUSeasonReleaseCaseno(Year);
            List<Model.QBR.LSReleaseCaseNo> list = new List<Model.QBR.LSReleaseCaseNo>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.QBR.LSReleaseCaseNo()
                {
                    SeasonNum = dr["SeasonNum"].ToString(),
                    TT_Release = dr["TT_Release"].ToString(),
                    CaseNo = Convert.ToInt32(dr["CaseNo"])
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list);
            context.Response.Write(strJson);
        }

        private void GetHFSeasonReleaseCaseno(HttpContext context)
        {
            string Year = context.Request["Year"];
            if (string.IsNullOrEmpty(Year))
            {
                Year = DateTime.Now.Year.ToString();
            }
            BLL.QBR bll = new BLL.QBR();
            DataSet ds = bll.GetHFSeasonReleaseCaseno(Year);
            List<Model.QBR.LSReleaseCaseNo> list = new List<Model.QBR.LSReleaseCaseNo>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.QBR.LSReleaseCaseNo() {
                    SeasonNum = dr["SeasonNum"].ToString(),
                    TT_Release = dr["TT_Release"].ToString(),
                    CaseNo = Convert.ToInt32(dr["CaseNo"])
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list);
            context.Response.Write(strJson);
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