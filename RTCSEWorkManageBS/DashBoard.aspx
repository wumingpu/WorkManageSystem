﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="DashBoard.aspx.cs" Inherits="RTCSEWorkManageBS.DashBoard" %>

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
                                <canvas id="lineMonthBugnoRelease"></canvas>
                            </div>
                            <div class="col-lg-3"></div>
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
        });

        function LoadSeasonCaseTotal() {
            $.post('../ashx/QBRHandler.ashx', {
                mode: 'GetSeasonTotalCaseno'
            }, function (data) {
                var dataJSON = $.parseJSON(data);
                var CaseTarget = $('#SeasonCaseTarget').text();
                var CaseRunned = dataJSON.CaseNo;
                $('#SeasonCaseRuned').html(CaseRunned);
                $('#SeasonCaseProgress').html(((Number(CaseRunned) / Number(CaseTarget)) * 100).toFixed(2) + '%');
            });
        }

        function LoadBarMonthTasknumber(Year) {
            var barData = {
                labels: [],
                datasets: [{
                    label: 'Task Number',
                    backgroundColor: randomColor(),//'rgba(0,134,246,0.71)', //randomColor(), // rgba(15,122,233,0.8)
                    data: []
                }]
            }
            $.post('../ashx/ChartReportHandler.ashx', {
                mode: 'BarMonthTasknumber', Year: Year
            }, function (data) {
                var dataJSON = $.parseJSON(data);
                for (var i in dataJSON) {
                    barData.labels.push(dataJSON[i].Month + ' / ' + DateTimeNow.getFullYear());
                    barData.datasets[0].data.push(dataJSON[i].DataPreMonth);
                }
                window.ChartBarMonthTasknumber.update();
            });

            var ctx = document.getElementById("barMonthTasknumber").getContext("2d");
            window.ChartBarMonthTasknumber = new Chart(ctx, {
                type: 'bar',
                data: barData,
                options: {
                    responsive: true,
                    legend: {
                        position: 'bottom'
                    },
                    //title: {
                    //    display: true,
                    //    text: 'Task Number for Every Month'
                    //}
                    animation: {
                        onComplete: function () {
                            var chartInstance = this.chart;
                            var ctx = chartInstance.ctx;
                            ctx.textAlign = "center";

                            Chart.helpers.each(this.data.datasets.forEach(function (dataset, i) {
                                var meta = chartInstance.controller.getDatasetMeta(i);
                                Chart.helpers.each(meta.data.forEach(function (bar, index) {
                                    ctx.fillText(dataset.data[index], bar._model.x, bar._model.y);
                                }), this)
                            }), this);
                        }
                    }
                }
            });
        }

        function LoadBarTaskstyleCaseno(Year, Season) {
            var barData = {
                labels: ['E2E', 'Hotfix', 'MU', 'Total'],
                datasets: [{
                    label: 'Target per SOW',
                    backgroundColor: randomColor(), // rgba(15,122,233,0.8)
                    data: [1250, 900, 750, 4200]
                }, {
                    label: 'Actual Case Valume',
                    backgroundColor: randomColor(), // rgba(15,122,233,0.8)
                    data: []
                }]
            }
            $.post('../ashx/ChartReportHandler.ashx', {
                mode: 'BarTaskstyleCaseno', Year: Year, Season: Season
            }, function (data) {
                var dataJSON = $.parseJSON(data);
                for (var i in dataJSON) {
                    //barData.labels.push(dataJSON[i].Month);
                    barData.datasets[1].data.push(dataJSON[i].iData);
                }
                window.ChartBarTaskstyleCaseno.update();
            });

            var ctx = document.getElementById("barTaskstyleCaseno").getContext("2d");
            window.ChartBarTaskstyleCaseno = new Chart(ctx, {
                type: 'bar',
                data: barData,
                options: {
                    responsive: true,
                    legend: {
                        position: 'bottom'
                    },
                    animation: {
                        onComplete: function () {
                            var chartInstance = this.chart;
                            var ctx = chartInstance.ctx;
                            ctx.textAlign = "center";

                            Chart.helpers.each(this.data.datasets.forEach(function (dataset, i) {
                                var meta = chartInstance.controller.getDatasetMeta(i);
                                Chart.helpers.each(meta.data.forEach(function (bar, index) {
                                    ctx.fillText(dataset.data[index], bar._model.x, bar._model.y - 15);
                                }), this)
                            }), this);
                        }
                    }
                }
            });
        }

        function LoadLineMonthCasenoRelease(Year) {
            var barData = {
                labels: ['1 / ' + Year, '2 / ' + Year, '3 / ' + Year, '4 / ' + Year, '5 / ' + Year, '6 / ' + Year, '7 / ' + Year, '8 / ' + Year, '9 / ' + Year, '10 / ' + Year, '11 / ' + Year, '12 / ' + Year],
                datasets: [{
                    label: 'W14',
                    backgroundColor: randomColor(),//'rgba(0,134,246,0.71)', //randomColor(), // rgba(15,122,233,0.8)
                    data: [],
                    lineTension: 0,
                    fill: false
                }, {
                    label: 'W15',
                    backgroundColor: randomColor(),//'rgba(0,134,246,0.71)', //randomColor(), // rgba(15,122,233,0.8)
                    data: [],
                    lineTension: 0,
                    fill: false
                }, {
                    label: 'W16',
                    backgroundColor: randomColor(),//'rgba(0,134,246,0.71)', //randomColor(), // rgba(15,122,233,0.8)
                    data: [],
                    lineTension: 0,
                    fill: false
                }, {
                    label: 'LM',
                    backgroundColor: randomColor(),//'rgba(0,134,246,0.71)', //randomColor(), // rgba(15,122,233,0.8)
                    data: [],
                    lineTension: 0,
                    fill: false
                }]
            }
            $.post('../ashx/ChartReportHandler.ashx', {
                mode: 'LineMonthCasenoRelease', Year: Year
            }, function (data) {
                var dataJSON = $.parseJSON(data);
                for (var i in dataJSON) {
                    //barData.labels.push(dataJSON[i].Month + ' / ' + DateTimeNow.getFullYear());
                    if (dataJSON[i].Release == 'W14') { barData.datasets[0].data.push(dataJSON[i].iData); }
                    else if (dataJSON[i].Release == 'W15') { barData.datasets[1].data.push(dataJSON[i].iData); }
                    else if (dataJSON[i].Release == 'W16') { barData.datasets[2].data.push(dataJSON[i].iData); }
                    else if (dataJSON[i].Release == 'LM') { barData.datasets[3].data.push(dataJSON[i].iData); }
                }
                $.each(barData.datasets, function (i, dataset) {
                    var background = randomColor(0.5);
                    dataset.borderColor = background;
                    dataset.backgroundColor = background;
                    dataset.pointBorderColor = background;
                    dataset.pointBackgroundColor = background;
                    dataset.pointBorderWidth = 1;
                });
                window.ChartLineMonthCasenoRelease.update();
            });
            var ctx = document.getElementById("lineMonthCasenoRelease").getContext("2d");
            window.ChartLineMonthCasenoRelease = new Chart(ctx, {
                type: 'line',
                data: barData,
                options: {
                    responsive: true,
                    legend: {
                        position: 'bottom'
                    },
                    animation: {
                        onComplete: function () {
                            var chartInstance = this.chart;
                            var ctx = chartInstance.ctx;
                            ctx.textAlign = "center";

                            Chart.helpers.each(this.data.datasets.forEach(function (dataset, i) {
                                var meta = chartInstance.controller.getDatasetMeta(i);
                                Chart.helpers.each(meta.data.forEach(function (bar, index) {
                                    ctx.fillText(dataset.data[index], bar._model.x, bar._model.y - 15);
                                }), this)
                            }), this);
                        }
                    }
                }
            });
        }

        function LoadPieReleaseCaseno(Year, Season) {
            var ChartData = {
                datasets: [{
                    //label: 'Task Number',
                    data: [randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor()],
                    //data:[],
                    backgroundColor: [randomColor(), randomColor(), randomColor(), randomColor()]//'rgba(0,134,246,0.71)', //randomColor(), // rgba(15,122,233,0.8)
                }],
                labels: ['W14', 'W15', 'W16', 'LM']
            }
            $.post('../ashx/ChartReportHandler.ashx', {
                mode: 'PieReleaseCaseno', Year: Year, Season: Season
            }, function (data) {
                var newDataset = { backgroundColor: [], data: [], label: [] }
                var dataJSON = $.parseJSON(data);
                for (var i in dataJSON) {
                    newDataset.backgroundColor.push(randomColor());
                    newDataset.data.push(dataJSON[i].iData);
                    ChartData.labels[i] += ' - ' + dataJSON[i].Percent;
                }
                ChartData.datasets.splice(0, 1);
                ChartData.datasets.push(newDataset);
                window.ChartPieReleaseCaseno.update();
            });

            var ctx = document.getElementById("pieReleaseCaseno").getContext("2d");
            window.ChartPieReleaseCaseno = new Chart(ctx, {
                type: 'pie',
                data: ChartData,
                options: {
                    responsive: true,
                    legend: {
                        position: 'bottom'
                    }
                }
            });
        }

        function LoadPieIssuetypeIssueno(Year, Season) {
            var ChartData = {
                datasets: [{
                    //label: 'Task Number',
                    data: [randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor()],
                    //data:[],
                    backgroundColor: [randomColor(), randomColor(), randomColor(), randomColor(), randomColor()]//'rgba(0,134,246,0.71)', //randomColor(), // rgba(15,122,233,0.8)
                }],
                labels: ['Confirm', 'MU', 'Configure(W14/W15)', 'Configure(W16)', 'Other']
            }
            $.post('../ashx/ChartReportHandler.ashx', {
                mode: 'PieIssuetypeIssueno', Year: Year, Season: Season
            }, function (data) {
                var newDataset = { backgroundColor: [], data: [], label: [] }
                var dataJSON = $.parseJSON(data);
                for (var i in dataJSON) {
                    newDataset.backgroundColor.push(randomColor());
                    newDataset.data.push(dataJSON[i].iData);
                    ChartData.labels[i] += ' - ' + dataJSON[i].Percent;
                }
                ChartData.datasets.splice(0, 1);
                ChartData.datasets.push(newDataset);
                window.ChartPieIssuetypeIssueno.update();
            });

            var ctx = document.getElementById("pieIssuetypeIssueno").getContext("2d");
            window.ChartPieIssuetypeIssueno = new Chart(ctx, {
                type: 'pie',
                data: ChartData,
                options: {
                    responsive: true,
                    legend: {
                        position: 'bottom'
                    }
                }
            });
        }

        function LoadLineMonthBugnoRelease(Year) {
            var ChartData = {
                labels: ['1 / ' + Year, '2 / ' + Year, '3 / ' + Year, '4 / ' + Year, '5 / ' + Year, '6 / ' + Year, '7 / ' + Year, '8 / ' + Year, '9 / ' + Year, '10 / ' + Year, '11 / ' + Year, '12 / ' + Year],
                datasets: [{
                    label: 'W14',
                    backgroundColor: randomColor(),
                    data: [],
                    lineTension: 0,
                    fill: false
                }, {
                    label: 'W15',
                    backgroundColor: randomColor(),
                    data: [],
                    lineTension: 0,
                    fill: false
                }, {
                    label: 'W16',
                    backgroundColor: randomColor(),
                    data: [],
                    lineTension: 0,
                    fill: false
                }, {
                    label: 'LM',
                    backgroundColor: randomColor(),
                    data: [],
                    lineTension: 0,
                    fill: false
                }]
            }
            $.post('../ashx/ChartReportHandler.ashx', {
                mode: 'LineMonthBugnoRelease', Year: Year
            }, function (data) {
                var dataJSON = $.parseJSON(data);
                for (var i in dataJSON) {
                    if (dataJSON[i].Release == 'W14') { ChartData.datasets[0].data.push(dataJSON[i].iData); }
                    else if (dataJSON[i].Release == 'W15') { ChartData.datasets[1].data.push(dataJSON[i].iData); }
                    else if (dataJSON[i].Release == 'W16') { ChartData.datasets[2].data.push(dataJSON[i].iData); }
                    else if (dataJSON[i].Release == 'LM') { ChartData.datasets[3].data.push(dataJSON[i].iData); }
                }
                $.each(ChartData.datasets, function (i, dataset) {
                    var background = randomColor(0.5);
                    dataset.borderColor = background;
                    dataset.backgroundColor = background;
                    dataset.pointBorderColor = background;
                    dataset.pointBackgroundColor = background;
                    dataset.pointBorderWidth = 1;
                });
                window.ChartLineMonthBugnoRelease.update();
            });
            var ctx = document.getElementById("lineMonthBugnoRelease").getContext("2d");
            window.ChartLineMonthBugnoRelease = new Chart(ctx, {
                type: 'line',
                data: ChartData,
                options: {
                    responsive: true,
                    legend: {
                        position: 'bottom'
                    },
                    title: {
                        display: true,
                        text: 'Bug Trend'
                    },
                    animation: {
                        onComplete: function () {
                            var chartInstance = this.chart;
                            var ctx = chartInstance.ctx;
                            ctx.textAlign = "center";

                            Chart.helpers.each(this.data.datasets.forEach(function (dataset, i) {
                                var meta = chartInstance.controller.getDatasetMeta(i);
                                Chart.helpers.each(meta.data.forEach(function (bar, index) {
                                    ctx.fillText(dataset.data[index], bar._model.x, bar._model.y - 15);
                                }), this)
                            }), this);
                        }
                    }
                }
            });
        }
    </script>
</asp:Content>
