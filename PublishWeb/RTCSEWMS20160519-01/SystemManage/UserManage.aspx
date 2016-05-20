<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="UserManage.aspx.cs" Inherits="RTCSEWorkManageBS.SystemManage.UserManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <!-- JQGrid CSS -->
    <link href="<%=ResolveUrl("~/bower_components/jqgrid/css/ui.jqgrid-bootstrap.css") %>" rel="stylesheet" />
    <!-- BS-Select CSS -->
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-select/dist/css/bootstrap-select.min.css") %>" rel="stylesheet" />
    <!-- iCheck CSS -->
    <link href="<%=ResolveUrl("~/bower_components/icheck/skins/square/blue.css") %>" rel="stylesheet" />
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
                <h1 class="page-header">Total Task List</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Task List
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <input class="btn btn-success" type="button" value="New" onclick="AddDialogShow()" />
                        <input class="btn btn-primary" type="button" value="Edit" onclick="EditDialogShow()" />
                        <input class="btn btn-danger" type="button" value="Delete" onclick="DeleteUser()" />
                        <br />
                        <br />
                        <table id="GT_User"></table>
                        <div id="jqGridPager"></div>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /.page-wrapper -->

    <div class="modal fade" id="ModalUserInfo" tabindex="-1" role="dialog" aria-labelledby="ModalUserInfoLabel" aria-hidden="true">
        <form id="FormUserInfo" method="post" action="">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="ModalUserInfoLabel">User Information</h4>
                    </div>
                    <!-- /.modal-header -->
                    <div class="modal-body">

                        <label id="U_ID" hidden="hidden">*</label>
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label>User Name(Alias)</label>
                                    <input class="form-control" id="U_username" required />
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label>Nick Name(LastName FirstName)</label>
                                    <input class="form-control" id="U_nickname" required />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label>Mail Box</label>
                                    <input class="form-control" id="U_mailbox" type="email" required />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label>Role</label>
                                    <ul class="list-inline" style="line-height: 30px">
                                        <li>
                                            <input type="radio" name="RoleItem" id="RoleItem1" value="Tester" /><label for="RoleItem1">Tester</label></li>
                                        <li>
                                            <input type="radio" name="RoleItem" id="RoleItem2" value="Dev" /><label for="RoleItem2">Dev</label></li>
                                        <li>
                                            <input type="radio" name="RoleItem" id="RoleItem3" value="Leader" /><label for="RoleItem3">Leader</label></li>
                                        <li>
                                            <input type="radio" name="RoleItem" id="RoleItem4" value="Customer" /><label for="RoleItem4">Customer</label></li>
                                    </ul>
                                    <label id="U_Role" hidden="hidden">*</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label>Power</label>
                                    <ul class="list-inline" style="line-height: 30px">
                                        <li>
                                            <input type="radio" name="PowerItem" id="PowerItem1" value="L10" /><label for="PowerItem1">System Root</label></li>
                                        <li>
                                            <input type="radio" name="PowerItem" id="PowerItem2" value="L9" /><label for="PowerItem2">Administrator</label></li>
                                        <li>
                                            <input type="radio" name="PowerItem" id="PowerItem3" value="L8" /><label for="PowerItem3">Feature Owner</label></li>
                                        <li>
                                            <input type="radio" name="PowerItem" id="PowerItem4" value="L6" /><label for="PowerItem4">Verified Account</label></li>
                                        <li>
                                            <input type="radio" name="PowerItem" id="PowerItem5" value="L1" /><label for="PowerItem5">Guest</label></li>
                                        <li>
                                            <input type="radio" name="PowerItem" id="PowerItem6" value="L7" /><label for="PowerItem6">Customer</label></li>
                                    </ul>
                                    <label id="U_Power" hidden="hidden">*</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label>Comments</label>
                                    <textarea class="form-control" id="U_Comments"></textarea>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- /.modal-body -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-success" id="btn_AddUser" onclick="SaveUserInfo('Add')">Save</button>
                        <button type="button" class="btn btn-success" id="btn_UpdateUser" onclick="SaveUserInfo('Update')">Update</button>
                    </div>
                    <!-- /.modal-footer -->
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </form>
    </div>
    <!-- /.modal -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <!-- jqgrid langue JavaScript -->
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/jqgrid/js/i18n/grid.locale-en.js") %>"></script>
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/jqgrid/js/jquery.jqGrid.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap/js/modal.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-select/dist/js/bootstrap-select.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/icheck/icheck.min.js") %>"></script>
    <script type="text/javascript">
        $.jgrid.defaults.responsive = true;
        $.jgrid.defaults.styleUI = 'Bootstrap';

        $(document).ready(function () {
            // JQGrid options
            $('#GT_User').jqGrid({
                url: '../ashx/SystemManageHandler.ashx?mode=QueryUserList',
                datatype: "json",
                colModel: [
                    { label: 'ID', name: 'U_ID', key: true, hidden: true },
                    { label: 'Username', name: 'U_username', width: 150 },
                    { label: 'Nick Name', name: 'U_nickname', width: 150 },
                    { label: 'Mail Box', name: 'U_mailbox', width: 150 },
                    { label: 'Role', name: 'U_Role', width: 150 },
                    { label: 'Power', name: 'U_PowerDisplay', width: 80 }
                ],
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
            $('#GT_User').navGrid("#jqGridPager", {
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

            $('[type=radio]').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '20%' // optional
            });
            $('[name=RoleItem]').on('ifChecked', function (event) {
                $('#U_Role').val(this.value);//alert(this.value);
            });
            $('[name=PowerItem]').on('ifChecked', function (event) {
                $('#U_Power').val(this.value);//alert(this.value);
            });
        });

        function InitialUserInfoModal() {
            $('#U_username').val('');
            $('#U_nickname').val('');
            $('#U_mailbox').val('');
            $('#U_Comments').val('');
            $('[type=radio]').iCheck('uncheck');
            $('#U_Role').val('*');
            $('#U_Power').val('*');
        }
        function AddDialogShow() {
            $('#btn_AddUser').show();
            $('#btn_UpdateUser').hide();
            InitialUserInfoModal();
            $('#ModalUserInfo').modal({ backdrop: 'static' }).modal('show');
        }
        function EditDialogShow() {
            $('#btn_AddUser').hide();
            $('#btn_UpdateUser').show();
            var rowid = $('#GT_User').jqGrid('getGridParam', 'selrow');
            if (rowid == null) {
                alert('please select a row ~');
                return;
            }
            InitialUserInfoModal();
            $('#U_ID').val(rowid);
            $.post('../ashx/SystemManageHandler.ashx', {
                mode: 'GetUserInfoSingle', U_ID: rowid
            }, function (data, status) {
                var dataJSON = $.parseJSON(data);
                $('#U_username').val(dataJSON.U_username);
                $('#U_nickname').val(dataJSON.U_nickname);
                $('#U_mailbox').val(dataJSON.U_mailbox);
                $('#U_Role').val(dataJSON.U_Role);
                $('#U_Power').val(dataJSON.U_power);
                $('#U_Comments').val(dataJSON.U_Comments);
                $('[value=' + dataJSON.U_Role + ']').iCheck('check');
                $('[value=' + dataJSON.U_power + ']').iCheck('check');
            });
            $('#ModalUserInfo').modal({ backdrop: 'static' }).modal('show');
        }
        function DeleteUser() {
            var rowid = $('#GT_User').jqGrid('getGridParam', 'selrow');
            if (rowid == null) {
                alert('please select a row ~');
                return;
            }
            if (confirm('Delete the item now ?')) {
                $.post('../ashx/SystemManageHandler.ashx', {
                    mode: 'DeleteUserInfo', U_ID: rowid
                }, function (data, status) {
                    if (data == 'success') {
                        //alert('Delete Data Success ~');
                        ReloadJQGrid();
                    }
                    else {
                        alert('Delete Data Failed !');
                    }
                });
            }
        }

        function SaveUserInfo(Type) {
            var U_username = $('#U_username').val();
            var U_nickname = $('#U_nickname').val();
            var U_mailbox = $('#U_mailbox').val();
            var U_Role = $('#U_Role').val();
            var U_power = $('#U_Power').val();
            var U_Comments = $('#U_Comments').val();
            if (U_Role == '*' || U_power == '*') {
                alert("please Selete the \'User Role\' and \'User Power\'");
                return;
            }
            if (Type == 'Add') {
                $.post('../ashx/SystemManageHandler.ashx', {
                    mode: 'AddUserInfo', U_username: U_username, U_nickname: U_nickname,
                    U_mailbox: U_mailbox, U_Role: U_Role, U_power: U_power,
                    U_Comments: U_Comments
                }, function (data, status) {

                    if (data == 'success') {
                        //alert('Save Data Success ~');
                        ReloadJQGrid();
                        $('#ModalUserInfo').modal('hide');
                    }
                    else if (data == 'exist') {
                        alert('The User Name has Exist, please chanage to anthor one ~');
                        $('#U_username').val('');
                        $('#U_username').focus();
                    }
                    else {
                        alert('Save Data Failed !');
                    }
                });
            }
            else if (Type == 'Update') {
                var U_ID = $('#U_ID').val();
                $.post('../ashx/SystemManageHandler.ashx', {
                    mode: 'UpdateUserInfo', U_ID: U_ID, U_username: U_username,
                    U_nickname: U_nickname, U_mailbox: U_mailbox, U_Role: U_Role,
                    U_power: U_power, U_Comments: U_Comments
                }, function (data, status) {
                    if (data == 'success') {
                        //alert('Update Data Success ~');
                        ReloadJQGrid();
                        $('#ModalUserInfo').modal('hide');
                    }
                    else if (data == 'exist') {
                        alert('The User Name has Exist, please chanage to anthor one ~');
                        $('#U_username').val('');
                        $('#U_username').focus();
                    }
                    else {
                        alert('Update Data Failed !');
                    }
                });
            }
        }

        // Reload jqGrid
        function ReloadJQGrid() {
            $('#GT_User').setGridParam({
                url: '../ashx/SystemManageHandler.ashx?mode=QueryUserList',
                datatype: 'json'
            }).trigger('reloadGrid');
        }
    </script>
</asp:Content>
