<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="RagulaTest.aspx.cs" Inherits="RTCSEWorkManageBS.TestPages.RagulaTest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <link href="<%=ResolveUrl("~/bower_components/dragula/dist/dragula.css") %>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/dist/css/w3card.css") %>" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Ragula + W3 CSS simple Task DashBoard</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-4">
                <div class="panel panel-warning">
                    <div class="panel-heading">
                        TO-DO
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body" id="LeftPanel">
                        <%--<div>You can move these elements between these two containers</div>
                        <div>Moving them anywhere else isn't quite possible</div>
                        <div>
                            Anything can be moved around. That includes images, <a href='https://github.com/bevacqua/dragula'>links</a>, or any other nested elements.
                        </div>--%>
                        <div class="w3-card-4">
                            <header class="w3-container w3-blue">
                                <h5>Task 1</h5>
                            </header>
                            <div class="w3-container">
                                <p>this is the first task</p>
                                <p>Assign to : Mingpu Wu</p>
                                <p>Comments : asdf asdfasd fasdf asdf asdf asdfas dfas dfasdfas dfasdfa sdfas dasdf</p>
                                <p>Comments++ : asdf asdfasd fasdf asdf asdf asdfas dfas dfasdfas dfasdfa sdfas dasdf</p>
                                <p>
                                    <button class="w3-btn w3-dark-grey">Button</button>
                                </p>
                            </div>
                        </div>
                        <div class="w3-card-4">
                            <header class="w3-container w3-blue">
                                <h5>Task 2</h5>
                            </header>
                            <div class="w3-container">
                                <p>this is the second task</p>
                                <p>Assign to : Ellin Lv</p>
                                <p>Comments : ghjkghj kghjkg hjkghjkgh jkghj kghjkg hjkg hjk ghjghk</p>
                                <p>
                                    <button class="w3-btn w3-dark-grey">Button</button>
                                </p>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel-body -->
                </div>
            </div>
            <!-- /.panel-left -->
            <div class="col-lg-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Doing
                    </div>
                    <div class="panel-body" id="MiddlePanel">
                        <div class="w3-card-4">
                            <header class="w3-container w3-pink">
                                <h5>Task 3</h5>
                            </header>
                            <div class="w3-container">
                                <p>this is the second task</p>
                                <p>Assign to : Chen Chen</p>
                                <p>Comments : ghjkghj kghjkg hjkghjkgh jkghj kghjkg hjkg hjk ghjghk</p>
                                <p>
                                    <button class="w3-btn w3-dark-grey">Button</button>
                                </p>
                            </div>
                        </div>
                        <div class="w3-card-4">
                            <header class="w3-container w3-light-blue">
                                <h5>Task 4</h5>
                            </header>
                            <div class="w3-container">
                                <p>this is the second task</p>
                                <p>Assign to : Huichen Wang</p>
                                <p>Comments : ghjkghj kghjkg hjkghjkgh jkghj kghjkg hjkg hjk ghjghk</p>
                                <p>
                                    <button class="w3-btn w3-green">Button</button>
                                </p>
                            </div>
                        </div>
                        <div class="w3-card-4">
                            <header class="w3-container w3-cyan">
                                <h5>Task 5</h5>
                            </header>
                            <div class="w3-container">
                                <p>this is the second task</p>
                                <p>Assign to : Ellin Lv</p>
                                <p>Comments : ghjkghj kghjkg hjkghjkgh jkghj kghjkg hjkg hjk ghjghk</p>
                                <p>
                                    <button class="w3-btn w3-dark-grey">Button</button>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.panel-mid -->
            <div class="col-lg-4">
                <div class="panel panel-success">
                    <div class="panel-heading">
                        Done
                    </div>
                    <div class="panel-body" id="RightPanel">
                        <div class="w3-card-4">
                            <header class="w3-container w3-cyan">
                                <h5>Task 6</h5>
                            </header>
                            <div class="w3-container">
                                <p>this is the second task</p>
                                <p>Assign to : Ellin Lv</p>
                                <p>Comments : ghjkghj kghjkg hjkghjkgh jkghj kghjkg hjkg hjk ghjghk</p>
                                <p>
                                    <button class="w3-btn w3-dark-grey">Button</button>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.panel-right -->
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Drag Event Log
                    </div>
                    <div class="panel-body" id="DragLog">
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <script type="text/ecmascript" src="<%=ResolveUrl("~/bower_components/dragula/dist/dragula.min.js") %>"></script>
    <script>
        $(document).ready(function () {
            dragula([document.getElementById('LeftPanel'), document.getElementById('MiddlePanel'), document.getElementById('RightPanel')])
              .on('drag', function (el, container) {
                  //el.className = el.className.replace('ex-moved', '');
                  AddDragLog("Drag event -- el.id:" + el.id + " -- container:" + container.id);
              })
              .on('drop', function (el, container) {
                  //el.className += ' ex-moved';
                  AddDragLog("Drop event -- el.id:" + el.id + " -- container:" + container.id);
              });
              //.on('over', function (el, container) {
              //    //container.className += ' ex-over';
              //    AddDragLog("over event -- container:" + container.id);
              //})
              //.on('out', function (el, container) {
              //    //container.className = container.className.replace('ex-over', '');
              //    AddDragLog("out event -- container:" + container.id);
              //});
            //dragula([, document.getElementById('MiddlePanel')]);
        });
        function AddDragLog(LogContent) {
            $('#DragLog').append("<div class=\"w3-card\"><p>" + LogContent + "</p></div>")
        }
    </script>
</asp:Content>
