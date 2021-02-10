<%-- 
    Document   : TourismCompanyHome
    Created on : Dec 6, 2019, 11:19:41 AM
    Author     : fhfai
--%>

<%@page import="com.util.DBConnection"%>
<%@page import="java.io.OutputStream"%>
<%@page import="com.bean.BoatServiceBean"%>
<%@page import="java.util.List"%>
<%@page import="com.bean.TourismCompanyBean"%>
<%@page import="com.dao.TourismCompanyDao"%>
<%@page import="com.bean.BoatBean" %>
<%@page import="java.sql.*" %>
<jsp:useBean id="db" class="com.util.DBConnection" scope="request"/>
<jsp:useBean id="bd" class="com.dao.BoatDao" scope="request"/>
<jsp:useBean id="sd" class="com.dao.ServiceDao" scope="request"/>
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
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
                integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
                integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
                integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
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

        <div class="tchpage" id="tchpage"></div>
        <jsp:include page="../header.jsp" flush="true"/>
        <div class="container tch" id="tch" style="font-size: 20px;">
            <div class="tchprofile" id="tchprofile">
                <div class="row">
                    <div class="col-md-12 mt-2 mb-2" style="background-color: #1B5360; padding: 10px; height: 334px;">
                        <img src="data:image/jpg;base64,<%= tcb.getCompanyImg()%>" alt="cover page"/>
                        <form action="tourismCompanyCtrl" method="post">
                            <button class="tchCover editimage iconbutton" data-toggle="tooltip" data-placement="left" title="Edit Image" type="submit"><i class="fa fa-image"></i></button>
                            <input type="hidden" name="action" value="editImageForm"/>
                            <input type="hidden" name="companyID" value="<%= tcb.getCompanyID()%>"/>
                        </form>
                        <form action="tourismCompanyCtrl" method="post">
                            <button class="tchCover deleteimage iconbutton" data-toggle="tooltip" data-placement="top" title="Delete Image" type="submit"><i class="fa fa-trash"></i></button>
                            <input type="hidden" name="action" value="deleteImage"/>
                            <input type="hidden" name="companyID" value="<%= tcb.getCompanyID()%>"/>
                        </form>
                    </div>
                </div>
                <%
                    if (tcb.getCompanyImg() == null) {
                %>
                <div class="row">
                    <div class="col">
                        <form action="tourismCompanyCtrl" method="post">
                            <h3 style="display: inline"><%= tcb.getCompanyName()%> <button class="iconbutton" type="submit" disabled><i class="fa fa-user tchicon" data-toggle="tooltip" data-placement="right" title="To update company details please insert cover photo first"></i></button></h3>
                            <input type="hidden" name="action" value="editForm"/>
                            <input type="hidden" name="companyEmail" value="<%= tcb.getCompanyEmail()%>"/>
                        </form>
                    </div>
                </div>
                <%
                } else {
                %>
                <div class="row">
                    <div class="col">
                        <form action="tourismCompanyCtrl" method="post">
                            <h3 style="display: inline"><%= tcb.getCompanyName()%> <button class="iconbutton" type="submit" data-toggle="tooltip" data-placement="right" title="Edit Profile"><i class="fa fa-user tchicon"></i></button></h3>
                            <input type="hidden" name="action" value="editForm"/>
                            <input type="hidden" name="companyEmail" value="<%= tcb.getCompanyEmail()%>"/>
                        </form>
                    </div>
                </div>
                <%
                    }
                %>

                <!-- BoatInfo -->
                <div class="row" id="boatInfo">
                    <div class="col mb-2 mt-5">
                        <form action="boatCtrl" method="post">
                            <h3 style="display: inline">Boat <button class="iconbutton" type="submit"><i class="fa fa-plus-circle tchicon"></i></button></h3>
                            <input type="hidden" name="action" value="addBoatForm"/>
                            <input type="hidden" name="companyID" value="<%= tcb.getCompanyID()%>"/>
                        </form>
                    </div>
                </div> 
                <div class="row">
                    <%
                        List<BoatBean> allBoatByID = bd.retrieveAllBoatByID(tcb.getCompanyID());
                    %>
                    <div class="col-md-12 card" style="padding: 10px; box-shadow: 1px 1px 5px #777;">
                        <div style="overflow-x: auto;">
                            <table class="table table-striped dataTable">
                                <thead>
                                    <tr>
                                        <th>Bil</th>
                                        <th>Boat</th>
                                        <th>Boat Type</th>
                                        <th>Boat Capacity</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < allBoatByID.size(); i++) {
                                    %>
                                    <tr>
                                        <td><%= i + 1%></td>
                                        <td><%= allBoatByID.get(i).getBoatID()%></td>
                                        <td><%= allBoatByID.get(i).getBoatType()%></td>
                                        <td><%= allBoatByID.get(i).getBoatCapacity()%></td>
                                        <td>
                                            <form style="display:inline" action="boatCtrl" method="post">
                                                <input type="hidden" name="action" value="editBoatForm"/>
                                                <input type="hidden" name="boatID" value="<%= allBoatByID.get(i).getBoatID()%>"/>
                                                <button type="submit" class="iconbutton"><i class="fa fa-edit"></i></button>
                                            </form>
                                            <form style="display:inline" action="boatCtrl" method="post">
                                                <input type="hidden" name="action" value="deleteBoat"/>
                                                <input type="hidden" name="boatID" value="<%= allBoatByID.get(i).getBoatID()%>"/>
                                                <button type="submit" class="iconbutton" onclick="return deleteConfirmation()"><i class="fa fa-trash"></i></button>
                                            </form>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- BoatService -->
                <div class="row" id="boatService">
                    <div class="col mb-2 mt-5">
                        <form action="boatServiceCtrl" method="post">
                            <h3 style="display: inline">Service <button class="iconbutton" type="submit"><i class="fa fa-plus-circle tchicon"></i></button></h3>
                            <input type="hidden" name="action" value="addBoatServiceForm"/>
                            <input type="hidden" name="companyID" value="<%= tcb.getCompanyID()%>"/>
                        </form>
                    </div>
                </div> 
                <div class="row">
                    <%
                        List<BoatServiceBean> allBoatServiceByID = sd.retrieveAllBoatServiceByID(tcb.getCompanyID());
                    %>
                    <div class="col-md-12 card" style="padding: 10px; box-shadow: 1px 1px 5px #777;">
                        <div style="overflow-x: auto">
                            <table class="table table-striped dataTable">
                                <thead>
                                    <tr>
                                        <th>Service</th>
                                        <th>Boat</th>
                                        <th>Name</th>
                                        <th>From</th>
                                        <th>To</th>
                                        <th>Time</th>
                                        <th>Adult</th>
                                        <th>Child</th>
                                        <th>Infant</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < allBoatServiceByID.size(); i++) {
                                    %>
                                    <tr>
                                        <td><%= allBoatServiceByID.get(i).getServiceID()%></td>
                                        <td><%= allBoatServiceByID.get(i).getBoatID().getBoatID()%></td>
                                        <td><%= allBoatServiceByID.get(i).getServiceName()%></td>
                                        <td><%= allBoatServiceByID.get(i).getFromLocation()%></td>
                                        <td><%= allBoatServiceByID.get(i).getToLocation()%> </td>
                                        <td><%= allBoatServiceByID.get(i).getDepartureTime()%></td>
                                        <td><%= allBoatServiceByID.get(i).getAdultPrice()%></td>
                                        <td><%= allBoatServiceByID.get(i).getChildPrice()%></td>
                                        <td><%= allBoatServiceByID.get(i).getInfantPrice()%></td>
                                        <td>
                                            <form style="display:inline" action="boatServiceCtrl" method="post">
                                                <input type="hidden" name="action" value="editBoatServiceForm"/>
                                                <input type="hidden" name="serviceID" value="<%= allBoatServiceByID.get(i).getServiceID()%>"/>
                                                <button type="submit" class="iconbutton"><i class="fa fa-edit"></i></button>
                                            </form>
                                            <form style="display:inline" action="boatServiceCtrl" method="post">
                                                <input type="hidden" name="action" value="deleteBoatService"/>
                                                <input type="hidden" name="serviceID" value="<%= allBoatServiceByID.get(i).getServiceID()%>"/>
                                                <button type="submit" class="iconbutton" onclick="return deleteConfirmation()"><i class="fa fa-trash"></i></button>
                                            </form>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <jsp:include page="../footer.jsp" flush="true"/>
        </div>
        <script>
            $(document).ready(function () {
                $('[data-toggle="tooltip"]').tooltip();
            });

            $(document).ready(function () {
                $('.dataTable').DataTable({
                    "order": [[0, "desc"]],
                    "lengthMenu": [[5, 25, 50, -1], [5, 25, 50, "All"]]
                            //                    columnDefs: [{
                            //                            targets: [0],
                            //                            orderData: [0, 1]
                            //                        }, {
                            //                            targets: [1],
                            //                            orderData: [1, 0]
                            //                        }, {
                            //                            targets: [4],
                            //                            orderData: [4, 0]
                            //                        }]
                });
            });

            function deleteConfirmation() {
                var x = confirm("Press OK to delete.");
                if (x)
                    return true;
                else
                    return false;
            }
        </script>
    </body>
</html>
