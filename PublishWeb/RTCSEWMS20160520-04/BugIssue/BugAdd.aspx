<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="BugAdd.aspx.cs" Inherits="RTCSEWorkManageBS.BugIssue.BugAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-select/dist/css/bootstrap-select.min.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/typeahead/dist/typeaheadjs.css") %>" rel="stylesheet" />

    <style type="text/css">
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
                <h1 class="page-header">New Bug/Issue</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-body" id="formBugIssue">
                        <div class="row">
                            <div class="col-lg-9">
                                <div class="form-group">
                                    <label>Bug/Issue Title</label>
                                    <input class="form-control" id="BI_Title" />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group">
                                    <label>Type</label>
                                    <select class="form-control selectpicker" id="BI_Type">
                                        <%--<option>Issue</option>
                                        <option>Bug</option>--%>
                                        <option></option>
                                        <optgroup label="Issue">
                                            <option>Issue</option>
                                            <option>Comfirm Issue</option>
                                            <option>MU Issue</option>
                                            <option>Configure Issue(W14/W15)</option>
                                            <option>Configure Issue(W16)</option>
                                        </optgroup>
                                        <optgroup label="Bug">
                                            <option>Bug</option>
                                        </optgroup>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-8">
                                <div class="form-group">
                                    <label>Hit Task</label>
                                    <select class="form-control selectpicker" id="BI_FK_TT_ID" data-size="8">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group">
                                    <label>Task KeyWord</label>
                                    <input class="form-control" id="BI_TT_Keyword" />
                                </div>
                            </div>
                            <div class="col-lg-1">
                                <div class="form-group">
                                    <label>Reload</label>
                                    <button type="button" class="btn btn-default" onclick="SearchDDLTaskTotal()">Search</button>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label>Hit Scenario</label>
                                    <select class="form-control selectpicker" id="BI_FK_S_ID" data-size="8">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label>Hit Feature</label>
                                    <select class="form-control selectpicker" id="BI_FK_SR_ID" data-size="8">
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-3">
                                <div class="form-group">
                                    <label>Failed Case Number</label>
                                    <input class="form-control" id="BI_CaseNumber" />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group">
                                    <label>Topology Name</label>
                                    <input class="form-control" id="BI_TopologyName" />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group">
                                    <label>Server</label>
                                    <input class="form-control" id="BI_EnvironmentServer" />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group">
                                    <label>Priority</label>
                                    <select class="form-control selectpicker" id="BI_Priority">
                                        <option></option>
                                        <option>P0</option>
                                        <option>P1</option>
                                        <option>P2</option>
                                        <option>P3</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label>Bug/Issue Content</label>
                                    <textarea id="BI_Content"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <button type="button" class="btn btn-success" onclick="SaveBug()">Save</button>
                        <%--<button type="button" class="btn btn-danger" onclick="EmptyPageContent()">EmptyPageContent</button>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-select/dist/js/bootstrap-select.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/typeahead/dist/typeahead.bundle.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/tinymce/tinymce.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/PageJS/BugIssue/BugAdd.js") %>"></script>
</asp:Content>
