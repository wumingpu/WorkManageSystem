<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="Scenario.aspx.cs" Inherits="RTCSEWorkManageBS.TaskManage.Scenario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <!-- JQGrid CSS -->
    <link href="<%=ResolveUrl("~/bower_components/jqgrid/css/ui.jqgrid-bootstrap.css") %>" rel="stylesheet" />
    <!-- tagsinput CSS -->
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput-typeahead.css") %>" rel="stylesheet" />
    <style type="text/css">
        .bootstrap-tagsinput {
            width: 40%;
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
                <h1 class="page-header">Scenario</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-5">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <table id="GT_TaskListTotal"></table>
                        <div id="jqGridPagerTask"></div>
                    </div>
                </div>
            </div>
            <div class="col-lg-7">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Scenario Manage
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <%--<input class="btn btn-default" type="button" value="Add Row" onclick="ShowDialog()" />--%>
                        <input class="btn btn-success" type="button" value="New" onclick="AddDialogShow()" />
                        <input class="btn btn-primary" type="button" value="Edit" onclick="EditDialogShow()" />
                        <input class="btn btn-danger" type="button" value="Delete" onclick="DeleteScenario()" />
                        <input class="btn btn-default" type="button" value="Add Scenario Feature" onclick="AddScenarioRoleDialogShow()" />
                        <br />
                        <br />
                        <table id="GT_Scenario"></table>
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

    <div class="modal fade" id="ModalScenarioInfo" tabindex="-1" role="dialog" aria-labelledby="ModalScenarioInfoLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="ModalScenarioInfoLabel">Add Scenario Info</h4>
                </div>
                <!-- /.modal-header -->
                <div class="modal-body" id="FormScenario">
                    <div class="row">
                        <div class="form-group">
                            <div class="col-lg-12">
                                <label>Scenario Title</label>
                                <label id="S_FK_TT_ID" hidden="hidden">*</label>
                                <label id="S_ID" hidden="hidden">*</label>
                                <input class="form-control" id="S_ScenarioName" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.modal-body -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-success" id="btn_AddScenarioInfo" onclick="SaveScenarioInfo('add')">Save</button>
                    <button type="button" class="btn btn-success" id="btn_UpdateScenarioInfo" onclick="SaveScenarioInfo('edit')">Update</button>
                </div>
                <!-- /.modal-footer -->
            </div>
        </div>
    </div>

    <div class="modal fade" id="ModalScenarioRole" tabindex="-1" role="dialog" aria-labelledby="ModalScenarioRoleLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="ModalScenarioRoleLabel">Add Scenario Feature</h4>
                </div>
                <!-- /.modal-header -->
                <div class="modal-body" id="FormScenarioRole">
                    <label id="SR_FK_S_ID" hidden="hidden">*</label>
                    <label id="SR_FK_TT_ID" hidden="hidden">*</label>
                    <%--<div class="row DynamicSR" style="line-height: 40px">
                        <div class="form-inline">
                            <div class="col-lg-12">
                                <label>Feature Title</label><input class="form-control SR_RoleTitle" />
                                <label>Case No.</label><input class="form-control SR_CaseNum" style="width: 7%" />
                                <label>Resource</label><input class="form-control SR_AssignedUser" style="width: 40%" />
                                <button type="button" class="btn btn-default" name="btnAdd" onclick="AddScenarioRoleRow()">Add</button>
                            </div>
                        </div>
                    </div>--%>
                </div>
                <!-- /.modal-body -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-success" onclick="SaveScenarioRole()">Save</button>
                </div>
                <!-- /.modal-footer -->
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <!-- jqgrid langue JavaScript 'Required!!!' -->
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/jqgrid/js/i18n/grid.locale-en.js") %>"></script>
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/jqgrid/js/jquery.jqGrid.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap/js/modal.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/typeahead/dist/typeahead.bundle.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/DynamicJS/TagsInputUserData.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/PageJS/TaskManage/Scenario.js") %>"></script>
</asp:Content>
