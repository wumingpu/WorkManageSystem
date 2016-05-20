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
                                <input class="form-control" id="U_username" />
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Nick Name(LastName FirstName)</label>
                                <input class="form-control" id="U_nickname_UM" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Mail Box</label>
                                <input class="form-control" id="U_mailbox" type="email" />
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
    <script type="text/javascript" src="<%=ResolveUrl("~/PageJS/SystemManage/UserManage.js") %>"></script>
</asp:Content>
