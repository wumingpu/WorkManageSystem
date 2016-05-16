using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RTCSEWorkManageBS
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_Login_Click(object sender, EventArgs e)
        {
            string strUserName = this.txt_username.Value.Trim();
            string strPassword = this.txt_password.Value.Trim();
            if (string.IsNullOrEmpty(strUserName) || string.IsNullOrEmpty(strPassword))
            {
                Response.Write("<script>alert('Please Input Username or Password !');location.href='Login.aspx'</script>");
            }
            else
            {
                BLL.UserInfo bll = new BLL.UserInfo();
                DataSet ds = bll.Login(strUserName, strPassword);
                
                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataRow dr = ds.Tables[0].Rows[0];
                    Session["User_ID"] = dr["U_ID"];
                    Session["User_UserName"] = dr["U_username"];
                    Session["User_Power"] = dr["U_power"];

                    Response.Redirect("DashBoard.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Username or Password Incorrect !');location.href='Login.aspx'</script>");
                }
            }
        }
    }
}