<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="JsonManage.aspx.cs" Inherits="RTCSEWorkManageBS.SystemManage.JsonManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <!-- tagsinput CSS -->
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput-typeahead.css") %>" rel="stylesheet" />
    <style type="text/css">
        .bootstrap-tagsinput {
            width: 100%;
        }

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
                <h1 class="page-header">Total Task List</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Json Data Manage
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <input class="btn btn-success" type="button" value="Update User Info Json Data for Tags Input" onclick="UpdateUserInfoJson()" />
                        <%--<input class="btn btn-default" type="button" value="Add Row" onclick="ShowDialog()" />--%>
                        <br />
                        <br />
                        <textarea class="form-control" rows="15" id="Json_UserInfo"></textarea>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Tags Input Test
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Resource</label>
                                <input class="form-control SR_AssignedUser" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Tags Input Test
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Resource</label>
                                <input class="form-control SR_AssignedUser" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/typeahead/dist/typeahead.bundle.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/DynamicJS/TagsInputUserData.js") %>"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            InitialTagsInputUser($('.SR_AssignedUser')); // function in TagsInputUserData.js
        });

        function UpdateUserInfoJson() {
            $.post('../ashx/SystemManageHandler.ashx', { mode: 'UpdateDynamicJSUserInfo' }, function (data, status) {
                if (data != 'fail') {
                    $('#Json_UserInfo').val(data);
                    alert('Update JSON data Success ~');
                }
                else {
                    aler('Update JSON data Failed !');
                }

            });
        }
    </script>
</asp:Content>
