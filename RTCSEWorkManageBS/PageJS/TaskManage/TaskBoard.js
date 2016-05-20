$(document).ready(function () {
    var dragFrom = '', dropTo = '';
    dragula([document.getElementById('LeftPanel'), document.getElementById('MiddlePanel'), document.getElementById('RightPanel')], {
        copy: function (el, container, target) {
            if (container.id == 'RightPanel') {
                return (target === document.getElementById('RightPanel'));
            }
            else if (container.id == 'MiddlePanel') {
                return (target === document.getElementById('MiddlePanel')) && (target === document.getElementById('RightPanel'));
            }
        },
        accepts: function (el, container, target) {
            if (container.id == 'RightPanel') {
                return (target !== document.getElementById('RightPanel'));
            }
            else if (container.id == 'MiddlePanel') {
                return (target !== document.getElementById('MiddlePanel')) && (target !== document.getElementById('RightPanel'));
            }
        }
    }).on('drag', function (el, container) {
        dragFrom = container.id;
    }).on('drop', function (el, container) {
        dropTo = container.id;
        var CardID = el.id.toString();
        if (CardID.indexOf("public") == 0) {
            TD_CardType = 'public';
            TD_ID = CardID.substring(6);
        }
        else if (CardID.indexOf("private") == 0) {
            TD_CardType = 'private';
            TD_ID = CardID.substring(7);
        }
        else {
            alert('Card ID Error !');
            return;
        }
        //UpdateTaskStatus(dragFrom, dropTo, el);
        AddProgressDialogShow(null, dragFrom, dropTo, TD_ID, TD_CardType);
        if (container.id == "MiddlePanel") {
            el.innerHTML = el.innerHTML.replace("PDHidden", "PDShown");
        }
        else if (container.id == "RightPanel") {
            el.innerHTML = el.innerHTML.replace("PDShown", "PDHidden");
        }
    });

    $('#ModalAddProgress').on('hidden.bs.modal', function () {
        ReloadCardList(false, true, true);
    })

    // Datetime Picker options
    $("#TP_DateStart").datetimepicker({ format: 'mm/dd/yyyy', minView: "month", autoclose: true }).on("click", function (ev) {
        $('#TP_DateStart').datetimepicker("setEndDate", $("#TP_DateEnd").val());
    }); // showMeridian
    $("#TP_DateEnd").datetimepicker({ format: 'mm/dd/yyyy', minView: "month", autoclose: true }).on("click", function (ev) {
        $('#TP_DateEnd').datetimepicker("setStartDate", $("#TP_DateStart").val());
    });

    $('#TD_TimeStart').datetimepicker({ format: 'mm/dd/yyyy hh:ii:ss', autoclose: true }).on("click", function (ev) {
        $('#TD_TimeStart').datetimepicker("setEndDate", $('#TD_TimeEnd').val());
    });
    $('#TD_TimeEnd').datetimepicker({ format: 'mm/dd/yyyy hh:ii:ss', autoclose: true }).on("click", function (ev) {
        $('#TD_TimeEnd').datetimepicker("setStartDate", $("#TD_TimeStart").val());
    });

    InitialTagsInputUser($('#TP_Owner'), 1);

    AddTaskCards();
});
function AddTaskCards() {
    ReloadCardList(true, true, true);
}

function InitialFormTaskPersonal() {
    $('#TP_Title').val('');
    $('#TP_DateStart').val('');
    $('#TP_DateEnd').val('');
    $('#TP_Owner').tagsinput('removeAll');
    $('#TP_Comments').val('');
}

function DetailDialogShow(selector) {
    //alert(selector.parent().find('.TD_ID').text());//.find('.C_ID').val());
    var TD_ID = selector.parent().find('.TD_ID').text();
    var TD_CardType = selector.parent().find('.TD_CardType').text();
    var TaskInfo = '';
    $.post('../ashx/TaskHandler.ashx', { mode: 'GetTaskDetailPersonal', TD_ID: TD_ID, TD_CardType: TD_CardType }, function (data, status) {
        TaskInfo = $.parseJSON(data);
        $('#TD_TaskTitle').val(TaskInfo.TD_TaskTitle);
        $('#TT_Release').val(TaskInfo.TT_Release);
        $('#TT_BuildType').val(TaskInfo.TT_BuildType);
        $('#TT_TaskType').val(TaskInfo.TT_TaskType);
        $('#TT_TaskStyle').val(TaskInfo.TT_TaskStyle);
        $('#TT_CU').val(TaskInfo.TT_CU);
        $('#TT_BuildNum').val(TaskInfo.TT_BuildNum);
        $('#TD_ScenarioTitle').val(TaskInfo.TD_ScenarioTitle);
        $('#TD_RoleTitle').val(TaskInfo.TD_RoleTitle);
        $('#TD_DateStart').val(TaskInfo.TD_DateStart);
        $('#TD_DateEnd').val(TaskInfo.TD_DateEnd);
        $('#TD_Owner').val(TaskInfo.TD_Owner);
        $('#TD_AssignedUserName').val(TaskInfo.TD_AssignedUserName);
        $('#TD_Comments').val(TaskInfo.TD_Comments);
        $('#p_TD_CompleteReason').val(TaskInfo.TD_CompleteReason)
        var TD_ProgressNum = Number(TaskInfo.TD_Progress);
        $('#TD_Progress').html('<div class="progress-bar" role="progressbar" aria-valuenow="' + TD_ProgressNum + '" aria-valuemin="0" aria-valuemax="100" style="width: ' + TD_ProgressNum + '%;">' + TD_ProgressNum + '%</div>');
        if (TD_CardType == "public") {
            $('.publicRow').show();
            $('#ModalTaskDetail').modal({ backdrop: 'static' }).modal('show');
        }
        else if (TD_CardType == "private") {
            $('.publicRow').hide();
            $('#ModalTaskDetail').modal({ backdrop: 'static' }).modal('show');
        }
    });
}

function AddDialogShow() {
    InitialFormTaskPersonal();
    $('#ModalTaskPersonal').modal({ backdrop: 'static' }).modal('show');
}

function ReloadCardList(left, middle, right) {
    var User_ID = $('#User_ID').text();
    var DataCardHTML = '';
    if (left) {
        $('#LeftPanel').children().remove();
    }
    if (middle) {
        $('#MiddlePanel').children().remove();
    }
    if (right) {
        $('#RightPanel').children().remove();
    }
    $.post('../ashx/TaskHandler.ashx', {
        mode: 'GetTaskBoardPersonal', User_ID: User_ID
    }, function (data, status) {
        var TaskInfo = $.parseJSON(data);
        //TaskInfo = data;
        for (var i in TaskInfo) {
            if (TaskInfo[i].TD_CardType == "public") {
                DataCardHTML = '<div class="panel w3-card-4" id="' + TaskInfo[i].TD_CardType + TaskInfo[i].TD_ID + '"><div class="panel-heading w3-blue">' + TaskInfo[i].TD_TaskType + '<label class="TD_ID" hidden="hidden">' + TaskInfo[i].TD_ID + '</label><label class="TD_CardType" hidden="hidden">' + TaskInfo[i].TD_CardType + '</label><button type="button" class="btn btn-primary btn-xs pull-right PDHidden" onclick="AddProgressDialogShow($(this),\'*\',\'*\',\'\',\'\')">Add Progress</button><button type="button" class="btn btn-default btn-xs pull-right" onclick="DetailDialogShow($(this))">Detail</button></div>' +
                '<div class="list-group"><div class="list-group-item"><p class="list-group-item-text">Task Title</p><h4 class="list-group-item-heading">' + TaskInfo[i].TD_TaskTitle + '</h4></div>' +
                '<div class="list-group-item"><p class="list-group-item-text">Assigned to</p><h4 class="list-group-item-heading">' + TaskInfo[i].TD_AssignedUserName + '</h4></div>' +
                '<div class="list-group-item"><p class="list-group-item-text">Owner</p><h4 class="list-group-item-heading">' + TaskInfo[i].TD_Owner + '</h4></div>' +
                '<div class="list-group-item"><p class="list-group-item-text">Scenario</p><h4 class="list-group-item-heading">' + TaskInfo[i].TD_ScenarioTitle + '</h4></div>' +
                '<div class="list-group-item"><p class="list-group-item-text">Feature</p><h4 class="list-group-item-heading">' + TaskInfo[i].TD_RoleTitle + '</h4></div>' +
                '<div class="list-group-item"><p class="list-group-item-text">Date Range</p><h4 class="list-group-item-heading">' + TaskInfo[i].TD_Date + '</h4></div></div></div>';
            }
            else if (TaskInfo[i].TD_CardType == "private") {
                DataCardHTML = '<div class="panel w3-card-4"  id="' + TaskInfo[i].TD_CardType + TaskInfo[i].TD_ID + '"><div class="panel-heading w3-pink">' + TaskInfo[i].TD_TaskType + '<label class="TD_ID" hidden="hidden">' + TaskInfo[i].TD_ID + '</label><label class="TD_CardType" hidden="hidden">' + TaskInfo[i].TD_CardType + '</label><button type="button" class="btn btn-primary btn-xs pull-right PDHidden" onclick="AddProgressDialogShow($(this),\'*\',\'*\',\'\',\'\')">Add Progress</button><button type="button" class="btn btn-default btn-xs pull-right" onclick="DetailDialogShow($(this))">Detail</button></div>' +
                '<div class="list-group"><div class="list-group-item"><p class="list-group-item-text">Task Title</p><h4 class="list-group-item-heading">' + TaskInfo[i].TD_TaskTitle + '</h4></div>' +
                '<div class="list-group-item"><p class="list-group-item-text">Assigned to</p><h4 class="list-group-item-heading">' + TaskInfo[i].TD_AssignedUserName + '</h4></div>' +
                '<div class="list-group-item"><p class="list-group-item-text">Owner</p><h4 class="list-group-item-heading">' + TaskInfo[i].TD_Owner + '</h4></div>' +
                '<div class="list-group-item"><p class="list-group-item-text">Date Range</p><h4 class="list-group-item-heading">' + TaskInfo[i].TD_Date + '</h4></div></div></div>';
            }

            if (left && TaskInfo[i].TD_Status == "Pending") {
                $('#LeftPanel').append(DataCardHTML);
            }
            if (middle && TaskInfo[i].TD_Status == "InProgress") {
                DataCardHTML = DataCardHTML.replace("PDHidden", "PDShown");
                $('#MiddlePanel').append(DataCardHTML);
            }
            if (right && TaskInfo[i].TD_Status == "Complete") {
                $('#RightPanel').append(DataCardHTML);
            }
        }
    });
}

function AddTaskPersonal() {
    var TP_Title = $('#TP_Title').val();
    if (TP_Title == '') { alert('please input Task Title !'); $('#TP_Title').focus(); return; }
    var TP_DateStart = $('#TP_DateStart').val();
    if (TP_DateStart == '') { alert('please input Start Date !'); $('#TP_DateStart').focus(); return; }
    var TP_DateEnd = $('#TP_DateEnd').val();
    if (TP_DateEnd == '') { alert('please input End Date !'); $('#TP_DateEnd').focus(); return; }
    var TP_Owner = $('#TP_Owner').val();
    var TP_Comments = $('#TP_Comments').val();
    var User_ID = $('#User_ID').text();
    if (TP_Owner == '') { TP_Owner = User_ID; }
    $.post('../ashx/TaskHandler.ashx', {
        mode: 'AddTaskPersonal', TP_Title: TP_Title, TP_DateStart: TP_DateStart,
        TP_DateEnd: TP_DateEnd, TP_Owner: TP_Owner, TP_Comments: TP_Comments,
        User_ID: User_ID
    }, function (data, status) {
        if (data == 'success') {
            alert("Save Data Success ~");
            ReloadCardList(true, false, false);
            $('#ModalTaskPersonal').modal('hide');
        }
        else {
            alert("Save Data Failed !");
        }
    });
}

function AddProgressDialogShow(selector, dragFrom, dropTo, TD_ID, TD_CardType) {
    //alert("111");
    if (selector != null) {
        TD_ID = selector.parent().find('.TD_ID').text();
        TD_CardType = selector.parent().find('.TD_CardType').text();
    }
    $('#p_TD_ID').text(TD_ID);
    $('#p_TD_CardType').text(TD_CardType);
    $('#p_DragFrom').text(dragFrom);
    $('#p_DropTo').text(dropTo);
    if (dragFrom == "LeftPanel" && dropTo == "MiddlePanel") {
        CommitTaskProgress();
        return;
    }
    if (TD_CardType == 'public') {
        $('.PublicProgressRow').show();
        $('#p_TD_Progress').attr('readonly', 'readonly');
    }
    else if (TD_CardType == 'private') {
        $('.PublicProgressRow').hide();
        $('#p_TD_Progress').removeAttr('readonly');
    }
    else {
        alert('TD Card Type Error !');
        return;
    }
    $.post('../ashx/TaskHandler.ashx', {
        mode: 'GetTaskDetailPersonal', TD_ID: TD_ID, TD_CardType: TD_CardType
    }, function (data, status) {
        dataJson = $.parseJSON(data);
        $('#TT_ID').text(dataJson.TT_ID);
        $('#p_TD_TaskTitle').val(dataJson.TD_TaskTitle);
        $('#p_TD_ScenarioTitle').val(dataJson.TD_ScenarioTitle);
        $('#p_TD_RoleTitle').val(dataJson.TD_RoleTitle);
        $('#SR_CaseNum').val(dataJson.SR_CaseNum);

        $('#SR_CasePassed').val(dataJson.SR_CasePassed);
        $('#SR_CaseFailed').val(dataJson.SR_CaseFailed);
        $('#SR_CaseNA').val(dataJson.SR_CaseNA);
        $('#SR_CaseRedmond').val(dataJson.SR_CaseRedmond);

        $('#SR_CasePassedOld').text(dataJson.SR_CasePassed);
        $('#SR_CaseFailedOld').text(dataJson.SR_CaseFailed);
        $('#SR_CaseNAOld').text(dataJson.SR_CaseNA);
        $('#SR_CaseRedmondOld').text(dataJson.SR_CaseRedmond);

        $('#p_TD_Progress').val(dataJson.TD_Progress);
        $('#TD_TimeStart').val(dataJson.TD_TimeStart);
        $('#TD_TimeEnd').val(dataJson.TD_TimeEnd);

        if (dataJson.TD_TimeStart != '') {
            $('#TD_TimeStart').attr('disabled', 'disabled');
            $('.TimeEndCol').hide();
        }
        else {
            $('#TD_TimeStart').removeAttr('disabled');
            $('.TimeEndCol').show();
        }
        if (dataJson.TD_TimeEnd != '') {
            $('#TD_TimeEnd').attr('disabled', 'disabled');
        }
        else {
            $('#TD_TimeEnd').removeAttr('disabled');
        }
        if (TD_CardType == 'public') {
            CalculateProgressNum();
            $('.CaseLeftCol').show();
        }
        else {
            $('.CaseLeftCol').hide();
        }
        $('#ModalAddProgress').modal({ backdrop: 'static' }).modal('show');
    });
}
function CommitTaskProgress() { // dragFrom, dropTo, TD_ID, TD_CardType
    //if (dragFrom == "MiddlePanel" && dropTo == "RightPanel" && TD_CardType == "public") {
    //    // 完成公共任务，需要填写case数目
    //    $('.TimeSelectRow').hide();
    //    AddProgressDialogShow(null, "*", "*", TD_ID, TD_CardType);
    //    return;
    //}
    var dragFrom = $('#p_DragFrom').text();
    var dropTo = $('#p_DropTo').text();
    var TD_ID = $('#p_TD_ID').text();
    var TD_CardType = $('#p_TD_CardType').text();
    var TT_ID = $('#TT_ID').text();
    var User_ID = $('#User_ID').text();

    if (!(dragFrom == "LeftPanel" && dropTo == "MiddlePanel")) {
        var SR_CasePassed = $('#SR_CasePassed').val();
        var SR_CaseFailed = $('#SR_CaseFailed').val();
        var SR_CaseNA = $('#SR_CaseNA').val();
        var SR_CaseRedmond = $('#SR_CaseRedmond').val();

        var SR_CasePassedGrow = Number(SR_CasePassed) - Number($('#SR_CasePassedOld').text());
        var SR_CaseFailedGrow = Number(SR_CaseFailed) - Number($('#SR_CaseFailedOld').text());
        var SR_CaseNAGrow = Number(SR_CaseNA) - Number($('#SR_CaseNAOld').text());
        var SR_CaseRedmondGrow = Number(SR_CaseRedmond) - Number($('#SR_CaseRedmondOld').text());
        var TimeStart = $('#TD_TimeStart').val();
        var TimeEnd = $('#TD_TimeEnd').val();
        var TD_Progress = $('#p_TD_Progress').val();
        var TD_CompleteReason = $('#TD_CompleteReason').selectpicker('val');
        if (!NumberVali($('#p_TD_Progress'))) {
            alert("Not a Integer !");
            return;
        };
        if (dropTo == "RightPanel" && TD_Progress != '100') {
            if (TD_CompleteReason == "") {
                alert("your Task Progress is not 100%, Please Select the Complete Reason");
                return;
            }
            else if (TD_CompleteReason == "Completed") {
                alert("your Task Progress is not 100%, Can not select Reason 'Completed'");
                return;
            }
        }
        if (TD_Progress == '100') {
            if (TD_CompleteReason == "") {
                //TD_CompleteReason = "Completed";
                alert("Please Select a Complete Reason !");
                return;
            }
        }
        if (TD_Progress == "" || Number(TD_Progress) > 100) {
            alert("your Task Progress is not avaliable ! Can not empty or larger than 100%");
            return;
        }
    }

    $.post('../ashx/TaskHandler.ashx', {
        mode: 'UpdataTaskProgress', SR_CasePassed: SR_CasePassed, SR_CaseFailed: SR_CaseFailed,
        SR_CasePassedGrow: SR_CasePassedGrow, SR_CaseFailedGrow: SR_CaseFailedGrow, SR_CaseNAGrow: SR_CaseNAGrow, SR_CaseRedmondGrow: SR_CaseRedmondGrow,
        SR_CaseNA: SR_CaseNA, SR_CaseRedmond: SR_CaseRedmond, TimeStart: TimeStart,
        TimeEnd: TimeEnd, TD_Progress: TD_Progress, TD_CompleteReason: TD_CompleteReason,
        dragFrom: dragFrom, dropTo: dropTo, TD_CardType: TD_CardType, TD_ID: TD_ID, TT_ID: TT_ID,
        User_ID: User_ID
    }, function (data, status) {
        if (data == 'Refresh') {
            alert("Task Complete");
            ReloadCardList(false, true, true);
            $('#ModalAddProgress').modal('hide');
        }
        else if (data == 'TaskStart') {
            alert("Task Start ~");
            $('#ModalAddProgress').modal('hide');
        }
        else if (data == 'SaveSuccess') {
            alert("Save Data Success ~");
            $('#ModalAddProgress').modal('hide');
        }
        else {
            alert(data);
        }
    });
}

function CalculateProgressNum() {
    NumberVali($('#SR_CasePassed'));
    NumberVali($('#SR_CaseFailed'));
    NumberVali($('#SR_CaseNA'));
    NumberVali($('#SR_CaseRedmond'));
    var SR_CasePassed = $('#SR_CasePassed').val();
    var SR_CaseFailed = $('#SR_CaseFailed').val();
    var SR_CaseNA = $('#SR_CaseNA').val();
    var SR_CaseRedmond = $('#SR_CaseRedmond').val();
    var SR_CaseNum = $('#SR_CaseNum').val();
    var SumCaseNum = Number(SR_CasePassed) + Number(SR_CaseFailed) + Number(SR_CaseNA) + Number(SR_CaseRedmond);
    var TotalCaseNum = Number(SR_CaseNum);
    $('#CaseLeft').val(Number(TotalCaseNum - SumCaseNum));
    var Progress = parseInt((SumCaseNum / TotalCaseNum) * 100);
    $('#p_TD_Progress').val(Progress);
}

function NumberVali(selector) {
    var regex = /^\d+$/;
    if (!regex.test(selector.val())) {
        selector.val(0);
        //selector.focus();
        return false;
    }
    else {
        return true;
    }
}

function AddDragLog(LogContent) {
    $('#DragLog').append("<div class=\"w3-card\"><p>" + LogContent + "</p></div>");
}