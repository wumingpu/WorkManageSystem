<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="ScenarioRole.aspx.cs" Inherits="RTCSEWorkManageBS.TaskManage.ScenarioRole" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <!-- JQGrid CSS -->
    <link href="<%=ResolveUrl("~/bower_components/jqgrid/css/ui.jqgrid-bootstrap.css") %>" rel="stylesheet" />
    <!-- tagsinput CSS -->
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput-typeahead.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bower_components/bootcards/dist/css/bootcards-desktop.css") %>" rel="stylesheet" />
    <style type="text/css">
        .bootstrap-tagsinput {
            width: 100%;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h2 class="page-header">Feature</h2>
                <%--class="page-header"--%>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-4">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="search-form">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="input-group">
                                        <input id="txt_KeyWord" type="text" class="form-control" placeholder="Search for..." />
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="button" onclick="SearchTaskList()">Search</button>
                                        </span>
                                    </div>
                                    <!-- /input-group -->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="list-group" id="TaskList">
                        <label hidden="hidden">*</label>
                        <%--<a class="list-group-item" onclick="TaskListClick($(this))" id="TaskList23">
                            <h4 class="list-group-item-heading">W16 CU3 server build (9319.253) sanity Hotfix Verification</h4>
                            <p class="list-group-item-text">03/30/2016 - 04/02/2016</p>
                        </a>
                        <a class="list-group-item" onclick="TaskListClick($(this))">
                            <h4 class="list-group-item-heading">W15-CU7 and W14-CU14 SHA1 issue Task</h4>
                            <p class="list-group-item-text">04/07/2016 - 04/09/2016</p>
                        </a>--%>
                    </div>
                    <div class="row">
                        <ul class="pager">
                            <li><a class="btn" onclick="prevPage(); return false;"><<</a></li>
                            <li><span id="CurrentPage">Current:0</span></li>
                            <li><span id="TotalPage">Total:0</span></li>
                            <li><span id="TotalItem">Items:0</span></li>
                            <li><a class="btn" onclick="nextPage(); return false;">>></a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- /.col-lg-3 Left TaskList-->
            <div class="col-lg-8 bootcards-cards">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Scenario
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <table id="GT_Scenario"></table>
                        <div id="jqGridPagerScenario"></div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Feature
                        <%--<h4 class="pull-left">Feature</h4>--%>
                        <%--<a style="margin-left: 15px"></a>--%>
                        <%--<div class="pull-right">
                            <input class="btn btn-success btn-sm" type="button" value="New" onclick="AddDialogShow()" />
                            <input class="btn btn-primary btn-sm" type="button" value="Edit" onclick="EditDialogShow()" />
                            <input class="btn btn-danger btn-sm" type="button" value="Delete" onclick="DeleteScenarioRole()" />
                        </div>--%>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <input class="btn btn-success btn-sm" type="button" value="New" onclick="AddDialogShow()" />
                        <input class="btn btn-primary btn-sm" type="button" value="Edit" onclick="EditDialogShow()" />
                        <input class="btn btn-danger btn-sm" type="button" value="Delete" onclick="DeleteScenarioRole()" />
                        <p style="margin-top: 10px"></p>
                        <table id="GT_ScenarioRole"></table>
                        <div id="jqGridPager"></div>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /.page-wrapper -->

    <div class="modal fade" id="ModalScenarioRole" tabindex="-1" role="dialog" aria-labelledby="ModalScenarioRoleLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="ModalScenarioRoleLabel">Add Scenario Feature</h4>
                </div>
                <!-- /.modal-header -->
                <div class="modal-body" id="FormScenarioRole">
                    <label id="SR_ID" hidden="hidden">*</label>
                    <label id="SR_FK_S_ID" hidden="hidden">*</label>
                    <label id="SR_FK_TT_ID" hidden="hidden">*</label>
                    <label id="TT_TaskStatus" hidden="hidden">*</label>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Feature Title</label>
                                <input class="form-control" id="SR_RoleTitle" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Case Number</label>
                                <input class="form-control" id="SR_CaseNum" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>Assigned User</label>
                                <input class="form-control" id="SR_AssignedUser" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.modal-body -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-success" id="btn_AddRole" onclick="AddScenarioRole()">Save</button>
                    <button type="button" class="btn btn-success" id="btn_UpdateRole" onclick="UpdateScenarioRole()">Update</button>
                </div>
                <!-- /.modal-footer -->
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <!-- jqgrid langue JavaScript 'Required!!!' -->
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/jqgrid/js/i18n/grid.locale-en.js") %>"></script>
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/jqgrid/js/jquery.jqGrid.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap/js/modal.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/typeahead/dist/typeahead.bundle.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.min.js") %>"></script>
    <script type="text/javascript" src="<%=ResolveUrl("~/DynamicJS/TagsInputUserData.js") %>"></script>
    <script type="text/javascript">
        $.jgrid.defaults.responsive = true;
        $.jgrid.defaults.styleUI = 'Bootstrap';

        $(document).ready(function () {
            ReloadTaskList('');//var HaveTaskList = ReloadTaskList('', false);
            //var S_FK_TT_ID;
            //if (HaveTaskList) {
            //    S_FK_TT_ID = $('.list-group a').first().attr('id').substring(8); // TaskList+S_FK_TT_ID
            //}
            //else {
            //    S_FK_TT_ID = 0;
            //}
            $('#GT_Scenario').jqGrid({
                url: '../ashx/TaskHandler.ashx?mode=QueryScenario&S_FK_TT_ID=0',// + S_FK_TT_ID,
                datatype: "json",
                colModel: [
                    { label: 'ID', name: 'S_ID', key: true, hidden: true },
                    { label: 'TT_ID', name: 'S_FK_TT_ID', hidden: true },
                    { label: 'TT_TaskStatus', name: 'TT_TaskStatus', hidden: true },
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
                pager: '#jqGridPagerScenario',
                onSelectRow: function (FK_S_ID) {
                    if (FK_S_ID != null) {
                        ReloadJQGrid(FK_S_ID);
                    }
                    else {
                        ReloadJQGrid(0);
                    }
                }
            });

            $('#GT_ScenarioRole').jqGrid({
                url: '../ashx/TaskHandler.ashx?mode=QueryScenarioRole&SR_FK_S_ID=0',
                datatype: "json",
                //colNames: ['SR_ID', 'SR_FK_S_ID', 'SR_FK_TT_ID', 'TT_Title', 'S_ScenarioName', 'SR_RoleTitle', 'SR_AssignedUser', 'SR_AssignedUserName', 'SR_CreateUser', 'U_nickname', 'SR_CaseNum',
                //'SR_CasePassed', 'SR_CaseFailed', 'SR_CaseNA', 'SR_CaseRedmond', 'SR_CompleteProgress'],
                colModel: [
                    { label: 'ID', name: 'SR_ID', key: true, hidden: true },
                    { label: 'S_ID', name: 'SR_FK_S_ID', hidden: true },
                    { label: 'TT_ID', name: 'SR_FK_TT_ID', hidden: true },
                    { label: 'AssignedID', name: 'SR_AssignedUser', hidden: true },
                    { label: 'OwnerID', name: 'SR_CreateUser', hidden: true },
                    //{ label: 'Task Title', name: 'TT_Title', sortable: false },//, width: 300
                    //{ label: 'Scenario Name', name: 'S_ScenarioName', sortable: false },//, width: 400
                    { label: 'Feature Name', name: 'SR_RoleTitle', sortable: false, width: 250 },//, width: 200
                    { label: 'Assigned', name: 'SR_AssignedUserName', width: 350 },//, width: 100
                    { label: 'Owner', name: 'U_nickname', width: 230 },//, width: 100
                    { label: 'No.', name: 'SR_CaseNum', width: 85 },//, width: 80
                    { label: 'Pass', name: 'SR_CasePassed', width: 85 },//, width: 80
                    { label: 'Fail', name: 'SR_CaseFailed', width: 85 },//, width: 80
                    { label: 'N/A', name: 'SR_CaseNA', width: 85 },//, width: 80
                    { label: 'Rdm', name: 'SR_CaseRedmond', width: 85 },//, width: 80
                    { label: '%', name: 'SR_CompleteProgress', width: 85 }//, width: 80
                ],
                cmTemplate: { sortable: false },
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
            $('#GT_ScenarioRole').navGrid("#jqGridPager", {
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

            InitialTagsInputUser($('#SR_AssignedUser'), '');
        });

        var pager = {};
        pager.itemsPerPage = 5;
        function ReloadTaskList(keyWord) {
            //<a class="list-group-item" onclick="TaskListClick($(this))" id="TaskList23">
            //<h4 class="list-group-item-heading">W16 CU3 server build (9319.253) sanity Hotfix Verification</h4>
            //<p class="list-group-item-text">03/30/2016 - 04/02/2016</p></a>
            $.post('../ashx/TaskHandler.ashx', {
                mode: 'QueryTaskListTotalSimple', ListItemNum: keyWord == '' ? 30 : 0, keyWord: keyWord
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


        function InitialScenarioRole() {
            $('#SR_RoleTitle').val('');
            $('#SR_CaseNum').val('');
            $('#SR_AssignedUser').tagsinput('removeAll');
        }

        function SearchTaskList() {
            var KeyWord = $('#txt_KeyWord').val();
            ReloadTaskList(KeyWord);
        }

        function TaskListClick(selector) {
            if (selector.hasClass('list-group-item')) {
                selector.addClass('active').siblings().removeClass('active');
            }
            var S_FK_TT_ID = selector.attr('id').substring(8);
            ReloadJQGridScenario(S_FK_TT_ID);
        }

        function AddDialogShow() {
            var rowid = $('#GT_Scenario').jqGrid('getGridParam', 'selrow');
            if (rowid != null) {
                var rowData = $('#GT_Scenario').jqGrid('getRowData', rowid);
                $('#SR_FK_S_ID').val(rowid);
                $('#SR_FK_TT_ID').val(rowData.S_FK_TT_ID);
                $('#TT_TaskStatus').text(rowData.TT_TaskStatus);
                $('#btn_AddRole').show();
                $('#btn_UpdateRole').hide();
                InitialScenarioRole();
                $('#ModalScenarioRole').modal({ backdrop: 'static' }).modal('show');
            }
            else {
                alert("please choose a row in Scenario Table ~ The New Feature\'s Scenario Title will same as the row you selected");
            }
        }
        function AddScenarioRole() {
            SaveScenarioRole('Add');
        }
        function UpdateScenarioRole() {
            //var rowid = $('#GT_ScenarioRole').jqGrid('getGridParam', 'selrow');
            SaveScenarioRole('Update');
        }

        function EditDialogShow() {
            var rowid = $('#GT_ScenarioRole').jqGrid('getGridParam', 'selrow');
            if (rowid == null) {
                alert('please select a row ~');
                return;
            }
            InitialScenarioRole();
            $('#btn_AddRole').hide();
            $('#btn_UpdateRole').show();

            var rowData = $('#GT_ScenarioRole').jqGrid('getRowData', rowid);
            $('#SR_FK_S_ID').val(rowData.SR_FK_S_ID);
            $('#SR_FK_TT_ID').val(rowData.SR_FK_TT_ID);
            $('#SR_ID').val(rowid);

            $('#SR_RoleTitle').val(rowData.SR_RoleTitle);
            $('#SR_CaseNum').val(rowData.SR_CaseNum);
            //$('#SR_AssignedUser').val(rowData.SR_AssignedUser);
            if (rowData.SR_AssignedUser == '' && rowData.SR_AssignedUserName == '') { }
            else {
                var U_IDs = (rowData.SR_AssignedUser.Trim(',')).split(",");
                var U_Names = (rowData.SR_AssignedUserName).split(",");
                //var loopNum = Number(U_IDs.length) >= Number(U_Names.length) ? Number(U_Names.length) : Number(U_IDs.length);
                if (Number(U_IDs.length) == Number(U_Names.length)) {
                    var loopNum = Number(U_IDs.length);
                    for (var i = 0; i < loopNum; i++) {
                        // Number转换和toString()必须加入，否则tagsinput会不识别去重复的功能
                        $('#SR_AssignedUser').tagsinput('add', { "U_ID": Number(U_IDs[i]), "U_nickname": U_Names[i].toString() });
                    }
                }
                else {
                    //$('#SR_AssignedUser').attr('placeholder', 'Dirty Data, Unable to display, please type in new Assigned User, thank you~');
                    alert("Assigned User input -- Dirty Data, Unable to display, please type in new Assigned User, thank you~")
                }
            }
            $('#ModalScenarioRole').modal({ backdrop: 'static' }).modal('show');
        }

        function SaveScenarioRole(Type) {
            var SR_RoleTitle = $('#SR_RoleTitle').val();
            var SR_CaseNum = $('#SR_CaseNum').val();
            var regex = /^\d+$/;
            SR_CaseNum = (SR_CaseNum.length > 0 && regex.test(SR_CaseNum)) ? SR_CaseNum : 0;
            var SR_AssignedUser = ',' + $('#SR_AssignedUser').val() + ','; // 为了精确搜索被指派人
            var SR_AssignedUserObj = $('#SR_AssignedUser').tagsinput('items');
            var SR_FK_S_ID = $('#SR_FK_S_ID').val();
            var SR_FK_TT_ID = $('#SR_FK_TT_ID').val();
            var SR_AssignedUserName = '';
            for (var i = 0; i < SR_AssignedUserObj.length; i++) {
                SR_AssignedUserName += SR_AssignedUserObj[i]["U_nickname"] + ',';
            }
            SR_AssignedUserName = SR_AssignedUserName.substring(0, SR_AssignedUserName.length - 1);
            var TT_TaskStatus = $('#TT_TaskStatus').text();

            if (Type == 'Add') {
                var User_ID = $('#User_ID').text();
                $.post('../ashx/TaskHandler.ashx', {
                    mode: 'AddScenarioRole', SR_RoleTitle: SR_RoleTitle, SR_CaseNum: SR_CaseNum,
                    SR_AssignedUser: SR_AssignedUser, SR_AssignedUserName: SR_AssignedUserName,
                    SR_FK_S_ID: SR_FK_S_ID, SR_FK_TT_ID: SR_FK_TT_ID, User_ID: User_ID, TT_TaskStatus: TT_TaskStatus
                }, function (data, status) {
                    if (data == 'success') {
                        $('#ModalScenarioRole').modal('hide');
                        //alert('Save Data Success ~');
                        ReloadJQGrid(SR_FK_S_ID);
                    }
                    else {
                        alert('Save Data Failed !');
                    }
                });
            }
            else if (Type == 'Update') {
                var SR_ID = $('#SR_ID').val();
                $.post('../ashx/TaskHandler.ashx', {
                    mode: 'UpdateScenarioRole', SR_RoleTitle: SR_RoleTitle, SR_CaseNum: SR_CaseNum,
                    SR_AssignedUser: SR_AssignedUser, SR_AssignedUserName: SR_AssignedUserName,
                    SR_FK_S_ID: SR_FK_S_ID, SR_FK_TT_ID: SR_FK_TT_ID, SR_ID: SR_ID
                }, function (data, status) {
                    if (data == 'success') {
                        $('#ModalScenarioRole').modal('hide');
                        //alert('Save Data Success ~');
                        ReloadJQGrid(SR_FK_S_ID);
                    }
                    else {
                        alert('Save Data Failed !');
                    }
                });
            }
        }

        function DeleteScenarioRole() {
            var rowid = $('#GT_ScenarioRole').jqGrid('getGridParam', 'selrow');
            var rowData = $('#GT_ScenarioRole').jqGrid('getRowData', rowid);
            var SR_FK_S_ID = rowData.SR_FK_S_ID;
            if (rowid == null) {
                alert('please select a row ~');
                return;
            }
            if (confirm('Delete the item now ?')) {
                $.post('../ashx/TaskHandler.ashx', {
                    mode: 'DeleteScenarioRole', SR_ID: rowid
                }, function (data, status) {
                    if (data == 'success') {
                        //alert('Save data success !');
                        ReloadJQGrid(SR_FK_S_ID);
                    }
                    else {
                        alert('Save Data Failed !');
                    }
                });
            }
        }

        // Reload jqGrid
        function ReloadJQGrid(SR_FK_S_ID) {
            $('#GT_ScenarioRole').setGridParam({
                url: '../ashx/TaskHandler.ashx?mode=QueryScenarioRole&SR_FK_S_ID=' + SR_FK_S_ID,
                datatype: 'json',
                page: 1
            }).trigger('reloadGrid');
        }

        function ReloadJQGridScenario(S_FK_TT_ID) {
            $('#GT_Scenario').setGridParam({
                url: '../ashx/TaskHandler.ashx?mode=QueryScenario&S_FK_TT_ID=' + S_FK_TT_ID,
                datatype: 'json',
                page: 1
            }).trigger('reloadGrid');
            ReloadJQGrid(0);
        }

        //去除字符串头尾空格或指定字符  
        String.prototype.Trim = function (c) {
            //if(c==null||c=="")  
            //{  
            //    var str= this.replace('/^/s*/', '');  
            //    var rg = '//s/';  
            //    var i = str.length;  
            //    while (rg.test(str.charAt(--i)));  
            //    return str.slice(0, i + 1);  
            //}  
            //else  
            //{  
            var rg = new RegExp("^" + c + "*");
            var str = this.replace(rg, '');
            rg = new RegExp(c);
            var i = str.length;
            while (rg.test(str.charAt(--i)));
            return str.slice(0, i + 1);
            //}  
        }
    </script>
</asp:Content>
