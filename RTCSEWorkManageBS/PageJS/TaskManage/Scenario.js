$.jgrid.defaults.responsive = true;
$.jgrid.defaults.styleUI = 'Bootstrap';

$(document).ready(function () {
    $('#GT_TaskListTotal').jqGrid({
        url: '../ashx/TaskHandler.ashx?mode=QueryTaskListTotal&keyWord=OnlyHaveScenario',
        datatype: "json",
        //colNames: ['ID', 'Release', 'CU', 'Build Type', 'Build Number', 'Task Type', 'Case No.', 'Real Run', 'Date', 'Task Style', 'Issue/Bug', 'Report Link', 'Comments'],
        colModel: [
            { label: 'ID', name: 'TT_ID', key: true, hidden: true },
            { label: 'Scenario?', name: 'TT_HaveScenario', hidden: true },
            //{ label: 'CreateDate', name: 'TT_CreateDate', hidden: true },
            { label: 'TaskTitle', name: 'TT_Title', width: 300 },
            //{ label: 'Real Run', name: 'TT_CaseRealRunNum', width: 100 },//, width: 100
            //{ label: 'Date', name: 'TT_Date', width: 210 },//, width: 250
            { label: '%', name: 'TT_TaskProgress', width: 60 },
            { label: 'Task Status', name: 'TT_TaskStatus', width: 115 }
            //{ label: 'Issue/Bug', name: 'TT_BugIssueNum' },
            //{ label: 'Report Link', name: "TT_ReportLink" },
            //{ label: 'Comments', name: "TT_Comments" }
        ],
        autowidth: true,
        shinkToFit: true,
        loadonce: true,
        viewrecords: true,
        rownumbers: true,
        height: 'auto',
        rowNum: 10,
        rowList: [10, 20, 30, 50],
        pager: '#jqGridPagerTask',
        onSelectRow: function (TT_ID) {
            ReloadJQGrid(TT_ID);
        }
    });

    // pager options
    $('#GT_TaskListTotal').navGrid("#jqGridPagerTask", {
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

    //JQGrid Options
    $('#GT_Scenario').jqGrid({
        url: '../ashx/TaskHandler.ashx?mode=QueryScenario&S_FK_TT_ID=0',
        datatype: "json",
        colModel: [
            { label: 'ID', name: 'S_ID', key: true, hidden: true },
            { label: 'TT_ID', name: 'S_FK_TT_ID', hidden: true },
            //{ label: 'Task Title', name: 'TT_Title', width: 300 },
            { label: 'Scenario Title', name: 'S_ScenarioName', width: 400 },
            { label: 'Create Date', name: 'S_CreateDate', width: 150 },
            { label: 'Have Feature?', name: 'S_HaveRole', Width: 60 }
        ],
        //cmTemplate: { sortable: false },
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
    $('#GT_Scenario').navGrid("#jqGridPager", {
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

function AddScenarioRoleDialogShow() {
    var rowid = $('#GT_Scenario').jqGrid('getGridParam', 'selrow');
    if (rowid == null) {
        alert('please select a row ~');
        return;
    }
    var rowData = $('#GT_Scenario').jqGrid('getRowData', rowid);
    if (rowData.S_HaveRole == 'Yes') {
        alert('This Scenario has Already have Feature, please go \'Scenario Feature\' to add or edit Features ~');
        return;
    }
    $('#SR_FK_S_ID').val(rowid);
    $('#SR_FK_TT_ID').val(rowData.S_FK_TT_ID);

    InitalRoleRow();

    $('#ModalScenarioRole').modal({ backdrop: 'static' }).modal('show');
}
function InitalRoleRow() {
    //<div class="row DynamicSR" style="line-height: 40px"><div class="form-inline"><div class="col-lg-12">
    //         <label>Feature Title</label><input class="form-control SR_RoleTitle" />
    //         <label>Case No.</label><input class="form-control SR_CaseNum" style="width: 7%" />
    //         <label>Resource</label><input class="form-control SR_AssignedUser" style="width: 40%" />
    //         <button type="button" class="btn btn-default" name="btnAdd" onclick="AddScenarioRoleRow()">Add</button>
    //</div></div></div>     
    $('.DynamicSR').remove();
    $('#FormScenarioRole').append('<div class="row DynamicSR" style="line-height: 40px;padding:2px"><div class="form-inline"><div class="col-lg-12">'
        + '<label>Feature Title</label><input class="form-control SR_RoleTitle" />'
        + '<label>Case No.</label><input class="form-control SR_CaseNum" style="width: 7%" />'
        + '<label>Resource</label><input class="form-control SR_AssignedUser" style="width: 40%" />'
        + '<button type="button" class="btn btn-default" name="btnAdd" onclick="AddScenarioRoleRow()">Add</button>'
        + '</div></div></div>');
    //$('.DynamicSR label').style.padding = "2px";
    InitialTagsInputUser($('.SR_AssignedUser'), '');
}
function AddScenarioRoleRow() {
    //<div class="row DynamicSR" style="line-height: 40px">
    //            <div class="form-inline">
    //                <div class="col-lg-12">
    //                    <label>Feature Title</label><input class="form-control SR_RoleTitle" />
    //                    <label>Case No.</label><input class="form-control SR_CaseNum" style="width: 5%" />
    //                    <label>Resource</label><input class="form-control SR_AssignedUser" style="width: 40%" />
    //                    <button type="button" class="btn btn-danger" name="btnDel" onclick="RemoveScenarioRoleRow($(this))">Delete</button>
    //                </div>
    //            </div>
    //        </div>
    $('#FormScenarioRole').append('<div class="row DynamicSR" style="line-height:40px"><div class="form-inline"><div class="col-lg-12">'
        + '<label>Feature Title</label><input class="form-control SR_RoleTitle" />'
        + '<label>Case No.</label><input class="form-control SR_CaseNum" style="width:7.3%" />'
        + '<label>Resource</label><input class="form-control SR_AssignedUser" style="width:40%" />'
        + '<button type="button" class="btn btn-danger" name="btnDel" onclick="RemoveScenarioRoleRow($(this))">Del</button>'
        + '</div></div></div>');
    InitialTagsInputUser($('.SR_AssignedUser'), '');
}
function RemoveScenarioRoleRow(selector) {
    selector.parent().parent().parent().remove();
}
function SaveScenarioRole() {
    var SR_RoleTitles = '', SR_CaseNums = '', SR_AssignedUsers = '', SR_AssignedUserName = '';
    var regex = /^\d+$/;
    var objJSON = ''; //= [];
    $('.DynamicSR').each(function () {
        SR_RoleTitle = $(this).find('.SR_RoleTitle').val();
        SR_CaseNum = $(this).find('.SR_CaseNum').val();
        SR_CaseNum = (SR_CaseNum.length > 0 && regex.test(SR_CaseNum)) ? SR_CaseNum : 0;
        SR_AssignedUser = ',' + $(this).find('.SR_AssignedUser').val() + ',';
        SR_AssignedUserObj = $(this).find('.SR_AssignedUser').tagsinput('items');
        for (var i = 0; i < SR_AssignedUserObj.length; i++) {
            SR_AssignedUserName += SR_AssignedUserObj[i]["U_nickname"] + ',';
        }
        SR_AssignedUserName = SR_AssignedUserName.substring(0, SR_AssignedUserName.length - 1);
        objJSON += '{"SR_RoleTitle":"' + SR_RoleTitle + '","SR_CaseNum":' + SR_CaseNum + ',"SR_AssignedUser":"' + SR_AssignedUser + '","SR_AssignedUserName":"' + SR_AssignedUserName + '"},';
        SR_AssignedUserName = '';
    });
    objJSON = objJSON.substring(0, objJSON.length - 1);
    var SR_FK_S_ID = $('#SR_FK_S_ID').val();
    var SR_FK_TT_ID = $('#SR_FK_TT_ID').val();
    var User_ID = $('#User_ID').text();
    $.post('../ashx/TaskHandler.ashx', {
        mode: 'AddScenarioRoleBatch', JsonSenarioRole: objJSON, SR_FK_S_ID: SR_FK_S_ID,
        SR_FK_TT_ID: SR_FK_TT_ID, User_ID: User_ID
    }, function (data, status) {
        if (data == 'success') {
            $('#ModalScenarioRole').modal('hide');
            //alert('Save Data Success ~');
            ReloadJQGrid(SR_FK_TT_ID);
        }
        else {
            alert('Save Data Failed !');
        }
    });
}

function AddDialogShow() {
    var rowid = $('#GT_TaskListTotal').jqGrid('getGridParam', 'selrow');
    if (rowid == null) {
        alert('please select a row in Task List ~ The new Scenario\'s Task Title will same as the row you selected.');
        return;
    }
    var rowData = $('#GT_Scenario').jqGrid('getRowData', rowid);
    $('#S_ID').val(rowid);
    $('#S_FK_TT_ID').val(rowData.S_FK_TT_ID);

    $('#S_ScenarioName').val('');
    $('#ModalScenarioInfo').modal({ backdrop: 'static' }).modal('show');
    $('#btn_AddScenarioInfo').show();
    $('#btn_UpdateScenarioInfo').hide();
}
function EditDialogShow() {
    var rowid = $('#GT_Scenario').jqGrid('getGridParam', 'selrow');
    if (rowid == null) {
        alert('please select a row ~');
        return;
    }
    var rowData = $('#GT_Scenario').jqGrid('getRowData', rowid);
    $('#S_ID').val(rowid);
    $('#S_FK_TT_ID').val(rowData.S_FK_TT_ID);

    $('#S_ScenarioName').val(rowData.S_ScenarioName);
    $('#ModalScenarioInfo').modal({ backdrop: 'static' }).modal('show');
    $('#btn_AddScenarioInfo').hide();
    $('#btn_UpdateScenarioInfo').show();
}
function SaveScenarioInfo(SaveType) {
    var S_ID = $('#S_ID').val();
    var S_FK_TT_ID = $('#S_FK_TT_ID').val();
    var S_ScenarioName = $('#S_ScenarioName').val();

    if (SaveType == 'add') {
        $.post('../ashx/TaskHandler.ashx', {
            mode: 'AddScenarioInfo', S_FK_TT_ID: S_FK_TT_ID, S_ScenarioName: S_ScenarioName
        }, function (data, status) {
            if (data == 'success') {
                //alert('Save data success !');
                $('#ModalScenarioInfo').modal('hide');
                ReloadJQGrid(S_FK_TT_ID);
            }
            else {
                alert('Save Data Failed !');
            }
        });
    }
    else if (SaveType == 'edit') {
        $.post('../ashx/TaskHandler.ashx', {
            mode: 'UpdateScenarioInfo', S_ID: S_ID, S_ScenarioName: S_ScenarioName
        }, function (data, status) {
            if (data == 'success') {
                //alert('Save data success !');
                $('#ModalScenarioInfo').modal('hide');
                ReloadJQGrid(S_FK_TT_ID);
            }
            else {
                alert('Save Data Failed !');
            }
        });
    }
}
function DeleteScenario() {
    var rowid = $('#GT_Scenario').jqGrid('getGridParam', 'selrow');
    if (rowid == null) {
        alert('please select a row ~');
        return;
    }
    var rowData = $('#GT_Scenario').jqGrid('getRowData', rowid);
    if (rowData.S_HaveRole == "Yes") {
        alert('This Scenario Have Feature, Can not be deleted !');
        return;
    }
    if (confirm('Delete the item now ?')) {
        var S_FK_TT_ID = rowData.S_FK_TT_ID;

        $.post('../ashx/TaskHandler.ashx', {
            mode: 'DeleteScenarioInfo', S_ID: rowid, S_FK_TT_ID: S_FK_TT_ID
        }, function (data, status) {
            if (data == 'success') {
                //alert('delete data success !');
                ReloadJQGrid(S_FK_TT_ID);
            }
            else {
                alert('delete Data Failed !');
            }
        });
    }
}

// Reload jqGrid
function ReloadJQGrid(TT_ID) {
    $('#GT_Scenario').setGridParam({
        url: '../ashx/TaskHandler.ashx?mode=QueryScenario&S_FK_TT_ID=' + TT_ID,
        datatype: 'json'
    }).trigger('reloadGrid');
}