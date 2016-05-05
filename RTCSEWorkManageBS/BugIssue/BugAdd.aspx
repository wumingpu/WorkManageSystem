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
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label>Bug/Issue Title</label>
                                    <input class="form-control" id="BI_Title" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <%--<div class="input-group">
                                    <div class="input-group-addon">Hit Task</div>
                                    <select class="form-control selectpicker" id="BI_FK_TT_ID">
                                        <option></option>
                                    </select>
                                    <input class="form-control pull-right" id="BI_TT_Keyword" />
                                    <button type="button" class="btn input-group-btn" onclick="SearchDDLTaskTotal()">Search</button>
                                </div>--%>
                                <div class="form-group">
                                    <label>Hit Task</label>
                                    <%--<input class="form-control" id="BI_FK_TT_ID" />--%>
                                    <select class="form-control selectpicker" id="BI_FK_TT_ID">
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <button type="button" class="btn btn-default" onclick="SaveBug()">Save</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-select/dist/js/bootstrap-select.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/typeahead/dist/typeahead.bundle.min.js") %>"></script>

    <script type="text/javascript">
        //var DataSourceTaskTitle = new Bloodhound({
        //    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
        //    queryTokenizer: Bloodhound.tokenizers.whitespace,
        //    //prefetch: '../data/films/post_1960.json',
        //    remote: {
        //        url: '../ashx/BugIssueHandler.ashx?mode=GetDDLTaskTotalSearch',
        //        //wildcard: '%QUERY'
        //    }
        //});

        $(document).ready(function () {
            //$('#BI_FK_TT_ID').typeahead({
            //    minLength: 1,
            //    highlight: true
            //},
            //{
            //    limit: 6,
            //    display: 'TT_Title',
            //    //source: DataSourceTaskTitle
            //    source: function (query, process) {
            //        return $.get('../ashx/BugIssueHandler.ashx', {
            //            mode: 'GetDDLTaskTotalSearch', query: query
            //        }, function (data) { return $.parseJSON(data).rows });
            //    }
            //});
            InitialDDLTaskTotal();
        });

        function InitialDDLTaskTotal() {
            $.post('../ashx/BugIssueHandler.ashx', {
                mode: 'GetDDLTaskTotalInprogress'
            }, function (data) {
                $('#BI_FK_TT_ID').html('<option></option>');
                var TaskInfo = $.parseJSON(data);
                for (var i in TaskInfo) {
                    $('#BI_FK_TT_ID').append('<option value=' + TaskInfo[i].TT_ID + '>' + TaskInfo[i].TT_Title + '</option>');
                }
            })
        }

    </script>
</asp:Content>
