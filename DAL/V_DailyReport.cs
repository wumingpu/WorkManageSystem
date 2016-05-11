using Maticsoft.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public partial class V_DailyReport
    {
        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * from V_DailyReport");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        public bool Add(string ResourcesID, int TableID, string DR_Type)
        {
            StringBuilder strSql = new StringBuilder();
            string DateNow = DateTime.Now.ToString("yyyy-MM-dd");
            string DR_TypeFullName;
            if (DR_Type == "TT")
            {
                DR_TypeFullName = "Public Task";
            }
            else if (DR_Type == "TP")
            {
                DR_TypeFullName = "Personal Task";
            }
            else if (DR_Type == "BI")
            {
                DR_TypeFullName = "Repo Bug/Issue";
            }
            else
            {
                DR_TypeFullName = "Unknow Task Type";
            }
            strSql.Append(string.Format("if((select count(DR_ID) from DailyReport where DR_Resources={0} and DR_FK_ID='{1}{2}' and DR_UpdateDate='{3}')=0) begin ", ResourcesID, DR_Type, TableID, DateNow));
            strSql.Append("insert into DailyReport (DR_Resources,DR_FK_ID,DR_UpdateDate,DR_Type) values ");
            strSql.Append(string.Format("({0},'{3}{1}','{2}','{4}') end", ResourcesID, TableID, DateNow, DR_Type, DR_TypeFullName));
            int AddRes = DbHelperSQL.ExecuteSql(strSql.ToString());
            if (AddRes > 0)
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
