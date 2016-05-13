using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace RTCSEWorkManageBS.ashx
{
    /// <summary>
    /// Summary description for SystemManageHandler
    /// </summary>
    public class SystemManageHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            if (context.Request["mode"] != null)
            {
                string mode = context.Request["mode"].ToString();
                switch (mode)
                {
                    // User
                    case "UpdateDynamicJSUserInfo":
                        UpdateDynamicJSUserInfo(context);
                        break;
                    case "GetUserInfoJsonFromFile":
                        GetUserInfoJsonFromFile(context);
                        break;

                    case "QueryUserList":
                        QueryUserList(context);
                        break;
                    case "AddUserInfo":
                        AddUserInfo(context);
                        break;
                    case "UpdateUserInfo":
                        UpdateUserInfo(context);
                        break;
                    case "DeleteUserInfo":
                        DeleteUserInfo(context);
                        break;
                    case "GetUserInfoSingle":
                        GetUserInfoSingle(context);
                        break;

                    //case "LoginReturnUserInfo":
                    //    LoginReturnUserInfo(context);
                    //    break;
                }
            }
        }

        //private void LoginReturnUserInfo(HttpContext context)
        //{
            
        //}

        private void GetUserInfoSingle(HttpContext context)
        {
            BLL.UserInfo bll = new BLL.UserInfo();
            DataSet ds = bll.GetList(" U_ID=" + context.Request["U_ID"]);
            DataRow dr = ds.Tables[0].Rows[0];
            List<Model.UserInfo> list = new List<Model.UserInfo>();
            list.Add(new Model.UserInfo()
            {
                U_username = dr["U_username"].ToString(),
                U_PowerDisplay = ChangePowerToDisplay(dr["U_power"].ToString()),
                U_power = dr["U_power"].ToString(),
                U_nickname = dr["U_nickname"].ToString(),
                U_mailbox = dr["U_mailbox"].ToString(),
                U_Role = dr["U_Role"].ToString(),
                U_Comments = dr["U_Comments"].ToString()
            });
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string strJson = jss.Serialize(list).TrimStart('[').TrimEnd(']');
            context.Response.Write(strJson);
        }

        private void DeleteUserInfo(HttpContext context)
        {
            BLL.UserInfo bll = new BLL.UserInfo();
            int U_ID = Convert.ToInt32(context.Request["U_ID"]);
            if (bll.Delete(U_ID))
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void UpdateUserInfo(HttpContext context)
        {
            BLL.UserInfo bll = new BLL.UserInfo();
            string UserName = context.Request["U_username"];
            string ID = context.Request["U_ID"];
            int ExistRes = bll.Exist(string.Format("U_username='{0}' and U_ID not in ({1})", UserName, ID));
            if (ExistRes > 0)
            {
                context.Response.Write("exist");
                return;
            }
            Model.UserInfo model = new Model.UserInfo();
            model.U_ID = Convert.ToInt32(ID);
            model.U_username = UserName;
            model.U_power = context.Request["U_power"];
            model.U_nickname = context.Request["U_nickname"];
            model.U_mailbox = context.Request["U_mailbox"];
            model.U_Role = context.Request["U_Role"];
            model.U_Comments = context.Request["U_Comments"];
            if (bll.Update(model))
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void AddUserInfo(HttpContext context)
        {
            BLL.UserInfo bll = new BLL.UserInfo();
            string UserName = context.Request["U_username"];
            int ExistRes = bll.Exist(string.Format("U_username='{0}'", UserName));
            if (ExistRes > 0)
            {
                context.Response.Write("exist");
                return;
            }
            Model.UserInfo model = new Model.UserInfo();
            model.U_username = UserName;
            model.U_password = model.U_username;
            model.U_power = context.Request["U_power"];
            model.U_nickname = context.Request["U_nickname"];
            model.U_mailbox = context.Request["U_mailbox"];
            model.U_Role = context.Request["U_Role"];
            model.U_Comments = context.Request["U_Comments"];
            model.U_CreateDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            model.U_IsDelete = 0;
            if (bll.Add(model) > 0)
            {
                context.Response.Write("success");
            }
            else
            {
                context.Response.Write("fail");
            }
        }

        private void QueryUserList(HttpContext context)
        {
            string strKeyWord = context.Request["KeyWord"];
            BLL.UserInfo bll = new BLL.UserInfo();
            List<Model.UserInfo> list = new List<Model.UserInfo>();
            DataSet ds = new DataSet();
            if (!string.IsNullOrEmpty(strKeyWord))
            {
               ds = bll.GetList(string.Format("U_nickname like '%{0}%'", strKeyWord));
            }
            else
            {
                ds = bll.GetList("");
            }
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.UserInfo()
                {
                    U_ID = Convert.ToInt32(dr["U_ID"]),
                    U_username = dr["U_username"].ToString(),
                    //U_power = dr["U_power"].ToString(),
                    U_PowerDisplay = ChangePowerToDisplay(dr["U_power"].ToString()),
                    //U_power = dr["U_Power"].ToString(),
                    U_nickname = dr["U_nickname"].ToString(),
                    U_mailbox = dr["U_mailbox"].ToString(),
                    U_Role = dr["U_Role"].ToString(),
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            //string strJson = string.Format("{{\"rows\":{0}}}", jss.Serialize(list));
            string strJson = jss.Serialize(list);
            context.Response.Write(strJson);
        }
        private string ChangePowerToDisplay(string power)
        {
            string strPowerDisplay = string.Empty;
            switch (power)
            {
                case "L10":
                    strPowerDisplay = "System Root";
                    break;
                case "L9":
                    strPowerDisplay = "Administrator";
                    break;
                case "L8":
                    strPowerDisplay = "Feature Owner";
                    break;
                case "L7":
                    strPowerDisplay = "Customer";
                    break;
                case "L6":
                    strPowerDisplay = "Verified Account";
                    break;
                case "L1":
                    strPowerDisplay = "Guest";
                    break;
            }
            return strPowerDisplay;
        }

        private void GetUserInfoJsonFromFile(HttpContext context)
        {
            try
            {
                string strJson = File.ReadAllText(WMSys.Common.PathHelper.ServerPath + "\\jsonData\\UserInfo.json");
                context.Response.Write(strJson);
            }
            catch (Exception)
            {
                context.Response.Write("fail");
            }
        }

        private void UpdateDynamicJSUserInfo(HttpContext context)
        {
            BLL.UserInfo bll = new BLL.UserInfo();
            DataSet ds = bll.GetList("");
            List<Model.UserForJson> list = new List<Model.UserForJson>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Model.UserForJson()
                {
                    U_ID = Convert.ToInt32(dr["U_ID"]),
                    U_nickname = dr["U_nickname"].ToString()
                });
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            //string strJson = string.Format("{{\"rows\":{0}}}", jss.Serialize(list));
            string strJson = jss.Serialize(list);
            try
            {
                //File.WriteAllText(WMSys.Common.PathHelper.ServerPath+"\\jsonData\\UserInfo.json", strJson);
                string DynamicJSPath = WMSys.Common.PathHelper.ServerPath + "\\DynamicJS\\TagsInputUserData.js";
                string[] DynamicJSContent = File.ReadAllLines(DynamicJSPath);
                DynamicJSContent[0] = string.Format("var JsonData = '{0}'", strJson);
                File.WriteAllLines(DynamicJSPath, DynamicJSContent);
                context.Response.Write(strJson);
            }
            catch (Exception)
            {
                context.Response.Write("fail");
            }
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