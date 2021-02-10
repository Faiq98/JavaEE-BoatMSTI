<%-- 
    Document   : Login.jsp
    Created on : Dec 6, 2019, 10:58:54 AM
    Author     : fhfai
--%>

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
            String bookpage = (String) request.getAttribute("bookpage");
        %>

        <div class="loginpage"></div>
        <div class="container">
            <div class="loginlogo" id="loginlogo">
                <img src="img/boatmstistroke.png" onclick="goBack();" style="cursor: pointer">
            </div>
            <center>
                <%
                    if (request.getAttribute("errMessage") != null) {
                %>
                <p><span style="color: red"><%= request.getAttribute("errMessage")%></span></p>
                    <%
                        }
                    %>
            </center>
            <div class="row">
                <div class="loginform">
                    <div class="col-md-12">
                        <form class="form" name="form" action="LoginServlet" method="post" onSubmit="validate()">
                            <input type="hidden" name="bookpage" value="<%= bookpage%>"/>
                            <input type="text" class="form-control mb-2 mr-sm-2" name="email" id="email" placeholder="Email">
                            <input type="password" class="form-control mb-2 mr-sm-2" name="password" id="password" placeholder="Password">
                            <div class="custom-control custom-radio custom-control-inline mb-2">
                                <input type="radio" class="custom-control-input" id="customRadio" name="role" value="customer" checked ><label class="custom-control-label" for="customRadio">Customer</label>
                            </div>
                            <div class="custom-control custom-radio custom-control-inline mb-2">
                                <input type="radio" class="custom-control-input" id="customRadio2" name="role" value="tourismCompany"><label class="custom-control-label" for="customRadio2">Tourism Company</label>
                            </div>
                            <p><a href="customerCtrl?action=''" style="color: #000; text-decoration: none" onmouseover="this.style.color='white'" onmouseout="this.style.color='black'">Register as New Customer</a></p>
                            <button type="submit" class="btn btn-block mb-2"><i class="fa fa-key"></i> Login</button>
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
            var email = document.form.email.value;
            var password = document.form.password.value;

            if (email == null || email == "") {
                alert("Email cannot be blank");
                return false;
            } else if (password == null || password == "") {
                alert("Password cannot be blank");
                return false;
            }
        }
    </script>
</html>
