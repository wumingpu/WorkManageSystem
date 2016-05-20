$(document).ready(function () {
    LoadSeasonCaseTotal();
    LoadLSHFCaseNum('');
    LoadLSMUCaseNum('');
    LoadLSE2ECaseNum('');
    LoadLCE2ECaseNum('');
    LoadLMCaseNum('');
});

function LoadSeasonCaseTotal() {
    $.post('../ashx/QBRHandler.ashx', {
        mode: 'GetSeasonTotalCaseno'
    }, function (data) {
        var dataJSON = $.parseJSON(data);
        var CaseTarget = $('#SeasonCaseTarget').text();
        var CaseRunned = dataJSON.CaseNo;
        $('#SeasonCaseRuned').html(CaseRunned);
        $('#SeasonCaseProgress').html(((Number(CaseRunned) / Number(CaseTarget)) * 100).toFixed(2) + '%');
    });
}

function LoadLSHFCaseNum(Year) {
    $.post('../ashx/QBRHandler.ashx', {
        mode: 'GetHFSeasonReleaseCaseno', Year: Year
    }, function (data, status) {
        var dataJSON = $.parseJSON(data);
        for (var i in dataJSON) {
            $('#LS_HF_' + dataJSON[i].SeasonNum + 'S_' + dataJSON[i].TT_Release).html(dataJSON[i].CaseNo);
        }
    });
}

function LoadLSMUCaseNum(Year) {
    $.post('../ashx/QBRHandler.ashx', {
        mode: 'GetMUSeasonReleaseCaseno', Year: Year
    }, function (data) {
        var dataJSON = $.parseJSON(data);
        for (var i in dataJSON) {
            $('#LS_MU_' + dataJSON[i].SeasonNum + 'S_' + dataJSON[i].TT_Release).html(dataJSON[i].CaseNo);
        }
    });
}

function LoadLSE2ECaseNum(Year) {
    $.post('../ashx/QBRHandler.ashx', {
        mode: 'GetE2ESeasonReleaseCaseno', Year: Year
    }, function (data) {
        var dataJSON = $.parseJSON(data);
        for (var i in dataJSON) {
            $('#LS_E2E_' + dataJSON[i].SeasonNum + 'S_' + dataJSON[i].TT_Release).html(dataJSON[i].CaseNo);
        }
    });
}

function LoadLCE2ECaseNum(Year) {
    $.post('../ashx/QBRHandler.ashx', {
        mode: 'GetClientE2ESeasonReleaseCaseno', Year: Year
    }, function (data) {
        var dataJSON = $.parseJSON(data);
        for (var i in dataJSON) {
            $('#LC_E2E_' + dataJSON[i].SeasonNum + 'S_' + dataJSON[i].TT_Release).html(dataJSON[i].CaseNo);
        }
    });
}

function LoadLMCaseNum(Year) {
    $.post('../ashx/QBRHandler.ashx', {
        mode: 'GetLMSeasonReleaseCaseno', Year: Year
    }, function (data) {
        var dataJSON = $.parseJSON(data);
        for (var i in dataJSON) {
            $('#LM_' + dataJSON[i].SeasonNum + 'S');
        }
    });
}