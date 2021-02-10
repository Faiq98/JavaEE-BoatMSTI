<%-- 
    Document   : CustomerHome
    Created on : Dec 6, 2019, 5:59:32 PM
    Author     : fhfai
--%>

<%@page import="com.bean.FeedbackBean"%>
<%@page import="com.dao.FeedbackDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.bean.FeedbackTopicBean"%>
<%@page import="com.dao.FeedbackTopicDao"%>
<%@page import="com.bean.BookingTicketBean"%>
<%@page import="com.dao.BookingTicketDao"%>
<%@page import="java.util.List"%>
<%@page import="com.bean.CustomerBean"%>
<%@page import="com.dao.CustomerDao"%>
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
<!--
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
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

    </head>
    <body>
        <%
//            response.setHeader("Cache-Control", "no-cache, no-store");
//            response.setHeader("Pragma", "no-cache");
//            response.setDateHeader("Expires", 0);

//            String custEmail = null;
//            if (session.getAttribute("custEmail") == null) {
//                response.sendRedirect("/index.jsp");
//            } else {
//                custEmail = (String) session.getAttribute("custEmail");
//            }
            String custEmail = (String) session.getAttribute("custEmail");
            CustomerDao cd = new CustomerDao();
            CustomerBean cb = cd.oneCustomer(custEmail);

            Date date = new Date();
            SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
            String currentDate = ft.format(date);
        %>
        <div class="cpage" id="cpage"></div>
        <jsp:include page="../header.jsp" flush="true"/>
        <div class="container ch" style="font-size: 20px;">
            <div class="chprofile" id="chprofile">
                <form action="customerCtrl" method="post">
                    <div class="row text-center">
                        <input class="img" data-toggle="tooltip" data-placement="bottom" title="Click to Upload Profile Image" class="custImage" type="image" src="data:image/jpg;base64,<%= cb.getCustImg()%>" alt="profileimage"/>
                    </div>
                    <input type="hidden" name="action" value="editImageForm"/>
                    <input type="hidden" name="custEmail" value="<%= cb.getCustEmail()%>"/>
                </form>
                <!--                <div class="text-center">
                                    <form action="customerCtrl" method="post">
                                        <button class="iconbutton" data-toggle="tooltip" data-placement="right" title="Upload Image" ><i class="fa fa-upload chicon" style="color: white; text-shadow: 1px 1px 5px grey;"></i></button>
                                        <input type="hidden" name="action" value="editForm"/>
                                        <input type="hidden" name="custEmail" value="<%= cb.getCustEmail()%>"/>
                                    </form>
                                </div>-->
                <div class="row" style="background-color: #3D969E; height: 150px; margin-top: -100px; box-shadow: 1px 1px 5px #000;">
                    <div class="col-md-12 custName" style="margin-top: 100px;">
                        <form action="customerCtrl" method="post">
                            <h3 style="display: inline; color: white;"><%= cb.getCustFirstName()%> <%= cb.getCustLastName()%> <button class="iconbutton" type="submit" data-toggle="tooltip" data-placement="right" title="Update profile"><i class="fa fa-user chicon" style="color: white"></i></button></h3>
                            <input type="hidden" name="action" value="editForm"/>
                            <input type="hidden" name="custEmail" value="<%= cb.getCustEmail() %>"/>
                        </form>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-9">
                        <!-- BookingTicket -->
                        <div class="row" id="bookingTicket">
                            <div class="col mb-2 mt-5">
                                <form action="bookingTicketCtrl" method="post">
                                    <h3 style="display: inline">My Booking <button class="iconbutton" type="submit" data-toggle="tooltip" data-placement="right" title="Booking new ticket"><i class="fa fa-plus-circle chicon"></i></button></h3>
                                    <input type="hidden" name="action" value="trip"/>
                                    <input type="hidden" name="custID" value="<%= cb.getCustID()%>"/>
                                </form>
                            </div>
                        </div>

                        <%
                            BookingTicketDao btd = new BookingTicketDao();
                            List<BookingTicketBean> allBtb = btd.allbookingTicketByIC(cb.getCustID());
                        %>
                        <div class="col-md-12 card" style="padding: 10px; box-shadow: 1px 1px 5px #777;">
                            <div style="overflow-x: auto">
                                <table class="table table-striped dataTable">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Company</th>
                                            <th>From</th>
                                            <th>To</th>
                                            <th>Date</th>
                                            <th>Time</th>
                                            <th>Payment</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for (int i = 0; i < allBtb.size(); i++) {
                                        %>
                                        <tr>
                                            <td><%= allBtb.get(i).getBookID()%></td>
                                            <td><%= allBtb.get(i).getServiceID().getCompanyID().getCompanyName()%></td>
                                            <td><%= allBtb.get(i).getServiceID().getFromLocation()%></td>
                                            <td><%= allBtb.get(i).getServiceID().getToLocation()%></td>
                                            <td><%= allBtb.get(i).getDepartDate()%></td>
                                            <td><%= allBtb.get(i).getServiceID().getDepartureTime()%></td>
                                            <td><%= allBtb.get(i).getReferenceNo().getPaymentAmount()%></td>
                                            <td>
                                                <form style="display:inline" action="bookingTicketCtrl" method="post">
                                                    <input type="hidden" name="action" value="viewTicket"/>
                                                    <input type="hidden" name="bookID" value="<%= allBtb.get(i).getBookID()%>"/>
                                                    <button type="submit" class="iconbutton" data-toggle="tooltip" data-placement="bottom" title="View ticket"><i class="fa fa-ticket"></i></button>
                                                </form>
                                                    <button type="button" class="iconbutton" data-toggle="modal" data-placement="bottom" title="Add feedback" data-target="#myModal" data-serviceID="<%= allBtb.get(i).getServiceID().getServiceID()%>" data-bookID="<%= allBtb.get(i).getBookID()%>"><i class="fa fa-comments-o"></i></button>
                                                <form class="form" action="feedbackCtrl" method="post">
                                                    <input type="hidden" name="action" value="addFeedback"/>
                                                    <input type="hidden" name="custID" value="<%= cb.getCustID()%>"/>
                                                    <div class="modal fade" id="myModal" role="dialog">
                                                        <div class="modal-dialog modal-lg">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h4 class="modal-title">FeedBack</h4>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <input type="hidden" class="serviceID" name="serviceID"/>
                                                                    <input type="hidden" name="feedbackDate" value="<%= currentDate%>"/>
                                                                    <p>Please provide your feedback below :</p>

                                                                    <!-- Star rating -->
                                                                    <section class="rating-widget">
                                                                        <div class='rating-stars'>
                                                                            <ul id='stars'>
                                                                                <li class='star' title='Poor' data-value='1'>
                                                                                    <i class='fa fa-star fa-fw'></i>
                                                                                </li>
                                                                                <li class='star' title='Fair' data-value='2'>
                                                                                    <i class='fa fa-star fa-fw'></i>
                                                                                </li>
                                                                                <li class='star' title='Good' data-value='3'>
                                                                                    <i class='fa fa-star fa-fw'></i>
                                                                                </li>
                                                                                <li class='star' title='Excellent' data-value='4'>
                                                                                    <i class='fa fa-star fa-fw'></i>
                                                                                </li>
                                                                                <li class='star' title='WOW!!!' data-value='5'>
                                                                                    <i class='fa fa-star fa-fw'></i>
                                                                                </li>
                                                                            </ul>
                                                                        </div>
                                                                    </section>
                                                                    <input type="hidden" name="feedbackRating" class="feedbackRating"/>

                                                                    <label for="topicID" class="mr-sm-2">Topic : </label>
                                                                    <select style="width: 300px" class="form-control mb-2 mr-sm-3" name="topicID">
                                                                        <%
                                                                            FeedbackTopicDao ftd = new FeedbackTopicDao();
                                                                            List<FeedbackTopicBean> ftb = ftd.allTopic();
                                                                            for (int j = 0; j < ftb.size(); j++) {
                                                                        %>
                                                                        <option value="<%= ftb.get(j).getTopicID()%>"><%= ftb.get(j).getTopicID()%> | <%= ftb.get(j).getTopic()%></option>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    </select>
                                                                    <div class="form-group">
                                                                        <label for="feedbackCustomer">Comment : </label>
                                                                        <textarea class="form-control" rows="5" name="feedbackCustomer"></textarea>
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="submit" class="btn btn-block" style="background-color: #51702C; color: white" >Done</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
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

                        <!-- Booking Ticket History -->
                        <div class="row" id="bookingTicket">
                            <div class="col mb-2 mt-5">
<!--                                <form action="bookingTicketCtrl" method="post">-->
                                    <h3 style="display: inline">Booking History<button class="iconbutton" type="submit"><i class="fa fa-history chicon"></i></button></h3>
                                    <!--                                    <input type="hidden" name="action" value="trip"/>
                                                                        <input type="hidden" name="custID" value="<%= cb.getCustID()%>"/>
                                                                    </form>-->
                            </div>
                        </div>

                        <%
                            btd = new BookingTicketDao();
                            allBtb = btd.allCheckBookingTicketByIC(cb.getCustID());
                        %>
                        <div class="col-md-12 card" style="padding: 10px; box-shadow: 1px 1px 5px #777;">
                            <div style="overflow-x: auto">
                                <table class="table table-striped dataTable">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Company</th>
                                            <th>From</th>
                                            <th>To</th>
                                            <th>Date</th>
                                            <th>Time</th>
                                            <th>Payment</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for (int i = 0; i < allBtb.size(); i++) {
                                        %>
                                        <tr>
                                            <td><%= allBtb.get(i).getBookID()%></td>
                                            <td><%= allBtb.get(i).getServiceID().getCompanyID().getCompanyName()%></td>
                                            <td><%= allBtb.get(i).getServiceID().getFromLocation()%></td>
                                            <td><%= allBtb.get(i).getServiceID().getToLocation()%></td>
                                            <td><%= allBtb.get(i).getDepartDate()%></td>
                                            <td><%= allBtb.get(i).getServiceID().getDepartureTime()%></td>
                                            <td><%= allBtb.get(i).getReferenceNo().getPaymentAmount()%></td>
                                            <td>
                                                <form style="display:inline" action="bookingTicketCtrl" method="post">
                                                    <input type="hidden" name="action" value="viewTicket"/>
                                                    <input type="hidden" name="bookID" value="<%= allBtb.get(i).getBookID()%>"/>
                                                    <button type="submit" class="iconbutton" data-toggle="tooltip" data-placement="bottom" title="View ticket"><i class="fa fa-ticket"></i></button>
                                                </form>
                                                    <button type="button" class="iconbutton" data-toggle="modal" data-toggle="tooltip" data-placement="bottom" title="Add feedback" data-target="#myModal" data-serviceID="<%= allBtb.get(i).getServiceID().getServiceID()%>" data-bookID="<%= allBtb.get(i).getBookID()%>"><i class="fa fa-comments-o"></i></button>
                                                <form class="form" action="feedbackCtrl" method="post">
                                                    <input type="hidden" name="action" value="addFeedback"/>
                                                    <input type="hidden" name="custID" value="<%= cb.getCustID()%>"/>
                                                    <div class="modal fade" id="myModal" role="dialog">
                                                        <div class="modal-dialog modal-lg">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h4 class="modal-title">FeedBack</h4>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <input type="hidden" class="serviceID" name="serviceID"/>
                                                                    <input type="hidden" name="feedbackDate" value="<%= currentDate%>"/>
                                                                    <p>Please provide your feedback below :</p>

                                                                    <!-- Star rating -->
                                                                    <section class="rating-widget">
                                                                        <div class='rating-stars'>
                                                                            <ul id='stars'>
                                                                                <li class='star' title='Poor' data-value='1'>
                                                                                    <i class='fa fa-star fa-fw'></i>
                                                                                </li>
                                                                                <li class='star' title='Fair' data-value='2'>
                                                                                    <i class='fa fa-star fa-fw'></i>
                                                                                </li>
                                                                                <li class='star' title='Good' data-value='3'>
                                                                                    <i class='fa fa-star fa-fw'></i>
                                                                                </li>
                                                                                <li class='star' title='Excellent' data-value='4'>
                                                                                    <i class='fa fa-star fa-fw'></i>
                                                                                </li>
                                                                                <li class='star' title='WOW!!!' data-value='5'>
                                                                                    <i class='fa fa-star fa-fw'></i>
                                                                                </li>
                                                                            </ul>
                                                                        </div>
                                                                    </section>
                                                                    <input type="hidden" name="feedbackRating" class="feedbackRating"/>

                                                                    <label for="topicID" class="mr-sm-2">Topic : </label>
                                                                    <select style="width: 300px" class="form-control mb-2 mr-sm-3" name="topicID">
                                                                        <%
                                                                            FeedbackTopicDao ftd = new FeedbackTopicDao();
                                                                            List<FeedbackTopicBean> ftb = ftd.allTopic();
                                                                            for (int j = 0; j < ftb.size(); j++) {
                                                                        %>
                                                                        <option value="<%= ftb.get(j).getTopicID()%>"><%= ftb.get(j).getTopicID()%> | <%= ftb.get(j).getTopic()%></option>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    </select>
                                                                    <div class="form-group">
                                                                        <label for="feedbackCustomer">Comment : </label>
                                                                        <textarea class="form-control" rows="5" name="feedbackCustomer"></textarea>
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="submit" class="btn btn-block" style="background-color: #51702C; color: white" >Done</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
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
                        <!-- Booking Ticket History end -->
                    </div>

                    <!-- Review section -->
                    <div class="col-md-3">
                        <div class="row">
                            <div class="col mb-2 mt-5">

                                <h3 style="display: inline">Feedback <button class="iconbutton" type="submit" ><i class="fa fa-book chicon"></i></button></h3>
                            </div>
                        </div>

                        <div class="card col" style="padding: 5px; box-shadow: 1px 1px 5px #777; height: 535px;">
                            <div class="card-body" style="font-size: 18px; overflow-y: auto">
                                <%
                                    FeedbackDao fd = new FeedbackDao();
                                    List<FeedbackBean> allFb = fd.FeedbackByCust(cb.getCustID());
                                    for (int i = 0; i < allFb.size(); i++) {
                                %>
                                <div class="card-title">
                                    <%= allFb.get(i).getServiceID().getCompanyID().getCompanyName()%>
                                    <span style="float: right"><button class="iconbutton" data-toggle="modal" data-target="#reviewModal" data-feedbackID="<%= allFb.get(i).getFeedbackID()%>" style="float: right;"><i class="fa fa-edit" data-toggle="tooltip" data-placement="left" title="update feedback"></i></button></span>
                                </div>
                                <span style="font-size: 15px;">
                                    <%
                                        for (int s = 0; s < 5; s++) {
                                            if (s < allFb.get(i).getFeedbackRating()) {
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
                                <div class="card-text">
                                    <b><%= allFb.get(i).getTopicID().getTopic()%></b><br>
                                    <%= allFb.get(i).getFeedbackCustomer()%><br>
                                    <span style="font-size: 15px; color: gray"><%= allFb.get(i).getFeedbackDate()%></span>
                                </div>

                                <!-- review Modal -->
                                <div class="modal fade" id="reviewModal" role="dialog">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">Feedback</h4>
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="javaquery"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- review Mosal end -->

                                <hr>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                    <!-- Review section end -->

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

        $('#myModal').on('show.bs.modal', function (e) {
            var serviceID = $(e.relatedTarget).attr('data-serviceID');
            var input = document.getElementsByClassName("serviceID")[0];
            input.value = serviceID;
        });

        $(document).ready(function () {

            /* 1. Visualizing things on Hover - See next part for action on click */
            $('#stars li').on('mouseover', function () {
                var onStar = parseInt($(this).data('value'), 10); // The star currently mouse on

                // Now highlight all the stars that's not after the current hovered star
                $(this).parent().children('li.star').each(function (e) {
                    if (e < onStar) {
                        $(this).addClass('hover');
                    } else {
                        $(this).removeClass('hover');
                    }
                });

            }).on('mouseout', function () {
                $(this).parent().children('li.star').each(function (e) {
                    $(this).removeClass('hover');
                });
            });


            /* 2. Action to perform on click */
            $('#stars li').on('click', function () {
                var onStar = parseInt($(this).data('value'), 10); // The star currently selected
                var stars = $(this).parent().children('li.star');

                for (i = 0; i < stars.length; i++) {
                    $(stars[i]).removeClass('selected');
                }

                for (i = 0; i < onStar; i++) {
                    $(stars[i]).addClass('selected');
                }

                // JUST RESPONSE (Not needed)
                var ratingValue = parseInt($('#stars li.selected').last().data('value'), 10);
                var input = document.getElementsByClassName("feedbackRating")[0];
                input.value = ratingValue;
            });
        });

        $('#reviewModal').on('show.bs.modal', function (e) {
            var feedbackID = $(e.relatedTarget).attr('data-feedbackID');
            console.log(feedbackID);
            $.get("Customer/EditFeedback.jsp", {feedbackID: feedbackID}, function (data) {
                $(".javaquery").html(data);
            });
        });

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
    </script>
</body>
</html>
