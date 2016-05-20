<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="TaskBoard.aspx.cs" Inherits="RTCSEWorkManageBS.TaskManage.TaskBoard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-select/dist/css/bootstrap-select.min.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/dragula/dist/dragula.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/dist/css/w3card.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/bootcards/dist/css/bootcards-desktop.css") %>" rel="stylesheet" />
    <!-- tagsinput CSS -->
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput-typeahead.css") %>" rel="stylesheet" />
    <style type="text/css">
        .bootstrap-tagsinput {
            width: 100%;
        }

        .PDHidden {
            display: none;
        }

        .PDShown {
            display: normal;
        }

        .page-header {
            padding-bottom: 9px;
            margin: 15px 0 10px;
            border-bottom: 1px solid #eee;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Task Board</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-4">
                <div class="panel panel-yellow">
                    <div class="panel-heading">
                        TO-DO
                        <button type="button" class="btn btn-success btn-xs pull-right" onclick="AddDialogShow()">Create a Task</button>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body" id="LeftPanel">
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Doing
                    </div>
                    <div class="panel-body" id="MiddlePanel">
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="panel panel-green">
                    <div class="panel-heading">
                        Done
                    </div>
                    <div class="panel-body" id="RightPanel">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="ModalTaskPersonal" tabindex="-1" role="dialog" aria-labelledby="ModalTaskPersonalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="ModalTaskPersonalLabel">Add Personal Task</h4>
                </div>
                <!-- /.modal-header -->
                <div class="modal-body" id="FormTaskPersonal">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Task Title</label>
                                <input id="TP_Title" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Start Date</label>
                                <input id="TP_DateStart" class="form-control" />
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>End Date</label>
                                <input id="TP_DateEnd" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Owner</label>
                                <input class="form-control" id="TP_Owner" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Comments</label>
                                <textarea id="TP_Comments" rows="6" class="form-control"></textarea>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-success" id="btn_AddRole" onclick="AddTaskPersonal()">Save</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="ModalTaskDetail" tabindex="-1" role="dialog" aria-labelledby="ModalTaskDetailLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="ModalTaskDetailLabel">View Task Detail</h4>
                </div>
                <!-- /.modal-header -->
                <div class="modal-body" id="FormTaskDetail">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Task Title</label>
                                <input class="form-control" id="TD_TaskTitle" />
                            </div>
                        </div>
                    </div>
                    <div class="row publicRow">
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label>Release</label><input class="form-control" id="TT_Release" />
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="form-group">
                                <label>Build Type</label><input class="form-control" id="TT_BuildType" />
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label>Task Type</label><input class="form-control" id="TT_TaskType" />
                            </div>
                        </div>
                    </div>
                    <div class="row publicRow">
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label>Task Style</label><input class="form-control" id="TT_TaskStyle" />
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label>CU</label><input class="form-control" id="TT_CU" />
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label>Build Number</label><input class="form-control" id="TT_BuildNum" />
                            </div>
                        </div>
                    </div>
                    <div class="row publicRow">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Scenario</label>
                                <input class="form-control" id="TD_ScenarioTitle" />
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Feature</label>
                                <input class="form-control" id="TD_RoleTitle" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Date Start</label>
                                <input class="form-control" id="TD_DateStart" />
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Date End</label>
                                <input class="form-control" id="TD_DateEnd" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Owner</label>
                                <input class="form-control" id="TD_Owner" />
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Assigned User</label>
                                <input class="form-control" id="TD_AssignedUserName" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Comments</label><textarea class="form-control" rows="4" id="TD_Comments"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <%--<label>Progress</label>--%>
                            <div class="progress" id="TD_Progress">
                                <%--<div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
                                    60%
                                </div>--%>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="input-group">
                                <div class="input-group-addon">Complete Reason</div>
                                <input type="text" class="form-control" id="p_TD_CompleteReason" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="ModalAddProgress" tabindex="-1" role="dialog" aria-labelledby="ModalAddProgressLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="ModalAddProgressLabel">Add Task Progress</h4>
                    <label id="p_TD_ID" hidden="hidden">*</label>
                    <label id="p_TD_CardType" hidden="hidden">*</label>
                    <label id="p_DragFrom" hidden="hidden">*</label>
                    <label id="p_DropTo" hidden="hidden">*</label>
                    <label id="TT_ID" hidden="hidden">*</label>
                </div>
                <!-- /.modal-header -->
                <div class="modal-body" id="FormAddProgress">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Task Title</label>
                                <%--<h4 id="p_TD_TaskTitle"></h4>--%>
                                <input id="p_TD_TaskTitle" class="form-control" readonly="readonly" />
                            </div>
                        </div>
                    </div>
                    <div class="row PublicProgressRow">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Scenario</label>
                                <%--<h4 id="p_TD_ScenarioTitle"></h4>--%>
                                <input id="p_TD_ScenarioTitle" class="form-control" readonly="readonly" />
                            </div>
                        </div>
                    </div>
                    <div class="row PublicProgressRow">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Feature</label>
                                <%--<h4 id="p_TD_RoleTitle"></h4>--%>
                                <input id="p_TD_RoleTitle" class="form-control" readonly="readonly" />
                            </div>
                        </div>
                    </div>
                    <div class="row PublicProgressRow">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Case Total Number</label>
                                <%--<h4 id="SR_CaseNum"></h4>--%>
                                <input id="SR_CaseNum" class="form-control" readonly="readonly" />
                            </div>
                        </div>
                        <div class="col-lg-6 CaseLeftCol" hidden="hidden">
                            <%--<div class="input-group">
                                <div class="input-group-addon">Case Left</div>
                                <input type="number" class="form-control" id="CaseLeft" readonly="readonly" />
                                <div class="input-group-addon">Item</div>
                            </div>--%>

                            <div class="form-group">
                                <label>Case Left</label>
                                <input type="number" class="form-control" id="CaseLeft" readonly="readonly" />
                            </div>
                        </div>
                    </div>

                    <div class="row TimeSelectRow">
                        <div class="col-lg-6 TimeStartCol">
                            <div class="form-group">
                                <label>Task Start Time</label>
                                <input id="TD_TimeStart" class="form-control" />
                            </div>
                        </div>
                        <div class="col-lg-6 TimeEndCol">
                            <div class="form-group">
                                <label>Task End Time</label>
                                <input id="TD_TimeEnd" class="form-control" />
                            </div>
                        </div>
                    </div>

                    <div class="row PublicProgressRow">
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label>Passed</label>
                                <label id="SR_CasePassedOld" hidden="hidden">0</label>
                                <input onchange="CalculateProgressNum()" type="number" id="SR_CasePassed" class="form-control" />
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label>N/A</label>
                                <label id="SR_CaseNAOld" hidden="hidden">0</label>
                                <input onchange="CalculateProgressNum()" type="number" id="SR_CaseNA" class="form-control" />
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label>Failed</label>
                                <label id="SR_CaseFailedOld" hidden="hidden">0</label>
                                <input onchange="CalculateProgressNum()" type="number" id="SR_CaseFailed" class="form-control" />
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label>Redmond Run</label>
                                <label id="SR_CaseRedmondOld" hidden="hidden">0</label>
                                <input onchange="CalculateProgressNum()" type="number" id="SR_CaseRedmond" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="input-group">
                                <div class="input-group-addon">Progress</div>
                                <input type="number" class="form-control" id="p_TD_Progress" />
                                <div class="input-group-addon">%</div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="input-group">
                                <div class="input-group-addon">Complete Reason</div>
                                <select class="form-control selectpicker" id="TD_CompleteReason">
                                    <option></option>
                                    <option>Completed</option>
                                    <option>Reset</option>
                                    <option>Task Stop</option>
                                    <option>Give Up</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-success" onclick="CommitTaskProgress()">Save</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-select/dist/js/bootstrap-select.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap/js/modal.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/typeahead/dist/typeahead.bundle.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/DynamicJS/TagsInputUserData.js") %>"></script>
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/dragula/dist/dragula.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/PageJS/TaskManage/TaskBoard.js") %>"></script>
</asp:Content>
