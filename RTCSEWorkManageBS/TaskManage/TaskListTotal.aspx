<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="TaskListTotal.aspx.cs" Inherits="RTCSEWorkManageBS.TaskManage.TaskListTotal" %>

<asp:Content ID="ContentCss1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <!-- DataTables CSS -->
    <%--<link href="<%=ResolveUrl("~/bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.css") %>" rel="stylesheet" />--%>

    <!-- DataTables Responsive CSS -->
    <link href="<%=ResolveUrl("~/bower_components/datatables-responsive/css/dataTables.responsive.css") %>" rel="stylesheet" />

    <!-- DEmpty url CSS -->
    <%--<link href="<%=ResolveUrl("~/bower_components/") %>" rel="stylesheet" />--%>
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
                <h1 class="page-header">Total Task List</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <%--<div class="panel-heading">
                        DataTables Advanced Tables
                    </div>--%>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="dataTable_wrapper">
                            <%--class="table table-striped table-bordered table-hover"--%>
                            <table class="table table-striped table-bordered table-hover" id="GV_TaskListTotal">
                                <thead>
                                    <tr>
                                        <th>Task ID</th>
                                        <th>Release Wave</th>
                                        <th>CU</th>
                                        <th>Build Type</th>
                                        <th>Build Number</th>
                                        <th>Task Type</th>
                                        <th>Case No.</th>
                                        <th>Real Run</th>
                                        <th>Date</th>
                                        <th>Task Style</th>
                                        <th>Bug/Issue No.</th>
                                        <th>Report</th>
                                        <th>Comments</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                        <!-- /.table-responsive -->
                        <%--<div class="well">
                            <h4>DataTables Usage Information</h4>
                            <p>DataTables is a very flexible, advanced tables plugin for jQuery. In SB Admin, we are using a specialized version of DataTables built for Bootstrap 3. We have also customized the table headings to use Font Awesome icons in place of images. For complete documentation on DataTables, visit their website at <a target="_blank" href="https://datatables.net/">https://datatables.net/</a>.</p>
                            <a class="btn btn-default btn-lg btn-block" target="_blank" href="https://datatables.net/">View DataTables Documentation</a>
                        </div>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="ContentScript1" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <!-- DataTables JavaScript -->
    <script src="<%=ResolveUrl("~/bower_components/datatables/media/js/jquery.dataTables.min.js") %>"></script>
    <script src="<%=ResolveUrl("~/bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.min.js") %>"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            ReloadData();

            $('#GV_TaskListTotal tbody').on('click', 'tr', function () {
                $(this).toggleClass('selected');
            });

        });

        function ReloadData() {
            $('#GV_TaskListTotal').DataTable({
                "ajax": "../ashx/TaskHandler.ashx?mode=QueryTaskListTotal",
                responsive: true,
                "scrollX": true,
                "ordering": false,
                "columnDefs": [
                    {
                        "targets": [0],
                        "visible": false
                    }
                ],
                "rowCallback": function (row, data) {
                    if ($.inArray(data.TT_ID, selected) !== -1) {
                        $(row).addClass('selected');
                    }
                }
            });
        };
    </script>
</asp:Content>
