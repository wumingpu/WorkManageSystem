<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="Validate.aspx.cs" Inherits="RTCSEWorkManageBS.TestPages.Validate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-validator/dist/css/bootstrapValidator.min.css") %>" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Bootstrap Validator</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Bootstrap Validator
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label>firstName</label>
                                    <input type="text" class="form-control" name="firstName" placeholder="First name" />
                                </div>
                                <div class="form-group">
                                    <label>lastName</label>
                                    <input type="text" class="form-control" name="lastName" placeholder="Last name" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <button type="button" class="btn btn-info" id="validateBtn">Commit</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-validator/dist/js/bootstrapValidator.js") %>"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#defaultForm').bootstrapValidator({
                message: 'This value is not valid',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    firstName: {
                        //group: '.col-lg-4',
                        validators: {
                            notEmpty: {
                                message: 'The first name is required and cannot be empty'
                            }
                        }
                    },
                    lastName: {
                        //group: '.col-lg-4',
                        validators: {
                            notEmpty: {
                                message: 'The last name is required and cannot be empty'
                            }
                        }
                    }
                }
            });

            // Validate the form manually
            $('#validateBtn').click(function () {
                var res = $('#defaultForm').bootstrapValidator('validate');
                alert(res);
            });
        });

    </script>
</asp:Content>
