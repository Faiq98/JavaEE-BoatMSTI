<%-- 
    Document   : EditFeedback
    Created on : Apr 30, 2020, 4:34:34 PM
    Author     : fhfai
--%>

<%@page import="com.bean.FeedbackTopicBean"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.FeedbackTopicDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.bean.FeedbackBean"%>
<%@page import="com.dao.FeedbackDao"%>
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

        <!--                <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
                                integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
                        crossorigin="anonymous"></script>-->
        <!--        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>-->
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
                integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
                integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>
    </head>
    <body>
        <%
            int feedbackID = Integer.parseInt(request.getParameter("feedbackID"));
            FeedbackDao fd = new FeedbackDao();
            FeedbackBean fb = fd.FeedbackById(feedbackID);
            System.out.println("FeedbackID: " + feedbackID);
            Date date = new Date();
            SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
            String currentDate = ft.format(date);
        %>

        <form class="form" action="feedbackCtrl" method="post">
            <input type="hidden" name="action" value="EditFeedback"/>
            <input type="hidden" name="feedbackDate" value="<%= currentDate%>"/>
            <input type="hidden" name="feedbackID" value="<%= feedbackID%>"
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
            <input type="hidden" name="feedbackRating" class="editFeedbackRating"/>

            <label for="topicID" class="mr-sm-2">Topic : </label>
            <select style="width: 300px" class="form-control mb-2 mr-sm-3" name="topicID">
                <option hidden value="<%= fb.getTopicID().getTopicID()%>"><%= fb.getTopicID().getTopicID()%> | <%= fb.getTopicID().getTopic()%></option>
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
                <textarea class="form-control" rows="5" name="feedbackCustomer"><%= fb.getFeedbackCustomer()%></textarea>
            </div>
            <hr>
            <button type="submit" class="btn btn-block" style="background-color: #51702C; color: white" >Done</button>
        </form>
        <form class="mt-2" action="feedbackCtrl" method="post">
            <input type="hidden" name="action" value="deleteFeedback"/>
            <input type="hidden" name="feedbackID" value="<%= feedbackID%>"/>
            <button type="submit" class="btn btn-block" style="background-color: #8E1600; color: white" onclick="return deleteConfirmation()" >Delete</button>
        </form>
        <script>
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
                    var input = document.getElementsByClassName("editFeedbackRating")[0];
                    input.value = ratingValue;
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
