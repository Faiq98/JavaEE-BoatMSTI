<%-- 
    Document   : header
    Created on : Feb 19, 2020, 7:13:25 PM
    Author     : fhfai
--%>

<%@page import="com.dao.TourismCompanyDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.bean.TourismCompanyBean"%>
<%@page import="java.util.List"%>
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
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
                integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
                integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>

        <!--Google translate -->
        <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
    </head>
    <body>
        <%
            response.setHeader("Cache-Contrl", "no-cache, no-store, must-revalidate");
        %>
        <div class="nav-bar">
            <nav class="navbar navbar-expand-lg">
                <a class="navbar-brand" href="index.jsp" style="color: white">BoatMSTI</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="fa fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav mr-auto w-100">
                        <!--                        <li class="nav-item active">
                                                    <a class="nav-link" href="index.jsp">Home</a>
                                                </li>-->
                        <li class="nav-item">
                            <a class="nav-link" href="index.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="index.jsp#boatService">Boat Ticket</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="index.jsp#services">Service</a>
                        </li>


                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown"> Company</a>
                            <div class="dropdown-menu dropdown-menu-left">
                                <%
                                    TourismCompanyDao tcd = new TourismCompanyDao();
                                    List<TourismCompanyBean> alltcb = tcd.retrieveAllTourismCompany();
                                    for (int i = 0; i < alltcb.size(); i++) {
                                %>
                                <a class="dropdown-item" href="TourismCompanyDetails.jsp?companyEmail=<%= alltcb.get(i).getCompanyEmail()%>"> <%= alltcb.get(i).getCompanyName()%></a>
                                <%
                                    }
                                %>
                            </div>
                        </li>
                    </ul>
                    <ul class="navbar-nav ml-auto user">
                        <%
                            if (session.getAttribute("companyEmail") != null) {

                                String companyEmail = String.valueOf(session.getAttribute("companyEmail"));
                                String pass = String.valueOf(session.getAttribute("companyPassword"));
                                String companyName = String.valueOf(session.getAttribute("companyName"));
                        %>
                        <!-- Google translate -->
                        <div style="padding-top: 8px;" id="google_translate_element"></div>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                                <i class="fa fa-user"> <%= companyName%></i>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right">
                                <form action="tourismCompanyCtrl" method="post">
                                    <input type="hidden" name="action" value="dashboard"/>
                                    <input type="hidden" name="companyEmail" value="<%= companyEmail%>"/>
                                    <button class="dropdown-item" type="submit"><i class="fa fa-ship"></i> Boat Service</button>
                                </form>
                                <form action="tourismCompanyCtrl" method="post">
                                    <input type="hidden" name="action" value="customerList"/>
                                    <input type="hidden" name="companyEmail" value="<%= companyEmail%>"/>
                                    <button class="dropdown-item" type="submit"><i class="fa fa-ticket"></i> Customer List</button>
                                </form>
                                <form action="tourismCompanyCtrl" method="post">
                                    <input type="hidden" name="action" value="report"/>
                                    <input type="hidden" name="companyEmail" value="<%= companyEmail%>"/>
                                    <button class="dropdown-item" type="submit"><i class="fa fa-file"></i> Report</button>
                                </form>
<!--                                <a class="dropdown-item" href="LogoutServlet"><i class="fa fa-question-circle"></i> Help</a>-->

                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="LogoutServlet"><i class="fa fa-sign-out"></i> Logout</a>
                            </div>
                        </li>
                        <%
                        } else if (session.getAttribute("custEmail") != null) {
                            String custEmail = String.valueOf(session.getAttribute("custEmail"));
                            String pass = String.valueOf(session.getAttribute("custPassword"));
                            String custFirstName = String.valueOf(session.getAttribute("custFirstName"));
                        %>
                        <!-- Google translate -->
                        <div style="padding-top: 8px;" id="google_translate_element"></div>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                                <i class="fa fa-user"> <%= custFirstName%></i>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right">
                                <form action="customerCtrl" method="post">
                                    <input type="hidden" name="action" value="dashboard"/>
                                    <input type="hidden" name="custEmail" value="<%= custEmail%>"/>
                                    <button class="dropdown-item" type="submit"><i class="fa fa-columns"></i> Dashboard</button>
                                    <!--                                    <a class="dropdown-item" href="TourismCompany/TourismCompanyHome.jsp"><i class="fa fa-columns"></i> Dashboard</a>-->
                                </form>
                                <!--                                                                <form action="customerCtrl" method="post">
                                                                                                    <input type="hidden" name="action" value="editForm"/>
                                                                                                    <input type="hidden" name="custEmail" value="<%= custEmail%>"/>
                                                                                                    <button class="dropdown-item" type="submit"><i class="fa fa-edit"></i> Profile</button>
                                                                                                                                        <a class="dropdown-item" href="TourismCompany/TourismCompanyHome.jsp"><i class="fa fa-columns"></i> Dashboard</a>
                                                                                                </form>-->
<!--                                <a class="dropdown-item" href="LogoutServlet"><i class="fa fa-question-circle"></i> Help</a>-->

                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="LogoutServlet"><i class="fa fa-sign-out"></i> Logout</a>
                            </div>
                        </li>
                        <%
                        } else {

                            String fail = String.valueOf(session.getAttribute("fail"));
                            String message = "";
                            if (fail.equals("1")) {
                                message = "wrong Credentials";
                                session.removeAttribute("fail");
                            }
                        %>

                        <!-- Google translate -->
                        <div style="padding-top: 8px;" id="google_translate_element"></div>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                                <i class="fa fa-user"> GUEST</i>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item" href="Login.jsp"><i class="fa fa-sign-in"></i> Login</a>
                            </div>
                        </li>
                        <%
                            }
                        %>
                    </ul>
                </div>
            </nav>
        </div>
        <script type="text/javascript">
            function googleTranslateElementInit() {
                new google.translate.TranslateElement({
                    pageLanguage: 'en', includedLanguages: 'en,ms,zh-CN',
                    layout: google.translate.TranslateElement.InlineLayout.SIMPLE
                }, 'google_translate_element');
            }

            $('document').ready(function () {
                $('#google_translate_element').on("click", function () {

                    // Change font family and color
                    $("iframe").contents().find(".goog-te-menu2-item div, .goog-te-menu2-item:link div, .goog-te-menu2-item:visited div, .goog-te-menu2-item:active div") //, .goog-te-menu2 *
                            .css({
                                'color': '#544F4B',
                                'background-color': '#fff',
                                'font-family': '"Open Sans",Helvetica,Arial,sans-serif',
                            });

                    // Change hover effects  #e3e3ff = white
                    $("iframe").contents().find(".goog-te-menu2-item div").hover(function () {
                        $(this).css('background-color', '#51702C').find('span.text').css('color', 'white');
                    }, function () {
                        $(this).css('background-color', 'white').find('span.text').css('color', '#544F4B');
                    });

                    // Change Google's default blue border
                    $("iframe").contents().find('.goog-te-menu2').css('border', '1px solid white');

                    $("iframe").contents().find('.goog-te-menu2').css('background-color', 'white');

                    // Change the iframe's box shadow
                    $(".goog-te-menu-frame").css({
                        '-moz-box-shadow': '0 3px 8px 2px #666666',
                        '-webkit-box-shadow': '0 3px 8px 2px #666',
                        'box-shadow': '0 3px 8px 2px #666'
                    });
                });
            });
        </script>
    </body>
</html>
