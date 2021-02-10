<%-- 
    Document   : EditImageTourismCompany
    Created on : Mar 25, 2020, 2:30:05 AM
    Author     : fhfai
--%>

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
            String companyEmail = (String) session.getAttribute("companyEmail");
            TourismCompanyDao tcd = new TourismCompanyDao();
            TourismCompanyBean tcb = tcd.oneTourismCompany(companyEmail);
        %>
        <jsp:include page="../header.jsp" flush="true"/>
        <div class="container tch" style="font-size: 20px;">
            <div class="row">
                <div class="col-md-12 mt-2 mb-2" style="background-color: #1B5360; padding: 10px; height: 334px;">
                    <img id="preview" src="#" alt="Tourism Company Cover"/>
                </div>
            </div>
            <div class="row">
                <div class="col mb-5">
                    <h3><center>Upload Your Company Cover Photo</center></h3>
                </div>
            </div>
            <form action="tourismCompanyCtrl" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="editImage"/>
                <input type="hidden" name="companyID" value="<%= tcb.getCompanyID()%>"/>
                <div class="row">
                    <div class="custom-file col mb-2 ml-3 mr-3">
                        <input type="file" class="custom-file-input" id="customFile" onchange="previewImage(this)" name="companyImg"/>
                        <label class="custom-file-label" for="customFile">Cover Page with Dimension 2460 x 936 </label>
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
