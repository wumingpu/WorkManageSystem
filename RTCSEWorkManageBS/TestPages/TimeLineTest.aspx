<%@ Page Title="" Language="C#" MasterPageFile="~/MainFrame.Master" AutoEventWireup="true" CodeBehind="TimeLineTest.aspx.cs" Inherits="RTCSEWorkManageBS.TestPages.TimeLineTest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerCSSPlace" runat="server">
    <link href="<%=ResolveUrl("~/dist/css/timeline.css") %>" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Task Board</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-clock-o fa-fw"></i>
                        Time Line Test
                    </div>
                    <div class="panel-body">

                        <ul class="timeline">
                            <li class="timeline-inverted">
                                <div class="timeline-badge"><i class="glyphicon glyphicon-check"></i></div>
                                <div class="timeline-panel">
                                    <div class="timeline-heading">
                                        <h4 class="timeline-title">Mussum ipsum cacilds</h4>
                                        <p><small class="text-muted"><i class="glyphicon glyphicon-time"></i>11 hours ago via Twitter</small></p>
                                    </div>
                                    <div class="timeline-body">
                                        <p>Mussum ipsum cacilds, vidis litro abertis. Consetis adipiscings elitis. Pra lá , depois divoltis porris, paradis. Paisis, filhis, espiritis santis. Mé faiz elementum girarzis, nisi eros vermeio, in elementis mé pra quem é amistosis quis leo. Manduma pindureta quium dia nois paga. Sapien in monti palavris qui num significa nadis i pareci latim. Interessantiss quisso pudia ce receita de bolis, mais bolis eu num gostis.</p>
                                    </div>
                                </div>
                            </li>
                            <li class="timeline-inverted">
                                <div class="timeline-badge danger"><i class="glyphicon glyphicon-credit-card"></i></div>
                                <div class="timeline-panel">
                                    <div class="timeline-heading">
                                        <h4 class="timeline-title">Mussum ipsum cacilds</h4>
                                    </div>
                                    <div class="timeline-body">
                                        <p>Mussum ipsum cacilds, vidis litro abertis. Consetis adipiscings elitis. Pra lá , depois divoltis porris, paradis. Paisis, filhis, espiritis santis. Mé faiz elementum girarzis, nisi eros vermeio, in elementis mé pra quem é amistosis quis leo. Manduma pindureta quium dia nois paga. Sapien in monti palavris qui num significa nadis i pareci latim. Interessantiss quisso pudia ce receita de bolis, mais bolis eu num gostis.</p>
                                    </div>
                                </div>
                            </li>
                            <li class="timeline-inverted">
                                <div class="timeline-badge info"><i class="glyphicon glyphicon-floppy-disk"></i></div>
                                <div class="timeline-panel">
                                    <div class="timeline-heading">
                                        <h4 class="timeline-title">Mussum ipsum cacilds</h4>
                                    </div>
                                    <div class="timeline-body">
                                        <p>Mussum ipsum cacilds, vidis litro abertis. Consetis adipiscings elitis. Pra lá , depois divoltis porris, paradis. Paisis, filhis, espiritis santis. Mé faiz elementum girarzis, nisi eros vermeio, in elementis mé pra quem é amistosis quis leo. Manduma pindureta quium dia nois paga. Sapien in monti palavris qui num significa nadis i pareci latim. Interessantiss quisso pudia ce receita de bolis, mais bolis eu num gostis.</p>
                                        <hr>
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown">
                                                <i class="glyphicon glyphicon-cog"></i><span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu" role="menu">
                                                <li><a href="#">Action</a></li>
                                                <li><a href="#">Another action</a></li>
                                                <li><a href="#">Something else here</a></li>
                                                <li class="divider"></li>
                                                <li><a href="#">Separated link</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li class="timeline-inverted">
                                <div class="timeline-panel">
                                    <div class="timeline-heading">
                                        <h4 class="timeline-title">Mussum ipsum cacilds</h4>
                                    </div>
                                    <div class="timeline-body">
                                        <p>Mussum ipsum cacilds, vidis litro abertis. Consetis adipiscings elitis. Pra lá , depois divoltis porris, paradis. Paisis, filhis, espiritis santis. Mé faiz elementum girarzis, nisi eros vermeio, in elementis mé pra quem é amistosis quis leo. Manduma pindureta quium dia nois paga. Sapien in monti palavris qui num significa nadis i pareci latim. Interessantiss quisso pudia ce receita de bolis, mais bolis eu num gostis.</p>
                                    </div>
                                </div>
                            </li>
                        </ul>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomerJavaScriptPlace" runat="server">
</asp:Content>
