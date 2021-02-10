<%-- 
    Document   : EditTourismCompany
    Created on : Dec 7, 2019, 1:34:34 PM
    Author     : fhfai
--%>

<%@page import="com.bean.CustomerBean"%>
<%@page import="com.dao.CustomerDao"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.util.DBConnection"%>
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
    <%
        CustomerDao cd = new CustomerDao();
        String custEmail = (String) request.getSession().getAttribute("custEmail");
//        String companyEmail = request.getParameter("companyEmail");
        CustomerBean cb = cd.oneCustomer(custEmail);
    %>
    <body>
        <jsp:include page="../header.jsp" flush="true"/>
        <div class="container ch" style="font-size: 20px;">
            <div class="chprofile"> 
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
                            <input type="hidden" name="action" value="uploadImage"/>
                            <input type="hidden" name="custEmail" value="<%= cb.getCustID()%>"/>
                        </form>
                    </div>
                </div>

                <form action="customerCtrl" method="post">
                    <input type="hidden" name="action" value="edit"/>
                    <!--                    <div class="form-group">
                                            <label for="companyID"></label>-->
                    <input type="hidden" class="form-control" value="<%= cb.getCustID()%>" name="custID"/>
                    <!--                    </div>-->
                    <div class="card mt-3" style="padding: 30px; box-shadow: 1px 1px 5px #777;">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="firstName">First Name</label>
                                    <input type="text" class="form-control" value="<%= cb.getCustFirstName()%>" name="custFirstName"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="lastName">Last Name</label>
                                    <input type="text" class="form-control" value="<%= cb.getCustLastName()%>" name="custLastName"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="custPhone">Phone No</label>
                                    <input type="text" class="form-control" value="<%= cb.getCustPhone()%>" name="custPhone"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="custEmail">Email</label>
                                    <input type="text" class="form-control" value="<%= cb.getCustEmail()%>" name="custEmail"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="custCountry">Country</label>
                                    <input type="text" class="form-control" value="<%= cb.getCustCountry()%>" name="custCountry"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" grnBtn mt-3">
                        <button type="submit" class="btn btn-block">Done Edit</button>
                    </div>
                    <div class=" redBtn" style="margin-top: -10px;">
                        <input type="button" onclick="goBack()" class="btn btn-lg btn-block" value="Cancel"/>
                    </div>
                </form>
            </div>
        </div>
        <div>
            <jsp:include page="../footer.jsp" flush="true"/>
        </div>
    </body>
    <script>
        function goBack() {
            window.history.back();
        }

        $(document).ready(function () {
            $("#poscode").change(function () {
                var value = $(this).val();
                $.get("TourismCompany/addressData.jsp", {addPoscode: value}, function (data) {
                    $(".javaquery").html(data);
                });
            });
        });
    </script>
</html>
