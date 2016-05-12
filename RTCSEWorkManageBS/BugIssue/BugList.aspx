<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="BugList.aspx.cs" Inherits="RTCSEWorkManageBS.BugIssue.BugList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <link href="<%=ResolveUrl("~/bower_components/jqgrid/css/ui.jqgrid-bootstrap.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput-typeahead.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/bootcards/dist/css/bootcards-desktop.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/dist/css/timeline.css") %>" rel="stylesheet" />
    <style type="text/css">
        .bootstrap-tagsinput {
            width: 100%;
        }

        .row > .list-group-item {
            border: 0px 0px 0px 0px !important;
        }

        .page-header {
            padding-bottom: 9px;
            margin: 15px 0 10px;
            border-bottom: 1px solid #eee;
        }

        .ui-jqgrid tr.jqgrow td {
            white-space: normal !important;
            height: auto;
            vertical-align: text-top;
            padding-top: 2px;
            vertical-align: middle;
        }

        .help-block {
            margin-bottom: 0px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Bug Issue List</h1>
                <%--class="page-header"--%>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-7">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="search-form">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="input-group">
                                        <input id="txt_KeyWord" type="text" class="form-control" placeholder="Search for..." />
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="button" onclick="SearchBugIssueList()">Search</button>
                                        </span>

                                    </div>
                                    <span class="help-block">Empty for 'Open' Bug/Issue; Input '@all' display all Bug/Issue</span>
                                    <!-- /input-group -->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="list-group" id="BugIssueList">
                        <label hidden="hidden">*</label>
                        <%--<a class="list-group-item" onclick="TaskListClick($(this))" id="TaskList23">
                            <h4 class="list-group-item-heading">W16 CU3 server build (9319.253) sanity Hotfix Verification</h4>
                            <p class="list-group-item-text"><span class="text-danger">Bug</span> | <span class="bg-success">Open</span> | 04/02/2016 16:25:40 | Create by Mingpu Wu</p>
                        </a>
                        <a class="list-group-item" onclick="TaskListClick($(this))">
                            <h4 class="list-group-item-heading">W15-CU7 and W14-CU14 SHA1 issue Task</h4>
                            <p class="list-group-item-text"><span class="text-warning">Issue</span> | <span class="bg-info">Closed</span> | 04/09/2016 18:10:09</p>
                        </a>--%>
                    </div>
                    <div class="row">
                        <ul class="pager">
                            <li><a class="btn" onclick="prevPage(); return false;">Previous</a></li>
                            <li><span id="CurrentPage">Current:3</span></li>
                            <li><span id="TotalPage">Total:5</span></li>
                            <li><span id="TotalItem">Items:5</span></li>
                            <li><a class="btn" onclick="nextPage(); return false;">Next</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-lg-5">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <button type="button" class="btn btn-primary" id="btn_BugIssueContent" onclick="">B/I Content</button><%--#BugIssueContent target="_self"--%>
                        <%--<button type="button" class="btn btn-default">Close B/I</button>--%>
                        <p></p>
                        <div class="list-group">
                            <div class="row">
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Hit Task</p>
                                    <h4 class="list-group-item-heading" id="TT_Title">*</h4>
                                </div>
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Hit Scenario</p>
                                    <h4 class="list-group-item-heading" id="S_ScenarioName">*</h4>
                                </div>
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Hit Feature</p>
                                    <h4 class="list-group-item-heading" id="SR_RoleTitle">*</h4>
                                </div>
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Failed Case Number</p>
                                    <h4 class="list-group-item-heading" id="BI_CaseNumber">*</h4>
                                </div>
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Repo Server Name</p>
                                    <h4 class="list-group-item-heading" id="BI_EnvironmentServer">*</h4>
                                </div>
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Repo Topology Name</p>
                                    <h4 class="list-group-item-heading" id="BI_TopologyName">*</h4>
                                </div>
                                <%--<div class="list-group-item">
                                    <p class="list-group-item-text">Create Time</p>
                                    <h4 class="list-group-item-heading" id="BI_CreateDate">*</h4>
                                </div>--%>
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Update Time</p>
                                    <h4 class="list-group-item-heading" id="BI_UpdateTime">*</h4>
                                </div>
                                <div class="list-group-item">
                                    <p class="list-group-item-text">Close Time</p>
                                    <h4 class="list-group-item-heading" id="BI_CloseTime">*</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" id="BugIssueContent">
            <div class="col-lg-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Bug/Issue Content
                    </div>
                    <div class="panel-body">
                        <label hidden="hidden" id="BI_ID">*</label>
                        <%--<button class="btn btn-default btn-sm" onclick="window.location.href = '#page-wrapper'">Top</button>--%>
                        <div class="row">
                            <div class="col-lg-12">
                                <ul class="timeline" id="BugIssueTimeLine">
                                </ul>
                            </div>
                        </div>

                        <div id="div_BIR_Content">
                            <textarea id="BIR_Content"></textarea>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <input type="button" class="btn btn-success" id="btn_AddBugIssueReply" value="Add Bug/Issue Reply" onclick="AddReply()" />
                        <%--<button class="btn btn-default btn-sm" onclick="window.location.href = '#page-wrapper'">Top</button>--%>
                        <input type="button" class="btn btn-default" id="btn_CloseBugIssue" value="Close Bug/Issue" onclick="CloseBugIssue()" />
                        <input type="button" class="btn btn-primary" id="btn_ReOpenBugIssue" value="ReOpen Bug/Issue" onclick="ReOpenBugIssue()" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/tinymce/tinymce.min.js") %>"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            ReloadBugIssueList('');

            tinymce.init({
                selector: "textarea", theme: "modern",
                height: 200,
                setup: function (ed) {
                    ed.on('init', function () {
                        //this.execCommand("fontName", false, "Tahoma");
                        //this.execCommand("fontSize", false, "12pt");
                        this.getDoc().body.style.fontSize = '12pt';
                    });
                },
                plugins: [
                     "advlist autolink link image lists charmap print preview hr anchor pagebreak",
                     "searchreplace wordcount visualblocks visualchars insertdatetime media nonbreaking",
                     "table contextmenu directionality emoticons paste textcolor code codesample"//fullpage fullscreen
                ],
                //menubar: "edit",
                toolbar1: "undo redo | bold italic underline | fontselect fontsizeselect | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | styleselect",
                toolbar2: "paste | link unlink anchor | image media emoticons hr insertdatetime codesample | forecolor backcolor | charmap  | print preview code ",//fullpage fullscreen 
                image_advtab: true,
                paste_data_images: true,
                //readonly:true,
                file_browser_callback: RoxyFileBrowser
            });

            $('#btn_AddBugIssueReply').prop('disabled', true);
            $('#btn_BugIssueContent').prop('disabled', true);
            $('#btn_AddBugIssueReply').hide();
            $('#div_BIR_Content').hide();
            //tinymce.activeEditor.getBody().setAttribute('contenteditable', false);
            $('#btn_CloseBugIssue').hide();
            $('#btn_ReOpenBugIssue').hide();
        });
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

        //var items;
        var pager = {};
        //pager.items = JSON.parse(items);
        pager.itemsPerPage = 5;
        function ReloadBugIssueList(keyWord) {
            //<a class="list-group-item" onclick="BugIssueListClick($(this))" id="BugIssueList23">
            //                <h4 class="list-group-item-heading">W16 CU3 server build (9319.253) sanity Hotfix Verification</h4>
            //                <p class="list-group-item-text"><span class="text-danger">Bug</span> | <span class="bg-success">Open</span> | 04/02/2016 16:25:40 | Create by Mingpu Wu</p>
            //            </a>
            //            <a class="list-group-item" onclick="TaskListClick($(this))">
            //                <h4 class="list-group-item-heading">W15-CU7 and W14-CU14 SHA1 issue Task</h4>
            //                <p class="list-group-item-text"><span class="text-warning">Issue</span> | <span class="bg-info">Closed</span> | 04/09/2016 18:10:09</p>
            //            </a>
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
                if (BugInfo[i].BI_Type == 'Bug') { cssBI_Type = 'text-danger'; }
                else if (BugInfo[i].BI_Type == 'Issue') { cssBI_Type = 'text-warning'; }
                if (BugInfo[i].BI_Status == 'Open' || BugInfo[i].BI_Status == 'ReOpen') { cssBI_Status = 'bg-success'; }
                else if (BugInfo[i].BI_Status == 'Clolsed') { cssBI_Status = 'bg-info'; }
                $('#BugIssueList').append('<a class="list-group-item" onclick="BugIssueListClick($(this))" id="BugIssueList' + BugInfo[i].BI_ID + '">' +
                    '<h4 class="list-group-item-heading">' + BugInfo[i].BI_Title + '</h4>' +
                    '<p class="list-group-item-text"><span class="' + cssBI_Type + '">' + BugInfo[i].BI_Type + '</span> | <span class="' + cssBI_Status + '">' + BugInfo[i].BI_Status + '</span> | ' + BugInfo[i].BI_CreateDate + ' | Create by ' + BugInfo[i].U_nickname + '</p></a>');
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
            $('#btn_BugIssueContent').prop('disabled', false);
            $('#btn_AddBugIssueReply').hide();
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
            });
        }
        function ShowBugIssueContent(BI_ID, BI_Owner, BI_Status) {
            //window.location.href = 'BugContent.aspx?id=' + BI_ID;
            //<li class="timeline-inverted">
            //                    <div class="timeline-badge success">B / I</div>
            //                    <div class="timeline-panel">
            //                        <div class="timeline-heading">
            //                            <h4 class="timeline-title">Mussum ipsum cacilds</h4>
            //                            <p><small class="text-muted"><i class="glyphicon glyphicon-time"></i>11 hours ago via Twitter</small></p>
            //                        </div>
            //                        <div class="timeline-body" id="BI_Content">
            //                            <p>Mussum ipsum cacilds, vidis litro abertis. Consetis adipiscings elitis. Pra lá , depois divoltis porris, paradis. Paisis, filhis, espiritis santis. Mé faiz elementum girarzis, nisi eros vermeio, in elementis mé pra quem é amistosis quis leo. Manduma pindureta quium dia nois paga. Sapien in monti palavris qui num significa nadis i pareci latim. Interessantiss quisso pudia ce receita de bolis, mais bolis eu num gostis.</p>
            //                        </div>
            //                    </div>
            //                </li>
            //$('#BRI_Content')
            $('#btn_BugIssueContent').prop('disabled', true);
            //$('#BugIssueList').prop('disabled', true);
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
                                if (replyJson[i].BIR_Content == '<p>Bug/Issue Closed</p>') {
                                    var cssReplyIcon = '<div class="timeline-badge info">SYS</div>'
                                }
                                else if (replyJson[i].BIR_Content == '<p>Bug/Issue ReOpen</p>') {
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
                    $('#btn_AddBugIssueReply').show(); $('#div_BIR_Content').show();
                }
                else if (BI_Status == 'Closed') {
                    $('#btn_AddBugIssueReply').hide(); $('#div_BIR_Content').hide();
                }
                else {
                    $('#btn_AddBugIssueReply').hide(); $('#div_BIR_Content').hide();
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
            $.post('../ashx/BugIssueHandler.ashx', {
                mode: 'CloseBugIssue', BI_ID: BIR_FK_BI_ID, User_ID: User_ID
            }, function (data) {
                if (data == 'success') {
                    //<p>Bug/Issue Closed</p>
                    $('#BugIssueTimeLine').append('<li class="timeline-inverted"><div class="timeline-badge info">SYS</div><div class="timeline-panel">' +
                        '<p><small class="text-muted"><i class="glyphicon glyphicon-user"></i>' + $('#User_UserName').text() + ' | <i class="glyphicon glyphicon-time"></i>recently</small></p>' +//| <i class="glyphicon glyphicon-time"></i>' + replyJson[i].TT_CreateDate + '
                        '<div class="timeline-body"><p>Bug/Issue Closed</p></div></div></li>');
                    $('#div_BIR_Content').hide();
                    $('#btn_AddBugIssueReply').hide();
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
                    $('#btn_CloseBugIssue').show();
                    $('#btn_ReOpenBugIssue').hide();
                }
                else {
                    alert('Save Data Failed !');
                }
            });
        }
    </script>
</asp:Content>
