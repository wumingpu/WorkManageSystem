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
    <script type="text/javascript" src="<%=ResolveUrl("~/PageJS/TaskManage/TaskListDaily.js") %>"></script>
</asp:Content>
