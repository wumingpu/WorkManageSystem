<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="ListGroupPaging.aspx.cs" Inherits="RTCSEWorkManageBS.TestPages.ListGroupPaging" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h2 class="page-header">List-Group Paging</h2>
                <%--class="page-header"--%>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-1"></div>
            <div class="col-lg-3">
                <h2>Unpaged list</h2>
                <div class="panel panel-default">
                    <div class="panel-heading">Panel heading</div>
                    <ul class="list-group">
                        <li class="list-group-item">One</li>
                        <li class="list-group-item">Two</li>
                        <li class="list-group-item">Three</li>
                        <li class="list-group-item">Four</li>
                        <li class="list-group-item">Five</li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-3">
                <h2>Paged list</h2>
                <div class="panel panel-default">
                    <div class="panel-heading">Panel heading</div>
                    <ul id="myList" class="list-group"></ul>
                    <ul class="pager">
                        <li class="previous"><a onclick="prevPage(); return false;">«</a></li>
                        <li class="next"><a onclick="nextPage(); return false;">»</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-5"></div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
    <script type="text/javascript">
        var items = '[{"Id":1,"Title":"One"},{"Id":2,"Title":"Two"},{"Id":3,"Title":"Three"},{"Id":4,"Title":"Four"},{"Id":5,"Title":"Five"}]';
        var pager = {};
        pager.items = JSON.parse(items);
        pager.itemsPerPage = 3;
        pagerInit(pager);

        function bindList() {
            var pgItems = pager.pagedItems[pager.currentPage];
            $("#myList").empty();
            for (var i = 0; i < pgItems.length; i++) {
                var option = $('<li class="list-group-item">');
                for (var key in pgItems[i]) {
                    option.html(pgItems[i][key]);
                }
                $("#myList").append(option);
            }
        }
        function prevPage() {
            pager.prevPage();
            bindList();
        }
        function nextPage() {
            pager.nextPage();
            bindList();
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
        $(function () {
            bindList();
        });
    </script>
</asp:Content>
