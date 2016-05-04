<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="TaskListDaily.aspx.cs" Inherits="RTCSEWorkManageBS.TaskManage.TaskListDaily" %>

<asp:Content ID="ContentCss1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <!-- JQGrid CSS -->
    <link href="<%=ResolveUrl("~/bower_components/jqgrid/css/ui.jqgrid-bootstrap.css") %>" rel="stylesheet" />
    <style type="text/css">
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

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Daily Task List</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row Title -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Task List
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <input class="btn btn-default" type="button" value="Add Task Progress" onclick="AddTaskProgress()" /><%--添加任务进度--%>
                        <%--<input class="btn btn-default" type="button" value="Add Bug/Issue" onclick="AddBugIssue()" />--%>
                        <br />
                        <br />
                        <table id="GT_TaskListDaily"></table>
                        <div id="jqGridPager"></div>
                    </div>
                </div>
                <!-- /.panel panel-default -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row Panel Body -->
    </div>
    <!-- /.page-wrapper -->
</asp:Content>

<asp:Content ID="ContentJS1" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <!-- jqgrid langue JavaScript -->
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/jqgrid/js/i18n/grid.locale-en.js") %>"></script>
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/jqgrid/js/jquery.jqGrid.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap/js/modal.js") %>"></script>
    <script type="text/javascript">
        $.jgrid.defaults.responsive = true;
        $.jgrid.defaults.styleUI = 'Bootstrap';

        $(document).ready(function () {
            $('#GT_TaskListDaily').jqGrid({
                url: '../ashx/TaskHandler.ashx?mode=QueryTaskListDaily',
                datatype: "json",
                colModel: [
                        { label: 'ID', name: 'TD_ID', key: true, hidden: true },
                        { label: 'Task Date', name: 'TD_Date', width: 100 },
                        { label: 'Case No.', name: 'TD_CaseShouldRunNum', width: 60 },
                        { label: 'Case Real Run', name: 'TD_CaseRealRunNum', width: 90 },
                        { label: 'Passed', name: 'TD_CasePassNum', width: 60 },
                        { label: 'Failed', name: 'TD_CaseFailNum', width: 60 },
                        { label: 'N/A', name: 'TD_CaseNANum', width: 50 },
                        { label: 'Run in Redmond', name: 'TD_CaseRunInRedmond', width: 90 },
                        { label: 'Task Progress', name: 'TD_TaskProgress', width: 100 },
                        { label: 'Task Status', name: 'TD_TaskStatus', width: 100 }
                ],
                sortable: false,
                autowidth: true,
                shinkToFit: true,
                loadonce: true,
                viewrecords: true,
                rownumbers: true,
                height: 'auto',
                rowNum: 10,
                rowList: [10, 20, 30, 50],
                pager: '#jqGridPager'
            });
            // pager options
            $('#GT_TaskListDaily').navGrid("#jqGridPager", {
                search: true, // show search button on the toolbar
                add: false,
                edit: false,
                del: false,
                refresh: true
            },
            {}, // edit options
            {}, // add options
            {}, // delete options
            { multipleSearch: true, multipleGroup: true, showQuery: true } // search options - define multiple search
            );
        });

        function AddTaskProgress() {

        }

        function AddBugIssue() {

        }

        function ReloadJQGrid() {
            $('#GT_TaskListDaily').setGridParam({
                url: '../ashx/TaskHandler.ashx?mode=QueryTaskListDaily',
                datatype: 'json'
            }).trigger('reloadGrid');
        }
    </script>
</asp:Content>
