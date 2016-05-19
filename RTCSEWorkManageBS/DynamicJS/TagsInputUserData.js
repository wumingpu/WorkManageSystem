var JsonData = '[{"U_ID":1,"U_nickname":"Ellin Lv"},{"U_ID":2,"U_nickname":"Chen Chen"},{"U_ID":3,"U_nickname":"Guoxia Ma"},{"U_ID":4,"U_nickname":"Huichen Wang"},{"U_ID":5,"U_nickname":"Nina Cao"},{"U_ID":6,"U_nickname":"Peilin Zhang"},{"U_ID":7,"U_nickname":"Peng Zhang"},{"U_ID":8,"U_nickname":"Rui Dong"},{"U_ID":9,"U_nickname":"Walden Li"},{"U_ID":10,"U_nickname":"Wendy Wen Wen"},{"U_ID":11,"U_nickname":"Wenrong Chen"},{"U_ID":12,"U_nickname":"Yae Guo"},{"U_ID":13,"U_nickname":"Mingpu Wu"}]'
UserData = new Bloodhound({
    local: $.parseJSON(JsonData),
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('U_nickname'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
});
UserData.initialize();

function InitialTagsInputUser(selector, maxTagNum) {
    if (maxTagNum == '') {
        maxTagNum = 100;
    }
    selector.off().on().tagsinput({
        itemValue: 'U_ID',
        itemText: 'U_nickname',
        maxTags: maxTagNum,
        freeInput: false,
        typeaheadjs: {
            name: 'UserData',
            displayKey: 'U_nickname',
            source: UserData.ttAdapter()
        }
    });
}
