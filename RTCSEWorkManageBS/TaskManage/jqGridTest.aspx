<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="jqGridTest.aspx.cs" Inherits="RTCSEWorkManageBS.TaskManage.jqGridTest" %>

<asp:Content ID="Content2" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <!-- JQGrid CSS -->
    <link href="<%=ResolveUrl("~/bower_components/jqgrid/css/ui.jqgrid-bootstrap.css") %>" rel="stylesheet" />
    <!-- BS-Select CSS -->
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-select/dist/css/bootstrap-select.min.css") %>" rel="stylesheet" />
    <!-- BS-DateTimePicker CSS -->
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css") %>" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">JQGrid Test Page</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        JQGrid
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <input class="btn btn-default" type="button" value="Select row  with ID 1014" onclick="selectRow()" />
                        <input class="btn btn-default" type="button" value="Get Selected Row" onclick="getSelectedRow()" />
                        <input class="btn btn-default" type="button" value="Refresh JQGrid" onclick="RefreshRow()" />
                        <input class="btn btn-default" type="button" value="Add Row" onclick="ShowDialog()" />
                        <br />
                        <br />
                        <table id="jqGrid"></table>
                        <div id="jqGridPager"></div>
                    </div>
                    <!-- /.panel-body -->
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="TestModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                </div>
                <div class="modal-body" id="FormTaskList">

                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Release</label>
                                <input class="form-control" id="TT_Release" />
                                <label>CU</label>
                                <input class="form-control" id="TT_CU" />
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Build Type</label>
                                <select class="form-control selectpicker" id="TT_BuildType">
                                    <option>1</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                    <option>6</option>
                                    <option>7</option>
                                </select>
                                <label>Build Number</label>
                                <input class="form-control" id="TT_BuildNum" />
                                <div class="col-lg-6">
                                    <label>Start Date</label>
                                    <input class="form-control" id="TT_DateStart" />
                                    <%--<span class="add-on"><i class="icon-remove"></i></span>
                                    <span class="add-on"><i class="icon-calendar"></i></span>--%>
                                </div>
                                <div class="col-lg-6">
                                    <label>End Date</label>
                                    <input class="form-control" id="TT_DateEnd" />
                                </div>
                                <%--<label>Date</label>
                                <input class="form-control" id="TT_DateStart" readonly="true" />
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-calendar"></i></span>
                                <span>
                                    <input class="form-control" id="TT_DateEnd" readonly="true" />
                                    <span class="add-on"><i class="icon-remove"></i></span>
                                    <span class="add-on"><i class="icon-calendar"></i></span></span>--%>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Commonts</label>
                                <textarea class="form-control" rows="6"></textarea>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="AddNewTask()">Save changes</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <!-- jqgrid langue JavaScript -->
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/jqgrid/js/i18n/grid.locale-en.js") %>"></script>
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/jqgrid/js/jquery.jqGrid.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap/js/modal.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-select/dist/js/bootstrap-select.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js") %>"></script>
    <script type="text/javascript">
        $.jgrid.defaults.responsive = true;
        $.jgrid.defaults.styleUI = 'Bootstrap';

        $(document).ready(function () {
            $("#jqGrid").jqGrid({
                url: '../ashx/TaskHandler.ashx?mode=QueryTestJQTable',
                datatype: "json",
                colModel: [
                    {
                        label: 'Customer ID',
                        name: 'CustomerID',
                        width: 100,
                        key: true,
                        hide: true
                    },
                    {
                        label: 'Company Name',
                        name: 'CompanyName',
                        frozen: true,
                        width: 150
                    },
                    {
                        label: 'Phone',
                        name: 'Phone',
                        width: 200
                    },
                    {
                        label: 'Postal Code',
                        name: 'PostalCode',
                        width: 250
                    },
                    {
                        label: 'City',
                        name: 'City',
                        width: 250
                    }
                ],
                shinkToFit: false,
                //loadonce: true,
                viewrecords: true,
                rownumbers: true,
                width: '50%',
                height: 'auto',
                rowNum: 10,
                rowList: [10, 20, 30, 50],
                pager: "#jqGridPager"
            });

            //$('#jqGrid').navGrid("#jqGridPager", {
            //    search: true, // show search button on the toolbar
            //    add: false,
            //    edit: false,
            //    del: false,
            //    refresh: true
            //},
            //{}, // edit options
            //{}, // add options
            //{}, // delete options
            //{ multipleSearch: true, multipleGroup: true, showQuery: true } // search options - define multiple search
            //);

            // bootstrap-datetimepicker 用法
            //$('#datetimepicker').datetimepicker({
            //    minView: "month", //选择日期后，不会再跳转去选择时分秒 
            //    format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式 
            //    language: 'zh-CN', //汉化 
            //    autoclose: true, //选择日期后自动关闭 
            //    startView: 1, //从时分选择开始
            //    showMeridian: true, // 分开上下午选择
            //    minuteStep: 5,
            //});
            $("#TT_DateStart").datetimepicker({ format: 'mm/dd/yyyy', minView: "month", autoclose: true }); // showMeridian
            $("#TT_DateEnd").datetimepicker({ format: 'mm/dd/yyyy', minView: "month", autoclose: true });
        });

        function AddNewTask() {
            var TT_BuildType = $('#TT_BuildType').selectpicker('val');
            var TT_Release = $('#TT_Release').val();
            var TT_CU = $('#TT_CU').val();
            //alert(TT_BuildType);
            var TT_DateStart = $('#TT_DateStart').val();
            var TT_DateEnd = $('#TT_DateEnd').val();
            //alert(TT_DateStart + ' ~ ' + TT_DateEnd);

            $.post('../ashx/TaskHandler.ashx', {
                mode: 'AddTaskListTotal', TT_BuildType: TT_BuildType, TT_Release: TT_Release,
                TT_CU: TT_CU, TT_DateStart: TT_DateStart, TT_DateEnd: TT_DateEnd
            }, function (data, status) {
                if (data == 'success') {
                    alert('Save Success~');
                    RefreshRow();
                }
                else {
                    alert('Some Error Occured！');
                }
            });

        }

        function ShowDialog() {
            $('#TestModal').modal('show');
            //.draggable({ handle: ".modal-header" });//拖拽相关，不能实现
        }

        function getSelectedRow() {
            var grid = $("#jqGrid");
            var rowKey = grid.jqGrid('getGridParam', "selrow");

            if (rowKey)
                alert("Selected row primary key is: " + rowKey);
            else
                alert("No rows are selected");
        }

        function selectRow() {
            jQuery('#jqGrid').jqGrid('setSelection', '1014');
        }

        function RefreshRow() {
            //$('#jqGrid').jqGrid({
            //    url: '../ashx/TaskHandler.ashx?mode=QueryTestJQTable',
            //    datatype: "json"
            //}).trigger("reloadGrid");
            $('#jqGrid').jqGrid('setGridParam', { url: "../ashx/TaskHandler.ashx?mode=QueryTestJQTable", page: 1 }).trigger("reloadGrid");
        }

    </script>
</asp:Content>
