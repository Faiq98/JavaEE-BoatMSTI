<%-- 
    Document   : Trip
    Created on : Mar 28, 2020, 2:25:42 AM
    Author     : fhfai
--%>

<%@page import="com.bean.FeedbackBean"%>
<%@page import="com.dao.FeedbackDao"%>
<%@page import="com.bean.BoatServiceBean"%>
<%@page import="com.dao.ServiceDao"%>
<%@page import="java.util.List"%>
<%@page import="com.bean.BookingTicketBean"%>
<%@page import="com.dao.BookingTicketDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!--        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
                crossorigin="anonymous"></script>-->

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
        <title>BoatMSTI</title>

        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
              integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <!--        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
                        integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
                crossorigin="anonymous"></script>-->
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
                integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
                integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>
    </head>
    <body>
        <%
            String fromLocation = (String) request.getAttribute("fromLocation");
            String toLocation = (String) request.getAttribute("toLocation");
            String departDate = (String) request.getAttribute("departDate");

            ServiceDao sd = new ServiceDao();
        %>

        <jsp:include page="../header.jsp" flush="true"/>
        <div class="boatService" style="padding-bottom: 5px">
            <div class="container">
                <div class="row">
                    <div>
                        <img style="width:80px" src="img/boatmstistroke.png"/>
                    </div>
                    <div class="col-md-8 mt-2">
                        <h1>Boat Ticket</h1>
                        <p>Search Your Online Boat Service Ticket Here...</p>
                    </div>
                    <!--                    <div class="col-md-2 mb-3" style=" margin-top: auto;">
                                            <button class="btn btn-block btn-warning">Check Booking</button>
                                        </div>-->
                </div>
                <div class="row">
                    <form class="form-inline search" action="customerCtrl" method="post">
                        <input type="hidden" name="action" value="searchTrip"/>
                        <label for="fromLocation" class="mr-sm-2">From: </label>
                        <!--                            <input type="text" class="form-control mb-2 mr-sm-2" name="fromLocation" id="fromLocation">-->
                        <select class="form-control mb-2 mr-sm-3" name="fromLocation" id="fromlocation">
                            <option hidden value="<%= fromLocation%>"><%= fromLocation%> </option>
                            <option value="Merang Jetty">Merang Jetty</option>
                            <option value="Shahbandar Jetty">Shahbandar Jetty</option>
                            <option value="Kuala Besut Jetty">Kuala Besut Jetty</option>
                            <option value="Kapas Island">Kapas Island</option>
                            <option value="Redang Island">Redang Island</option>
                            <option value="Lang Tengah Island">Lang Tengah Island</option>
                            <option value="Perhentian Island">Perhentian Island</option>
                        </select>
                        <label for="toLocation" class="mr-sm-2">To: </label>
                        <!--                            <input type="text" class="form-control mb-2 mr-sm-2" name="toLocation" id="toLocation">-->
                        <select class="form-control mb-2 mr-sm-3" name="toLocation" id="toLocation">
                            <option hidden value="<%= toLocation%>"><%= toLocation%></option>
                            <option value="Kapas Island">Kapas Island</option>
                            <option value="Redang Island">Redang Island</option>
                            <option value="Lang Tengah Island">Lang Tengah Island</option>
                            <option value="Perhentian Island">Perhentian Island</option>
                            <option value="Merang Jetty">Merang Jetty</option>
                            <option value="Shahbandar Jetty">Shahbandar Jetty</option>
                            <option value="Kuala Besut Jetty">Kuala Besut Jetty</option>
                        </select>
                        <label for="departureDate" class="mr-sm-2 ml-sm-5">Departure Date: </label>
                        <input type="date" class="form-control mb-2 mr-sm-2" name="departDate" id="departDate" value="<%= departDate%>" required>
                        <button type="submit" class="btn btn-block mb-2"><i class="fa fa-search"></i> Search</button>
                    </form>
                </div>
            </div>
        </div>


        <div class="sticky text-center">
            <div class="container">
                <div style="white-space: nowrap; overflow-x: auto">
                    <label>Filter : </label>
                    <button class="btn" id="companyName">Company Name</button>
                    <button class="btn" id="adultPrice">Price</button>
                    <button class="btn" id="time">Time</button>
                    <button class="btn" id="rating">Rating</button>
                </div>
            </div>
        </div>

        <!--list of trip-->
        <div class="tripList container">
            <div class="wrap">
                <%
                    BookingTicketDao btd = new BookingTicketDao();
                    List<BoatServiceBean> allBsb = btd.checkAvailability(fromLocation, toLocation, departDate);
                    int currentServiceID = 0;
                    for (int i = 0; i < allBsb.size(); i++) {
                        if (currentServiceID == allBsb.get(i).getServiceID()) {
                            continue;
                        } else {
                            if (allBsb.get(i).getBoatID().getBoatCapacity() != 0) {
                                FeedbackDao fd = new FeedbackDao();
                                List<FeedbackBean> allFb = fd.FeedbackByService(allBsb.get(i).getServiceID());
                %>
                <div class="row ticketList">
                    <div class="col-md-12">
                        <div class="card border-success mt-2 mb-2" style="padding: 10px;">

                            <!--Ticket Header-->
                            <div class="card-header companyName" style="font-size: 20px;">
                                <%= allBsb.get(i).getCompanyID().getCompanyName()%>

                                <%
                                    double totalRate = 0;
                                    double avgRate = 0;
                                    int reviews = 0;
                                    for (int j = 0; j < allFb.size(); j++) {
                                        totalRate += allFb.get(j).getFeedbackRating();
                                        reviews = j + 1;
                                    }
                                    avgRate = Math.round((totalRate / reviews) * 10) / 10.0;
                                %>
                                <button class="btn rating" data-toggle="modal" data-target="#myModal" data-serviceID="<%= allBsb.get(i).getServiceID()%>" style="float: right; background-color: #ccc"><b><%= avgRate%></b></button>
                            </div>
                            <div class="row">
                                <div class="card-body text-success col-md-3">
                                    <h5 class="card-title"><%= allBsb.get(i).getFromLocation()%> <i class="fa fa-angle-right"></i> <%= allBsb.get(i).getToLocation()%></h5>
                                    <h5 class="card-title time">Time : <%= allBsb.get(i).getDepartureTime()%></h5>
                                    <p class="card-text mb-1">Boat Type : <%= allBsb.get(i).getBoatID().getBoatType()%></p>
                                    <p class="card-text" style="color: #1B5360">Seat Available : <%= allBsb.get(i).getBoatID().getBoatCapacity()%></p>
                                </div>
                                <div class="col-md-3 mt-2 mb-2 text-center" style="padding: 10px;">
                                    <p></p>
                                    <p class="card-text adultPrice"><b>Adult Price :</b> RM <%= allBsb.get(i).getAdultPrice()%></p>
                                    <p class="card-text"><b>Child Price :</b> RM <%= allBsb.get(i).getChildPrice()%></p>
                                    <p class="card-text"><b>Infant Price :</b> RM <%= allBsb.get(i).getInfantPrice()%></p>
                                </div>
                                <div class="col-md-6">
                                    <div class="card border-success mt-2 mb-3" style="padding: 10px; height: 150px;">
                                        <!--                                        <div class="card-header" style="font-size: 20px" data>
                                                                                    Review 
                                                                                </div>-->
                                        <div class="card-body" style="overflow-y: auto">
                                            <%
                                                for (int k = 0; k < allFb.size(); k++) {
                                            %>
                                            <p class="card-text"><b><%= allFb.get(k).getCustID().getCustFirstName()%></b> <span style="float: right;"><%= allFb.get(k).getFeedbackDate()%></span>
                                                <span style="margin-left: 10px;">
                                                    <%
                                                        for (int s = 0; s < 5; s++) {
                                                            if (s < allFb.get(k).getFeedbackRating()) {
                                                    %>
                                                    <span class="fa fa-star" style="color: orange"></span>
                                                    <%
                                                    } else {
                                                    %>
                                                    <span class="fa fa-star"></span>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </span>
                                            </p>
                                            <p class="card-text"><%= allFb.get(k).getFeedbackCustomer()%></p>
                                            <hr>
                                            <%
                                                }
                                            %>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <form action="bookingTicketCtrl" method="post">
                                <input type="hidden" name="action" value="addBookingForm"/>
                                <input type="hidden" name="serviceID" value="<%= allBsb.get(i).getServiceID()%>"/>
                                <input type="hidden" name="departDate" value="<%= departDate%>"/>
                                <div class="row text-center" style="margin-top: -20px; padding: 10px; width: 100%">
                                    <div class="col mt-2">
                                        Ticket : 
                                        <input class="form-control" type="number" min="0"  placeholder="Adult" name="bookAdult" style="width: 6em; display: inline-block" data-toggle="tooltip" data-placement="top" title="12 years old above" required>
                                        <input class="form-control" type="number" min="0" placeholder="Child" name="bookChild" style="width: 6em; display: inline-block" data-toggle="tooltip" data-placement="top" title="Between 2 - 12 years old" required>
                                        <input class="form-control" type="number" min="0" placeholder="Infant" name="bookInfant" style="width: 6em; display: inline-block" data-toggle="tooltip" data-placement="top" title="2 years old" required>
                                    </div>
                                </div>
                                <button class="btn btn-block btn-warning">Buy</button>
                            </form>
                        </div>
                    </div>
                </div>
                <%
                    currentServiceID = allBsb.get(i).getServiceID();
                } else {
                    FeedbackDao fd = new FeedbackDao();
                    List<FeedbackBean> allFb = fd.FeedbackByService(allBsb.get(i).getServiceID());
                %>
                <div class="row ticketList">
                    <div class="col-md-12">
                        <div class="card border-success mt-2 mb-2" style="padding: 10px;">

                            <!--Ticket Header-->
                            <div class="card-header companyName" style="font-size: 20px;">
                                <%= allBsb.get(i).getCompanyID().getCompanyName()%>

                                <%
                                    double totalRate = 0;
                                    double avgRate = 0;
                                    int reviews = 0;
                                    for (int j = 0; j < allFb.size(); j++) {
                                        totalRate += allFb.get(j).getFeedbackRating();
                                        reviews = j + 1;
                                    }
                                    avgRate = Math.round((totalRate / reviews) * 10) / 10.0;
                                %>
                                <button class="btn rating" data-toggle="modal" data-target="#myModal" data-serviceID="<%= allBsb.get(i).getServiceID()%>" style="float: right; background-color: #ccc"><b><%= avgRate%></b></button>
                            </div>
                            <div class="row">
                                <div class="card-body text-success col-md-3">
                                    <h5 class="card-title"><%= allBsb.get(i).getFromLocation()%> <i class="fa fa-angle-right"></i> <%= allBsb.get(i).getToLocation()%></h5>
                                    <h5 class="card-title time">Time : <%= allBsb.get(i).getDepartureTime()%></h5>
                                    <p class="card-text mb-1">Boat Type : <%= allBsb.get(i).getBoatID().getBoatType()%></p>
                                    <p class="card-text" style="color: #1B5360">Seat Available : Sold Out</p>
                                </div>
                                <div class="col-md-3 mt-2 mb-2 text-center" style="padding: 10px;">
                                    <p></p>
                                    <p class="card-text adultPrice"><b>Adult Price :</b> RM <%= allBsb.get(i).getAdultPrice()%></p>
                                    <p class="card-text"><b>Child Price :</b> RM <%= allBsb.get(i).getChildPrice()%></p>
                                    <p class="card-text"><b>Infant Price :</b> RM <%= allBsb.get(i).getInfantPrice()%></p>
                                </div>
                                <div class="col-md-6">
                                    <div class="card border-success mt-2 mb-3" style="padding: 10px; height: 150px;">
                                        <!--                                        <div class="card-header" style="font-size: 20px" data>
                                                                                    Review 
                                                                                </div>-->
                                        <div class="card-body" style="overflow-y: auto">
                                            <%
                                                for (int k = 0; k < allFb.size(); k++) {
                                            %>
                                            <p class="card-text"><b><%= allFb.get(k).getCustID().getCustFirstName()%></b> <span style="float: right;"><%= allFb.get(k).getFeedbackDate()%></span>
                                                <span style="margin-left: 10px;">
                                                    <%
                                                        for (int s = 0; s < 5; s++) {
                                                            if (s < allFb.get(k).getFeedbackRating()) {
                                                    %>
                                                    <span class="fa fa-star" style="color: orange"></span>
                                                    <%
                                                    } else {
                                                    %>
                                                    <span class="fa fa-star"></span>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </span>
                                            </p>
                                            <p class="card-text"><%= allFb.get(k).getFeedbackCustomer()%></p>
                                            <hr>
                                            <%
                                                }
                                            %>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <form action="bookingTicketCtrl" method="post">
                                <input type="hidden" name="action" value="addBookingForm"/>
                                <input type="hidden" name="serviceID" value="<%= allBsb.get(i).getServiceID()%>"/>
                                <input type="hidden" name="departDate" value="<%= departDate%>"/>
                                <div class="row text-center" style="margin-top: -20px; padding: 10px; width: 100%">
                                    <div class="col mt-2">
                                        Ticket : 
                                        <input class="form-control" type="number" min="0"  placeholder="Adult" name="bookAdult" style="width: 6em; display: inline-block" data-toggle="tooltip" data-placement="top" title="12 years old above" required>
                                        <input class="form-control" type="number" min="0" placeholder="Child" name="bookChild" style="width: 6em; display: inline-block" data-toggle="tooltip" data-placement="top" title="Between 2 - 12 years old" required>
                                        <input class="form-control" type="number" min="0" placeholder="Infant" name="bookInfant" style="width: 6em; display: inline-block" data-toggle="tooltip" data-placement="top" title="2 years old" required>
                                    </div>
                                </div>
                                <button class="btn btn-block btn-danger" disabled>Sold Out</button>
                            </form>
                        </div>
                    </div>
                </div>
                <%
                                currentServiceID = allBsb.get(i).getServiceID();
                            }
                        }
                    }
                %>
            </div>
            <div class="modal fade" id="myModal" role="dialog">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Feedback</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="javaquery"></div>
                        </div>
                        <div class="modal-footer">
                            <button style="background-color: #8E1600; color: white;" type="button" data-dismiss="modal" class="btn btn-block" >Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="../footer.jsp" flush="true"/>
        <script>
            $(document).ready(function () {
                $('[data-toggle="tooltip"]').tooltip();
            });

            $(function () {

                var alpha = [];
                var number = [];
                var time = [];
                var rating = [];

                $('.ticketList').each(function () {

                    var alphaArr = [];
                    var numArr = [];
                    var timeArr = [];
                    var ratingArr = [];

                    alphaArr.push($('.companyName', this).text());
                    alphaArr.push($(this));
                    alpha.push(alphaArr);
                    alpha.sort();

                    numArr.push($('.adultPrice', this).text());
                    numArr.push($(this));
                    number.push(numArr);
                    number.sort();

                    timeArr.push($('.time', this).text());
                    timeArr.push($(this));
                    time.push(timeArr);
                    time.sort();

                    ratingArr.push($('.rating', this).text());
                    ratingArr.push($(this));
                    rating.push(ratingArr);
                    rating.sort();
                    rating.reverse();
                })

                $('#companyName').on('click', function () {
                    $('.ticketList').remove();
                    for (var i = 0; i < alpha.length; i++) {
                        $('.wrap').append(alpha[i][1]);
                    }
                })

                $('#adultPrice').on('click', function () {
                    $('.ticketList').remove();
                    for (var i = 0; i < number.length; i++) {
                        $('.wrap').append(number[i][1]);
                    }
                })

                $('#time').on('click', function () {
                    $('.ticketList').remove();
                    for (var i = 0; i < time.length; i++) {
                        $('.wrap').append(time[i][1]);
                    }
                })

                $('#rating').on('click', function () {
                    $('.ticketList').remove();
                    for (var i = 0; i < rating.length; i++) {
                        $('.wrap').append(rating[i][1]);
                    }
                })
            });

            $('#myModal').on('show.bs.modal', function (e) {
                var serviceID = $(e.relatedTarget).attr('data-serviceID');
                console.log(serviceID);
                $.get("Customer/Feedback.jsp", {serviceID: serviceID}, function (data) {
                    $(".javaquery").html(data);
                });
            });

        </script>
    </body>
</html>
