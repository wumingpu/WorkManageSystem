var roxyFileman = '../bower_components/fileman/index.html?integration=tinymce4';
function RoxyFileBrowser(field_name, url, type, win) {
    var cmsURL = roxyFileman;  // script URL - use an absolute path!
    if (cmsURL.indexOf("?") < 0) {
        cmsURL = cmsURL + "?type=" + type;
    }
    else {
        cmsURL = cmsURL + "&type=" + type;
    }
    cmsURL += '&input=' + field_name + '&value=' + win.document.getElementById(field_name).value;
    tinyMCE.activeEditor.windowManager.open({
        file: cmsURL,
        title: 'File Browser',
        width: 850, // Your dimensions may differ - toy around with them!
        height: 650,
        resizable: "yes",
        plugins: "media",
        inline: "yes", // This parameter only has an effect if you use the inlinepopups plugin!
        close_previous: "no"
    }, {
        window: win,
        input: field_name
    });
    return false;
}

var pager = {};
pager.itemsPerPage = 5;
function ReloadBugIssueList(keyWord) {
    $.post('../ashx/BugIssueHandler.ashx', { mode: 'QueryBugIssueListGroup', keyWord: keyWord }, function (data) {
        var BugInfo = $.parseJSON(data);
        pager.items = BugInfo;
        pagerInit(pager);
        $('#TotalPage').text('Total:' + pager.pagedItems.length);
        $('#TotalItem').text('Items:' + BugInfo.length);
        BindBugIssueList();
    });
}
function BindBugIssueList() {
    var BugInfo = pager.pagedItems[pager.currentPage];
    $('#CurrentPage').text('Current:' + (pager.currentPage + 1));
    var cssBI_Type, cssBI_Status;
    $('#BugIssueList').empty();
    for (var i in BugInfo) {
        if (BugInfo[i].BI_Type.indexOf('Bug') >= 0) { cssBI_Type = 'text-danger'; }
        else if (BugInfo[i].BI_Type.indexOf('Issue') >= 0) { cssBI_Type = 'text-warning'; }
        if (BugInfo[i].BI_Status == 'Open' || BugInfo[i].BI_Status == 'ReOpen') { cssBI_Status = 'bg-success'; }
        else if (BugInfo[i].BI_Status == 'Clolsed') { cssBI_Status = 'bg-info'; }
        $('#BugIssueList').append('<a class="list-group-item" onclick="BugIssueListClick($(this))" id="BugIssueList' + BugInfo[i].BI_ID + '">' +
            '<h4 class="list-group-item-heading">' + BugInfo[i].BI_Title + '</h4>' +
            '<p class="list-group-item-text"><span class="' + cssBI_Type + '">' + BugInfo[i].BI_Type + '</span> | <span class="' + cssBI_Status + '">' + BugInfo[i].BI_Status + '</span> | ' + BugInfo[i].BI_Priority + ' | ' + BugInfo[i].BI_CreateDate + ' | Create by ' + BugInfo[i].U_nickname + '</p></a>');
    }
}
function prevPage() {
    pager.prevPage();
    BindBugIssueList();
}
function nextPage() {
    pager.nextPage();
    BindBugIssueList();
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

function SearchBugIssueList() {
    var KeyWord = $('#txt_KeyWord').val();
    ReloadBugIssueList(KeyWord);
}
function BugIssueListClick(selector) {
    if (selector.hasClass('list-group-item')) {
        selector.addClass('active').siblings().removeClass('active');
    }
    tinymce.activeEditor.setContent('');
    $('#BugIssueTimeLine').empty();
    $('#btn_AddBugIssueReply').prop('disabled', true);
    $('#BI_Resolution').attr('disabled', true);
    $('#BI_Resolution').selectpicker('val', '');
    $('#btn_BugIssueContent').prop('disabled', false);
    $('#btn_AddBugIssueReply').hide();
    $('#BI_Resolution').selectpicker('hide');
    $('#BIR_Content').hide();
    $('#btn_CloseBugIssue').hide();
    $('#btn_ReOpenBugIssue').hide();
    var BI_ID = selector.attr('id').substring(12);
    ReloadBugIssueDetail(BI_ID);
}
function ReloadBugIssueDetail(BI_ID) {
    $.post('../ashx/BugIssueHandler.ashx', {
        mode: 'GetBugIssueDetail', BI_ID: BI_ID
    }, function (data) {
        var BugInfo = $.parseJSON(data);
        $('#btn_BugIssueContent').attr('onclick', 'ShowBugIssueContent(' + BI_ID + ',' + BugInfo.BI_Owner + ',"' + BugInfo.BI_Status + '")');
        $('#TT_Title').html(BugInfo.TT_Title == '' ? '*' : BugInfo.TT_Title);
        $('#S_ScenarioName').html(BugInfo.S_ScenarioName == '' ? '*' : BugInfo.S_ScenarioName);
        $('#SR_RoleTitle').html(BugInfo.SR_RoleTitle == '' ? '*' : BugInfo.SR_RoleTitle);
        $('#BI_CaseNumber').html(BugInfo.BI_CaseNumber == '' ? '*' : BugInfo.BI_CaseNumber);
        $('#BI_EnvironmentServer').html(BugInfo.BI_EnvironmentServer == '' ? '*' : BugInfo.BI_EnvironmentServer);
        $('#BI_TopologyName').html(BugInfo.BI_TopologyName == '' ? '*' : BugInfo.BI_TopologyName);
        $('#BI_UpdateTime').html(BugInfo.BI_UpdateTime == '' ? '*' : BugInfo.BI_UpdateTime);
        $('#BI_CloseTime').html(BugInfo.BI_CloseTime == '' ? '*' : BugInfo.BI_CloseTime);
        $('#BI_Priority').html(BugInfo.BI_Priority == '' ? '*' : BugInfo.BI_Priority);
    });
}
function ShowBugIssueContent(BI_ID, BI_Owner, BI_Status) {
    $('#btn_BugIssueContent').prop('disabled', true);
    $('#btn_BugIssueContent').text('Loading Data...');
    $('#BI_ID').val(BI_ID);
    tinymce.activeEditor.setContent('');
    $('#BugIssueTimeLine').empty();
    $.post('../ashx/BugIssueHandler.ashx', { mode: 'GetBugIssueContentSingle', BI_ID: BI_ID }, function (data) {
        if (data != 'fail') {
            var contentJson = $.parseJSON(data);//dataJson.BI_Content
            $('#BugIssueTimeLine').append('<li class="timeline-inverted"><div class="timeline-badge success">B / I</div><div class="timeline-panel">' +
                '<div class="timeline-heading"><h4 class="timeline-title">' + contentJson.BI_Title + '</h4>' +
                '<p><small class="text-muted"><i class="glyphicon glyphicon-time"></i>' + contentJson.BI_CreateDate + '</small></p></div>' +
                '<div class="timeline-body">' + contentJson.BI_Content + '</div></div></li>');

            $.post('../ashx/BugIssueHandler.ashx', { mode: 'GetBugIssueReplySingle', BI_ID: BI_ID }, function (data) {
                if (data != 'fail') {
                    var replyJson = $.parseJSON(data);
                    for (var i in replyJson) {
                        if (replyJson[i].BIR_Content.indexOf('Bug/Issue Closed') >= 0) {
                            var cssReplyIcon = '<div class="timeline-badge info">SYS</div>'
                        }
                        else if (replyJson[i].BIR_Content.indexOf('Bug/Issue ReOpen') >= 0) {
                            var cssReplyIcon = '<div class="timeline-badge info">SYS</div>'
                        }
                        else {
                            var cssReplyIcon = '<div class="timeline-badge warning">R E</div>'
                        }
                        $('#BugIssueTimeLine').append('<li class="timeline-inverted">' + cssReplyIcon + '<div class="timeline-panel">' +
                        //'<div class="timeline-heading"><h4 class="timeline-title">' + replyJson[i].BI_Title + '</h4>' +
                        '<p><small class="text-muted"><i class="glyphicon glyphicon-user"></i>' + replyJson[i].U_nickname + ' | <i class="glyphicon glyphicon-time"></i>' + replyJson[i].BIR_CreateTime + '</small></p>' +//</div>
                        '<div class="timeline-body">' + replyJson[i].BIR_Content + '</div></div></li>');
                    }
                }
            });
        }
        $('#btn_BugIssueContent').prop('disabled', false);
        $('#btn_AddBugIssueReply').prop('disabled', false);
        $('#BI_Resolution').attr('disabled', false).selectpicker('refresh');
        $('#btn_BugIssueContent').text('B/I Content');
        if (BI_Owner == $('#User_ID').text()) {
            if (BI_Status == "Open") {
                $('#btn_CloseBugIssue').show(); $('#btn_ReOpenBugIssue').hide();
            }
            else if (BI_Status == "Closed") {
                $('#btn_CloseBugIssue').hide(); $('#btn_ReOpenBugIssue').show();
            }
        }
        else { $('#btn_CloseBugIssue').hide(); $('#btn_ReOpenBugIssue').hide(); }

        if (BI_Status == 'Open') {
            $('#btn_AddBugIssueReply').show(); $('#BI_Resolution').selectpicker('show'); $('#div_BIR_Content').show();
        }
        else if (BI_Status == 'Closed') {
            $('#btn_AddBugIssueReply').hide(); $('#BI_Resolution').selectpicker('hide'); $('#div_BIR_Content').hide();
        }
        else {
            $('#btn_AddBugIssueReply').hide(); $('#BI_Resolution').selectpicker('hide'); $('#div_BIR_Content').hide();
        }

        window.location.href = '#BugIssueContent';
    });
}

function AddReply() {
    var BIR_FK_BI_ID = $('#BI_ID').val();
    var BIR_Content = tinymce.activeEditor.getContent();
    if (BIR_Content == '') {
        alert('Reply Content should not Empty !');
        return;
    }
    var BIR_CreateUser = $('#User_ID').text();
    var U_nickname = $('#User_UserName').text();
    $.post('../ashx/BugIssueHandler.ashx', {
        mode: 'AddBugIssueReply', BIR_FK_BI_ID: BIR_FK_BI_ID, BIR_Content: BIR_Content,
        BIR_CreateUser: BIR_CreateUser
    }, function (data) {
        if (data == 'success') {
            tinymce.activeEditor.setContent('');
            $('#BugIssueTimeLine').append('<li class="timeline-inverted"><div class="timeline-badge warning">R E</div><div class="timeline-panel">' +
                '<p><small class="text-muted"><i class="glyphicon glyphicon-user"></i>' + U_nickname + ' | <i class="glyphicon glyphicon-time"></i>recently</small></p>' +//| <i class="glyphicon glyphicon-time"></i>' + replyJson[i].TT_CreateDate + '
                '<div class="timeline-body">' + BIR_Content + '</div></div></li>');
        }
        else {
            alert('Save Data Failed !');
        }
    });
}

function CloseBugIssue() {
    var BIR_FK_BI_ID = $('#BI_ID').val();
    var User_ID = $('#User_ID').text();
    if (!confirm('Close This Bug/Issue Now ?')) {
        return;
    }
    var BI_Resolution = $('#BI_Resolution').selectpicker('val');
    if (BI_Resolution == '') {
        alert('Please select a Bug/Issue Resolution');
        return;
    }
    $.post('../ashx/BugIssueHandler.ashx', {
        mode: 'CloseBugIssue', BI_ID: BIR_FK_BI_ID, User_ID: User_ID,
        BI_Resolution: BI_Resolution
    }, function (data) {
        if (data == 'success') {
            //<p>Bug/Issue Closed</p>
            $('#BugIssueTimeLine').append('<li class="timeline-inverted"><div class="timeline-badge info">SYS</div><div class="timeline-panel">' +
                '<p><small class="text-muted"><i class="glyphicon glyphicon-user"></i>' + $('#User_UserName').text() + ' | <i class="glyphicon glyphicon-time"></i>recently</small></p>' +//| <i class="glyphicon glyphicon-time"></i>' + replyJson[i].TT_CreateDate + '
                '<div class="timeline-body"><p>Bug/Issue Closed, Resolution: ' + BI_Resolution + '</p></div></div></li>');
            $('#div_BIR_Content').hide();
            $('#btn_AddBugIssueReply').hide();
            $('#BI_Resolution').selectpicker('hide');
            $('#btn_CloseBugIssue').hide();
            $('#btn_ReOpenBugIssue').show();
            //ReloadBugIssueList('');
        }
        else {
            alert('Save Data Failed !');
        }
    });
}

function ReOpenBugIssue() {
    var BIR_FK_BI_ID = $('#BI_ID').val();
    var User_ID = $('#User_ID').text();
    if (!confirm('ReOpen This Bug/Issue Now ?')) {
        return;
    }
    $.post('../ashx/BugIssueHandler.ashx', {
        mode: 'ReOpenBugIssue', BI_ID: BIR_FK_BI_ID, User_ID: User_ID
    }, function (data) {
        if (data == 'success') {
            $('#BugIssueTimeLine').append('<li class="timeline-inverted"><div class="timeline-badge info">SYS</div><div class="timeline-panel">' +
                '<p><small class="text-muted"><i class="glyphicon glyphicon-user"></i>' + $('#User_UserName').text() + ' | <i class="glyphicon glyphicon-time"></i>recently</small></p>' +//| <i class="glyphicon glyphicon-time"></i>' + replyJson[i].TT_CreateDate + '
                '<div class="timeline-body"><p>Bug/Issue ReOpen</p></div></div></li>');
            $('#div_BIR_Content').show();
            $('#btn_AddBugIssueReply').show();
            $('#BI_Resolution').selectpicker('show');
            $('#BI_Resolution').selectpicker('val', '');
            $('#btn_CloseBugIssue').show();
            $('#btn_ReOpenBugIssue').hide();
        }
        else {
            alert('Save Data Failed !');
        }
    });
}