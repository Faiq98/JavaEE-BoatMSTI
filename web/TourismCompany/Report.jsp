<%-- 
    Document   : CustomerList
    Created on : Apr 13, 2020, 1:00:11 PM
    Author     : fhfai
--%>

<%@page import="com.bean.ReportBean"%>
<%@page import="com.bean.FeedbackBean"%>
<%@page import="com.dao.FeedbackDao"%>
<%@page import="com.dao.ReportDao"%>
<%@page import="com.dao.BookingTicketDao"%>
<%@page import="java.util.List"%>
<%@page import="com.bean.BookingTicketBean"%>
<%@page import="com.bean.TourismCompanyBean"%>
<%@page import="com.dao.TourismCompanyDao"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>BoatMSTI</title>

        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
              integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
        <!--        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
                        integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
                crossorigin="anonymous"></script>-->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
                integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
                integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
        <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
    </head>
    <body>
        <%
            String companyEmail = (String) session.getAttribute("companyEmail");
            TourismCompanyDao tcd = new TourismCompanyDao();
            TourismCompanyBean tcb = tcd.oneTourismCompany(companyEmail);
        %>

        <div class="tchpage"></div>
        <jsp:include page="../header.jsp" flush="true"/>
        <div class="container tch" style="font-size: 20px;">
            <div class="tchprofile">
                <%
                    ReportDao rd = new ReportDao();
                    String dataPoints = rd.generateReport(tcb.getCompanyID());
                %>
                <div class="row">
                    <div class="col-md-8">
                        <div class="card mt-3" style="padding: 10px; box-shadow: 1px 1px 5px #777;">
                            <div id="chartContainer" style="height: 220px; width: 100%;"></div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="row justify-content-center" style="font-size: 15px;">
                            <div class="card border-success mb-3 mt-3" style="box-shadow: 1px 1px 5px #777;">
                                <div class="card-header">Sales (RM)</div>
                                <div class="card-body text-success">
                                    <div class="row">
                                        <div class="col">Total</div>
                                        <div class="col"><%= rd.getTotalSales(tcb.getCompanyID())%></div>
                                        |
                                        <div class="col">Monthly</div>
                                        <div class="col"><%= rd.getMonthlySales(tcb.getCompanyID())%></div>                            
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-center" style="font-size: 15px;">
                            <div class="card border-primary mb-3" style="box-shadow: 1px 1px 5px #777;">
                                <div class="card-header">Customers</div>
                                <div class="card-body text-primary">
                                    <div class="row">
                                        <div class="col">Total</div>
                                        <div class="col"><%= rd.getTotalCustomer(tcb.getCompanyID())%></div>
                                        |
                                        <div class="col">Monthly</div>
                                        <div class="col"><%= rd.getMonthlyCustomer(tcb.getCompanyID())%></div>                            
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--            <div class="text-center" style="white-space: nowrap; overflow-x: auto; font-size: 15px;">
                            <div class="card border-primary mb-3 mt-3" style=" display: inline-block; box-shadow: 1px 1px 5px #777;">
                                <div class="card-header">Customers</div>
                                <div class="card-body text-primary">
                                    <div class="row">
                                        <div class="col">Total :</div>
                                        <div class="col">7543543</div>
                                        |
                                        <div class="col">This Month :</div>
                                        <div class="col">75435</div>                            
                                    </div>
                                </div>
                            </div>
                            <div class="card border-success mb-3 mt-3" style=" display: inline-block; box-shadow: 1px 1px 5px #777;">
                                <div class="card-header">Sales</div>
                                <div class="card-body text-success">
                                    <div class="row">
                                        <div class="col">Total :</div>
                                        <div class="col">7543543</div>
                                        |
                                        <div class="col">This Month :</div>
                                        <div class="col">75435</div>                            
                                    </div>
                                </div>
                            </div>
                        </div>-->

            <div class="row">
                <div class="col-md-7">

                    <!-- Monthly Report -->
                    <div class="row" id="boatInfo">
                        <div class="col mb-2 mt-3">
                            <h3 style="display: inline">Monthly Report <button class="iconbutton" type="button" data-toggle="modal" data-toggle="tooltip" data-placement="right" title="View sales trend" data-target="#myModal"><i class="fa fa-line-chart tchicon"></i></button></h3>
                        </div>
                    </div>

                    <div class="row">
                        <%
                            List<ReportBean> allRb = rd.displayReport(tcb.getCompanyID());
                        %>
                        <div class="col card" style="margin: 5px; padding: 10px; box-shadow: 1px 1px 5px #777; font-size: 15px; height: 470px">
                            <div style="overflow-x: auto;">
                                <table class="table table-striped dataTable2">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Date</th>
                                            <th>Customer</th>
                                            <th>Sales</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for (int i = 0; i < allRb.size(); i++) {
                                        %>
                                        <tr>
                                            <td><%= allRb.get(i).getReportID()%></td>
                                            <td><%= allRb.get(i).getReportDate()%></td>
                                            <td><%= allRb.get(i).getTotalCustomer()%></td>
                                            <td><%= allRb.get(i).getSales()%></td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <form action="reportCtrl" method="post">
                        <div class=" grnBtn mt-2">
                            <input type="hidden" name="companyID" value="<%= tcb.getCompanyID()%>"/>
                            <input type="hidden" name="action" value="addReport"/>
                            <input type="hidden" name="totalCustomer" value="<%= rd.getMonthlyCustomer(tcb.getCompanyID())%>"/>
                            <input type="hidden" name="sales" value="<%= rd.getMonthlySales(tcb.getCompanyID())%>"/>
                            <button type="submit" class="btn btn-block">Update Report</button>
                        </div>
                    </form>
                </div>

                <div class="col-md-5">
                    <!-- Feedback -->
                    <div class="row" id="boatInfo">
                        <div class="col mb-2 mt-3">
<!--                            <form action="boatCtrl" method="post">-->
                                <h3 style="display: inline">Feedback <button class="iconbutton" type="submit"><i class="fa fa-star tchicon"></i></button></h3>
<!--                                <input type="hidden" name="action" value="addBoatForm"/>
                                <input type="hidden" name="companyID" value="<%= tcb.getCompanyID()%>"/>
                            </form>-->
                        </div>
                    </div> 
                    <div class="row">
                        <%
                            FeedbackDao fd = new FeedbackDao();
                            List<FeedbackBean> allFb = fd.displayFeedback(tcb.getCompanyID());
                        %>
                        <div class="col card" style="margin: 5px; padding: 10px; box-shadow: 1px 1px 5px #777; font-size: 15px; height: 530px">
                            <div style="overflow-x: auto;">
                                <table class="table table-striped dataTable">
                                    <thead>
                                        <tr>
                                            <th hidden>ID</th>
                                            <th>Rate</th>
                                            <th>Feedback</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for (int i = 0; i < allFb.size(); i++) {
                                        %>
                                        <tr>
                                            <td hidden><%= allFb.get(i).getFeedbackID()%></td>
                                            <td class="text-center"><%= allFb.get(i).getFeedbackRating()%></td>
                                            <td>
                                                <b><%= allFb.get(i).getTopicID().getTopic()%></b> <span style="float: right"><%= allFb.get(i).getFeedbackDate()%></span><br>
                                                <span style="font-family: monospace; font-size: 12px;"><%= allFb.get(i).getServiceID().getServiceName()%></span><br>
                                                <%= allFb.get(i).getFeedbackCustomer()%>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <%
                String salesTrend = rd.salesTrend(tcb.getCompanyID());
            %>
            <div class="modal fade" id="myModal" role="dialog">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Sales Trend</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div id="chartContainer2" style="height: 220px; width: 100%;"></div>
                        </div>
                        <div class="modal-footer">
                            <button style="background-color: #8E1600; color: white;" type="button" data-dismiss="modal" class="btn btn-block" >Close</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Edit Report Modal -->
            <div class="modal fade" id="editReport" role="dialog">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Edit Report</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="javaquery"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Edit Report Modal -->

        </div>
        <div>
            <jsp:include page="../footer.jsp" flush="true"/>
        </div>
        <script>
            $(document).ready(function () {
                $('[data-toggle="tooltip"]').tooltip();

                $('.dataTable').DataTable({
                    "order": [[0, "desc"]],
                    "lengthMenu": [[4, 5, 25, 50, -1], [4, 5, 25, 50, "All"]]
                            //                    columnDefs: [{
                            //                            targets: [0],
                            //                            orderData: [0, 1]
                            //                        }, {
                            //                            targets: [1],
                            //                            orderData: [1, 0]
                            //                        }, {
                            //                            targets: [4],
                            //                            orderData: [4, 0]
                            //                        }]
                });

                //datatable2
                $('.dataTable2').DataTable({
                    "order": [[0, "desc"]],
                    "lengthMenu": [[8, 25, 50, -1], [8, 25, 50, "All"]]
                            //                    columnDefs: [{
                            //                            targets: [0],
                            //                            orderData: [0, 1]
                            //                        }, {
                            //                            targets: [1],
                            //                            orderData: [1, 0]
                            //                        }, {
                            //                            targets: [4],
                            //                            orderData: [4, 0]
                            //                        }]
                });
            });

            $(function () {
            <%if (dataPoints != null) {%>
                var chart = new CanvasJS.Chart("chartContainer", {
                    theme: "light2",
                    zoomEnabled: true,
                    animationEnabled: true,
                    title: {
                        text: "Customer Trip"
                    },

                    axisX: {
                        title: "Islands"
                    },

                    axisY: {
                        title: "Customer"
                    },

                    data: [
                        {
                            type: "column",
                            dataPoints: <%out.print(dataPoints);%>
                        }
                    ]
                });

                chart.render();
            <%}%>

            <%if (salesTrend != null) {%>
                var chart = new CanvasJS.Chart("chartContainer2", {
                    theme: "light2",
                    zoomEnabled: true,
                    animationEnabled: true,
                    axisX: {
                        title: "Date"
                    },

                    axisY: {
                        title: "Sales"
                    },

                    data: [
                        {
                            type: "line",
                            dataPoints: <%out.print(salesTrend);%>
                        }
                    ]
                });

                $('#myModal').on('shown.bs.modal', function () {
                    chart.render();
                });
            <%}%>
            });

            function deleteConfirmation() {
                var x = confirm("Press OK to delete.");
                if (x)
                    return true;
                else
                    return false;
            }

            $('#editReport').on('show.bs.modal', function (e) {
                var reportID = $(e.relatedTarget).attr('data-reportID');
                console.log(reportID);
                $.get("TourismCompany/EditReport.jsp", {reportID: reportID}, function (data) {
                    $(".javaquery").html(data);
                });
            });
        </script>
    </body>
</html>