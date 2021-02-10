<%-- 
    Document   : BookingTicket
    Created on : Apr 5, 2020, 3:41:56 PM
    Author     : fhfai
--%>

<%@page import="com.bean.CustomerBean"%>
<%@page import="com.dao.CustomerDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.bean.BoatServiceBean"%>
<%@page import="com.dao.ServiceDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>BoatMSTI</title>

    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
            integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
    crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
    crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
    crossorigin="anonymous"></script>

    <body>
        <%
            Integer serviceID = (Integer) request.getAttribute("serviceID");
            String departDate = (String) request.getAttribute("departDate");
            Integer bookAdult = (Integer) request.getAttribute("bookAdult");
            Integer bookChild = (Integer) request.getAttribute("bookChild");
            Integer bookInfant = (Integer) request.getAttribute("bookInfant");

            ServiceDao sd = new ServiceDao();
            BoatServiceBean bsb = sd.BoatServiceById(serviceID);

            DecimalFormat format = new DecimalFormat("Rm#0.00");

            double adultPrice = bookAdult * bsb.getAdultPrice();
            double childPrice = bookChild * bsb.getChildPrice();
            double infantPrice = bookInfant * bsb.getInfantPrice();

            double totalPrice = adultPrice + childPrice + infantPrice;

            String custEmail = (String) session.getAttribute("custEmail");
            CustomerDao cd = new CustomerDao();
            CustomerBean cb = cd.oneCustomer(custEmail);
        %>

        <jsp:include page="../header.jsp" flush="true"/>
        <div class="container">
            <div class="py-5 text-center">
                <img class="d-block mx-auto mb-4" src="img/boatmsti.png" alt="" width="72" height="72">
                <h2>Ticket Checkout</h2>
                <p class="lead">Thank you for choosing our service. We hope you have a nice trip. <br> Please complete the form below.</p>
            </div>

            <div class="row">
                <div class="col-md-4 order-md-2 mb-4">
                    <h4 class="d-flex justify-content-between align-items-center mb-3">
                        <span class="text-muted">Price</span>
                    </h4>
                    <ul class="list-group mb-3">
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">Adult Price</h6>
                                <small class="text-muted"><%= format.format(bsb.getAdultPrice())%>/person</small>
                            </div>
                            <span class="text-muted"><%= format.format(adultPrice)%></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">Child Price</h6>
                                <small class="text-muted"><%= format.format(bsb.getChildPrice())%>/person</small>
                            </div>
                            <span class="text-muted"><%= format.format(childPrice)%></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">Infant Price</h6>
                                <small class="text-muted"><%= format.format(bsb.getInfantPrice())%>/person</small>
                            </div>
                            <span class="text-muted"><%= format.format(infantPrice)%></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between">
                            <span>Total (MYR)</span>
                            <strong><%= format.format(totalPrice)%></strong>
                        </li>
                    </ul>

                </div>
                <div class="col-md-8 order-md-1 card" style="padding: 10px;">
                    <h4 class="mb-3">BoatMSTI Ticket</h4>
                    <form action="bookingTicketCtrl" method="post" onsubmit="return validate()" enctype="multipart/form-data" >
                        <input type="hidden" name="action" value="addBookingTicket"/>
                        <input type="hidden" name="custID" value="<%= cb.getCustID()%>"/>
                        <input type="hidden" name="serviceID" value="<%= serviceID%>"/>
                        <input type="hidden" name="departDate" value="<%= departDate%>"/>
                        <input type="hidden" name="bookAdult" value="<%= bookAdult%>"/>
                        <input type="hidden" name="bookChild" value="<%= bookChild%>"/>
                        <input type="hidden" name="bookInfant" value="<%= bookInfant%>"/>
                        <input type="hidden" name="totalBook" value="<%= bookAdult + bookChild + bookInfant%>"/>
                        <input type="hidden" name="paymentAmount" value="<%= totalPrice%>"/>
                        <div class="row">
                            <div class="col-md-4 mb-2">
                                <label for="companyName"><b>Company: </b><%= bsb.getCompanyID().getCompanyName()%></label>
                            </div>
                            <div class="col-md-4 mb-2">
                                <label for="companyPhone"><b>Phone: </b><%= bsb.getCompanyID().getCompanyPhone()%></label>
                            </div>
                            <div class="col-md-4 mb-2">
                                <label for="companyEmail"><b>Email: </b><%= bsb.getCompanyID().getCompanyEmail()%></label>
                            </div>
                        </div>
                        <div class="card" style="padding: 10px">
                            <div class="card-header mb-2" style="background-color: #3D969E; color: white">
                                <label for="fromLocation"><b>From: </b><%= bsb.getFromLocation()%></label>
                                <label style="float: right" for="toLocation"><b>To: </b><%= bsb.getToLocation()%></label>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-5">
                                        <div class="row mb-2">
                                            <label for="boatID"><b>Boat ID: </b><%= bsb.getBoatID().getBoatID()%></label>
                                        </div>
                                        <div class="row mb-2">
                                            <label for="boatType"><b>Type: </b><%= bsb.getBoatID().getBoatType()%></label>
                                        </div>
                                    </div>
                                    <div class="col-md-5">
                                        <div class="row mb-2">
                                            <label for="custFirstName"><b>Name: </b><%= cb.getCustFirstName()%></label>
                                        </div>
                                        <div class="row mb-2">
                                            <label for="custPhone"><b>Phone: </b><%= cb.getCustPhone()%></label>
                                        </div>
                                        <div class="row mb-2">
                                            <label for="custEmail"><b>Email: </b><%= custEmail%></label>
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="row mb-2">
                                            <label for="bookAdult"><b>Adult: </b><%= bookAdult%></label>
                                        </div>
                                        <div class="row mb-2">
                                            <label for="bookChild"><b>Child: </b><%= bookChild%></label>
                                        </div>
                                        <div class="row mb-2">
                                            <label for="bookInfant"><b>Infant: </b><%= bookInfant%></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <label for="departDate"><b>Date: </b><%= departDate%></label>
                                <label style="float: right" for="departureTime"><b>Time: </b><%= bsb.getDepartureTime()%></label>
                            </div>
                        </div>
                        <hr class="mb-4">

                        <div style="padding: 10px">
                            <h4 class="mb-3">Payment</h4>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="referenceNo">Reference No</label>
                                    <input oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" name="referenceNo" type="text" class="form-control" id="referenceNo" placeholder="Enter Reference" required>
                                    <!--                                <small class="text-muted">Full name as displayed on card</small>
                                                                    <div class="invalid-feedback">
                                                                        Name on card is required
                                                                    </div>-->
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="paymentReceipt">Upload Receipt (Pdf Only)</label>
                                    <input type="file" name="paymentReceipt" id="paymentReceipt" required>
                                    <!--                                <div class="invalid-feedback">
                                                                        Credit card number is required
                                                                    </div>-->
                                </div>
                            </div>
                        </div>
                        <hr class="mb-4">
                        <div class="grnBtn">
                            <button class="btn btn-lg btn-block" type="submit">Continue to checkout</button>
                        </div>
                        <div class="redBtn" style="margin-top: -10px">
                            <input onclick="window.history.back()" type="button" class="btn btn-lg btn-block" type="submit" value="Cancel">
                        </div>
                    </form>
                </div>
            </div>

            <footer class="my-5 pt-5 text-muted text-center text-small">
                <p class="mb-1">Boat Management System To Terengganu Islands</p>
            </footer>
        </div>
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script>window.jQuery || document.write('<script src="/docs/4.4/assets/js/vendor/jquery.slim.min.js"><\/script>')</script><script src="/docs/4.4/dist/js/bootstrap.bundle.min.js" integrity="sha384-6khuMg9gaYr5AxOqhkVIODVIvm9ynTT5J4V1cfthmT+emCG6yVmEZsRHdxlotUnm" crossorigin="anonymous"></script>
    </body>
</html>
