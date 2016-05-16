using Maticsoft.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public partial class UserInfo
    {
        public UserInfo()
        { }

        public int Exist(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(*) from UserInfo ");
            if (strWhere != "")
            {
                strSql.Append(" where ");
                strSql.Append(strWhere);
            }
            object obj = DbHelperSQL.GetSingle(strSql.ToString());
            if (obj == null)
            {
                return -1;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }

        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * from UserInfo where U_IsDelete=0");
            if (strWhere != "")
            {
                strSql.Append(" and ");
                strSql.Append(strWhere);
            }
            strSql.Append(" order by U_ID ASC;");
            return DbHelperSQL.Query(strSql.ToString());
        }

        public string ChangePassword(int U_ID, string oldPassword, string newPassword)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("if ((select U_password from UserInfo where U_ID=@U_ID)=@oldPassword) ");
            strSql.Append(" begin ");
            strSql.Append(" update UserInfo set U_password =@newPassword where U_ID=@U_ID; ");
            strSql.Append(" if @@ROWCOUNT > 0 begin select 'success' as Res; end ");
            strSql.Append(" else begin select 'fail' as Res; end ");
            strSql.Append(" end ");
            strSql.Append(" else begin select 'password incorrect' as Res end ");

            SqlParameter[] parameters = {
                new SqlParameter("@U_ID",SqlDbType.Int,4),
                new SqlParameter("@oldPassword",SqlDbType.VarChar,200),
                new SqlParameter("@newPassword",SqlDbType.VarChar,200)
            };
            parameters[0].Value = U_ID;
            parameters[1].Value = oldPassword;
            parameters[2].Value = newPassword;

            object obj = DbHelperSQL.GetSingle(strSql.ToString(), parameters);
            return obj.ToString();
        }

        public DataSet Login(string username, string password)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * from UserInfo where U_username=@U_username and U_password=@U_password");
            SqlParameter[] parameters = {
                new SqlParameter("@U_username",SqlDbType.VarChar,50),
                new SqlParameter("@U_password",SqlDbType.VarChar,200)
            };
            parameters[0].Value = username;
            parameters[1].Value = password;
            DataSet ds = DbHelperSQL.Query(strSql.ToString(), parameters);
            return ds;
        }

        public int Add(Model.UserInfo model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into UserInfo (U_username,U_password,U_power,U_nickname,U_mailbox,U_Role,U_Comments,U_CreateDate,U_IsDelete) ");
            strSql.Append(" values (@U_username,@U_password,@U_power,@U_nickname,@U_mailbox,@U_Role,@U_Comments,@U_CreateDate,@U_IsDelete) ");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
                new SqlParameter("@U_username",SqlDbType.VarChar,50),
                new SqlParameter("@U_password",SqlDbType.VarChar,200),
                new SqlParameter("@U_power",SqlDbType.VarChar,10),
                new SqlParameter("@U_nickname",SqlDbType.VarChar,100),
                new SqlParameter("@U_mailbox",SqlDbType.VarChar,50),
                new SqlParameter("@U_Role",SqlDbType.VarChar,50),
                new SqlParameter("@U_Comments",SqlDbType.VarChar),
                new SqlParameter("@U_CreateDate",SqlDbType.VarChar,20),
                new SqlParameter("@U_IsDelete",SqlDbType.Int,4)};
            parameters[0].Value = model.U_username;
            parameters[1].Value = model.U_password;
            parameters[2].Value = model.U_power;
            parameters[3].Value = model.U_nickname;
            parameters[4].Value = model.U_mailbox;
            parameters[5].Value = model.U_Role;
            parameters[6].Value = model.U_Comments;
            parameters[7].Value = model.U_CreateDate;
            parameters[8].Value = model.U_IsDelete;
            object obj = DbHelperSQL.GetSingle(strSql.ToString(), parameters);
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }

        public bool Update(Model.UserInfo model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update UserInfo set ");
            strSql.Append(string.Format("U_username='{0}',U_power='{1}',U_nickname='{2}',", model.U_username, model.U_power, model.U_nickname));
            strSql.Append(string.Format("U_mailbox='{0}',U_Role='{1}',U_Comments='{2}'", model.U_mailbox, model.U_Role, model.U_Comments));
            strSql.Append(string.Format(" where U_ID={0};", model.U_ID));
            int UpdateRes = DbHelperSQL.ExecuteSql(strSql.ToString());
            if (UpdateRes>0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool Delete(int U_ID)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update UserInfo set U_IsDelete=1 ");
            strSql.Append("where U_ID=" + U_ID);
            int DelRes = DbHelperSQL.ExecuteSql(strSql.ToString());
            if (DelRes>0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
