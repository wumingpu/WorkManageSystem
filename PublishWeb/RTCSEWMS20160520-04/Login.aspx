<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="RTCSEWorkManageBS.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <title>RTCSE Work Manage System</title>

    <!-- Bootstrap Core CSS -->
    <link href="<%=ResolveUrl("~/bower_components/bootstrap/dist/css/bootstrap.min.css") %>" rel="stylesheet" />

    <!-- MetisMenu CSS -->
    <link href="<%=ResolveUrl("~/bower_components/metisMenu/dist/metisMenu.min.css") %>" rel="stylesheet" />

    <!-- Custom CSS -->
    <link href="<%=ResolveUrl("~/dist/css/sb-admin-2.css") %>" rel="stylesheet" />

    <!-- Custom Fonts -->
    <link href="<%=ResolveUrl("~/bower_components/font-awesome/css/font-awesome.min.css") %>" rel="stylesheet" type="text/css" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h3 style="text-align: center; margin-top: 15%">Sign in to RTCSE Work Manage System</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="panel panel-default" style="margin-top: 5%">
                        <%--<div class="panel-heading">
                            <h3 class="panel-title">Please Sign In</h3>
                        </div>--%>
                        <div class="panel-body">
                            <fieldset>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Alias" type="text" id="txt_username" runat="server" autofocus />
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Password" type="password" id="txt_password" runat="server" value="" />
                                </div>
                                <%--<div class="checkbox">
                                    <label>
                                        <input name="remember" type="checkbox" value="Remember Me">Remember Me
                                   
                                    </label>
                                </div>--%>
                                <!-- Change this to a button or input when using this as a form -->
                                <%--<a href="index.html" class="btn btn-lg btn-success btn-block">Login</a>--%>
                                <asp:Button ID="btn_Login" CssClass="btn btn-lg btn-success btn-block" runat="server" Text="Login" OnClick="btn_Login_Click" />
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- jQuery -->
        <script src="<%=ResolveUrl("~/bower_components/jquery/dist/jquery.min.js") %>"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="<%=ResolveUrl("~/bower_components/bootstrap/dist/js/bootstrap.min.js") %>"></script>

        <!-- Metis Menu Plugin JavaScript -->
        <script src="<%=ResolveUrl("~/bower_components/metisMenu/dist/metisMenu.min.js") %>"></script>

        <!-- Custom Theme JavaScript -->
        <script src="<%=ResolveUrl("~/dist/js/sb-admin-2.js") %>"></script>
    </form>
</body>
</html>
