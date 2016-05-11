<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="PersonalReport.aspx.cs" Inherits="RTCSEWorkManageBS.DailyReport.PersonalReport" %>

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
                <h1 class="page-header">Daily Report (Personal Report)</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row Title -->
        <div class="row">
            <div class="col-lg-12">
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
            var U_ID = $('#User_ID').text();
            var DR_Date = $('#DR_Date').val();
            $('#GT_DailyReport').jqGrid({
                url: '../ashx/DailyReportHandler.ashx?mode=QueryDailyReportList&U_ID=' + U_ID + '&DR_Date=' + DR_Date,
                datatype: "json",
                colModel: [
                        { label: 'ID', name: 'TD_ID', key: true, hidden: true },
                        { label: 'Title', name: 'BTT_Title', width: 300 },
                        { label: 'Resources', name: 'DR_ResourcesName', width: 80 },
                        { label: 'Owner', name: 'BTT_Owner', width: 80 },
                        { label: 'Status', name: 'BTT_Status', width: 55 },
                        { label: '%', name: 'BTT_Progress', width: 30 },
                        { label: 'Type', name: 'DR_Type', width: 80 }
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

            $("#DR_Date").datetimepicker({ format: 'mm/dd/yyyy', minView: "month", autoclose: true });
            //    .on("click", function (ev) {
            //    $('#TT_DateStart').datetimepicker("setEndDate", $('#TT_DateEnd').val());
            //});

            //ReloadJQGrid();
        });

        function ReloadJQGrid() {
            var U_ID = $('#User_ID').text();
            var DR_Date = $('#DR_Date').val();
            $('#GT_DailyReport').setGridParam({
                url: '../ashx/DailyReportHandler.ashx?mode=QueryDailyReportList&U_ID=' + U_ID + '&DR_Date=' + DR_Date,
                datatype: 'json'
            }).trigger('reloadGrid');
        }
    </script>
</asp:Content>
