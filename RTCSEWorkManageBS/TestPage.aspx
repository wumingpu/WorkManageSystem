<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="TestPage.aspx.cs" Inherits="RTCSEWorkManageBS.TestPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
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
                        <div>
                            <table>
                                <tr>
                                    <td>用户名:</td>
                                    <td>
                                        <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>密码:</td>
                                    <td>
                                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>域:</td>
                                    <td>
                                        <asp:DropDownList ID="ddlDomain" runat="server">
                                            <asp:ListItem Value="fareast.corp.microsoft.com">fareast</asp:ListItem>
                                            <asp:ListItem Value="TestDomain">TestDomain</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:Button ID="btnLogin" runat="server" Text="登录" OnClick="btnLogin_Click" /></td>
                                </tr>
                                
                            </table>
                            <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>

            <div class="panel panel-info">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <input class="form-control" id="txt_Mintues"  runat="server"/>
                            <asp:Button CssClass="btn btn-primary" ID="btnMintueToDay" runat="server" Text="MintuesToDay" OnClick="btnMintueToDay_Click" />
                        </div>
                    </div>
                </div>
            </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
</asp:Content>
