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
                        <form class="form" name="form" action="customerCtrl" method="post" onsubmit="return validate()">
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="custFirstName" style="float: left">First Name</label>
                                    <input type="text" class="form-control mb-2 mr-sm-2" name="custFirstName" id="custFirstName" placeholder="First Name" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="custLastName" style="float: left">Last Name</label>
                                    <input type="text" class="form-control mb-2 mr-sm-2" name="custLastName" id="custLastName" placeholder="Last Name" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="custPhone" style="float: left">Phone</label>
                                    <input type="text" class="form-control mb-2 mr-sm-2" name="custPhone" id="custPhone" placeholder="Phone No" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="custEmail" style="float: left">Email</label>
                                    <input type="text" class="form-control mb-2 mr-sm-2" name="custEmail" id="custEmail" placeholder="Email" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <label for="custCountry" style="float: left">Country</label>
                                    <input type="text" class="form-control mb-2 mr-sm-2" name="custCountry" id="custCountry" placeholder="Country" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <label for="custPassword" style="float: left">Password</label>
                                    <input type="password" class="form-control mb-2 mr-sm-2" name="custPassword" id="custPassword" placeholder="Password">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <input type="password" class="form-control mb-2 mr-sm-2" name="rePassword" id="rePassword" placeholder="Re-Type Password">
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
            var custPassword = document.form.custPassword.value;
            var rePassword = document.form.rePassword.value;

            if (custPassword != rePassword) {
                alert("Password do not match");
                $('#custPassword').val('');
                $('#rePassword').val('');
                return false;
            }
        }
    </script>
</html>
