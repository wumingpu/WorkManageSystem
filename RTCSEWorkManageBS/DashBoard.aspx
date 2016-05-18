<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="DashBoard.aspx.cs" Inherits="RTCSEWorkManageBS.DashBoard" %>

<asp:Content ID="Content2" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-colorpicker/dist/css/bootstrap-colorpicker.min.css") %>" rel="stylesheet" />
    <style type="text/css">
        .page-header {
            padding-bottom: 9px;
            margin: 15px 0 10px;
            border-bottom: 1px solid #eee;
        }
    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Content -->
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">DashBoard</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
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
        <!-- /.row -->
        <%--Color Picker !--%>
        <%--<div class="row">
            <div class="col-lg-6">
                <div id="cp3" class="input-group colorpicker-component">
                    <input type="text" value="#00AABB" class="form-control" id="ColorPicker" />
                    <span class="input-group-addon">
                        <i></i>
                    </span>
                    <span class="input-group-btn">
                        <button type="button" class="btn btn-default" onclick="LoadBarMonthTasknumber()">Reload</button>
                    </span>
                </div>
            </div>
            <div class="col-lg-6">
            </div>
        </div>--%>
        <div class="row">
            <div class="col-lg-6">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Trend of Project Test Cases Delivered
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <canvas id="lineMonthCasenoRelease"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        Run Case Per Release in this season
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <canvas id="pieReleaseCaseno"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-lg-6">
                <div class="panel panel-success">
                    <div class="panel-heading">
                        Target Cases (per SOW) vs. Acutal Case Volume
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <canvas id="barTaskstyleCaseno"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        Task Number for Every Month
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <canvas id="barMonthTasknumber"></canvas>
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
                        Issue Distribution
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <canvas id="pieIssuetypeIssueno"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-danger">
                    <div class="panel-heading">
                        Delivery – Bug Reported
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-9">
                                <canvas id="lineMonthBugnoRelease" style="height:50%"></canvas>
                            </div>
                            <div class="col-lg-3">
                                <canvas id="pieFoundbyBugno" style="height:50%"></canvas>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-3">
                                <canvas id="pieReleaseBugno"></canvas>
                            </div>
                            <div class="col-lg-3">
                                <canvas id="pieTasktypeBugno"></canvas>
                            </div>
                            <div class="col-lg-3">
                                <canvas id="piePriorityBugno"></canvas>
                            </div>
                            <div class="col-lg-3">
                                <canvas id="pieResolutionBugno"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /#page-wrapper -->
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/Chartjs/dist/Chart.bundle.min.js") %>"></script>
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min.js") %>"></script>
    <script type="text/ecmascript" src="<%=ResolveUrl("~/PageJS/DashBoardJS.js") %>"></script>
    <script type="text/javascript">
        var DateTimeNow = new Date();
        var randomScalingFactor = function () {
            return Math.round(Math.random() * 100);
        };
        var randomColorFactor = function () {
            return Math.round(Math.random() * 255);
        };
        var randomColor = function () {
            return 'rgba(' + randomColorFactor() + ',' + randomColorFactor() + ',' + randomColorFactor() + ',.8)';
            //return $('#ColorPicker').val();
        };

        $(document).ready(function () {
            LoadSeasonCaseTotal();
            //$('#cp3').colorpicker({ color: 'rgba(0,134,246,0.71)', format: 'rgba' });//#AA3399
            LoadBarMonthTasknumber(DateTimeNow.getFullYear());
            LoadBarTaskstyleCaseno('', '');
            LoadLineMonthCasenoRelease('');
            LoadPieReleaseCaseno('', '');
            LoadPieIssuetypeIssueno('', '');
            LoadLineMonthBugnoRelease('');
            LoadPieFoundbyBugno('', '');
            LoadPieReleaseBugno('', '');
            LoadPieTasktypeBugno('', '');
            LoadPiePriorityBugno('', '');
            LoadPieResolutionBugno('', '');
        });
    </script>
</asp:Content>
