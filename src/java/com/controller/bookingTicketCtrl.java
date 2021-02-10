/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.bean.BoatServiceBean;
import com.bean.BookingTicketBean;
import com.bean.CustomerBean;
import com.bean.PaymentBean;
import com.dao.BookingTicketDao;
import com.dao.CustomerDao;
import com.dao.PaymentDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author fhfai
 */
@MultipartConfig(maxFileSize = 16177216)
public class bookingTicketCtrl extends HttpServlet {

    private static final String bookingTicketRecord = null;
    private static String addBookingTicketForm = "/Customer/BookingTicket.jsp"; //create
    private static String chome = "/Customer/CustomerHome.jsp";
//    private static String editBoatForm = "/TourismCompany/EditBoat.jsp"; //update
//    private static String deleteForm = "/TourismCompany/DeleteTourismCompany.jsp"; //delete
    private static String ticket = "/Customer/Ticket.jsp";
    private static String trip = "/Customer/Trip.jsp";
    private static String customerList = "/TourismCompany/CustomerList.jsp";
    private static String loginForm = "/Login.jsp";
    private static String index = "/Index.jsp";
    private BookingTicketDao btd;
    private PaymentDao pd;

    public bookingTicketCtrl() {
        super();
        btd = new BookingTicketDao();
        pd = new PaymentDao();

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String redirect = "";
        String action = request.getParameter("action");

        if (action.equalsIgnoreCase("addBookingForm")) {

            HttpSession session = request.getSession();
            if (session.getAttribute("custEmail") != null) {
                int serviceID = Integer.parseInt(request.getParameter("serviceID"));
                String departDate = request.getParameter("departDate");
                int bookAdult = Integer.parseInt(request.getParameter("bookAdult"));
                int bookChild = Integer.parseInt(request.getParameter("bookChild"));
                int bookInfant = Integer.parseInt(request.getParameter("bookInfant"));

                request.setAttribute("serviceID", serviceID);
                request.setAttribute("departDate", departDate);
                request.setAttribute("bookAdult", bookAdult);
                request.setAttribute("bookChild", bookChild);
                request.setAttribute("bookInfant", bookInfant);
                redirect = addBookingTicketForm;
            } else {
                String bookpage = "bookpage";
                request.setAttribute("bookpage", bookpage);
                redirect = loginForm;
            }

        } else if (action.equalsIgnoreCase("addBookingTicket")) {
            try {

                CustomerBean cb = new CustomerBean();
                cb.setCustID(Integer.parseInt(request.getParameter("custID")));

                BoatServiceBean bsb = new BoatServiceBean();
                bsb.setServiceID(Integer.parseInt(request.getParameter("serviceID")));

                PaymentBean pb = new PaymentBean();
                pb.setReferenceNo(request.getParameter("referenceNo"));
                pb.setPaymentAmount(Double.parseDouble(request.getParameter("paymentAmount")));
                Part part = request.getPart("paymentReceipt");

                BookingTicketBean btb = new BookingTicketBean();
                btb.setCustID(cb);
                btb.setServiceID(bsb);
                btb.setReferenceNo(pb);
                btb.setDepartDate(request.getParameter("departDate"));
                btb.setBookAdult(Integer.parseInt(request.getParameter("bookAdult")));
                btb.setBookChild(Integer.parseInt(request.getParameter("bookChild")));
                btb.setBookInfant(Integer.parseInt(request.getParameter("bookInfant")));
                btb.setTotalBook(Integer.parseInt(request.getParameter("totalBook")));

                pd.addPayment(pb, part);
                btd.addBookingTicket(btb);
                redirect = chome;

            } catch (Exception ex) {
                System.out.println("Exception addBookingTicket is: " + ex);
            }
        } else if (action.equalsIgnoreCase("trip")) {
            String fromLocation = "Merang Jetty";
            String toLocation = "Redang Island";
            Date date = new Date();
            SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
            String currentDate = ft.format(date);
            
            request.setAttribute("departDate", currentDate);
            request.setAttribute("fromLocation", fromLocation);
            request.setAttribute("toLocation", toLocation);
            redirect = trip;
        }else if(action.equalsIgnoreCase("viewTicket")){
            int bookID = Integer.parseInt(request.getParameter("bookID"));
            request.setAttribute("bookID", bookID);
            redirect = ticket;
        }else if(action.equalsIgnoreCase("updateStatus")){
            int bookID = Integer.parseInt(request.getParameter("bookID"));
            String Check = request.getParameter("check");
            
            BookingTicketBean btb = new BookingTicketBean();
            btb.setBookID(bookID);
            btb.setStatus(Check);
            btd.updateStatus(btb);
            request.setAttribute("btb", btb);
            redirect = customerList;
            
        } else if (action.equalsIgnoreCase("deleteBookingTicket")) {
            String referenceNo = request.getParameter("referenceNo");
            int bookID = Integer.parseInt(request.getParameter("bookID"));
            System.out.println("delete payment "+referenceNo);
            btd.deleteBookingTicket(bookID);
            pd.deletePayment(referenceNo);
            redirect = customerList;
        } else {
            redirect = index;
        }

        RequestDispatcher rd = request.getRequestDispatcher(redirect);
        rd.forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
