<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="TaskListTotalNew.aspx.cs" Inherits="RTCSEWorkManageBS.TaskManage.TaskListTotalNew" %>

<asp:Content ID="Content2" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <!-- JQGrid CSS -->
    <link href="<%=ResolveUrl("~/bower_components/jqgrid/css/ui.jqgrid-bootstrap.css") %>" rel="stylesheet" />
    <!-- BS-Select CSS -->
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-select/dist/css/bootstrap-select.min.css") %>" rel="stylesheet" />
    <!-- BS-DateTimePicker CSS -->
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css") %>" rel="stylesheet" />
    <%--<link href="<%=ResolveUrl("~/bower_components/bootstrap-validator/dist/css/bootstrapValidator.min.css") %>" rel="stylesheet" />--%>
    <style type="text/css">
        .page-header {
            padding-bottom: 9px;
            margin: 15px 0 10px;
            border-bottom: 1px solid #eee;
        }

        .col-lg-3 {
            border-right: 1px solid #eee;
        }

        .col-lg-4 {
            border-right: 1px solid #eee;
        }

        .col-lg-6 {
            border-right: 1px solid #eee;
            /*border-bottom: 1px solid #eee;*/
        }

        .ui-jqgrid tr.jqgrow td {
            white-space: normal !important;
            height: auto;
            vertical-align: text-top;
            padding-top: 2px;
            vertical-align: middle;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Total Task List</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-7">
                <div class="panel panel-default">
                    <%--<div class="panel-heading">
                        Task List
                    </div>--%>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <input class="btn btn-success" type="button" value="New" onclick="AddDialogShow()" />
                        <input class="btn btn-primary" type="button" value="Edit" onclick="EditDialogShow()" />
                        <input class="btn btn-danger" type="button" value="Delete" onclick="DeleteTask()" />
                        <input class="btn btn-default" type="button" value="Add Scenario" onclick="AddScenarioDialogShow()" />
                        <input class="btn btn-default" type="button" value="Start Task" onclick="StartTask()" />
                        <input class="btn btn-default" type="button" value="Complete Task" onclick="EndTask()" />
                        <%--<input class="btn btn-default" type="button" value="Add Row" onclick="ShowDialog()" />--%>
                        <br />
                        <br />
                        <table id="GT_TaskListTotal"></table>
                        <div id="jqGridPager"></div>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-7 -->
            <div class="col-lg-5">
                <div class="panel panel-default">
                    <%--<div class="panel-heading">
                        Task Detial
                    </div>--%>
                    <div class="list-group">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Task Title</p>
                                    <h4 class="list-group-item-heading" id="D_TT_Title">*</h4>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Type</p>
                                    <h4 class="list-group-item-heading" id="D_TT_TaskType">*</h4>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Complete Reason</p>
                                    <h4 class="list-group-item-heading" id="D_TT_CompleteReason">*</h4>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-3">
                                <div class="list-group-item">
                                    <%--<div class="list-group-item">
                                        <p class="list-group-item-text"></p>
                                        <h4 class="list-group-item-heading"></h4>
                                        </div>--%>
                                    <p class="list-group-item-text">Release</p>
                                    <h4 class="list-group-item-heading" id="D_TT_Release">*</h4>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Server/Client</p>
                                        <h4 class="list-group-item-heading" id="D_TT_ServerClient">*</h4>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">CU</p>
                                    <h4 class="list-group-item-heading" id="D_TT_CU">*</h4>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Build Type</p>
                                    <h4 class="list-group-item-heading" id="D_TT_BuildType">*</h4>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-4">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Build Number</p>
                                    <h4 class="list-group-item-heading" id="D_TT_BuildNum">*</h4>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Style</p>
                                    <h4 class="list-group-item-heading" id="D_TT_TaskStyle">*</h4>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Status</p>
                                    <h4 class="list-group-item-heading" id="D_TT_TaskStatus">*</h4>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-4">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Case No.</p>
                                    <h4 class="list-group-item-heading" id="D_TT_CaseTotalNum">*</h4>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Runned Now</p>
                                    <h4 class="list-group-item-heading" id="D_TT_CaseRealRunNum">*</h4>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Progress</p>
                                    <h4 class="list-group-item-heading" id="D_TT_TaskProgress">*</h4>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Date Start</p>
                                    <h4 class="list-group-item-heading" id="D_TT_DateStart">*</h4>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Date End</p>
                                    <h4 class="list-group-item-heading" id="D_TT_DateEnd">*</h4>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Time Start</p>
                                    <h4 class="list-group-item-heading" id="D_TT_TimeStart">*</h4>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Time End</p>
                                    <h4 class="list-group-item-heading" id="D_TT_TimeEnd">*</h4>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-8">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Time Used</p>
                                    <h4 class="list-group-item-heading" id="D_TT_TimeUsed">*</h4>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Have Scenario ?</p>
                                    <h4 class="list-group-item-heading" id="D_TT_HaveScenario">*</h4>
                                </div>
                            </div>
                        </div>
                        <%--<div class="row">
                            
                        </div>--%>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="list-group-item">
                                    <h4 class="list-group-item-heading">Comments</h4>
                                    <p class="list-group-item-text" id="D_TT_Comments">*</p>
                                    <%--Scenario Steps and Verifications: 
                                        1. user1 start IM with user2 
                                            [Verify User2 gets IM Toast notification]
                                        2. User1 adds User3 in the session to esclate it to a conference
                                            [Verify user3 is able to join & it is escalated to IM conference]--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.row -->
    </div>
    <!-- /.page-wrapper -->



    <div class="modal fade" id="ModalTaskListTotal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">New Task(Total)</h4>
                </div>
                <!-- /.modal-header -->
                <div class="modal-body" id="FormTaskList">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Task Title</label>
                                <input class="form-control" id="TT_Title" name="TT_Title" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Release</label>
                                <label id="TT_ID" hidden="hidden">*</label>
                                <select class="form-control selectpicker" id="TT_Release">
                                    <option>W16</option>
                                    <option>W15</option>
                                    <option>W14</option>
                                    <option>LM</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>CU</label>
                                <input class="form-control" id="TT_CU" value="CU" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label>Server/Client Build</label>
                                <select class="form-control selectpicker" id="TT_ServerClient">
                                    <option>Server</option>
                                    <option>Client</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label>Build Type</label>
                                <select class="form-control selectpicker" id="TT_BuildType">
                                    <option>Escrow</option>
                                    <option>Private</option>
                                    <option>MSRC</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label>Build Number</label>
                                <input class="form-control" id="TT_BuildNum" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Task Type</label>
                                <select class="form-control selectpicker" id="TT_TaskType">
                                    <optgroup label="HotFix">
                                        <option>HotFix Sanity</option>
                                        <option>HotFix Full Pass</option>
                                    </optgroup>
                                    <optgroup label="MU (Microsoft Update)">
                                        <option>MU</option>
                                        <option>MU Sanity</option>
                                    </optgroup>
                                    <optgroup label="E2E (End 2 End)">
                                        <option>E2E</option>
                                        <option>E2E Sanity</option>
                                    </optgroup>
                                    <optgroup label="Others">
                                        <option>Focus Testing</option>
                                        <option>Ad-hoc</option>
                                        <option>others</option>
                                    </optgroup>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Case No.</label>
                                <input class="form-control" id="TT_CaseTotalNum" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Task Style</label>
                                <select class="form-control selectpicker" id="TT_TaskStyle">
                                    <option>Official</option>
                                    <option>Re-Set</option>
                                    <option>Skip</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label>Start Date</label>
                                <input class="form-control" id="TT_DateStart" />
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label>End Date</label>
                                <input class="form-control" id="TT_DateEnd" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Commonts</label>
                                <textarea class="form-control" rows="6" id="TT_Comments"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.modal-body -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-success" id="btn_AddTask" onclick="AddNewTaskTotal()">Save</button>
                    <button type="button" class="btn btn-success" id="btn_UpdateTask" onclick="UpdateTaskTotal()">Update</button>
                </div>
                <!-- /.modal-footer -->
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <div class="modal fade" id="ModalScenario" tabindex="-1" role="dialog" aria-labelledby="ModalScenarioLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="ModalScenarioLabel">Add Scenario</h4>
                </div>
                <!-- /.modal-header -->
                <div class="modal-body" id="FormScenario">
                    <div class="row form-inline">
                        <div class="form-group">
                            <div class="col-lg-12">
                                <label>Scenario Num</label>
                                <label id="FK_TT_ID" hidden="hidden">*</label>
                                <input class="form-control" id="S_ScenarioNumber" name="ScenarioNumber" />
                                <button type="button" class="btn btn-default" onclick="AddDynamicScenarioInput()">Submit</button>
                            </div>
                        </div>
                    </div>
                    <br />
                </div>
                <!-- /.modal-body -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-success" onclick="AddScenario()">Save</button>
                </div>
                <!-- /.modal-footer -->
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <div class="modal fade" id="ModalTaskComplete" tabindex="-1" role="dialog" aria-labelledby="ModalTaskCompleteLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="ModalTaskCompleteLabel">Task Complete</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-5">
                            <div class="input-group">
                                <label id="TC_TT_ID" hidden="hidden">*</label>
                                <div class="input-group-addon">Progress</div>
                                <input type="number" class="form-control" id="TT_Progress" />
                                <div class="input-group-addon">%</div>
                            </div>
                        </div>
                        <div class="col-lg-7">
                            <div class="input-group">
                                <div class="input-group-addon">Complete Reason</div>
                                <select class="form-control selectpicker" id="TT_CompleteReason">
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
                    <button type="button" class="btn btn-success" onclick="CommitEndTask()">Save</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <!-- jqgrid langue JavaScript -->
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/jqgrid/js/i18n/grid.locale-en.js") %>"></script>
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/jqgrid/js/jquery.jqGrid.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap/js/modal.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-select/dist/js/bootstrap-select.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js") %>"></script>
    <%--<script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-validator/dist/js/bootstrapValidator.js") %>"></script>--%>
    <%--<script type="text/javascript" src="<%=ResolveUrl("~/bower_components/jquery-validator/dist/jquery.validate.min.js") %>"></script>--%>
    <script type="text/javascript" src="<%=ResolveUrl("~/PageJS/TaskManage/TaskListTotalNew.js") %>"></script>
</asp:Content>
