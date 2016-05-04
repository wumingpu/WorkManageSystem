using System;
using System.Collections.Generic;
using System.DirectoryServices;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RTCSEWorkManageBS
{
    public partial class TestPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                using (DirectoryEntry deUser = new DirectoryEntry(@"LDAP://" + ddlDomain.SelectedValue, txtUserName.Text.Trim(), txtPassword.Text.Trim()))
                {
                    DirectorySearcher src = new DirectorySearcher(deUser);
                    //src.Filter = ("(objectClass=user)");
                    src.Filter = "(&(&(objectCategory=person)(objectClass=user))(sAMAccountName=" + txtUserName.Text.Trim() + "))";
                    src.PropertiesToLoad.Add("cn");
                    src.SearchRoot = deUser;
                    src.SearchScope = SearchScope.Subtree;

                    SearchResult result = src.FindOne();
                    if (result != null)//登录成功
                    {
                        DirectoryEntry de = result.GetDirectoryEntry();
                        foreach (var p in de.Properties.PropertyNames)
                        {
                            lblMsg.Text += p.ToString() + ":" + de.Properties[p.ToString()][0].ToString() + "<br/>";
                        }

                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=\"javascript\">alert('用户名或密码错误！')</script>");
                    }

                }
            }
            catch (Exception exc)
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=\"javascript\">alert('" + exc.Message + "')</script>");
            }
        }

        protected void btnMintueToDay_Click(object sender, EventArgs e)
        {
            //DateTime dt = new DateTime(1970, 1, 1);
            //dt = dt.AddMinutes(Convert.ToDouble(this.txt_Mintues.Value));
            //Response.Write(dt.ToString("yyyyMMdd HH:mm:ss"));
            TimeSpan ts = new TimeSpan(0, Convert.ToInt32(this.txt_Mintues.Value), 0);
            Response.Write(ts.Days.ToString() + "Days " + ts.Hours.ToString() + "Hours " + ts.Minutes.ToString() + "Minutes");
        }
    }
}