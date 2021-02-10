<%-- 
    Document   : test
    Created on : Apr 9, 2020, 2:41:00 AM
    Author     : fhfai
--%>

<%@page import="com.bean.CustomerBean"%>
<%@page import="com.dao.CustomerDao"%>
<%@page import="com.bean.BoatBean"%>
<%@page import="com.dao.BoatDao"%>
<%@page import="com.bean.PaymentBean"%>
<%@page import="com.dao.PaymentDao"%>
<%@page import="com.bean.BoatServiceBean"%>
<%@page import="com.dao.ServiceDao"%>
<%@page import="com.bean.TourismCompanyBean"%>
<%@page import="com.dao.TourismCompanyDao"%>
<%@page import="com.bean.BookingTicketBean"%>
<%@page import="com.dao.BookingTicketDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Integer bookID = (Integer)request.getAttribute("bookID");
            BookingTicketDao btd = new BookingTicketDao();
            BookingTicketBean btb = btd.oneBookingTicket(bookID);
            
            TourismCompanyDao tcd = new TourismCompanyDao();
            TourismCompanyBean tcb = tcd.oneTourismCompany(btb.getServiceID().getCompanyID().getCompanyEmail());
            
            ServiceDao sd = new ServiceDao();
            BoatServiceBean bsb = sd.BoatServiceById(btb.getServiceID().getServiceID());
            
            BoatDao bd = new BoatDao();
            BoatBean bb = bd.BoatById(bsb.getBoatID().getBoatID());
            
            String custEmail = (String) session.getAttribute("custEmail");
            CustomerDao cd = new CustomerDao();
            CustomerBean cb = cd.oneCustomer(custEmail);
        %>
        
        <p><%= tcb.getCompanyName() %></p>
        <p><%= tcb.getCompanyPhone() %></p>
        <p><%= tcb.getCompanyEmail() %></p>
        
        <p><%= bsb.getFromLocation() %></p>
        <p><%= bsb.getToLocation() %></p>
        <p><%= bsb.getDepartureTime() %></p>
        
        <p><%= bb.getBoatID() %></p>
        <p><%= bb.getBoatType() %></p>
    </body>
</html>
