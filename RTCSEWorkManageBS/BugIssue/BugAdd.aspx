<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="BugAdd.aspx.cs" Inherits="RTCSEWorkManageBS.BugIssue.BugAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-select/dist/css/bootstrap-select.min.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/typeahead/dist/typeaheadjs.css") %>" rel="stylesheet" />

    <style type="text/css">
        .page-header {
            padding-bottom: 9px;
            margin: 15px 0 10px;
            border-bottom: 1px solid #eee;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">New Bug/Issue</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-body" id="formBugIssue">
                        <div class="row">
                            <div class="col-lg-10">
                                <div class="form-group">
                                    <label>Bug/Issue Title</label>
                                    <input class="form-control" id="BI_Title" />
                                </div>
                            </div>
                            <div class="col-lg-2">
                                <div class="form-group">
                                    <label>Type</label>
                                    <select class="form-control selectpicker" id="BI_Type">
                                        <option>Issue</option>
                                        <option>Bug</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-8">
                                <div class="form-group">
                                    <label>Hit Task</label>
                                    <select class="form-control selectpicker" id="BI_FK_TT_ID" data-size="8">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group">
                                    <label>Task KeyWord</label>
                                    <input class="form-control" id="BI_TT_Keyword" />
                                </div>
                            </div>
                            <div class="col-lg-1">
                                <div class="form-group">
                                    <label>Reload</label>
                                    <button type="button" class="btn btn-default" onclick="SearchDDLTaskTotal()">Search</button>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label>Hit Scenario</label>
                                    <select class="form-control selectpicker" id="BI_FK_S_ID" data-size="8">
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label>Hit Feature</label>
                                    <select class="form-control selectpicker" id="BI_FK_SR_ID" data-size="8">
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-3">
                                <div class="form-group">
                                    <label>Failed Case Number</label>
                                    <input class="form-control" id="BI_CaseNumber" />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group">
                                    <label>Topology Name</label>
                                    <input class="form-control" id="BI_TopologyName" />
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group">
                                    <label>Server</label>
                                    <input class="form-control" id="BI_EnvironmentServer" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label>Bug/Issue Content</label>
                                    <textarea id="BI_Content"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <button type="button" class="btn btn-success" onclick="SaveBug()">Save</button>
                        <%--<button type="button" class="btn btn-danger" onclick="EmptyPageContent()">EmptyPageContent</button>--%>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-select/dist/js/bootstrap-select.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/typeahead/dist/typeahead.bundle.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/tinymce/tinymce.min.js") %>"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            ReloadDDLTaskTotal('InProgress');

            $('#BI_FK_TT_ID').off().on('changed.bs.select', function () {
                var TT_ID = $(this).find('option:selected').val();
                ReloadDDLScenario(TT_ID);
                $('#BI_FK_SR_ID').html('<option></option>');
                $('#BI_FK_SR_ID').selectpicker('refresh');
            });
            $('#BI_FK_S_ID').off().on('changed.bs.select', function () {
                var S_ID = $(this).find('option:selected').val();
                ReloadDDLScenarioRole(S_ID);
            });

            tinymce.init({
                selector: "textarea", theme: "modern",
                height: 600,
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
                file_browser_callback: RoxyFileBrowser
            });
        });

        function EmptyPageContent() {
            $('#BI_Title').val('');
            $('#BI_TT_Keyword').val('');
            $('#BI_EnvironmentServer').val('');
            $('#BI_TopologyName').val('');
            $('#BI_CaseNumber').val('');
            $('#BI_Type').selectpicker('val', 'Issue');
            $('.selectpicker:not(#BI_Type)').html('<option></option>').selectpicker('refresh');
            ReloadDDLTaskTotal('InProgress');
            tinymce.activeEditor.setContent('');
        }

        function ReloadDDLTaskTotal(keyword) {
            $.post('../ashx/BugIssueHandler.ashx', {
                mode: 'GetDDLTaskTotalSearch', keyword: keyword
            }, function (data) {
                $('#BI_FK_TT_ID').html('<option></option>');
                var TaskInfo = $.parseJSON(data);
                for (var i in TaskInfo) {
                    $('#BI_FK_TT_ID').append('<option data-subtext=' + '"' + TaskInfo[i].TT_TaskStatus + '"' + ' value=' + TaskInfo[i].TT_ID + '>' + TaskInfo[i].TT_Title + '</option>');
                }
                $('#BI_FK_TT_ID').selectpicker('refresh');
            })
        }
        function ReloadDDLScenario(FK_TT_ID) {
            $.post('../ashx/BugIssueHandler.ashx', {
                mode: 'GetDDLScenario', TT_ID: FK_TT_ID
            }, function (data) {
                $('#BI_FK_S_ID').html('<option></option>');
                var ScenarioInfo = $.parseJSON(data);
                for (var i in ScenarioInfo) {
                    $('#BI_FK_S_ID').append('<option value=' + ScenarioInfo[i].S_ID + '>' + ScenarioInfo[i].S_ScenarioName + '</option>');
                }
                $('#BI_FK_S_ID').selectpicker('refresh');
            })
        }
        function ReloadDDLScenarioRole(FK_S_ID) {
            $.post('../ashx/BugIssueHandler.ashx', {
                mode: 'GetDDLScenarioRole', S_ID: FK_S_ID
            }, function (data) {
                $('#BI_FK_SR_ID').html('<option></option>');
                var ScenarioRoleInfo = $.parseJSON(data);
                for (var i in ScenarioRoleInfo) {
                    $('#BI_FK_SR_ID').append('<option value=' + ScenarioRoleInfo[i].SR_ID + '>' + ScenarioRoleInfo[i].SR_RoleTitle + '</option>')
                }
                $('#BI_FK_SR_ID').selectpicker('refresh');
            });
        }

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

        function SearchDDLTaskTotal() {
            var KeyWord = $('#BI_TT_Keyword').val();
            ReloadDDLTaskTotal(KeyWord);
        }

        function SaveBug() {
            var BI_Title = $('#BI_Title').val();
            if (BI_Title == '') {
                alert('Bug/Issue Title can not Empty !');
                $('#BI_Title').focus();
                return;
            }
            var BI_FK_TT_ID = $('#BI_FK_TT_ID').val();
            var BI_FK_S_ID = $('#BI_FK_S_ID').val();
            var BI_FK_SR_ID = $('#BI_FK_SR_ID').val();
            var BI_Type = $('#BI_Type').selectpicker('val');
            var BI_EnvironmentServer = $('#BI_EnvironmentServer').val();
            var BI_TopologyName = $('#BI_TopologyName').val();
            var BI_CaseNumber = $('#BI_CaseNumber').val();
            var BI_Content = tinymce.activeEditor.getContent();
            var BI_Owner = $('#User_ID').text();
            $.post('../ashx/BugIssueHandler.ashx', {
                mode: 'AddBugIssue', BI_FK_TT_ID: BI_FK_TT_ID, BI_FK_S_ID: BI_FK_S_ID,
                BI_FK_SR_ID: BI_FK_SR_ID, BI_Title: BI_Title, BI_Type: BI_Type,
                BI_EnvironmentServer: BI_EnvironmentServer, BI_TopologyName: BI_TopologyName,
                BI_CaseNumber: BI_CaseNumber, BI_Content: BI_Content, BI_Owner: BI_Owner
            }, function (data) {
                if (data=='success') {
                    alert('Save Data Success ~');
                    //location.reload();
                    //$('#formBugIssue').load(location.href + " #formBugIssue");
                    //jQuery.read();
                    //onPageLoad();
                    EmptyPageContent();
                }
                else {
                    alert('Save Data Failed !');
                }
            });
        }

    </script>
</asp:Content>
