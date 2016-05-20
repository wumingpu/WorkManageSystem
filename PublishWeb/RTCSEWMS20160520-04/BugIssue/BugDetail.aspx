<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="BugDetail.aspx.cs" Inherits="RTCSEWorkManageBS.BugIssue.BugDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <link href="<%=ResolveUrl("~/bower_components/jqgrid/css/ui.jqgrid-bootstrap.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput-typeahead.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/bootcards/dist/css/bootcards-desktop.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/dist/css/timeline.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-select/dist/css/bootstrap-select.min.css") %>" rel="stylesheet" />
    <style type="text/css">
        .bootstrap-tagsinput {
            width: 100%;
        }

        .row > .list-group-item {
            border: 0px 0px 0px 0px !important;
            /;
        }

        .row > .col-lg-6 > .list-group-item {
            border: 0px 0px 0px 0px !important;
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

        .help-block {
            margin-bottom: 0px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Bug Issue List</h1>
                <%--class="page-header"--%>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-7">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="search-form">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="input-group">
                                        <input id="txt_KeyWord" type="text" class="form-control" placeholder="Search for..." />
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="button" onclick="SearchBugIssueList()">Search</button>
                                        </span>

                                    </div>
                                    <span class="help-block">Empty for 'Open' Bug/Issue; Input '@all' display all Bug/Issue</span>
                                    <!-- /input-group -->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="list-group" id="BugIssueList">
                        <label hidden="hidden">*</label>
                    </div>
                    <div class="row">
                        <ul class="pager">
                            <li><a class="btn" onclick="prevPage(); return false;">Previous</a></li>
                            <li><span id="CurrentPage">Current:0</span></li>
                            <li><span id="TotalPage">Total:0</span></li>
                            <li><span id="TotalItem">Items:0</span></li>
                            <li><a class="btn" onclick="nextPage(); return false;">Next</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-lg-5">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <button type="button" class="btn btn-primary" id="btn_BugIssueContent" onclick="">B/I Content</button><%--#BugIssueContent target="_self"--%>
                        <p></p>
                        <div class="list-group">
                            <div class="row">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Hit Task</p>
                                    <h4 class="list-group-item-heading" id="TT_Title">*</h4>
                                </div>
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Hit Scenario</p>
                                    <h4 class="list-group-item-heading" id="S_ScenarioName">*</h4>
                                </div>
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Hit Feature</p>
                                    <h4 class="list-group-item-heading" id="SR_RoleTitle">*</h4>
                                </div>
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Failed Case Number</p>
                                    <h4 class="list-group-item-heading" id="BI_CaseNumber">*</h4>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="list-group-item">
                                            <p class="list-group-item-text">Repo Server Name</p>
                                            <h4 class="list-group-item-heading" id="BI_EnvironmentServer">*</h4>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="list-group-item">
                                            <p class="list-group-item-text">Repo Topology Name</p>
                                            <h4 class="list-group-item-heading" id="BI_TopologyName">*</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="list-group-item">
                                            <p class="list-group-item-text">Update Time</p>
                                            <h4 class="list-group-item-heading" id="BI_UpdateTime">*</h4>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="list-group-item">
                                            <p class="list-group-item-text">Close Time</p>
                                            <h4 class="list-group-item-heading" id="BI_CloseTime">*</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Priority</p>
                                    <h4 class="list-group-item-heading" id="BI_Priority">*</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" id="BugIssueContent">
            <div class="col-lg-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Bug/Issue Content
                    </div>
                    <div class="panel-body">
                        <label hidden="hidden" id="BI_ID">*</label>
                        <div class="row">
                            <div class="col-lg-12">
                                <ul class="timeline" id="BugIssueTimeLine">
                                </ul>
                            </div>
                        </div>

                        <div id="div_BIR_Content">
                            <textarea id="BIR_Content"></textarea>
                        </div>
                    </div>
                    <div class="panel-footer form-inline">
                        <input type="button" class="btn btn-success" id="btn_AddBugIssueReply" value="Add Bug/Issue Reply" onclick="AddReply()" />
                        <div class="input-group">
                            <select class="form-control selectpicker" id="BI_Resolution" style="width: 200px" data-container="body">
                                <option></option>
                                <option>Fixed</option>
                                <option>Active</option>
                            </select>
                            <div class="input-group-btn">
                                <input type="button" class="btn btn-default" id="btn_CloseBugIssue" value="Close Bug/Issue" onclick="CloseBugIssue()" />
                            </div>
                        </div>

                        <input type="button" class="btn btn-primary" id="btn_ReOpenBugIssue" value="ReOpen Bug/Issue" onclick="ReOpenBugIssue()" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/tinymce/tinymce.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-select/dist/js/bootstrap-select.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/PageJS/BugIssue/BugDetail.js") %>"></script>
</asp:Content>
