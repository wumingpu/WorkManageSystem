<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="ScenarioRole.aspx.cs" Inherits="RTCSEWorkManageBS.TaskManage.ScenarioRole" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <!-- JQGrid CSS -->
    <link href="<%=ResolveUrl("~/bower_components/jqgrid/css/ui.jqgrid-bootstrap.css") %>" rel="stylesheet" />
    <!-- tagsinput CSS -->
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput-typeahead.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/bootcards/dist/css/bootcards-desktop.css") %>" rel="stylesheet" />
    <style type="text/css">
        .bootstrap-tagsinput {
            width: 100%;
        }

        .page-header {
            padding-bottom: 9px;
            margin: 15px 0 10px;
            border-bottom: 1px solid #eee;
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h2 class="page-header">Feature</h2>
                <%--class="page-header"--%>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-4">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="search-form">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="input-group">
                                        <input id="txt_KeyWord" type="text" class="form-control" placeholder="Search for..." />
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="button" onclick="SearchTaskList()">Search</button>
                                        </span>
                                    </div>
                                    <!-- /input-group -->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="list-group" id="TaskList">
                        <label hidden="hidden">*</label>
                        <%--<a class="list-group-item" onclick="TaskListClick($(this))" id="TaskList23">
                            <h4 class="list-group-item-heading">W16 CU3 server build (9319.253) sanity Hotfix Verification</h4>
                            <p class="list-group-item-text">03/30/2016 - 04/02/2016</p>
                        </a>
                        <a class="list-group-item" onclick="TaskListClick($(this))">
                            <h4 class="list-group-item-heading">W15-CU7 and W14-CU14 SHA1 issue Task</h4>
                            <p class="list-group-item-text">04/07/2016 - 04/09/2016</p>
                        </a>--%>
                    </div>
                    <div class="row">
                        <ul class="pager">
                            <li><a class="btn" onclick="prevPage(); return false;"><<</a></li>
                            <li><span id="CurrentPage">Current:0</span></li>
                            <li><span id="TotalPage">Total:0</span></li>
                            <li><span id="TotalItem">Items:0</span></li>
                            <li><a class="btn" onclick="nextPage(); return false;">>></a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- /.col-lg-3 Left TaskList-->
            <div class="col-lg-8 bootcards-cards">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Scenario
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <table id="GT_Scenario"></table>
                        <div id="jqGridPagerScenario"></div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Feature
                        <%--<h4 class="pull-left">Feature</h4>--%>
                        <%--<a style="margin-left: 15px"></a>--%>
                        <%--<div class="pull-right">
                            <input class="btn btn-success btn-sm" type="button" value="New" onclick="AddDialogShow()" />
                            <input class="btn btn-primary btn-sm" type="button" value="Edit" onclick="EditDialogShow()" />
                            <input class="btn btn-danger btn-sm" type="button" value="Delete" onclick="DeleteScenarioRole()" />
                        </div>--%>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <input class="btn btn-success btn-sm" type="button" value="New" onclick="AddDialogShow()" />
                        <input class="btn btn-primary btn-sm" type="button" value="Edit" onclick="EditDialogShow()" />
                        <input class="btn btn-danger btn-sm" type="button" value="Delete" onclick="DeleteScenarioRole()" />
                        <p style="margin-top: 10px"></p>
                        <table id="GT_ScenarioRole"></table>
                        <div id="jqGridPager"></div>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /.page-wrapper -->

    <div class="modal fade" id="ModalScenarioRole" tabindex="-1" role="dialog" aria-labelledby="ModalScenarioRoleLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="ModalScenarioRoleLabel">Add Scenario Feature</h4>
                </div>
                <!-- /.modal-header -->
                <div class="modal-body" id="FormScenarioRole">
                    <label id="SR_ID" hidden="hidden">*</label>
                    <label id="SR_FK_S_ID" hidden="hidden">*</label>
                    <label id="SR_FK_TT_ID" hidden="hidden">*</label>
                    <label id="TT_TaskStatus" hidden="hidden">*</label>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Feature Title</label>
                                <input class="form-control" id="SR_RoleTitle" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Case Number</label>
                                <input class="form-control" id="SR_CaseNum" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Assigned User</label>
                                <input class="form-control" id="SR_AssignedUser" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.modal-body -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-success" id="btn_AddRole" onclick="AddScenarioRole()">Save</button>
                    <button type="button" class="btn btn-success" id="btn_UpdateRole" onclick="UpdateScenarioRole()">Update</button>
                </div>
                <!-- /.modal-footer -->
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <!-- jqgrid langue JavaScript 'Required!!!' -->
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/jqgrid/js/i18n/grid.locale-en.js") %>"></script>
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/jqgrid/js/jquery.jqGrid.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap/js/modal.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/typeahead/dist/typeahead.bundle.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/DynamicJS/TagsInputUserData.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/PageJS/TaskManage/ScenarioRole.js") %>"></script>
</asp:Content>
