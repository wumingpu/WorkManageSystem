$.jgrid.defaults.responsive = true;
$.jgrid.defaults.styleUI = 'Bootstrap';

$(document).ready(function () {
    ReloadTaskList('');

    $('#GT_TaskListDaily').jqGrid({
        url: '../ashx/TaskHandler.ashx?mode=QueryTaskListDaily&TD_FK_TaskTotalID=0',
        datatype: "json",
        colModel: [
                { label: 'ID', name: 'TD_ID', key: true, hidden: true },
                { label: 'Task Date', name: 'TD_Date', width: 100 },
                { label: 'No.', name: 'TD_CaseShouldRunNum', width: 90 },
                { label: 'Runned', name: 'TD_CaseRealRunNum', width: 90 },
                { label: 'Pass', name: 'TD_CasePassNum', width: 85 },
                { label: 'Fail', name: 'TD_CaseFailNum', width: 85 },
                { label: 'N/A', name: 'TD_CaseNANum', width: 85 },
                { label: 'Rdm', name: 'TD_CaseRunInRedmond', width: 85 },
                { label: '%', name: 'TD_TaskProgress', width: 85 }
                //{ label: 'Task Status', name: 'TD_TaskStatus', width: 100 }
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
    $('#GT_TaskListDaily').navGrid("#jqGridPager", {
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
});

var pager = {};
pager.itemsPerPage = 5;
function ReloadTaskList(keyWord) {
    $.post('../ashx/TaskHandler.ashx', {
        mode: 'QueryTaskListTotalSimple', ListItemNum: keyWord == '' ? 10 : 0, keyWord: keyWord
    }, function (data, status) {
        var TaskInfo = $.parseJSON(data);
        pager.items = TaskInfo;
        pagerInit(pager);
        $('#TotalPage').text('Total:' + pager.pagedItems.length);
        $('#TotalItem').text('Items:' + TaskInfo.length);
        BindTaskList();
    });
}
function BindTaskList() {
    var TaskInfo = pager.pagedItems[pager.currentPage];
    $('#CurrentPage').text('Current:' + (pager.currentPage + 1));
    $('#TaskList').empty();
    var cssTT_TaskStatus;
    for (var i in TaskInfo) {
        if (TaskInfo[i].TT_TaskStatus == 'Pending') { cssTT_TaskStatus = 'text-warning'; }
        else if (TaskInfo[i].TT_TaskStatus == 'InProgress') { cssTT_TaskStatus = 'text-primary'; }
        else if (TaskInfo[i].TT_TaskStatus == 'Complete') { cssTT_TaskStatus = 'text-success'; }
        $('#TaskList').append('<a class="list-group-item" onclick="TaskListClick($(this))" id="TaskList' + TaskInfo[i].TT_ID + '">' +
            '<h4 class="list-group-item-heading">' + TaskInfo[i].TT_Title + '</h4>' +
            '<p class="list-group-item-text"><span class="' + cssTT_TaskStatus + '">' + TaskInfo[i].TT_TaskStatus + '</span> | ' + TaskInfo[i].TT_Date + '</p></a>');
    }
}
function prevPage() {
    pager.prevPage();
    BindTaskList();
}
function nextPage() {
    pager.nextPage();
    BindTaskList();
}
function pagerInit(p) {
    p.pagedItems = [];
    p.currentPage = 0;
    if (p.itemsPerPage === undefined) {
        p.itemsPerPage = 5;
    }
    p.prevPage = function () {
        if (p.currentPage > 0) {
            p.currentPage--;
        }
    };
    p.nextPage = function () {
        if (p.currentPage < p.pagedItems.length - 1) {
            p.currentPage++;
        }
    };
    init = function () {
        for (var i = 0; i < p.items.length; i++) {
            if (i % p.itemsPerPage === 0) {
                p.pagedItems[Math.floor(i / p.itemsPerPage)] = [p.items[i]];
            } else {
                p.pagedItems[Math.floor(i / p.itemsPerPage)].push(p.items[i]);
            }
        }
    };
    init();
}

function SearchTaskList() {
    var KeyWord = $('#txt_KeyWord').val();
    ReloadTaskList(KeyWord);
}

function TaskListClick(selector) {
    if (selector.hasClass('list-group-item')) {
        selector.addClass('active').siblings().removeClass('active');
    }
    var TT_ID = selector.attr('id').substring(8);
    ReloadJQGrid(TT_ID);
}

function ReloadJQGrid(TT_ID) {
    $('#GT_TaskListDaily').setGridParam({
        url: '../ashx/TaskHandler.ashx?mode=QueryTaskListDaily&TD_FK_TaskTotalID=' + TT_ID,
        datatype: 'json'
    }).trigger('reloadGrid');
}