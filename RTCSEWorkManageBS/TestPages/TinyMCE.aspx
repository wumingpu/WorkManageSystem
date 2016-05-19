<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="TinyMCE.aspx.cs" Inherits="RTCSEWorkManageBS.TestPages.TinyMCE" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Tiny MCE Rich Editor + RoxyFileman</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Tiny MCE
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <textarea id="TinyMCEContent"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Data Display
                    </div>
                    <div class="panel-body" id="BI_Content">

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
            //tinymce.init({
            //    selector: "textarea", theme: "modern",
            //    height: 600,
            //    plugins: [
            //         "advlist autolink link image lists charmap print preview hr anchor pagebreak",
            //         "searchreplace wordcount visualblocks visualchars insertdatetime media nonbreaking",
            //         "table contextmenu directionality emoticons paste textcolor code"
            //    ], //responsivefilemanager 
            //    toolbar1: "undo redo | bold italic underline | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | styleselect",
            //    toolbar2: " | link unlink anchor | image media | forecolor backcolor  | print preview code ",
            //    image_advtab: true,//| responsivefilemanager
            //    //external_filemanager_path: "../bower_components/filemanager/",
            //    //filemanager_title: "Responsive Filemanager",
            //    //external_plugins: { "filemanager": "../bower_components/filemanager/plugin.min.js" }
            //    file_browser_callback: RoxyFileBrowser
            //});

            //$.post('../ashx/BugIssueHandler.ashx', { mode: 'GetBugIssueContentSingle', BI_ID: 1 }, function (data) {
            //    var dataJson = $.parseJSON(data);
            //    $('#BI_Content').html(dataJson.BI_Content);
            //});
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
    </script>
</asp:Content>
