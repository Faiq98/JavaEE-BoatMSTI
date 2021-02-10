<%-- 
    Document   : EditReport
    Created on : May 31, 2020, 4:15:30 PM
    Author     : fhfai
--%>

<%@page import="com.bean.ReportBean"%>
<%@page import="com.dao.ReportDao"%>
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
            Integer reportID = Integer.parseInt(request.getParameter("reportID"));
            ReportDao rd = new ReportDao();
            ReportBean rb = rd.reportById(reportID);
        %>
        <form action="reportCtrl" method="post">
            <input type="hidden" name="action" value="editReport"/>
            <input type="hidden" name="reportID" value="<%= rb.getReportID()%>"/>
            <div class="row">
                <div class="col">
                    <div class="form-group">
                        <label for="reportID">Report ID ~ <%= rb.getReportID()%></label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <div class="form-group">
                        <label for="reportDate">Date</label>
                        <input type="text" class="form-control" value="<%= rb.getReportDate()%>" name="reportDate"/>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <div class="form-group">
                        <label for="totalCustomer">Total Customer</label>
                        <input type="text" class="form-control" value="<%= rb.getTotalCustomer()%>" name="totalCustomer"/>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <div class="form-group">
                        <label for="sales">Sales</label>
                        <input type="text" class="form-control" value="<%= rb.getSales()%>" name="sales"/>
                    </div>
                </div>
            </div>
            <div class=" grnBtn mt-3">
                <button type="submit" class="btn btn-block">Done</button>
            </div>
        </form>
    </body>
</html>
