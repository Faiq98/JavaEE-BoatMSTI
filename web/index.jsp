<%-- 
    Document   : index.jsp
    Created on : Dec 6, 2019, 4:39:16 PM
    Author     : fhfai
--%>

<%@page import="com.bean.TourismCompanyBean"%>
<%@page import="com.dao.TourismCompanyDao"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.ServiceDao"%>
<%@page import="com.bean.BoatServiceBean"%>
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
    <!--    <body>
            <h1>Boat Management to Terengganu Island</h1>
            
            <form action="tourismCompanyCtrl" method="post">
                <button class="registerbtn">Register</button>
                <input type="hidden" name="action"> 
            </form>
            
            <a href="Login.jsp">Login to BMSTI</a>
        </body>-->

    <body>
        <!--------------- Header Section ------------->
        <!--        <section id="header">
                    <a style="color:white;text-decoration:none;padding:4px 6px;font-family:-apple-system, BlinkMacSystemFont, Ubuntu, Roboto, Noto, Arial, sans-serif;font-size:12px;font-weight:bold;line-height:1.2;display:inline-block;border-radius:3px" href="https://unsplash.com/@insolitus?utm_medium=referral&amp;utm_campaign=photographer-credit&amp;utm_content=creditBadge" target="_blank" rel="noopener noreferrer" title="Download free do whatever you want high-resolution photos from Rowan Heuvel"><span style="display:inline-block;padding:2px 3px"><svg xmlns="http://www.w3.org/2000/svg" style="height:12px;width:auto;position:relative;vertical-align:middle;top:-2px;fill:white" viewBox="0 0 32 32"><title>unsplash-logo</title><path d="M10 9V0h12v9H10zm12 5h10v18H0V14h10v9h12v-9z"></path></svg></span><span style="display:inline-block;padding:2px 3px">Rowan Heuvel</span></a>
                    <div class="container text-center">
                        <div class="boatmsti-box">
                                                <img src="img/faiq.jpeg">
                            <h1><span style="font-family: Courier; font-size: 60px;">Enjoy The Trip<br>With</span><br><span style="color: #3D969E; font-size: 70px">Boat</span><span style="color: #3D969E; font-size: 80px;">MSTI</span></h1>
                            <p>We Provide This Platform Just For You</p>
                                                <a href="Login.jsp" class="btn"><span>Login</span></a>
                        </div>
                    </div>
                    <div class="scroll-btn">
                        <div class="scroll-bar">
                            <a href="#about"><span></span></a>
                        </div>
                    </div>
                </section>-->

        <!----------------- BoatMSTI Section -------------->
        <section id="boatmsti-info">

            <jsp:include page="header.jsp" flush="true"/>

            <!--            <div class="nav-bar">
                            <nav class="navbar navbar-expand-lg">
                                <a class="navbar-brand" href="#top" style="color: white">BoatMSTI</a>
                                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                                    <i class="fa fa-bars"></i>
                                </button>
                                <div class="collapse navbar-collapse" id="navbarNav">
                                    <ul class="navbar-nav ml-auto">
                                        <li class="nav-item active">
                                            <a class="nav-link" href="#top">HOME</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="#about">ABOUT</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="#boatService">BOAT SERVICE</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="#services">SERVICE</a>
                                        </li>
                                    </ul>
                                </div>
                            </nav>
                        </div>-->

            <!------------ boat Service ------------------->

            <div class="boatService" id="boatService">
                <div class="container">
                    <div class="row">
                        <div>
                            <img style="width:80px" src="img/boatmstistroke.png"/>
                        </div>
                        <div class="col-md-8 mt-2">
                            <h1>Boat Ticket</h1>
                            <p>Search Your Online Boat Service Ticket Here...</p>
                        </div>
<!--                        <div class="col-md-2 mb-3" style=" margin-top: auto;">
                            <button class="btn btn-block btn-warning">Check Booking</button>
                        </div>-->
                    </div>
                    <div class="row">
                        <form class="form-inline search" action="customerCtrl" method="post">
                            <input type="hidden" name="action" value="searchTrip"/>
                            <label for="fromLocation" class="mr-sm-2">From: </label>
                            <!--                            <input type="text" class="form-control mb-2 mr-sm-2" name="fromLocation" id="fromLocation">-->
                            <select class="form-control mb-2 mr-sm-3" name="fromLocation" id="fromlocation">
                                <option value="Merang Jetty">Merang Jetty</option>
                                <option value="Shahbandar Jetty">Shahbandar Jetty</option>
                                <option value="Kuala Besut Jetty">Kuala Besut Jetty</option>
                                <option value="Kapas Island">Kapas Island</option>
                                <option value="Redang Island">Redang Island</option>
                                <option value="Lang Tengah Island">Lang Tengah Island</option>
                                <option value="Perhentian Island">Perhentian Island</option>
                            </select>
                            <label for="toLocation" class="mr-sm-2">To: </label>
                            <!--                            <input type="text" class="form-control mb-2 mr-sm-2" name="toLocation" id="toLocation">-->
                            <select class="form-control mb-2 mr-sm-3" name="toLocation" id="toLocation">
                                <option value="Kapas Island">Kapas Island</option>
                                <option value="Redang Island">Redang Island</option>
                                <option value="Lang Tengah Island">Lang Tengah Island</option>
                                <option value="Perhentian Island">Perhentian Island</option>
                                <option value="Merang Jetty">Merang Jetty</option>
                                <option value="Shahbandar Jetty">Shahbandar Jetty</option>
                                <option value="Kuala Besut Jetty">Kuala Besut Jetty</option>
                            </select>
                            <label for="departureDate" class="mr-sm-2 ml-sm-5">Departure Date: </label>
                            <input type="date" class="form-control mb-2 mr-sm-2" name="departDate" id="departDate" required>
                            <button type="submit" class="btn btn-block mb-2"><i class="fa fa-search"></i> Search</button>
                        </form>
                    </div>
                </div>
            </div>

            <!---------- About ----------->

            <!--            <div class="about container" id="about">
                            <div class="row">
                                <div class="col-md-6 text-center">
                                    <img src="img/boatmsti.png" class="profile-img">
            
                                </div>
                                <div class="col-md-6">
                                    <h3>Welcome to Boat Management System To Terengganu Islands</h3><br>
                                    <p>
                                        We also known as BoatMSTI and we gather all boat service information to Terengganu Islands 
                                        such as to Kapas Island, Perhentian Island, Redang Island and Lang Tengah Island
                                        in this website.
                                    </p>
                                </div>
                                <div class="col-md-12">
                                    <form action="tourismCompanyCtrl" method="post">
                                        <button class="btn btn-block">Have Own Company ? Feel Free to Join Us</button>
                                        <input type="hidden" name="action"> 
                                    </form>
                                </div>
                            </div>
                        </div>-->

            <!----------- Social Icon --------------->

            <!--                                    <div class="social-icons">
                                                    <ul>
                                                        <a href="https://www.linkedin.com/in/faiqhakimi">
                                                            <li><i class="fa fa-facebook"></i></li>
                                                        </a>
                                                        <a href="https://github.com/Faiq98">
                                                            <li><i class="fa fa-instagram"></i></li>
                                                        </a>
                                                        <a href="https://t.me/Izzfa">
                                                            <li><i class="fa fa-telegram"></i></li>
                                                        </a>
                                                        <a href="mailto:fhfaiq@gmail.com">
                                                            <li><i class="fa fa-envelope"></i></li>
                                                        </a>
                                                    </ul>
                                                </div>-->

            <!---------------- Services --------------------->

            <div class="services" id="services">
                <div class="container">
                    <h1 class="text-center">Services That We Provide</h1>
                    <p class="text-center">Suitable for all customer and Tourism Company that provide <br>boat service at Terengganu Only</p>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="services-box">
                                <i class="fa fa-ship e"></i><span>Boat Service Management</span>
                                <form action="tourismCompanyCtrl" method="post" class="text-center">
                                    <p class="text-center">
                                        With BoatMSTI, Tourism Company that provide boat service to Terengganu Islands can manage
                                        boat, boat service and customer booking ticket
                                    </p>
                                    <button class="btn mb-2">Join as Tourism Company</button>
                                    <input type="hidden" name="action">
                                </form>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="services-box">
                                <i class="fa fa-ticket"></i><span>Online Ticket Booking</span>
                                <form action="customerCtrl" method="post" class="text-center">
                                    <p class="text-center">
                                        Customer can use this platform to view and book the boat service to Terengganu Islands provided by
                                        the tourism company that registered with us
                                    </p>
                                    <button class="btn mb-2">Join as Customer</button>
                                    <input type="hidden" name="action"/>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!---------------- Joined Company --------------------->

            <%
                TourismCompanyDao tcd = new TourismCompanyDao();
                List<TourismCompanyBean> allTourismCompany = tcd.retrieveAllTourismCompany();
            %>

            <div class="joinedcompany" id="joinedcompany">
                <div class="container">
                    <h1 class="text-center">Tourism Company</h1>
                    <p class="text-center">Tourism Companies that joined with BoatMSTI. Just click the image below<br> to get see Tourism Companies details.</p>
                    <div id="demo" class="carousel slide" data-ride="carousel">
                        <ul class="carousel-indicators">
                            <li data-target="#demo" data-slide-to="0" class="active"></li>
                                <%
                                    for (int i = 0; i < allTourismCompany.size(); i++) {
                                %>
                            <li data-target="#demo" data-slide-to="<%= i%>"></li>
                                <%
                                    }
                                %>
                        </ul>
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="img/boatmsticover.png" alt="BoatMSTI" width="1100" height="500"> 
                            </div>
                            <%
                                for (int j = 0; j < allTourismCompany.size(); j++) {
                            %>
                            <div class="carousel-item">
                                <a href="TourismCompanyDetails.jsp?companyEmail=<%= allTourismCompany.get(j).getCompanyEmail()%>"><img src="data:image/jpg;base64,<%= allTourismCompany.get(j).getCompanyImg()%>" alt="<%= allTourismCompany.get(j).getCompanyName()%>" width="1100" height="500"></a>
                            </div>
                            <%
                                }
                            %>
                        </div>
                        <a class="carousel-control-prev" href="#demo" data-slide="prev">
                            <span class="carousel-control-prev-icon"></span>
                        </a>
                        <a class="carousel-control-next" href="#demo" data-slide="next">
                            <span class="carousel-control-next-icon"></span>
                        </a>
                    </div>

                    <form action="tourismCompanyCtrl" method="post">
                        <button class="btn btn-block">Have Own Company ? Feel Free to Join Us</button>
                        <input type="hidden" name="action"> 
                    </form>
                </div>
            </div>

            <!----------- Contact ------------->

            <div class="contact" id="contact">
                <div class="container text-center">
                    <h1>Contact BoatMSTI</h1>
                    <p class="text-center"></p> 

                    <div class="row">
                        <div class="col-md-4">
                            <i class="fa fa-phone"></i>
                            <p>+60 199616442</p>
                        </div>

                        <div class="col-md-4">
                            <i class="fa fa-envelope"></i>
                            <p><a href="mailto:fh.faiq@gmail.com" style="text-decoration: none; color: white">fh.faiq@gmail.com</a></p>
                        </div>

                        <div class="col-md-4">
                            <i class="fa fa-telegram"></i>
                            <p><a href="https://t.me/IzzFa" style="text-decoration: none; color: white">@IzzFa</a></p>
                        </div>
                    </div>
                </div>
                <jsp:include page="footer.jsp" flush="true"/>
            </div>
        </section>
        <!--        <script>
                    document.body.style.zoom = "80%";
                </script>-->
    </body>
</html>
