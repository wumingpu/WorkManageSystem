<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="HelpPage.aspx.cs" Inherits="RTCSEWorkManageBS.SystemManage.HelpPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
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
                <h1 class="page-header">Help Page</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <p>User Power说明:</p>
                        <ol>
                            <li>System Root: 最高权限，可以查看所有功能
                                <ol style="list-style-type: lower-alpha;">
                                    <li>Dashboard&nbsp;</li>
                                    <li>Task&nbsp;</li>
                                    <li>Bug/Issue&nbsp;</li>
                                    <li>Daily Report&nbsp;</li>
                                    <li>QBR</li>
                                    <li>SystemManage</li>
                                    <li>Test Pages</li>
                                </ol>
                            </li>
                            <li>Administrator: 管理员权限，封锁Test Pages模块
                                <ol style="list-style-type: lower-alpha;">
                                    <li>Dashboard&nbsp;</li>
                                    <li>Task&nbsp;</li>
                                    <li>Bug/Issue&nbsp;</li>
                                    <li>Daily Report&nbsp;</li>
                                    <li>QBR</li>
                                    <li>SystemManage</li>
                                </ol>
                            </li>
                            <li>Feature Owner: 封锁Test Pages&nbsp; System Manage&nbsp; QBR模块，以及Daily Report中的Report List功能
                                <ol style="list-style-type: lower-alpha;">
                                    <li>Dashboard&nbsp;</li>
                                    <li>Task&nbsp;</li>
                                    <li>Bug/Issue&nbsp;</li>
                                    <li>Daily Report&nbsp; -- Personal Report</li>
                                </ol>
                            </li>
                            <li>Customer: 客户权限 封锁Test Pages&nbsp; System Manage&nbsp;&nbsp;Daily Report&nbsp; Bug/Issue&nbsp; Task模块
                                <ol style="list-style-type: lower-alpha;">
                                    <li>Dashboard</li>
                                    <li>QBR</li>
                                </ol>
                            </li>
                            <li>Verified Account: 认证用户权限，普通用户，可用于Tester和Dev
                                <ol style="list-style-type: lower-alpha;">
                                    <li>Dashboard</li>
                                    <li>Task -- Task Board</li>
                                    <li>Bug/Issue</li>
                                    <li>Daily Report -- Personal Report</li>
                                </ol>
                            </li>
                            <li>Guest: 仅可查看Dashboard
                                <ol style="list-style-type: lower-alpha;">
                                    <li>Dashboard</li>
                                </ol>
                            </li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
</asp:Content>
