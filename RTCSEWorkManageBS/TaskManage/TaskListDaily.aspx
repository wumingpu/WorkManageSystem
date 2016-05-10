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
                    </div>
                </div>
            </div>
            <div class="col-lg-8">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Task Daily Progress List
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <%--<input class="btn btn-default" type="button" value="Add Task Progress" onclick="AddTaskProgress()" />--%><%--添加任务进度--%>
                        <%--<input class="btn btn-default" type="button" value="Add Bug/Issue" onclick="AddBugIssue()" />--%>
                        <%--<br />
                        <br />--%>
                        <span class="help-block">These Progress only everyday progress, not total progress of Task </span>
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
            ReloadTaskList('');

            $('#GT_TaskListDaily').jqGrid({
                url: '../ashx/TaskHandler.ashx?mode=QueryTaskListDaily&TD_FK_TaskTotalID=0',
                datatype: "json",
                colModel: [
                        { label: 'ID', name: 'TD_ID', key: true, hidden: true },
                        { label: 'Task Date', name: 'TD_Date', width: 100 },
                        { label: 'No.', name: 'TD_CaseShouldRunNum', width: 90 },
                        { label: 'Runned', name: 'TD_CaseRealRunNum', width: 90 },
                        { label: 'Pass', name: 'TD_CasePassNum', width: 85 },
                        { label: 'Fail', name: 'TD_CaseFailNum', width: 85 },
                        { label: 'N/A', name: 'TD_CaseNANum', width: 85 },
                        { label: 'Rdm', name: 'TD_CaseRunInRedmond', width: 85 },
                        { label: '%', name: 'TD_TaskProgress', width: 85 }
                        //{ label: 'Task Status', name: 'TD_TaskStatus', width: 100 }
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

        //function AddTaskProgress() {

        //}

        //function AddBugIssue() {

        //}

        function ReloadTaskList(keyWord) {
            $.post('../ashx/TaskHandler.ashx', {
                mode: 'QueryTaskListTotalSimple', ListItemNum: keyWord == '' ? 10 : 0, keyWord: keyWord
            }, function (data, status) {
                var TaskInfo = $.parseJSON(data);
                $('#TaskList').empty();
                for (var i in TaskInfo) {
                    $('#TaskList').append('<a class="list-group-item" onclick="TaskListClick($(this))" id="TaskList' + TaskInfo[i].TT_ID + '">' +
                        '<h4 class="list-group-item-heading">' + TaskInfo[i].TT_Title + '</h4>' +
                        '<p class="list-group-item-text">' + TaskInfo[i].TT_Date + '</p><p class="list-group-item-text">' + TaskInfo[i].TT_TaskStatus + '</p></a>');
                }
            });
        }

        function SearchTaskList() {
            var KeyWord = $('#txt_KeyWord').val();
            ReloadTaskList(KeyWord);
        }

        function TaskListClick(selector) {
            if (selector.hasClass('list-group-item')) {
                selector.addClass('active').siblings().removeClass('active');
            }
            var TT_ID = selector.attr('id').substring(8);
            ReloadJQGrid(TT_ID);
        }

        function ReloadJQGrid(TT_ID) {
            $('#GT_TaskListDaily').setGridParam({
                url: '../ashx/TaskHandler.ashx?mode=QueryTaskListDaily&TD_FK_TaskTotalID=' + TT_ID,
                datatype: 'json'
            }).trigger('reloadGrid');
        }
    </script>
</asp:Content>
