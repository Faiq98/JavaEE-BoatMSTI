<%-- 
    Document   : test
    Created on : Apr 14, 2020, 12:06:57 AM
    Author     : fhfai
--%>

<%@page import="com.bean.PaymentBean"%>
<%@page import="com.dao.PaymentDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BoatMSTI</title>
    </head>
    <body style="margin:0px;padding:0px;overflow:hidden">
        <%
            String referenceNo = request.getParameter("referenceNo");
            System.out.println("ref: " + referenceNo);
            PaymentDao pd = new PaymentDao();
            PaymentBean pb = pd.paymentByRef(referenceNo);
        %>
        <iframe src="data:application/pdf;base64,<%= pb.getPaymentReceipt() %>" frameborder="0" style="overflow:hidden;overflow-x:hidden;overflow-y:hidden;height:100%;width:100%;position:absolute;top:0px;left:0px;right:0px;bottom:0px;" height="150%" width="150%"></iframe>
    </body>
</html>
