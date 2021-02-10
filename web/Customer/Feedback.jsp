<%-- 
    Document   : Feedback
    Created on : Apr 25, 2020, 12:38:03 PM
    Author     : fhfai
--%>

<%@page import="com.bean.FeedbackBean"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.FeedbackDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
<!--        <script src="https://code.jquery.com/jquery-1.10.2.js"></script>-->
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
            int serviceID = Integer.parseInt(request.getParameter("serviceID"));
            FeedbackDao fd = new FeedbackDao();
            List<FeedbackBean> allFb = fd.FeedbackByService(serviceID);

            double fb_serviceProvider = 0, fb_safety = 0, fb_cleanlines = 0, fb_others = 0;
            int rv_serviceProvider = 0, rv_safety = 0, rv_cleanlines = 0, rv_others = 0;
            double avg_serviceProvider = 0, avg_safety = 0, avg_cleanlines = 0, avg_others = 0;
            for (int i = 0; i < allFb.size(); i++) {
                if (allFb.get(i).getTopicID().getTopic().equalsIgnoreCase("Service provide")) {
                    fb_serviceProvider += allFb.get(i).getFeedbackRating();
                    rv_serviceProvider += 1;
                } else if (allFb.get(i).getTopicID().getTopic().equalsIgnoreCase("Safety")) {
                    fb_safety += allFb.get(i).getFeedbackRating();
                    rv_safety += 1;
                } else if (allFb.get(i).getTopicID().getTopic().equalsIgnoreCase("Cleanlines")) {
                    fb_cleanlines += allFb.get(i).getFeedbackRating();
                    rv_cleanlines += 1;
                } else if (allFb.get(i).getTopicID().getTopic().equalsIgnoreCase("Others")) {
                    fb_others += allFb.get(i).getFeedbackRating();
                    rv_others += 1;
                } else {
                    System.out.println("Feedback process error");
                }
            }

            avg_serviceProvider = Math.round((fb_serviceProvider / rv_serviceProvider) * 10) / 10.0;
            avg_safety = Math.round((fb_safety / rv_safety) * 10) / 10.0;
            avg_cleanlines = Math.round((fb_cleanlines / rv_cleanlines) * 10) / 10.0;
            avg_others = Math.round((fb_others / rv_others) * 10) / 10.0;
        %>

        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <label>Service Provider</label><br>
                    <progress max="5" value="<%= avg_serviceProvider%>"></progress> <%= avg_serviceProvider%>
                </div>
                <div class="col-md-6">
                    <label>Safety</label><br>
                    <progress max="5" value="<%= avg_safety%>"></progress> <%= avg_safety%>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <label>Cleanlines</label><br>
                    <progress max="5" value="<%= avg_cleanlines%>"></progress> <%= avg_cleanlines%>
                </div>
                <div class="col-md-6">
                    <label>Others</label><br>
                    <progress max="5" value="<%= avg_others%>"></progress> <%= avg_others%>
                </div>
            </div>
        </div>
        <hr>
        <div class="container" style="height: 250px; overflow-y: auto">
            <%
                for (int j = 0; j < allFb.size(); j++) {
            %>
            <p>
                <b><%= allFb.get(j).getCustID().getCustFirstName()%></b> <span style="float: right"><%= allFb.get(j).getFeedbackDate()%></span>

                <span style="margin-left: 10px;">
                    <%
                        for (int k = 0; k < 5; k++) {
                            if (k < allFb.get(j).getFeedbackRating()) {
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
            <p><%= allFb.get(j).getFeedbackCustomer()%></p>
            <hr>
            <%
                }
            %>
        </div>
    </body>
</html>
