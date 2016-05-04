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
    public partial class TaskPersonal
    {
        public TaskPersonal()
        { }

        public int Add(Model.TaskPersonal model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into TaskPersonal (TP_Title,TP_DateStart,TP_DateEnd,TP_Progress,TP_CreateUser,TP_Owner,TP_Comments,TP_Status,TP_IsDelete,TP_CreateDate) ");
            strSql.Append("values (@TP_Title,@TP_DateStart,@TP_DateEnd,@TP_Progress,@TP_CreateUser,@TP_Owner,@TP_Comments,@TP_Status,@TP_IsDelete,@TP_CreateDate);");
            strSql.Append("select @@IDENTITY");
            SqlParameter[] parameters = {
                                        new SqlParameter("@TP_Title",SqlDbType.VarChar,300),
                                        new SqlParameter("@TP_DateStart",SqlDbType.VarChar,20),
                                        new SqlParameter("@TP_DateEnd",SqlDbType.VarChar,20),
                                        new SqlParameter("@TP_Progress",SqlDbType.VarChar,10),
                                        new SqlParameter("@TP_CreateUser",SqlDbType.VarChar,50),
                                        new SqlParameter("@TP_Owner",SqlDbType.VarChar,50),
                                        new SqlParameter("@TP_Comments",SqlDbType.VarChar),
                                        new SqlParameter("@TP_Status",SqlDbType.VarChar,10),
                                        new SqlParameter("@TP_IsDelete",SqlDbType.VarChar,5),
                                        new SqlParameter("@TP_CreateDate",SqlDbType.VarChar,20)
                                        };
            parameters[0].Value = model.TP_Title;
            parameters[1].Value = model.TP_DateStart;
            parameters[2].Value = model.TP_DateEnd;
            parameters[3].Value = model.TP_Progress;
            parameters[4].Value = model.TP_CreateUser;
            parameters[5].Value = model.TP_Owner;
            parameters[6].Value = model.TP_Comments;
            parameters[7].Value = model.TP_Status;
            parameters[8].Value = model.TP_IsDelete;
            parameters[9].Value = model.TP_CreateDate;
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
    }
}
