<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="SOWList.aspx.cs" Inherits="RTCSEWorkManageBS.QBR.SOWList" %>

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
                <h1 class="page-header">SOW List</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row Title -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-green">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-1">
                                <i class="fa fa-tasks fa-5x"></i>
                            </div>
                            <div class="col-xs-3 text-right">
                                <div class="huge" id="SeasonCaseTarget">4200</div>
                                <div>Target Case / Season </div>
                            </div>
                            <div class="col-xs-3 text-right">
                                <div class="huge" id="SeasonCaseRuned">0</div>
                                <div>Case Runned / This Season</div>
                            </div>
                            <div class="col-xs-3 text-right">
                                <div class="huge" id="SeasonCaseProgress">0%</div>
                                <div>Progress</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-6">
                <div class="panel panel-danger">
                    <div class="panel-heading">
                        Lync Server 2015/2013/2010 Hot fix regression testing
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="list-group">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Hot Fix Season Target</p>
                                        <h4 class="list-group-item-heading">900 Case / Season</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="list-group text-success">
                                <div class="col-lg-3">
                                    <div class="list-group-item bg-success">
                                        <p class="list-group-item-text">Jan - Mar</p>
                                        <h4 class="list-group-item-heading" id="LS_HF_1S_">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W14</p>
                                        <h4 class="list-group-item-heading" id="LS_HF_1S_W14">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W15</p>
                                        <h4 class="list-group-item-heading" id="LS_HF_1S_W15">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W16</p>
                                        <h4 class="list-group-item-heading" id="LS_HF_1S_W16">0</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="row text-warning">
                            <div class="list-group">
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Apr - Jun</p>
                                        <h4 class="list-group-item-heading" id="LS_HF_2S_">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W14</p>
                                        <h4 class="list-group-item-heading" id="LS_HF_2S_W14">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W15</p>
                                        <h4 class="list-group-item-heading" id="LS_HF_2S_W15">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W16</p>
                                        <h4 class="list-group-item-heading" id="LS_HF_2S_W16">0</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="list-group text-danger">
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Jul - Sep</p>
                                        <h4 class="list-group-item-heading" id="LS_HF_3S_">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W14</p>
                                        <h4 class="list-group-item-heading" id="LS_HF_3S_W14">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W15</p>
                                        <h4 class="list-group-item-heading" id="LS_HF_3S_W15">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W16</p>
                                        <h4 class="list-group-item-heading" id="LS_HF_3S_W16">0</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="list-group">
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Oct - Dec</p>
                                        <h4 class="list-group-item-heading" id="LS_HF_4S_">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W14</p>
                                        <h4 class="list-group-item-heading" id="LS_HF_4S_W14">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W15</p>
                                        <h4 class="list-group-item-heading" id="LS_HF_4S_W15">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W16</p>
                                        <h4 class="list-group-item-heading" id="LS_HF_4S_W16">0</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="panel panel-warning">
                    <div class="panel-heading">
                        Lync Server 2015/2013/2010 Microsoft Update regression testing
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="list-group">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">MU Testing Season Target</p>
                                        <h4 class="list-group-item-heading">750 Case / Season</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="list-group text-success">
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Jan - Mar</p>
                                        <h4 class="list-group-item-heading" id="LS_MU_1S_">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W14</p>
                                        <h4 class="list-group-item-heading" id="LS_MU_1S_W14">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W15</p>
                                        <h4 class="list-group-item-heading" id="LS_MU_1S_W15">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W16</p>
                                        <h4 class="list-group-item-heading" id="LS_MU_1S_W16">0</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="row text-warning">
                            <div class="list-group">
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Apr - Jun</p>
                                        <h4 class="list-group-item-heading" id="LS_MU_2S_">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W14</p>
                                        <h4 class="list-group-item-heading" id="LS_MU_2S_W14">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W15</p>
                                        <h4 class="list-group-item-heading" id="LS_MU_2S_W15">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W16</p>
                                        <h4 class="list-group-item-heading" id="LS_MU_2S_W16">0</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="list-group text-danger">
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Jul - Sep</p>
                                        <h4 class="list-group-item-heading" id="LS_MU_3S_">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W14</p>
                                        <h4 class="list-group-item-heading" id="LS_MU_3S_W14">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W15</p>
                                        <h4 class="list-group-item-heading" id="LS_MU_3S_W15">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W16</p>
                                        <h4 class="list-group-item-heading" id="LS_MU_3S_W16">0</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="list-group">
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Oct - Dec</p>
                                        <h4 class="list-group-item-heading" id="LS_MU_4S_">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W14</p>
                                        <h4 class="list-group-item-heading" id="LS_MU_4S_W14">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W15</p>
                                        <h4 class="list-group-item-heading" id="LS_MU_4S_W15">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">W16</p>
                                        <h4 class="list-group-item-heading" id="LS_MU_4S_W16">0</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Lync Server 2013 sustained engineering regression testing
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="list-group">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Lync Server 2013 E2E Testing Season Target</p>
                                        <h4 class="list-group-item-heading">300 Case / Season</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="list-group">
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Jan - Mar</p>
                                        <h4 class="list-group-item-heading" id="LS_E2E_1S_W15">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Apr - Jun</p>
                                        <h4 class="list-group-item-heading" id="LS_E2E_2S_W15">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Jul - Sep</p>
                                        <h4 class="list-group-item-heading" id="LS_E2E_3S_W15">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Oct - Dec</p>
                                        <h4 class="list-group-item-heading" id="LS_E2E_4S_W15">0</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Lync Server 2010 sustained engineering regression testing
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="list-group">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Lync Server 2010 E2E Testing Season Target</p>
                                        <h4 class="list-group-item-heading">150 Case / Season</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="list-group">
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Jan - Mar</p>
                                        <h4 class="list-group-item-heading" id="LS_E2E_1S_W14">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Apr - Jun</p>
                                        <h4 class="list-group-item-heading" id="LS_E2E_2S_W14">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Jul - Sep</p>
                                        <h4 class="list-group-item-heading" id="LS_E2E_3S_W14">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Oct - Dec</p>
                                        <h4 class="list-group-item-heading" id="LS_E2E_4S_W14">0</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="panel panel-green">
                    <div class="panel-heading">
                        Lync Client 2010 sustained engineering regression testing
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="list-group">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Lync Client 2010 E2E Testing Season Target</p>
                                        <h4 class="list-group-item-heading">300 Case / Season</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="list-group">
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Jan - Mar</p>
                                        <h4 class="list-group-item-heading" id="LC_E2E_1S_W14">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Apr - Jun</p>
                                        <h4 class="list-group-item-heading" id="LC_E2E_2S_W14">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Jul - Sep</p>
                                        <h4 class="list-group-item-heading" id="LC_E2E_3S_W14">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Oct - Dec</p>
                                        <h4 class="list-group-item-heading" id="LC_E2E_4S_W14">0</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Live Meeting sustained engineering regression testing
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="list-group">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Live Meeting E2E Testing Season Target</p>
                                        <h4 class="list-group-item-heading">900 Case / Season</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="list-group">
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Jan - Mar</p>
                                        <h4 class="list-group-item-heading" id="LM_1S">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Apr - Jun</p>
                                        <h4 class="list-group-item-heading" id="LM_2S">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Jul - Sep</p>
                                        <h4 class="list-group-item-heading" id="LM_3S">0</h4>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="list-group-item">
                                        <p class="list-group-item-text">Oct - Dec</p>
                                        <h4 class="list-group-item-heading" id="LM_4S">0</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <script type="text/javascript" src="<%=ResolveUrl("~/PageJS/QBR/SOWList.js") %>"></script>
</asp:Content>
