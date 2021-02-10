<%-- 
    Document   : RegisterCompany
    Created on : Dec 6, 2019, 10:50:46 PM
    Author     : fhfai
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.util.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
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
        <div class="registerpage" id="registerpage"></div>
        <div class="container">
            <div class="registerlogo" id="registerlogo">
                <img src="img/boatmstistroke.png" onclick="goBack();" style="cursor: pointer">
            </div>
            <div class="registerform" id="registerform">
                <div class="row">
                    <div class="col-md-12">
                        <form class="form" name="form" action="tourismCompanyCtrl" method="post" onsubmit="return validate()">
                            <div class="row">
                                <div class="col-md-8">
                                    <label for="companyName" style="float: left">Company Name</label>
                                    <input type="text" class="form-control mb-2 mr-sm-2" name="companyName" id="companyName" placeholder="Company Name" required>
                                </div>
                                <div class="col-md-4">
                                    <label for="companyLicense" style="float: left">License</label>
                                    <input type="text" class="form-control mb-2 mr-sm-2" name="companyLicense" id="companyLicense" placeholder="License" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <label for="companyPhone" style="float: left">Phone</label>
                                    <input type="text" class="form-control mb-2 mr-sm-2" name="companyPhone" id="companyPhone" placeholder="Phone Number" required>
                                </div>
                                <div class="col-md-8">
                                    <label for="companyEmail" style="float: left">Email</label>
                                    <input type="text" class="form-control mb-2 mr-sm-2" name="companyEmail" id="companyEmail" placeholder="Company Email" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <label for="companyAddress1" style="float: left">Street</label>
                                    <input type="text" class="form-control mb-2 mr-sm-2" name="companyAddress1" id="companyAddress1" placeholder="Street" required>
                                </div>
                                <div class="col-md-8">
                                    <label for="companyAddress2" style="float: left">Address</label>
                                    <input type="text" class="form-control mb-2 mr-sm-2" name="companyAddress2" id="companyAddress2" placeholder="Address" required>
                                </div>
                            </div>
                            <%
                                String query = "select addPoscode from address_info";
                                PreparedStatement ps = DBConnection.createConnection().prepareStatement(query);
                                ResultSet rs = ps.executeQuery();
                            %>
                            <div class="row">
                                <div class="col-md-12">
                                    <label for="addPoscode" style="float: left">Postcode</label>
                                    <input id="poscode" list="poscodelist" class="form-control mb-2 mr-sm-2" name="addPoscode" placeholder="Poscode" required/>
                                    <datalist id="poscodelist">
                                        <option>Select</option>
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
                            <div class="row javaquery">
                                <div class="col-md-6">
                                    <input type="text" class="form-control mb-2 mr-sm-2" placeholder="State"/>
                                </div>
                                <div class="col-md-6">
                                    <input type="text" class="form-control mb-2 mr-sm-2" placeholder="City"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <label for="companyPassword" style="float: left">Password</label>
                                    <input type="password" class="form-control mb-2 mr-sm-2" name="companyPassword" id="companyPassword" placeholder="Company Password" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <input type="password" class="form-control mb-2 mr-sm-2" name="companyRePassword" id="companyRePassword" placeholder="Re-Type Password" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 mt-2" style="margin-bottom: -10px;">
                                    <button type="submit" name="action" value="register" class="btn btn-block mb-2"><i class="fa fa-sign"></i> Register</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script>
        function goBack() {
            window.history.back();
        }

        function validate() {
            var companyPassword = document.form.companyPassword.value;
            var companyRePassword = document.form.companyRePassword.value;

            if (companyPassword != companyRePassword) {
                alert("Password does not match");
                $('#companyPassword').val('');
                $('#companyRePassword').val('');
                return false;
            }
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
