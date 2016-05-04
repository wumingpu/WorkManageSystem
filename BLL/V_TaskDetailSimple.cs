using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial class V_TaskDetailSimple
    {
        public V_TaskDetailSimple()
        { }
        DAL.V_TaskDetailSimple dal = new DAL.V_TaskDetailSimple();

        public DataSet GetList(string strWhere, int CompleteCaseNum)
        {
            return dal.GetList(strWhere, CompleteCaseNum);
        }

        public string UpdateTaskProgress(string dragFrom, string dropTo, int TD_ID, string CardType, string TimeStart, string TimeEnd, string CasePassed, string CaseFailed, string CaseNA, string CaseRedmod, string TD_Progress, string TD_CompleteReason)
        {
            if (dragFrom != "*" && dropTo != "*")
            { // 拖动而来的
                // progress==100返回refresh  标记为complete
                if (dragFrom == "MiddlePanel" && dropTo == "RightPanel")
                {
                    if (dal.TaskDoing2Done(TD_ID, CardType, CasePassed, CaseFailed, CaseNA, CaseRedmod, TD_Progress, TD_CompleteReason))
                    { return "Refresh"; }
                    else
                    { return "Update Fail"; }
                }
                else if (dragFrom == "LeftPanel" && dropTo == "RightPanel")
                {
                    if (dal.TaskToDo2Done(TD_ID, CardType, TimeStart, TimeEnd, CasePassed, CaseFailed, CaseNA, CaseRedmod, TD_Progress, TD_CompleteReason))
                    { return "Refresh"; }
                    else
                    { return "Update Fail"; }
                }
                else if (dragFrom == "LeftPanel" && dropTo == "MiddlePanel")
                { // 
                    if (dal.TaskToDo2Doing(TD_ID, CardType))
                    { return "TaskStart"; }
                    else
                    { return "Update Fail"; }
                }
                else
                {
                    return "Data Fail";
                }
                //}
            }
            else
            { // 点击按钮，仅仅是更新进度，如果progress==100，则执行todo-->done的操作，
                // refresh 刷新中间和右边
                if (TD_Progress == "100")
                {
                    if (dal.TaskDoing2Done(TD_ID, CardType, CasePassed, CaseFailed, CaseNA, CaseRedmod, TD_Progress, TD_CompleteReason))
                    { return "Refresh"; }
                    else
                    { return "Update Fail"; }
                }
                else
                {
                    if (dal.AddProgressNum(TD_ID, CardType, CasePassed, CaseFailed, CaseNA, CaseRedmod, TD_Progress))
                    { return "SaveSuccess"; }
                    else
                    { return "Update Fail"; }
                }
            }
        }

        public bool UpdateCaseNumTotalDaily(int TT_ID, string PassedGrow, string FailedGrow, string NAGrow, string RedmondGrow)
        {
            if (TT_ID == 0)
            {
                return true;
            }
            else
            {
                return dal.UpdateCaseNumTotalDaily(TT_ID, PassedGrow, FailedGrow, NAGrow, RedmondGrow);
            }
        }

        public bool UpdateTaskStatus(string dragFrom, string dropTo, int TD_ID, string CardType, string TimeStart, string TimeEnd)
        {// LeftPanel MiddlePanel RightPanel
            //if (dragFrom == "LeftPanel")
            //{
            //    if (dropTo == "MiddlePanel")
            //    {
            //        if (dal.TaskToDo2Doing(TD_ID, CardType)) { return true; } else { return false; }
            //    }
            //    else if (dropTo == "RightPanel")
            //    {
            //        if (dal.TaskToDo2Done(TD_ID, CardType, TimeStart, TimeEnd)) { return true; } else { return false; }
            //    }
            //    else
            //    {
            //        return false;
            //    }
            //}
            //else if (dragFrom == "MiddlePanel")
            //{
            //    if (dropTo == "RightPanel")
            //    {
            //        if (dal.TaskDoing2Done(TD_ID, CardType)) { return true; } else { return false; }
            //    }
            //    else
            //    {
            //        return false;
            //    }
            //}
            //else
            //{
            //    return false;
            //}
            return false;
        }
    }
}
