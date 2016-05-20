$.jgrid.defaults.responsive = true;
$.jgrid.defaults.styleUI = 'Bootstrap';

$(document).ready(function () {
    $('#GT_DailyReport').jqGrid({
        url: '../ashx/DailyReportHandler.ashx?mode=QueryDailyReportList&U_ID=0',
        datatype: "json",
        colModel: [
                { label: 'ID', name: 'TD_ID', key: true, hidden: true },
                { label: 'Title', name: 'BTT_Title', width: 200 },
                { label: 'Resources', name: 'DR_ResourcesName', width: 80 },
                { label: 'Owner', name: 'BTT_Owner', width: 80 },
                { label: 'Status', name: 'BTT_Status', width: 55 },
                { label: '%', name: 'BTT_Progress', width: 30 },
                { label: 'Type', name: 'DR_Type', width: 85 }
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

    ReloadUserList('');

    $("#DR_Date").datetimepicker({ format: 'mm/dd/yyyy', minView: "month", autoclose: true });
});

function ReloadUserList(keyWord) {
    $.post('../ashx/SystemManageHandler.ashx', {
        mode: 'QueryUserList', KeyWord: keyWord
    }, function (data) {
        var UserInfo = $.parseJSON(data);
        $('#UserInfoList').empty();
        for (var i in UserInfo) {
            $('#UserInfoList').append('<a class="list-group-item" onclick="UserInfoListClick($(this))" id="UserInfoList' + UserInfo[i].U_ID + '">' +
                '<h4 class="list-group-item-heading">' + UserInfo[i].U_nickname + '</h4>' +
                '<p class="list-group-item-text">' + UserInfo[i].U_mailbox + ' | ' + UserInfo[i].U_Role + '</p></a>');
        }
    })
}

function SearchUserInfoList() {
    var KeyWord = $('#txt_KeyWord').val();
    ReloadUserList(KeyWord);
}

function UserInfoListClick(selector) {
    if (selector.hasClass('list-group-item')) {
        selector.addClass('active').siblings().removeClass('active');
    }
    var U_ID = selector.attr('id').substring(12);
    $('#U_ID').val(U_ID);
    ReloadJQGrid();
}

function ReloadJQGrid() {
    var U_ID = $('#U_ID').val();
    var DR_Date = $('#DR_Date').val();
    $('#GT_DailyReport').setGridParam({
        url: '../ashx/DailyReportHandler.ashx?mode=QueryDailyReportList&U_ID=' + U_ID + '&DR_Date=' + DR_Date,
        datatype: 'json'
    }).trigger('reloadGrid');
}