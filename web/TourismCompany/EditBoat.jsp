<%-- 
    Document   : EditBoat
    Created on : Feb 25, 2020, 9:10:26 PM
    Author     : fhfai
--%>

<%@page import="com.bean.TourismCompanyBean"%>
<%@page import="com.dao.TourismCompanyDao"%>
<%@page import="com.bean.BoatBean"%>
<%@page import="com.dao.BoatDao"%>
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

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
                integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
                integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
                integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>
    </head>
    <body>
        <%
            String companyEmail = (String) session.getAttribute("companyEmail");
            TourismCompanyDao tcd = new TourismCompanyDao();
            TourismCompanyBean tcb = tcd.oneTourismCompany(companyEmail);

            BoatDao bd = new BoatDao();
            String boatID = request.getParameter("boatID");

            BoatBean bb = bd.BoatById(boatID);
        %>
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
                        <h3 style="display: inline">Edit Boat <i class="fa fa-ship tchicon"></i></h3>
                    </div>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-md-6">
                    <p><b>Company: </b><%= tcb.getCompanyName()%></p>
                </div>
                <div class="col-md-6">
                    <p><b>License No: </b><%= tcb.getCompanyLicense()%></p>
                </div>
            </div>
            <form action="boatCtrl" method="post">
                <div class="card" style="padding: 30px; box-shadow: 1px 1px 5px #777;">
                    <input type="hidden" name="action" value="editBoat"/>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="boatID">Register No</label>
                                <input type="text" class="form-control" value="<%= bb.getBoatID()%>" name="boatID"/>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="boatTpe">Boat Type</label>
                                <input list="typelist" type="text" class="form-control" value="<%= bb.getBoatType()%>" name="boatType"/>
                                <datalist id="typelist">
                                    <option value="Passenger Boat">Passenger Boat</option>
                                    <option value="Speed Boat">Speed Boat</option>
                                    <option value="Ferry">Ferry</option>
                                </datalist>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="boatCapacity">Capacity</label>
                                <input type="text" class="form-control" value="<%= bb.getBoatCapacity()%>" name="boatCapacity"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class=" grnBtn mt-3">
                    <button type="submit" class="btn btn-block">Done</button>
                </div>
                <div class=" redBtn" style="margin-top: -10px;">
                    <input type="button" onclick="goBack()" class="btn btn-lg btn-block" value="Cancel"/>
                </div>
            </form>
        </div>
        <div>
            <jsp:include page="../footer.jsp" flush="true"/>
        </div>
        <script>
            function goBack() {
                window.history.back();
            }
        </script>
    </body>
</html>
