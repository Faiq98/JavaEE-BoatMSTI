<%-- 
    Document   : EditTourismCompany
    Created on : Dec 7, 2019, 1:34:34 PM
    Author     : fhfai
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.util.DBConnection"%>
<%@page import="com.bean.AddressBean"%>
<%@page import="com.dao.TourismCompanyDao"%>
<%@page import="com.bean.TourismCompanyBean"%>
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
        TourismCompanyDao tcd = new TourismCompanyDao();
        String companyEmail = (String) request.getSession().getAttribute("companyEmail");
//        String companyEmail = request.getParameter("companyEmail");
        TourismCompanyBean tcb = tcd.oneTourismCompany(companyEmail);
        AddressBean ab = new AddressBean();
    %>
    <body>
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
                        <h3 style="display: inline"><%= tcb.getCompanyName()%> <i class="fa fa-info-circle tchicon"></i></h3>
                    </div>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-md-6">
                    <p><b>Company ID: </b><%= tcb.getCompanyID()%></p>
                </div>
                <div class="col-md-6">
                    <p><b>License No: </b><%= tcb.getCompanyLicense()%></p>
                </div>
            </div>
            <form name="form" action="tourismCompanyCtrl" method="post" onsubmit="return validate()">
                <div class="card" style="padding: 30px; box-shadow: 1px 1px 5px #777;">
                    <input type="hidden" name="action" value="edit"/>
                    <!--                    <div class="form-group">
                                            <label for="companyID"></label>-->
                    <input type="hidden" class="form-control" value="<%= tcb.getCompanyID()%>" name="companyID"/>
                    <!--                    </div>-->

                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#general"><span style="color: #000">General</span></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#address"><span style="color: #000">Address</span></a>
                        </li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div id="general" class="container tab-pane active"><br>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="companyName">Name</label>
                                        <input type="text" class="form-control" value="<%= tcb.getCompanyName()%>" name="companyName"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="companyLicense">License</label>
                                        <input type="text" class="form-control" value="<%= tcb.getCompanyLicense()%>" name="companyLicense"/>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="companyPhone">Phone No</label>
                                        <input type="text" class="form-control" value="<%= tcb.getCompanyPhone()%>" name="companyPhone"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="companyEmail">Email</label>
                                        <input type="text" class="form-control" value="<%= tcb.getCompanyEmail()%>" name="companyEmail"/>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="companyAbout">About</label>
                                        <textarea class="form-control" rows="5" name="companyAbout"><%= tcb.getCompanyAbout()%></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="address" class="container tab-pane fade"><br>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="companyAddress1">Street</label>
                                        <input type="text" class="form-control" value="<%= tcb.getCompanyAddress1()%>" name="companyAddress1"/>
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <div class="form-group">
                                        <label for="companyAddress2">Address</label>
                                        <input type="text" class="form-control" value="<%= tcb.getCompanyAddress2()%>" name="companyAddress2"/>
                                    </div>
                                </div>
                                <%
                                    String query = "select addPoscode from address_info";
                                    PreparedStatement ps = DBConnection.createConnection().prepareStatement(query);
                                    ResultSet rs = ps.executeQuery();
                                %>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="poscode">Postcode</label>
                                        <input id="poscode" list="postcodelist" class="form-control" value="<%= tcb.getAddPoscode().getAddPoscode()%>" name="addPoscode"/>
                                        <datalist id="postcodelist">
                                            <%
                                                while (rs.next()) {
                                            %>
                                            <option value="<%= rs.getInt(1)%>"><%= rs.getInt(1)%></option>
                                            <%
                                                }
                                            %>
                                        </datalist>
                                    </div>
                                </div>
                            </div>

                            <label for="city">City</label>    
                            <div class="form-group javaquery">
                                <div class="row">
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" value="<%= tcb.getAddPoscode().getAddCity()%>"/>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" value="<%= tcb.getAddPoscode().getAddState()%>"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr>
<!--                    <div class="row" style="padding-left: 5px; padding-right: 5px;">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="companyPassword">Password</label>
                                <input id="password" type="password" class="form-control" value="<%= tcb.getCompanyPassword()%>" name="companyPassword"/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="companyPassword">Re_Type Password</label>
                                <input type="password" id="reTypePassword" class="form-control" placeholder="Re-Type Password" name="companyPassword"/>
                            </div>
                        </div>
                    </div>-->
                </div>
                <div class=" grnBtn mt-3">
                    <button type="submit" class="btn btn-block">Done Edit</button>
                </div>
                <div class=" redBtn" style="margin-top: -10px;">
                    <input type="button" onclick="goBack()" class="btn btn-lg btn-block" value="Cancel"/>
                </div>
            </form>
        </div>
        <div>
            <jsp:include page="../footer.jsp" flush="true"/>
        </div>
    </body>
    <script>
//        function validate() {
//            var password = document.form.password.value;
//            var reTypePassword = document.form.reTypePassword.value;
//
//            if (password != reTypePassword) {
//                alert('Invalid Password, Please try again.');
//                return false;
//            }
//        }

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
