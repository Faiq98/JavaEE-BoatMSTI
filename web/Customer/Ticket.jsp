<%-- 
    Document   : Ticket
    Created on : Apr 11, 2020, 11:00:34 PM
    Author     : fhfai
--%>

<%@page import="com.bean.CustomerBean"%>
<%@page import="com.dao.CustomerDao"%>
<%@page import="com.bean.BoatBean"%>
<%@page import="com.dao.BoatDao"%>
<%@page import="com.bean.BoatServiceBean"%>
<%@page import="com.dao.ServiceDao"%>
<%@page import="com.bean.TourismCompanyBean"%>
<%@page import="com.dao.TourismCompanyDao"%>
<%@page import="com.bean.BookingTicketBean"%>
<%@page import="com.dao.BookingTicketDao"%>
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
            Integer bookID = (Integer) request.getAttribute("bookID");
            BookingTicketDao btd = new BookingTicketDao();
            BookingTicketBean btb = btd.oneBookingTicket(bookID);

            TourismCompanyDao tcd = new TourismCompanyDao();

            TourismCompanyBean tcb = tcd.oneTourismCompany(btb.getServiceID().getCompanyID().getCompanyEmail());
            System.out.println(btb.getServiceID().getCompanyID().getCompanyEmail());

            ServiceDao sd = new ServiceDao();
            BoatServiceBean bsb = sd.BoatServiceById(btb.getServiceID().getServiceID());

            BoatDao bd = new BoatDao();
            BoatBean bb = bd.BoatById(bsb.getBoatID().getBoatID());

            String custEmail = (String) session.getAttribute("custEmail");
            CustomerDao cd = new CustomerDao();
            CustomerBean cb = cd.oneCustomer(custEmail);
        %>
        <jsp:include page="../header.jsp" flush="true"/>
        <div class="container">
            <div class="py-5 text-center">
                <img class="d-block mx-auto mb-4" src="img/boatmsti.png" alt="" width="72" height="72">
                <h2>Ticket Details </h2>
                <p class="lead">Thank you for choosing our service. We hope you have a nice trip. <br> Please complete the form below.</p>
            </div>

            <div class="row">
                <div class="col-md-12 order-md-1 card" style="padding: 10px;">
                    <h4 class="mb-3">BoatMSTI Ticket ~ <%= btb.getBookID()%></h4>
                    <div class="row">
                        <div class="col-md-4 mb-2">
                            <label for="companyName"><b>Company: </b><%= tcb.getCompanyName()%></label>
                        </div>
                        <div class="col-md-4 mb-2">
                            <label for="companyPhone"><b>Phone: </b><%= tcb.getCompanyPhone()%></label>
                        </div>
                        <div class="col-md-4 mb-2">
                            <label for="companyEmail"><b>Email: </b><%= tcb.getCompanyEmail()%></label>
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
                                        <label for="boatID"><b>Boat ID: </b><%= bb.getBoatID()%></label>
                                    </div>
                                    <div class="row mb-2">
                                        <label for="boatType"><b>Type: </b><%= bb.getBoatType()%></label>
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
                                        <label for="bookAdult"><b>Adult: </b><%= btb.getBookAdult()%></label>
                                    </div>
                                    <div class="row mb-2">
                                        <label for="bookChild"><b>Child: </b><%= btb.getBookChild()%></label>
                                    </div>
                                    <div class="row mb-2">
                                        <label for="bookInfant"><b>Infant: </b><%= btb.getBookInfant()%></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <label for="departDate"><b>Date: </b><%= btb.getDepartDate()%></label>
                            <label style="float: right" for="departureTime"><b>Time: </b><%= bsb.getDepartureTime()%></label>
                        </div>
                    </div>
                    <hr class="mb-4">
                    <hr class="mb-4">
                    <div class="grnBtn printBtn">
                        <button class="btn btn-lg btn-block" type="submit" onclick="window.print()">Print</button>
                    </div>
                    <div class="redBtn printBtn" style="margin-top: -10px">
                        <input onclick="window.history.back()" type="button" class="btn btn-lg btn-block" type="submit" value="Back">
                    </div>
                </div>
            </div>

            <footer class="my-5 pt-5 text-muted text-center text-small">
                <p class="mb-1">Boat Management System To Terengganu Islands</p>
            </footer>
        </div>
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script>window.jQuery || document.write('<script src="/docs/4.4/assets/js/vendor/jquery.slim.min.js"><\/script>')</script><script src="/docs/4.4/dist/js/bootstrap.bundle.min.js" integrity="sha384-6khuMg9gaYr5AxOqhkVIODVIvm9ynTT5J4V1cfthmT+emCG6yVmEZsRHdxlotUnm" crossorigin="anonymous"></script>
        <script src="form-validation.js"></script>
    </body>
</html>