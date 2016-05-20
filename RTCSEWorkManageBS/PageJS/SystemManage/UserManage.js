$.jgrid.defaults.responsive = true;
$.jgrid.defaults.styleUI = 'Bootstrap';

$(document).ready(function () {
    // JQGrid options
    $('#GT_User').jqGrid({
        url: '../ashx/SystemManageHandler.ashx?mode=QueryUserList',
        datatype: "json",
        colModel: [
            { label: 'ID', name: 'U_ID', key: true, hidden: true },
            { label: 'Username', name: 'U_username', width: 150 },
            { label: 'Nick Name', name: 'U_nickname', width: 150 },
            { label: 'Mail Box', name: 'U_mailbox', width: 150 },
            { label: 'Role', name: 'U_Role', width: 150 },
            { label: 'Power', name: 'U_PowerDisplay', width: 80 }
        ],
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
    $('#GT_User').navGrid("#jqGridPager", {
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

    $('[type=radio]').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
    });
    $('[name=RoleItem]').on('ifChecked', function (event) {
        $('#U_Role').val(this.value);//alert(this.value);
    });
    $('[name=PowerItem]').on('ifChecked', function (event) {
        $('#U_Power').val(this.value);//alert(this.value);
    });
});

function InitialUserInfoModal() {
    $('#U_username').val('');
    $('#U_nickname_UM').val('');
    $('#U_mailbox').val('');
    $('#U_Comments').val('');
    $('[type=radio]').iCheck('uncheck');
    $('#U_Role').val('*');
    $('#U_Power').val('*');
}
function AddDialogShow() {
    $('#btn_AddUser').show();
    $('#btn_UpdateUser').hide();
    InitialUserInfoModal();
    $('#ModalUserInfo').modal({ backdrop: 'static' }).modal('show');
}
function EditDialogShow() {
    $('#btn_AddUser').hide();
    $('#btn_UpdateUser').show();
    var rowid = $('#GT_User').jqGrid('getGridParam', 'selrow');
    if (rowid == null) {
        alert('please select a row ~');
        return;
    }
    InitialUserInfoModal();
    $('#U_ID').val(rowid);
    $.post('../ashx/SystemManageHandler.ashx', {
        mode: 'GetUserInfoSingle', U_ID: rowid
    }, function (data, status) {
        var dataJSON = $.parseJSON(data);
        $('#U_username').val(dataJSON.U_username);
        $('#U_nickname_UM').val(dataJSON.U_nickname);
        $('#U_mailbox').val(dataJSON.U_mailbox);
        $('#U_Role').val(dataJSON.U_Role);
        $('#U_Power').val(dataJSON.U_power);
        $('#U_Comments').val(dataJSON.U_Comments);
        $('[value=' + dataJSON.U_Role + ']').iCheck('check');
        $('[value=' + dataJSON.U_power + ']').iCheck('check');
    });
    $('#ModalUserInfo').modal({ backdrop: 'static' }).modal('show');
}
function DeleteUser() {
    var rowid = $('#GT_User').jqGrid('getGridParam', 'selrow');
    if (rowid == null) {
        alert('please select a row ~');
        return;
    }
    if (confirm('Delete the item now ?')) {
        $.post('../ashx/SystemManageHandler.ashx', {
            mode: 'DeleteUserInfo', U_ID: rowid
        }, function (data, status) {
            if (data == 'success') {
                //alert('Delete Data Success ~');
                ReloadJQGrid();
            }
            else {
                alert('Delete Data Failed !');
            }
        });
    }
}

function SaveUserInfo(Type) {
    var U_username = $('#U_username').val();
    if (!EmptyWarning('U_username', 'Alias')) { return; };
    var U_nickname = $('#U_nickname_UM').val();
    if (!EmptyWarning('U_nickname_UM', 'Nick Name')) { return; };
    var U_mailbox = $('#U_mailbox').val();
    if (!EmptyWarning('U_mailbox', 'Mail Box')) { return; };
    var U_Role = $('#U_Role').val();
    var U_power = $('#U_Power').val();
    if (U_Role == '*' || U_power == '*') {
        alert("please Selete the \'User Role\' and \'User Power\'");
        return;
    }
    var U_Comments = $('#U_Comments').val();
    if (Type == 'Add') {
        $.post('../ashx/SystemManageHandler.ashx', {
            mode: 'AddUserInfo', U_username: U_username, U_nickname: U_nickname,
            U_mailbox: U_mailbox, U_Role: U_Role, U_power: U_power,
            U_Comments: U_Comments
        }, function (data, status) {

            if (data == 'success') {
                //alert('Save Data Success ~');
                ReloadJQGrid();
                $('#ModalUserInfo').modal('hide');
            }
            else if (data == 'exist') {
                alert('The User Name has Exist, please chanage to anthor one ~');
                $('#U_username').val('');
                $('#U_username').focus();
            }
            else {
                alert('Save Data Failed !');
            }
        });
    }
    else if (Type == 'Update') {
        var U_ID = $('#U_ID').val();
        $.post('../ashx/SystemManageHandler.ashx', {
            mode: 'UpdateUserInfo', U_ID: U_ID, U_username: U_username,
            U_nickname: U_nickname, U_mailbox: U_mailbox, U_Role: U_Role,
            U_power: U_power, U_Comments: U_Comments
        }, function (data, status) {
            if (data == 'success') {
                //alert('Update Data Success ~');
                ReloadJQGrid();
                $('#ModalUserInfo').modal('hide');
            }
            else if (data == 'exist') {
                alert('The User Name has Exist, please chanage to anthor one ~');
                $('#U_username').val('');
                $('#U_username').focus();
            }
            else {
                alert('Update Data Failed !');
            }
        });
    }
}

// Reload jqGrid
function ReloadJQGrid() {
    $('#GT_User').setGridParam({
        url: '../ashx/SystemManageHandler.ashx?mode=QueryUserList',
        datatype: 'json'
    }).trigger('reloadGrid');
}

function EmptyWarning(strFieldName, strFieldNickName) {
    if ($('#' + strFieldName + '').val() == "") {
        alert(strFieldNickName + " Can not Empty !");
        $('#' + strFieldName + '').focus();
        return false;
    }
    else {
        return true;
    }
}