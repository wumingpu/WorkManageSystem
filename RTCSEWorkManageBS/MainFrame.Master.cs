using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RTCSEWorkManageBS
{
    public partial class MainFrame : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["User_ID"] = "13";
            //Session["User_UserName"] = "Mingpu Wu";
            if (Session["User_ID"] != null)
            {
                this.User_ID.InnerText = Session["User_ID"].ToString();
                this.User_UserName.InnerText = Session["User_UserName"].ToString();
                this.U_nickname.InnerText = Session["User_UserName"].ToString();
                UP = Session["User_Power"].ToString();
            }
            else
            {
                //Response.Redirect("Login.aspx");
                Response.Write("<script>alert('Login Info Time Out, Please login again ~');location.href='Login.aspx'</script>");
            }
        }
        protected string UP = "";
    }
}