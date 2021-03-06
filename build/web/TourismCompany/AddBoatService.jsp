<%-- 
    Document   : AddService
    Created on : Feb 26, 2020, 3:14:57 PM
    Author     : fhfai
--%>

<%@page import="com.dao.BoatDao"%>
<%@page import="com.bean.BoatBean"%>
<%@page import="com.dao.ServiceDao"%>
<%@page import="java.util.List"%>
<%@page import="com.bean.BoatServiceBean"%>
<%@page import="com.dao.TourismCompanyDao"%>
<%@page import="com.bean.TourismCompanyBean"%>
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
                        <h3 style="display: inline">Add Boat Service <i class="fa fa-service tchicon"></i></h3>
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
            <form action="boatServiceCtrl" method="post">
                <div class="card" style="padding: 30px; box-shadow: 1px 1px 5px #777;">
                    <input type="hidden" name="action" value="addBoatService"/>
                    <input type="hidden" class="form-control" value="<%= tcb.getCompanyID()%>" name="companyID"/>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <%
                                    BoatDao bd = new BoatDao();
                                    List<BoatBean> allBb = bd.retrieveAllBoatByID(tcb.getCompanyID());
                                %>
                                <label for="boatID">Boat ID</label>
                                <select class="form-control" placeholder="Choose Boat ID" name="boatID">
                                    <%
                                        for (int i = 0; i < allBb.size(); i++) {
                                    %>
                                    <option value="<%= allBb.get(i).getBoatID()%>"><%= allBb.get(i).getBoatID()%> | <%= allBb.get(i).getBoatType()%> | <%= allBb.get(i).getBoatCapacity()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="departureTime">Departure Time</label>
                                <input type="text" class="form-control" placeholder="exp: 08:00 (hh:mm)" name="departureTime" required/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="serviceName">Service Name</label>
                                <input type="text" class="form-control" placeholder="Enter Service Name" name="serviceName" required/>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="fromLocation">From Location</label>
                                <input list="fromlist" type="text" class="form-control" placeholder="Enter From Location" name="fromLocation" required/>
                                <datalist id="fromlist">
                                    <option value="Merang Jetty">Merang Jetty</option>
                                    <option value="Shahbandar Jetty">Shahbandar Jetty</option>
                                    <option value="Kuala Besut Jetty">Kuala Besut Jetty</option>
                                    <option value="Kapas Island">Kapas Island</option>
                                    <option value="Redang Island">Redang Island</option>
                                    <option value="Lang Tengah Island">Lang Tengah Island</option>
                                    <option value="Perhentian Island">Perhentian Island</option>
                                </datalist>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="toLocation">To Location</label>
                                <input list="tolist" type="text" class="form-control" placeholder="Enter To Location" name="toLocation" required/>
                                <datalist id="tolist">
                                    <option value="Kapas Island">Kapas Island</option>
                                    <option value="Redang Island">Redang Island</option>
                                    <option value="Lang Tengah Island">Lang Tengah Island</option>
                                    <option value="Perhentian Island">Perhentian Island</option>
                                    <option value="Merang Jetty">Merang Jetty</option>
                                    <option value="Shahbandar Jetty">Shahbandar Jetty</option>
                                    <option value="Kuala Besut Jetty">Kuala Besut Jetty</option>
                                </datalist>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-4">
                            <label for="AdultPrice">Adult Price</label>
                            <input type="text" class="form-control" placeholder="Enter Adult Price" name="AdultPrice" required/>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="ChildPrice">Child Price</label>
                            <input type="text" class="form-control" placeholder="Enter Child Price" name="ChildPrice" required/>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="Infant Price">Infant Price</label>
                            <input type="text" class="form-control" placeholder="Enter Infant Price" name="InfantPrice" required/>
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
