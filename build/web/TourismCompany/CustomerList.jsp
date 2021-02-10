<%-- 
    Document   : CustomerList
    Created on : Apr 13, 2020, 1:00:11 PM
    Author     : fhfai
--%>

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
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
                integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
                integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
                integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    </head>
    <body>
        <%
//            response.setHeader("Cache-Control", "no-cache, no-store");
//            response.setHeader("Pragma", "no-cache");
//            response.setDateHeader("Expires", 0); 

//            String companyEmail = null;
//            if (session.getAttribute("companyEmail") == null) {
//                response.sendRedirect("../index.jsp");
//            } else {
//                companyEmail = (String) session.getAttribute("companyEmail");
//            }
            String companyEmail = (String) session.getAttribute("companyEmail");
            TourismCompanyDao tcd = new TourismCompanyDao();
            TourismCompanyBean tcb = tcd.oneTourismCompany(companyEmail);
        %>

        <div class="tchpage"></div>
        <jsp:include page="../header.jsp" flush="true"/>
        <div class="container tch" style="font-size: 20px;">
            <div class="tchprofile">
                <div class="row">
                    <div class="col-md-12 mt-2 mb-2" style="background-color: #1B5360; padding: 10px; height: 334px;">
                        <img src="data:image/jpg;base64,<%= tcb.getCompanyImg()%>" alt="cover page"/>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <form action="tourismCompanyCtrl" method="post">
                            <h3 style="display: inline"><%= tcb.getCompanyName()%> <button class="iconbutton" type="submit"><i class="fa fa-user tchicon"></i></button></h3>
                            <input type="hidden" name="action" value="editForm"/>
                            <input type="hidden" name="companyEmail" value="<%= tcb.getCompanyEmail()%>"/>
                        </form>
                    </div>
                </div>

                <!-- customerList -->
                <div class="row" id="customerList">
                    <div class="col mb-2 mt-5">
                        <h3 style="display: inline">New Ticket List <button class="iconbutton" type="submit"><i class="fa fa-address-card tchicon"></i></button></h3>
                    </div>
                </div> 
                <div class="row">
                    <%
                        BookingTicketDao btd = new BookingTicketDao();
                        List<BookingTicketBean> allBtb = btd.allbookingTicketByCompID(tcb.getCompanyID());
                    %>
                    <div class="col-md-12 card" style="padding: 10px; box-shadow: 1px 1px 5px #777;">
                        <div style="overflow-x: auto">
                            <table class="table table-striped dataTable" id="bookTable">
                                <thead>
                                    <tr>
                                        <th>Ticket</th>
                                        <th>Name</th>
                                        <th>Phone</th>
                                        <th>From</th>
                                        <th>To</th>
                                        <th><span data-toggle="tooltip" data-placement="top" title="Adult : Child : Infant">Ticket</span></th>
                                        <th>Date</th>
                                        <th>Time</th>
                                        <th>Payment</th>
                                        <th>Receipt</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < allBtb.size(); i++) {
                                    %>

                                    <tr>
                                        <td><%= allBtb.get(i).getBookID()%></td>
                                        <td><%= allBtb.get(i).getCustID().getCustFirstName()%></td>
                                        <td><%= allBtb.get(i).getCustID().getCustPhone()%></td>
                                        <td><%= allBtb.get(i).getServiceID().getFromLocation()%></td>
                                        <td><%= allBtb.get(i).getServiceID().getToLocation()%></td>
                                        <td><%= allBtb.get(i).getBookAdult()%>:<%= allBtb.get(i).getBookChild()%>:<%= allBtb.get(i).getBookInfant()%><br></td>
                                        <td><%= allBtb.get(i).getDepartDate()%></td>
                                        <td><%= allBtb.get(i).getServiceID().getDepartureTime()%></td>
                                        <td><%= allBtb.get(i).getReferenceNo().getPaymentAmount()%></td>
                                        <td>
                                            <a href="TourismCompany/Receipt.jsp?referenceNo=<%= allBtb.get(i).getReferenceNo().getReferenceNo()%>" target="_blank">View</a><br>
                                            <a download="<%= allBtb.get(i).getBookID()%><%= allBtb.get(i).getCustID().getCustFirstName()%>" href="data:application/pdf;base64,<%= allBtb.get(i).getReferenceNo().getPaymentReceipt()%>">Download</a>
                                        </td>
                                        <td>
                                            <form style="display:inline" action="bookingTicketCtrl" method="post">
                                                <input type="hidden" name="action" value="updateStatus"/>
                                                <input type="hidden" name="bookID" value="<%= allBtb.get(i).getBookID()%>"/>
                                                <input type="hidden" name="check" value="Check"/>
                                                <button type="submit" class="iconbutton" data-toggle="tooltip" data-placement="right" title="Check"><i class="fa fa-check"></i></button>
                                            </form>
<!--                                            <form style="display:inline" action="bookingTicketCtrl" method="post">
                                                <input type="hidden" name="action" value="deleteBookingTicket"/>
                                                <input type="hidden" name="bookID" value="<%= allBtb.get(i).getBookID()%>"/>
                                                <input type="hidden" name="referenceNo" value="<%= allBtb.get(i).getReferenceNo().getReferenceNo()%>"/>
                                                <button type="submit" class="iconbutton" data-toggle="tooltip" data-placement="right" title="Delete"><i class="fa fa-trash" onclick="return deleteConfirmation()"></i></button>
                                            </form>-->
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

                <!-- CheckedList -->
                <div class="row" id="checkedList">
                    <div class="col mb-2 mt-5">
                        <h3 style="display: inline">Used Ticket List <button class="iconbutton" type="submit"><i class="fa fa-address-card tchicon"></i></button></h3>
                    </div>
                    <div class="form-group has-search">
                        <span class="fa fa-search form-control-feedback"></span>
                        <input id="checkedBookIDInput" onKeyup="SearchCheckedBookID()" type="text" class="form-control" placeholder="BookID">
                    </div>
                </div> 
                <div class="row">
                    <%
                        btd = new BookingTicketDao();
                        allBtb = btd.allCheckbookingTicketByCompID(tcb.getCompanyID());
                    %>
                    <div class="col-md-12 card" style="padding: 10px; box-shadow: 1px 1px 5px #777;">
                        <div style="overflow-x: auto">
                            <table class="table table-striped dataTable" id="checkedBookTable">
                                <thead>
                                    <tr>
                                        <th>Ticket</th>
                                        <th>Name</th>
                                        <th>Phone</th>
                                        <th>From</th>
                                        <th>To</th>
                                        <th><span data-toggle="tooltip" data-placement="top" title="Adult : Child : Infant">Ticket</span></th>
                                        <th>Date</th>
                                        <th>Time</th>
                                        <th>Payment</th>
                                        <th>Receipt</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < allBtb.size(); i++) {
                                    %>
                                    <tr>
                                        <td><%= allBtb.get(i).getBookID()%></td>
                                        <td><%= allBtb.get(i).getCustID().getCustFirstName()%></td>
                                        <td><%= allBtb.get(i).getCustID().getCustPhone()%></td>
                                        <td><%= allBtb.get(i).getServiceID().getFromLocation()%></td>
                                        <td><%= allBtb.get(i).getServiceID().getToLocation()%></td>
                                        <td><%= allBtb.get(i).getBookAdult()%>:<%= allBtb.get(i).getBookChild()%>:<%= allBtb.get(i).getBookInfant()%><br></td>
                                        <td><%= allBtb.get(i).getDepartDate()%></td>
                                        <td><%= allBtb.get(i).getServiceID().getDepartureTime()%></td>
                                        <td><%= allBtb.get(i).getReferenceNo().getPaymentAmount()%></td>
                                        <td>
                                            <a href="TourismCompany/Receipt.jsp?referenceNo=<%= allBtb.get(i).getReferenceNo().getReferenceNo()%>" target="_blank">View</a><br>
                                            <a download="<%= allBtb.get(i).getBookID()%><%= allBtb.get(i).getCustID().getCustFirstName()%>" href="data:application/pdf;base64,<%= allBtb.get(i).getReferenceNo().getPaymentReceipt()%>">Download</a>
                                        </td>
                                        <td>
                                            <form style="display:inline" action="bookingTicketCtrl" method="post">
                                                <input type="hidden" name="action" value="updateStatus"/>
                                                <input type="hidden" name="bookID" value="<%= allBtb.get(i).getBookID()%>"/>
                                                <input type="hidden" name="check" value="Uncheck" />
                                                <button type="submit" class="iconbutton" data-toggle="tooltip" data-placement="right" title="Uncheck"><i class="fa fa-times"></i></button>
                                            </form>
                                            <form style="display:inline" action="bookingTicketCtrl" method="post">
                                                <input type="hidden" name="action" value="deleteBookingTicket"/>
                                                <input type="hidden" name="bookID" value="<%= allBtb.get(i).getBookID()%>"/>
                                                <input type="hidden" name="referenceNo" value="<%= allBtb.get(i).getReferenceNo().getReferenceNo()%>"/>
                                                <button type="submit" class="iconbutton" data-toggle="tooltip" data-placement="right" title="Delete" onclick="return deleteConfirmation()"><i class="fa fa-trash"></i></button>
                                            </form>
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
        <div>
            <jsp:include page="../footer.jsp" flush="true"/>
        </div>
        <script>
            $(document).ready(function () {
                $('[data-toggle="tooltip"]').tooltip();
            });

            function SearchBookID() {
                var input, filter, table, tr, td, i, txtValue;
                input = document.getElementById("bookIDInput");
                filter = input.value.toUpperCase();
                table = document.getElementById("bookTable");
                tr = table.getElementsByTagName("tr");
                for (i = 0; i < tr.length; i++) {
                    td = tr[i].getElementsByTagName("td")[0];
                    if (td) {
                        txtValue = td.textContent || td.innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }

            function SearchCheckedBookID() {
                var input, filter, table, tr, td, i, txtValue;
                input = document.getElementById("checkedBookIDInput");
                filter = input.value.toUpperCase();
                table = document.getElementById("checkedBookTable");
                tr = table.getElementsByTagName("tr");
                for (i = 0; i < tr.length; i++) {
                    td = tr[i].getElementsByTagName("td")[0];
                    if (td) {
                        txtValue = td.textContent || td.innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }

            $(document).ready(function () {
                $('.dataTable').DataTable({
                    "order": [[0, "desc"]],
                    "lengthMenu": [[5, 25, 50, -1], [5, 25, 50, "All"]]
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

            function deleteConfirmation() {
                var x = confirm("Press OK to delete.");
                if (x)
                    return true;
                else
                    return false;
            }
        </script>
    </body>
</html>