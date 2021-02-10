<%-- 
    Document   : data
    Created on : Feb 8, 2020, 12:50:10 AM
    Author     : fhfai
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.util.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>data</title>

        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
              integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
                integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
                integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>
    </head>
    <body>
        <%
            String city = "";
            String state = "";
            String poscode = request.getParameter("addPoscode");
            try {
                Connection con = DBConnection.createConnection();
                String query = "select * from address_info where addPoscode = ?";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, poscode);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    city = rs.getString("addCity");
                    state = rs.getString("addState");
                }
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
            <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <input type="text" class="form-control mb-2 mr-sm-2" value="<%out.print(city);%>" required/>
                </div>
                <div class="col-md-6">
                    <input type="text" class="form-control mb-2 mr-sm-2" value="<%out.print(state);%>" required/>
                </div>
            </div>
        </div>
    </body>
</html>
