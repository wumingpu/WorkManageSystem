$.jgrid.defaults.responsive = true;
$.jgrid.defaults.styleUI = 'Bootstrap';
//$.jgrid.defaults.width = '1500';        

$(document).ready(function () {
    // JQGrid options
    $('#GT_TaskListTotal').jqGrid({
        url: '../ashx/TaskHandler.ashx?mode=QueryTaskListTotal',
        datatype: "json",
        //colNames: ['ID', 'Release', 'CU', 'Build Type', 'Build Number', 'Task Type', 'Case No.', 'Real Run', 'Date', 'Task Style', 'Issue/Bug', 'Report Link', 'Comments'],
        colModel: [
            { label: 'ID', name: 'TT_ID', key: true, hidden: true },
            { label: 'Scenario?', name: 'TT_HaveScenario', hidden: true },
            { label: 'TaskTitle', name: 'TT_Title', width: 300 },
            { label: 'Date', name: 'TT_Date', width: 210 },//, width: 250
            { label: 'Style', name: 'TT_TaskStyle', width: 70 },//, width: 100
            { label: '%', name: 'TT_TaskProgress', width: 60 },
            { label: 'Task Status', name: 'TT_TaskStatus', width: 115 }
        ],
        autowidth: true,
        shinkToFit: true,
        loadonce: true,
        viewrecords: true,
        rownumbers: true,
        //width: '98%',
        height: 'auto',
        rowNum: 10,
        rowList: [10, 20, 30, 50],
        //mtype: 'post',
        pager: '#jqGridPager',
        onSelectRow: function (TT_ID) {
            ReloadTaskDetail(TT_ID);
        }
        //sortname: 'TT_CreateDate',
        //sortorder: "desc"
    });
    //$("#GT_TaskListTotal").jqGrid("setFrozenColumns");

    // pager options
    $('#GT_TaskListTotal').navGrid("#jqGridPager", {
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

    // Datetime Picker options
    $("#TT_DateStart").datetimepicker({ format: 'mm/dd/yyyy', minView: "month", autoclose: true }).on("click", function (ev) {
        $('#TT_DateStart').datetimepicker("setEndDate", $('#TT_DateEnd').val());
    }); // showMeridian
    $("#TT_DateEnd").datetimepicker({ format: 'mm/dd/yyyy', minView: "month", autoclose: true }).on("click", function (ev) {
        $('#TT_DateEnd').datetimepicker("setStartDate", $("#TT_DateStart").val());
    });

    // Events of select
    $('#TT_Release').on('loaded.bs.select', function (e) {
        var ReleaseWave = $('#TT_Release').selectpicker('val');
        SetBuildNumber(ReleaseWave);
    });
    $('#TT_Release').on('changed.bs.select', function (e) {
        var ReleaseWave = $('#TT_Release').selectpicker('val');
        SetBuildNumber(ReleaseWave);
    });

    //$('#ModalTaskListTotal').on('hidden.bs.modal', '.modal', function (e) {
    //    InitialTaskModal();
    //});

    //InitialFormValidator();
});

function InitialTaskModal() {
    $('#TT_Release').selectpicker('val', document.getElementById("TT_Release").options[0].value);
    var ReleaseWave = $('#TT_Release').selectpicker('val');
    SetBuildNumber(ReleaseWave);
    $('#TT_BuildType').selectpicker('val', document.getElementById("TT_BuildType").options[0].value);
    $('#TT_TaskType').selectpicker('val', document.getElementById("TT_TaskType").options[0].value);
    $('#TT_TaskStyle').selectpicker('val', document.getElementById("TT_TaskStyle").options[0].value);
    $('#TT_ServerClient').selectpicker('val', document.getElementById("TT_ServerClient").options[0].value);
    $('#TT_CU').val('CU');
    $('#TT_CaseTotalNum').val('');
    $('#TT_DateStart').val('');
    $('#TT_DateEnd').val('');
    $('#TT_Comments').val('');
    $('#TT_Title').val('');
}
function InitialScenarioModal() {
    //try{
    //    $('#FormScenario').data('bootstrapValidator').resetForm(true);
    //}
    //catch (e) { }
    $('.DynamicInput').remove();
    $('#S_ScenarioNumber').val('');
    //$('#S_ScenarioName').val('');
}

function ReloadTaskDetail(TT_ID) {
    $.post('../ashx/TaskHandler.ashx', {
        mode: 'GetTaskTotalInfoSingle', id: TT_ID
    }, function (data) {
        var TaskInfo = $.parseJSON(data);
        $('#D_TT_Title').html(TaskInfo.TT_Title);
        $('#D_TT_Release').html(TaskInfo.TT_Release);
        $('#D_TT_CU').html(TaskInfo.TT_CU);
        $('#D_TT_BuildType').html(TaskInfo.TT_BuildType);
        $('#D_TT_BuildNum').html(TaskInfo.TT_BuildNum);
        $('#D_TT_TaskType').html(TaskInfo.TT_TaskType);
        $('#D_TT_CaseTotalNum').html(TaskInfo.TT_CaseTotalNum);
        $('#D_TT_CaseRealRunNum').html(TaskInfo.TT_CaseRealRunNum);
        $('#D_TT_DateStart').html(TaskInfo.TT_DateStart);
        $('#D_TT_DateEnd').html(TaskInfo.TT_DateEnd);
        $('#D_TT_TaskStyle').html(TaskInfo.TT_TaskStyle);
        $('#D_TT_Comments').html(TaskInfo.TT_Comments);
        $('#D_TT_TaskProgress').html(TaskInfo.TT_TaskProgress);
        $('#D_TT_TaskStatus').html(TaskInfo.TT_TaskStatus);
        $('#D_TT_HaveScenario').html(TaskInfo.TT_HaveScenario);
        $('#D_TT_TimeStart').html(TaskInfo.TT_TimeStart);
        $('#D_TT_TimeEnd').html(TaskInfo.TT_TimeEnd);
        $('#D_TT_TimeUsed').html(TaskInfo.TT_TimeUsed);
        $('#D_TT_CompleteReason').html(TaskInfo.TT_CompleteReason);
        $('#D_TT_ServerClient').html(TaskInfo.TT_ServerClient)
    });
}

function StartTask() {
    var rowIndex = $('#GT_TaskListTotal').jqGrid('getGridParam', 'selrow');
    if (rowIndex != null) {
        var rowData = $('#GT_TaskListTotal').jqGrid('getRowData', rowIndex);
        if (rowData.TT_TaskStatus != 'Pending') {
            alert('The Task Status is ' + rowData.TT_TaskStatus + ',Can not Start this Task !');
        }
        else {
            if (confirm("Start This Task now ?")) {
                $.post('../ashx/TaskHandler.ashx', {
                    mode: 'StartTaskTotal', TT_ID: rowIndex
                }, function (data) {
                    if (data == 'success') {
                        alert('Task Start ~');
                        ReloadTaskDetail(rowIndex);
                        $('#GT_TaskListTotal').jqGrid('setCell', rowIndex, 7, 'InProgress');
                    }
                    else {
                        alert('Data Save Failed !');
                    }
                });
            }
        }
    }
    else {
        alert('Please Select a Row !');
    }
}

function EndTask() {
    var rowIndex = $('#GT_TaskListTotal').jqGrid('getGridParam', 'selrow');
    if (rowIndex != null) {
        $('#TC_TT_ID').val(rowIndex);
        var rowData = $('#GT_TaskListTotal').jqGrid('getRowData', rowIndex);
        if (rowData.TT_TaskStatus == 'Pending') {
            alert("Task Status is 'Pending', Can not Complete Task !");
        }
        else if (rowData.TT_TaskStatus == 'Complete') {
            alert("Task Status is Alredy 'Complete' !");
        }
        else {
            $('#TT_Progress').val(rowData.TT_TaskProgress.rtrim('%'));
            $('#ModalTaskComplete').modal({ backdrop: 'static' }).modal('show');
        }
    }
    else {
        alert('Please Select a Row !');
    }
}
function CommitEndTask() {
    var TT_CompleteReason = $('#TT_CompleteReason').selectpicker('val');
    var TT_Progress = $('#TT_Progress').val();
    if (!EmptyWarning(TT_Progress, 'TT_Progress', 'Progress')) { return false; }
    if (!NumberWarning(TT_Progress, 'TT_Progress', 'Progress')) { return false; }
    if (TT_Progress != '100') {
        if (TT_CompleteReason == 'Completed') {
            alert("Progress is not 100%, Complete Reason will not 'Completed' !");
            return;
        }
        else if (TT_CompleteReason == '') {
            alert("Progress is not 100%, Please Select a Complete Reason !");
            return;
        }
    }
    else if (TT_Progress == '100' && TT_CompleteReason == '') {
        alert("Please Select a Complete Reason");
        return;
    }
    var TC_TT_ID = $('#TC_TT_ID').val();
    var rowData = $('#GT_TaskListTotal').jqGrid('getRowData', TC_TT_ID);
    $.post('../ashx/TaskHandler.ashx', {
        mode: 'EndTaskTotal', TT_ID: TC_TT_ID, TT_TaskProgress: TT_Progress,
        TT_CompleteReason: TT_CompleteReason
    }, function (data) {
        if (data == 'success') {
            ReloadTaskDetail(TC_TT_ID);
            rowData.TT_TaskProgress = TT_Progress + '%';
            rowData.TT_TaskStatus = 'Complete';
            $('#GT_TaskListTotal').jqGrid('setRowData', TC_TT_ID, rowData);
            $('#ModalTaskComplete').modal('hide');
        }
        else {
            alert('End Task Failed !');
        }
    });
}

// Add Task List Total
function AddDialogShow() {
    $('#btn_UpdateTask').hide();
    $('#btn_AddTask').show();
    InitialTaskModal();
    $('#ModalTaskListTotal').modal({ backdrop: 'static' }).modal('show');
}
function AddNewTaskTotal() {
    SaveTaskTotal("Add");
}

// Edit Task List Total
function EditDialogShow() {
    var rowIndex = $('#GT_TaskListTotal').jqGrid('getGridParam', 'selrow');
    if (rowIndex != null) {
        $('#btn_AddTask').hide();
        $('#btn_UpdateTask').show();
        $.post('../ashx/TaskHandler.ashx', { mode: 'GetTaskTotalInfoSingle', id: rowIndex }, function (data, status) {
            $('#TT_ID').val(rowIndex);
            var result = $.parseJSON(data);
            $('#TT_Title').val(result.TT_Title);
            $('#TT_Release').selectpicker('val', result.TT_Release);
            $('#TT_BuildType').selectpicker('val', result.TT_BuildType);
            $('#TT_TaskType').selectpicker('val', result.TT_TaskType);
            $('#TT_TaskStyle').selectpicker('val', result.TT_TaskStyle);
            $('#TT_ServerClient').selectpicker('val', result.TT_ServerClient);
            $('#TT_BuildNum').val(result.TT_BuildNum);
            $('#TT_CU').val(result.TT_CU);
            $('#TT_CaseTotalNum').val(result.TT_CaseTotalNum);
            $('#TT_DateStart').val(result.TT_DateStart);
            $('#TT_DateEnd').val(result.TT_DateEnd);
            $('#TT_Comments').val(result.TT_Comments);
        });
        $('#ModalTaskListTotal').modal({ backdrop: 'static' }).modal('show');
    }
    else {
        alert("please choose a row ~");
    }
}
function UpdateTaskTotal() {
    SaveTaskTotal("Update");
}

function SaveTaskTotal(SaveType) {
    var TT_Release = $('#TT_Release').selectpicker('val');
    var TT_BuildType = $('#TT_BuildType').selectpicker('val');
    var TT_TaskType = $('#TT_TaskType').selectpicker('val');
    var TT_TaskStyle = $('#TT_TaskStyle').selectpicker('val');
    var TT_ServerClient = $('#TT_ServerClient').selectpicker('val');
    var TT_CU = $('#TT_CU').val();
    var TT_BuildNum = $('#TT_BuildNum').val();
    var TT_CaseTotalNum = $('#TT_CaseTotalNum').val();
    var TT_DateStart = $('#TT_DateStart').val();
    var TT_DateEnd = $('#TT_DateEnd').val();
    var TT_Comments = $('#TT_Comments').val();
    var TT_Title = $('#TT_Title').val();
    var ValRes = DataValidateFormTaskTotal(TT_Title, TT_CaseTotalNum, TT_DateStart, TT_DateEnd);
    if (!ValRes) { return; }
    if (SaveType == "Add") {
        $.post('../ashx/TaskHandler.ashx', {
            mode: 'AddTaskListTotal', TT_Release: TT_Release, TT_BuildType: TT_BuildType,
            TT_TaskType: TT_TaskType, TT_TaskStyle: TT_TaskStyle, TT_CU: TT_CU,
            TT_BuildNum: TT_BuildNum, TT_CaseTotalNum: TT_CaseTotalNum, TT_DateStart: TT_DateStart,
            TT_DateEnd: TT_DateEnd, TT_Comments: TT_Comments, TT_Title: TT_Title,
            TT_ServerClient: TT_ServerClient
        }, function (data, status) {
            if (data != 'fail') {
                //alert('Save Data Success !');
                $('#ModalTaskListTotal').modal('hide');
                ReloadJQGrid();
                ReloadTaskDetail(data);
                //$('#GT_TaskListTotal').jqGrid('setSelection', data);
            }
            else {
                alert('Save Data Failed !');
            }
        });
    }
    else if (SaveType == "Update") {
        var TT_ID = $('#TT_ID').val();
        $.post('../ashx/TaskHandler.ashx', {
            mode: 'UpdateTaskListTotal', TT_ID: TT_ID, TT_Release: TT_Release, TT_BuildType: TT_BuildType,
            TT_TaskType: TT_TaskType, TT_TaskStyle: TT_TaskStyle, TT_CU: TT_CU,
            TT_BuildNum: TT_BuildNum, TT_CaseTotalNum: TT_CaseTotalNum, TT_DateStart: TT_DateStart,
            TT_DateEnd: TT_DateEnd, TT_Comments: TT_Comments, TT_Title: TT_Title,
            TT_ServerClient: TT_ServerClient
        }, function (data, status) {
            if (data == 'success') {
                //alert('Update Data Success !');
                $('#ModalTaskListTotal').modal('hide');
                ReloadJQGrid();
                ReloadTaskDetail(TT_ID);
                //$('#GT_TaskListTotal').jqGrid('setSelection', TT_ID);
            }
            else {
                alert('Update Data Failed !');
            }
        });
    }
}

// Delete Task List Total
function DeleteTask() {
    var rowIndex = $('#GT_TaskListTotal').jqGrid('getGridParam', 'selrow');
    var rowData = $('#GT_TaskListTotal').jqGrid('getRowData', rowIndex);
    if (rowData.TT_HaveScenario == "Yes") {
        alert("This Task Have Scenario, Can not be Deleted !");
        return;
    }
    if (rowIndex != null) {
        if (confirm('Delete the item now ?')) {
            $.post('../ashx/TaskHandler.ashx', {
                mode: 'DeleteTaskListTotal', TT_ID: rowIndex
            }, function (data, status) {
                if (data == 'success') {
                    //alert('Delete Data Success !');
                    ReloadJQGrid();
                }
                else {
                    alert('Delete Data Failed !');
                }
            });
        }
    }
    else {
        alert("please choose a row ~");
    }
}

// Add Scenario
function AddScenarioDialogShow() {
    var rowIndex = $('#GT_TaskListTotal').jqGrid('getGridParam', 'selrow');
    if (rowIndex != null) {
        var rowData = $('#GT_TaskListTotal').jqGrid('getRowData', rowIndex);
        if (rowData.TT_HaveScenario == 'Yes') {
            alert('This Task Has Already have Scenario, Please go to \'Scenario\' page to Add Scenario ~');
            return;
        }
        InitialScenarioModal();
        $('#FK_TT_ID').val(rowIndex);
        $('#ModalScenario').modal({ backdrop: 'static' }).modal('show');
    }
    else {
        alert('Please Select a Row ~');
    }
}
function AddScenario() {
    //$('#FormScenario').bootstrapValidator('validate');
    var S_FK_TT_ID = $('#FK_TT_ID').val();
    var S_ScenarioNumber = $('#S_ScenarioNumber').val();
    var S_ScenarioNames = ''; //= $('#S_ScenarioName').val();
    for (var i = 1; i < Number(S_ScenarioNumber) + 1; i++) {
        if ($('#S_ScenarioName' + i).val() == '') {
            alert('Scenario Title ' + i + ' is required !');
            $('#S_ScenarioName' + i).focus();
            return;
        }
        S_ScenarioNames += $('#S_ScenarioName' + i).val() + '@@';
    }
    $.post('../ashx/TaskHandler.ashx', {
        mode: 'AddScenarios', S_FK_TT_ID: S_FK_TT_ID, S_ScenarioNames: S_ScenarioNames, S_ScenarioNumber: S_ScenarioNumber
    }, function (data, status) {
        if (data == 'success') {
            InitialScenarioModal();
            //alert('Scenario Add Success !');
            $('#ModalScenario').modal('hide');
            ReloadJQGrid();
        }
        else {
            alert('Scenario Add Failed !');
        }
    });
}
function AddDynamicScenarioInput() {
    //<div class="row"><div class="col-lg-12"><label>Scenario Title</label>
    //<input class="form-control" id="S_ScenarioName" /></div></div>
    //$('#form1').bootstrapValidator('validate');
    $('.DynamicInput').remove();
    var S_ScenarioNumber = $('#S_ScenarioNumber').val();
    for (var i = 1; i < Number(S_ScenarioNumber) + 1 ; i++) {
        $('#FormScenario').append('<div class="row DynamicInput"><div class="col-lg-12"><label>Scenario Title ' + i + '</label><input class="form-control" id="S_ScenarioName' + i + '" /></div></div>');
    }
    //$('#FormScenario').bootstrapValidator('addField', $('.DynamicInput'));
}

// set Build Number
function SetBuildNumber(ReleaseWave) {
    if (ReleaseWave == "W16") { $('#TT_BuildNum').val("6.0.9319.") }
    else if (ReleaseWave == "W15") { $('#TT_BuildNum').val("5.0.8308.") }
    else if (ReleaseWave == "W14") { $('#TT_BuildNum').val("4.0.7577.") }
}

// Reload jqGrid
function ReloadJQGrid() {
    $('#GT_TaskListTotal').setGridParam({
        url: '../ashx/TaskHandler.ashx?mode=QueryTaskListTotal',
        datatype: 'json'
        //sortname: 'TT_CreateDate',
        //sortorder: "desc"
    }).trigger('reloadGrid');
}

function DataValidateFormTaskTotal(TT_Title, TT_CaseTotalNum, TT_DateStart, TT_DateEnd) {
    if (!EmptyWarning(TT_Title, 'TT_Title', 'Task Title')) { return false; }
    if (!EmptyWarning(TT_CaseTotalNum, 'TT_CaseTotalNum', 'Case No.')) { return false; }
    if (!NumberWarning(TT_CaseTotalNum, 'TT_CaseTotalNum', 'Case No.')) { return false; }
    if (!EmptyWarning(TT_DateStart, 'TT_DateStart', 'Start Date')) { return false; }
    if (!EmptyWarning(TT_DateEnd, 'TT_DateEnd', 'End Date')) { return false; }
    return true;
}
function EmptyWarning(strContent, strFieldName, strFieldNickName) {
    if (strContent == "") {
        alert(strFieldNickName + " Can not Empty !");
        $('#' + strFieldName + '').focus();
        return false;
    }
    else {
        return true;
    }
}
function NumberWarning(strContent, strFieldName, strFieldNickName) {
    //var regex = /^\d+$/;
    var regex = /^[0-9]*[1-9][0-9]*$/;
    if (!regex.test(strContent)) {
        alert(strFieldNickName + " Must be Number !");
        $('#' + strFieldName + '').val('');
        $('#' + strFieldName + '').focus();
        return false;
    }
    else {
        return true;
    }
}

String.prototype.rtrim = function (s) {
    return this.replace(new RegExp(s + "*$"), '');
};