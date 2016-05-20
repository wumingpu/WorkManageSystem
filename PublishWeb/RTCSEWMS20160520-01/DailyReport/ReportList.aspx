<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="ReportList.aspx.cs" Inherits="RTCSEWorkManageBS.DailyReport.ReportList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <!-- JQGrid CSS -->
    <link href="<%=ResolveUrl("~/bower_components/jqgrid/css/ui.jqgrid-bootstrap.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css") %>" rel="stylesheet" />    
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Daily Report (Everyone Report)</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row Title -->

        <div class="row">
            <div class="col-lg-3">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="search-form">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="input-group">
                                        <input id="txt_KeyWord" type="text" class="form-control" placeholder="Search for..." />
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="button" onclick="SearchUserInfoList()">Search</button>
                                        </span>
                                    </div>
                                    <!-- /input-group -->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="list-group" id="UserInfoList">
                    </div>
                </div>
            </div>
            <div class="col-lg-9">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Daily Report Table
                        <label hidden="hidden" id="U_ID">*</label>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-5">
                                <div class="form-inline">
                                    <%--<label>Date</label>--%>
                                    <%--<input class="form-control" id="DR_Date" />--%>
                                    <%--<input type="button" class="btn btn-default" value="Search" onclick="ReloadJQGrid()" />--%>
                                    
                                    <div class="input-group">
                                        <div class="input-group-addon">Date</div>
                                        <input id="DR_Date" type="text" class="form-control" placeholder="Select Date..." />
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="button" onclick="ReloadJQGrid()">Load Report</button>
                                        </span>
                                    </div>
                                    <!-- /input-group -->
                                </div>
                            </div>
                        </div>
                        <br />
                        <table id="GT_DailyReport"></table>
                        <div id="jqGridPager"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <!-- jqgrid langue JavaScript -->
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/jqgrid/js/i18n/grid.locale-en.js") %>"></script>
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/jqgrid/js/jquery.jqGrid.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js") %>"></script>
    <script type="text/javascript">
        $.jgrid.defaults.responsive = true;
        $.jgrid.defaults.styleUI = 'Bootstrap';

        $(document).ready(function () {
            $('#GT_DailyReport').jqGrid({
                url: '../ashx/DailyReportHandler.ashx?mode=QueryDailyReportList&U_ID=0',
                datatype: "json",
                colModel: [
                        { label: 'ID', name: 'TD_ID', key: true, hidden: true },
                        { label: 'Title', name: 'BTT_Title', width: 200 },
                        { label: 'Resources', name: 'DR_ResourcesName', width: 80 },
                        { label: 'Owner', name: 'BTT_Owner', width: 80 },
                        { label: 'Status', name: 'BTT_Status', width: 55 },
                        { label: '%', name: 'BTT_Progress', width: 30 },
                        { label: 'Type', name: 'DR_Type', width: 85 }
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
            $('#GT_DailyReport').navGrid("#jqGridPager", {
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

            ReloadUserList('');

            $("#DR_Date").datetimepicker({ format: 'mm/dd/yyyy', minView: "month", autoclose: true });
            //    .on("click", function (ev) {
            //    $('#TT_DateStart').datetimepicker("setEndDate", $('#TT_DateEnd').val());
            //});
        });

        function ReloadUserList(keyWord) {
            $.post('../ashx/SystemManageHandler.ashx', {
                mode: 'QueryUserList', KeyWord: keyWord
            }, function (data) {
                var UserInfo = $.parseJSON(data);
                $('#UserInfoList').empty();
                for (var i in UserInfo) {
                    $('#UserInfoList').append('<a class="list-group-item" onclick="UserInfoListClick($(this))" id="UserInfoList' + UserInfo[i].U_ID + '">' +
                        '<h4 class="list-group-item-heading">' + UserInfo[i].U_nickname + '</h4>' +
                        '<p class="list-group-item-text">' + UserInfo[i].U_mailbox + ' | ' + UserInfo[i].U_Role + '</p></a>');
                }
            })
        }

        function SearchUserInfoList() {
            var KeyWord = $('#txt_KeyWord').val();
            ReloadUserList(KeyWord);
        }

        function UserInfoListClick(selector) {
            if (selector.hasClass('list-group-item')) {
                selector.addClass('active').siblings().removeClass('active');
            }
            var U_ID = selector.attr('id').substring(12);
            $('#U_ID').val(U_ID);
            ReloadJQGrid();
        }

        function ReloadJQGrid() {
            var U_ID = $('#U_ID').val();
            var DR_Date = $('#DR_Date').val();
            $('#GT_DailyReport').setGridParam({
                url: '../ashx/DailyReportHandler.ashx?mode=QueryDailyReportList&U_ID=' + U_ID + '&DR_Date=' + DR_Date,
                datatype: 'json'
            }).trigger('reloadGrid');
        }
    </script>
</asp:Content>
