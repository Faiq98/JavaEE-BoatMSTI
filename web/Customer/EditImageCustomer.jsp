<%-- 
    Document   : EditImageTourismCompany
    Created on : Mar 25, 2020, 2:30:05 AM
    Author     : fhfai
--%>

<%@page import="com.bean.CustomerBean"%>
<%@page import="com.dao.CustomerDao"%>
<%@page import="com.bean.TourismCompanyBean"%>
<%@page import="com.dao.TourismCompanyDao"%>
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
//            response.setHeader("Cache-Control", "no-cache, no-store");
//            response.setHeader("Pragma", "no-cache");
//            response.setDateHeader("Expires", 0); 

//            String companyEmail = null;
//            if (session.getAttribute("companyEmail") == null) {
//                response.sendRedirect("../index.jsp");
//            } else {
//                companyEmail = (String) session.getAttribute("companyEmail");
//            }
            String custEmail = (String) session.getAttribute("custEmail");
            CustomerDao cd = new CustomerDao();
            CustomerBean cb = cd.oneCustomer(custEmail);
        %>
        <jsp:include page="../header.jsp" flush="true"/>
        <div class="container ch" style="font-size: 20px;">
            <div class="row text-center">
                <img id="preview" alt="profileimage"/>
            </div>
            <div class="row" style="background-color: #3D969E; height: 150px; margin-top: -100px; box-shadow: 1px 1px 5px #000;">
                <div class="col-md-12 custName" style="margin-top: 100px;">
                    <h3 style="display: inline; color: white;"><%= cb.getCustFirstName()%> <%= cb.getCustLastName()%> <button class="iconbutton" type="submit"><i class="fa fa-user chicon" style="color: white"></i></button></h3>
                </div>
            </div>
            <div class="row">
                <div class="col mb-3 mt-3">
                    <h3><center>Upload Your Profile Image</center></h3>
                </div>
            </div>
            <form action="customerCtrl" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="editImage"/>
                <input type="hidden" name="custID" value="<%= cb.getCustID() %>"/>
                <div class="row">
                    <div class="custom-file col mb-2 ml-3 mr-3">
                        <input type="file" class="custom-file-input" id="customFile" onchange="previewImage(this)" name="custImg"/>
                        <label class="custom-file-label" for="customFile">Size 500 x 500 </label>
                    </div>
                </div>
                <div class="row">
                    <div class="col mb-2">
                        <input style="background-color: #51702C; color: #fff" type="submit" class="btn btn-lg btn-block" value="Upload Image"/>
                    </div>
                </div>
                <div class="row">
                    <div class="col redBtn">
                        <input type="button" onclick="goBack()" class="btn btn-lg btn-block" value="Cancel"/>
                    </div>
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

            function previewImage(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#preview')
                                .attr('src', e.target.result)
                                .width = window.innerWidth;
                    };

                    reader.readAsDataURL(input.files[0]);
                }
            }

            $(".custom-file-input").on("change", function () {
                var fileName = $(this).val().split("\\").pop();
                $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
            });
        </script>
    </body>
</html>
