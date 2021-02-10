<%-- 
    Document   : tourismCompanyDetails
    Created on : Mar 27, 2020, 3:20:35 AM
    Author     : fhfai
--%>

<%@page import="com.bean.TourismCompanyBean"%>
<%@page import="com.dao.TourismCompanyDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1">
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
            String companyEmail = request.getParameter("companyEmail");
            TourismCompanyDao tcd = new TourismCompanyDao();
            TourismCompanyBean tcb = tcd.oneTourismCompany(companyEmail);
        %>

        <div class="tchpage"></div>
        <jsp:include page="header.jsp" flush="true"/>
        <div class="container tch" id="tch" style="font-size: 20px;">
            <div class="tchprofile" id="tchprofile">
                <div class="row">
                    <div class="col-md-12 mt-2 mb-2" style="background-color: #1B5360; padding: 10px; height: 334px;">
                        <img src="data:image/jpg;base64,<%= tcb.getCompanyImg()%>" alt="cover page"/>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col">
                        <h3 style="display: inline"><%= tcb.getCompanyName()%> <button class="iconbutton" type="submit"><i class="fa fa-user tchicon"></i></button></h3>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 text-center">
                        <div class="card">
                            <div class="card-header" style="background-color: #3D969E; color: white"><h4>About</h4></div>
                            <div class="card-body">
                                <span style="font-size: 20px;">
                                    <%= tcb.getCompanyAbout()%>
                                </span>
                            </div>
                            <!--                    <div class="card-footer">Footer</div>-->
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header" style="background-color: #3D969E; color: white"><h4><center>Contact</center></h4></div>
                            <div class="card-body">
                                <p><img src="img/gmail.png" alt="Smiley face" align="middle" style="width: 45px; height: 45px; margin: 10px"><%= tcb.getCompanyEmail() %></p>
                                <p><img src="img/contact.png" alt="Smiley face" align="middle" style="width: 45px; height: 45px; margin: 10px"><%= tcb.getCompanyPhone() %></p>
                                <p><img src="img/cross.png" alt="Smiley face" align="left" style="width: 45px; height: 45px; margin: 10px">
                                    <%= tcb.getCompanyAddress1() %> <%= tcb.getCompanyAddress2() %><br><%= tcb.getAddPoscode().getAddPoscode() %> <%= tcb.getAddPoscode().getAddState() %>, <%= tcb.getAddPoscode().getAddCity() %>
                                </p>
                            </div>
                            <!--                    <div class="card-footer">Footer</div>-->
                        </div>
                    </div>
                </div>

                <hr class="mb-4">
                <div class="redBtn printBtn" style="margin-top: -10px;">
                    <input onclick="window.history.back()" type="button" class="btn btn-lg btn-block" type="submit" value="Back">
                </div>
            </div>
        </div>
        <div>
            <jsp:include page="footer.jsp" flush="true"/>
        </div>
        <script>
            $(document).ready(function () {
                $('[data-toggle="tooltip"]').tooltip();
            });
        </script>
    </body>
</html>
