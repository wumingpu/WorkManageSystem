function LoadSeasonCaseTotal() {
    $.post('ashx/QBRHandler.ashx', {
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
    $.post('ashx/ChartReportHandler.ashx', {
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
    $.post('ashx/ChartReportHandler.ashx', {
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
    if (Year == '') { Year = DateTimeNow.getFullYear(); }
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
    $.post('ashx/ChartReportHandler.ashx', {
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
            //data: [randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor()],
            data: [0, 0, 0, 0],
            backgroundColor: [randomColor(), randomColor(), randomColor(), randomColor()]//'rgba(0,134,246,0.71)', //randomColor(), // rgba(15,122,233,0.8)
        }],
        labels: ['W14', 'W15', 'W16', 'LM']
    }
    $.post('ashx/ChartReportHandler.ashx', {
        mode: 'PieReleaseCaseno', Year: Year, Season: Season
    }, function (data) {
        var newDataset = { backgroundColor: [], data: [] }
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
    $.post('ashx/ChartReportHandler.ashx', {
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
    if (Year == '') { Year = DateTimeNow.getFullYear(); }
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
    $.post('ashx/ChartReportHandler.ashx', {
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
    ctx.canvas.height = 80;
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

function LoadPieFoundbyBugno(Year, Season) {
    var ChartData = {
        datasets: [{
            data: [randomScalingFactor(), randomScalingFactor()],
            backgroundColor: [randomColor(), randomColor()]
        }],
        labels: ['Per Case', 'Ad-hoc']
    }
    $.post('ashx/ChartReportHandler.ashx', {
        mode: 'PieFoundbyBugno', Year: Year, Season: Season
    }, function (data) {
        var newDataset = { backgroundColor: [], data: [] }
        var dataJSON = $.parseJSON(data);
        for (var i in dataJSON) {
            newDataset.backgroundColor.push(randomColor());
            newDataset.data.push(dataJSON[i].iData);
            ChartData.labels[i] += ' - ' + dataJSON[i].Percent;
        }
        ChartData.datasets.splice(0, 1);
        ChartData.datasets.push(newDataset);
        window.ChartPieFoundbyBugno.update();
    });
    var ctx = document.getElementById("pieFoundbyBugno").getContext("2d");
    ctx.canvas.height = 255;
    window.ChartPieFoundbyBugno = new Chart(ctx, {
        type: 'pie',
        data: ChartData,
        options: {
            responsive: true,
            title: {
                display: true,
                text: 'Bug found by'
            },
            legend: {
                position: 'bottom'
            }
        }
    });
}
function LoadPieReleaseBugno(Year, Season) {
    var ChartData = {
        datasets: [{
            data: [randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor()],
            backgroundColor: [randomColor(), randomColor(), randomColor(), randomColor()]//'rgba(0,134,246,0.71)', //randomColor(), // rgba(15,122,233,0.8)
        }],
        labels: ['W14', 'W15', 'W16', 'LM']
    }
    $.post('ashx/ChartReportHandler.ashx', {
        mode: 'PieReleaseBugno', Year: Year, Season: Season
    }, function (data) {
        var newDataset = { backgroundColor: [], data: [] }
        var dataJSON = $.parseJSON(data);
        for (var i in dataJSON) {
            newDataset.backgroundColor.push(randomColor());
            newDataset.data.push(dataJSON[i].iData);
            ChartData.labels[i] += ' - ' + dataJSON[i].Percent;
        }
        ChartData.datasets.splice(0, 1);
        ChartData.datasets.push(newDataset);
        window.ChartPieReleaseBugno.update();
    });
    var ctx = document.getElementById("pieReleaseBugno").getContext("2d");
    ctx.canvas.height = 255;
    window.ChartPieReleaseBugno = new Chart(ctx, {
        type: 'pie',
        data: ChartData,
        options: {
            responsive: true,
            title: {
                display: true,
                text: 'Bug in Product'
            },
            legend: {
                position: 'bottom'
            }
        }
    });
}
function LoadPieTasktypeBugno(Year, Season) {
    var ChartData = {
        datasets: [{
            data: [randomScalingFactor(), randomScalingFactor(), randomScalingFactor()],
            backgroundColor: [randomColor(), randomColor(), randomColor()]//'rgba(0,134,246,0.71)', //randomColor(), // rgba(15,122,233,0.8)
        }],
        labels: ['Hotfix', 'E2E', 'MU']
    }
    $.post('ashx/ChartReportHandler.ashx', {
        mode: 'PieTasktypeBugno', Year: Year, Season: Season
    }, function (data) {
        var newDataset = { backgroundColor: [], data: [] }
        var dataJSON = $.parseJSON(data);
        for (var i in dataJSON) {
            newDataset.backgroundColor.push(randomColor());
            newDataset.data.push(dataJSON[i].iData);
            ChartData.labels[i] += ' - ' + dataJSON[i].Percent;
        }
        ChartData.datasets.splice(0, 1);
        ChartData.datasets.push(newDataset);
        window.ChartPieTasktypeBugno.update();
    });
    var ctx = document.getElementById("pieTasktypeBugno").getContext("2d");
    ctx.canvas.height = 255;
    window.ChartPieTasktypeBugno = new Chart(ctx, {
        type: 'pie',
        data: ChartData,
        options: {
            responsive: true,
            title: {
                display: true,
                text: 'Bug in Test Pass'
            },
            legend: {
                position: 'bottom'
            }
        }
    });
}
function LoadPiePriorityBugno(Year, Season) {
    var ChartData = {
        datasets: [{
            data: [randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor()],
            backgroundColor: [randomColor(), randomColor(), randomColor(), randomColor()]//'rgba(0,134,246,0.71)', //randomColor(), // rgba(15,122,233,0.8)
        }],
        labels: ['P0', 'P1', 'P2', 'P3']
    }
    $.post('ashx/ChartReportHandler.ashx', {
        mode: 'PiePriorityBugno', Year: Year, Season: Season
    }, function (data) {
        var newDataset = { backgroundColor: [], data: [] }
        var dataJSON = $.parseJSON(data);
        for (var i in dataJSON) {
            newDataset.backgroundColor.push(randomColor());
            newDataset.data.push(dataJSON[i].iData);
            ChartData.labels[i] += ' - ' + dataJSON[i].Percent;
        }
        ChartData.datasets.splice(0, 1);
        ChartData.datasets.push(newDataset);
        window.ChartPiePriorityBugno.update();
    });
    var ctx = document.getElementById("piePriorityBugno").getContext("2d");
    ctx.canvas.height = 255;
    window.ChartPiePriorityBugno = new Chart(ctx, {
        type: 'pie',
        data: ChartData,
        options: {
            responsive: true,
            title: {
                display: true,
                text: 'Bug Priority'
            },
            legend: {
                position: 'bottom'
            }
        }
    });
}
function LoadPieResolutionBugno(Year, Season) {
    var ChartData = {
        datasets: [{
            data: [randomScalingFactor(), randomScalingFactor()],
            backgroundColor: [randomColor(), randomColor()]
        }],
        labels: ['Fixed', 'Active']
    }
    $.post('ashx/ChartReportHandler.ashx', {
        mode: 'PieResolutionBugno', Year: Year, Season: Season
    }, function (data) {
        var newDataset = { backgroundColor: [], data: [] }
        var dataJSON = $.parseJSON(data);
        for (var i in dataJSON) {
            newDataset.backgroundColor.push(randomColor());
            newDataset.data.push(dataJSON[i].iData);
            ChartData.labels[i] += ' - ' + dataJSON[i].Percent;
        }
        ChartData.datasets.splice(0, 1);
        ChartData.datasets.push(newDataset);
        window.ChartPieResolutionBugno.update();
    });
    var ctx = document.getElementById("pieResolutionBugno").getContext("2d");
    ctx.canvas.height = 255;
    window.ChartPieResolutionBugno = new Chart(ctx, {
        type: 'pie',
        data: ChartData,
        options: {
            responsive: true,
            title: {
                display: true,
                text: 'Bug Resolution'
            },
            legend: {
                position: 'bottom'
            }
        }
    });
}