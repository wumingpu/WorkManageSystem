<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="DashBoard.aspx.cs" Inherits="RTCSEWorkManageBS.DashBoard" %>

<asp:Content ID="Content2" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
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
        <!-- /.row -->

        <div class="row">
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
            <div class="col-lg-6">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        Case Number For Every Task
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <canvas id="barTasknameCasenumber"></canvas>
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
    <script type="text/javascript">
        var randomColorFactor = function () {
            return Math.round(Math.random() * 255);
        };
        var randomColor = function () {
            return 'rgba(' + randomColorFactor() + ',' + randomColorFactor() + ',' + randomColorFactor() + ',.7)';
        };

        $(document).ready(function () {
            LoadBarMonthTasknumber();
        });

        //$('#barMonthTasknumber')
        function LoadBarMonthTasknumber() {
            var barData = {
                labels: [],
                datasets: [{
                    label: 'Task Number',
                    backgroundColor: randomColor(),
                    data: []
                }]
            }
            $.post('../ashx/ChartReportHandler.ashx', {
                mode: 'BarMonthTasknumber', Year: '2016'
            }, function (data) {
                var dataJSON = $.parseJSON(data);
                for (var i in dataJSON) {
                    barData.labels.push(dataJSON[i].Month);
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
                        position: 'top'
                    },
                    //title: {
                    //    display: true,
                    //    text: 'Task Number for Every Month'
                    //}
                }
            });
        }


    </script>
</asp:Content>
