$.jgrid.defaults.responsive = true;
$.jgrid.defaults.styleUI = 'Bootstrap';

$(document).ready(function () {
    var U_ID = $('#User_ID').text();
    var DR_Date = $('#DR_Date').val();
    $('#GT_DailyReport').jqGrid({
        url: '../ashx/DailyReportHandler.ashx?mode=QueryDailyReportList&U_ID=' + U_ID + '&DR_Date=' + DR_Date,
        datatype: "json",
        colModel: [
                { label: 'ID', name: 'TD_ID', key: true, hidden: true },
                { label: 'Title', name: 'BTT_Title', width: 300 },
                { label: 'Resources', name: 'DR_ResourcesName', width: 80 },
                { label: 'Owner', name: 'BTT_Owner', width: 80 },
                { label: 'Status', name: 'BTT_Status', width: 55 },
                { label: '%', name: 'BTT_Progress', width: 30 },
                { label: 'Type', name: 'DR_Type', width: 80 }
        ],
        sortable: false,
        autowidth: true,
        shinkToFit: true,
        loadonce: true,
        viewrecords: true,
        rownumbers: true,
        height: 'auto',
        rowNum: 10,
        rowList: [10, 20, 30, 50],
        pager: '#jqGridPager'
    });
    // pager options
    $('#GT_DailyReport').navGrid("#jqGridPager", {
        search: true, // show search button on the toolbar
        add: false,
        edit: false,
        del: false,
        refresh: true
    },
    {}, // edit options
    {}, // add options
    {}, // delete options
    { multipleSearch: true, multipleGroup: true, showQuery: true } // search options - define multiple search
    );

    $("#DR_Date").datetimepicker({ format: 'mm/dd/yyyy', minView: "month", autoclose: true });
});

function ReloadJQGrid() {
    var U_ID = $('#User_ID').text();
    var DR_Date = $('#DR_Date').val();
    $('#GT_DailyReport').setGridParam({
        url: '../ashx/DailyReportHandler.ashx?mode=QueryDailyReportList&U_ID=' + U_ID + '&DR_Date=' + DR_Date,
        datatype: 'json'
    }).trigger('reloadGrid');
}