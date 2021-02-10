/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.bean.CustomerBean;
import com.bean.TourismCompanyBean;
import com.dao.LoginDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author fhfai
 */
public class LoginServlet extends HttpServlet {

    public LoginServlet() {
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = request.getParameter("role");
        try {
            switch (role) {
                case "customer":
                    loginCustomer(request, response);
                    break;
                case "tourismCompany":
                    loginTourismCompany(request, response);
                    break;
//                case "cancel":
//                    cancel(request, response);
                default:
//                    cancel(request, response);
            }
        } catch (Exception ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
        processRequest(request, response);
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

    //Customer Login
    private void loginCustomer(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String custEmail = request.getParameter("email");
        String custPassword = request.getParameter("password");
        String bookpage = request.getParameter("bookpage");

        CustomerBean cb = new CustomerBean();

        cb.setCustEmail(custEmail);
        cb.setCustPassword(custPassword);
        cb.setCustFirstName(custPassword);

        LoginDao ld = new LoginDao();

        String customerValidate = ld.authenticateCustomer(cb);

        if (customerValidate.equals("SUCCESS") && bookpage.equalsIgnoreCase("null")) {
            HttpSession session = request.getSession();
            session.removeAttribute("fail");
            session.setAttribute("custPassword", custPassword);
            session.setAttribute("custEmail", custEmail);
            session.setAttribute("custFirstName", cb.getCustFirstName());
            getServletContext().getRequestDispatcher("/Customer/CustomerHome.jsp").forward(request, response);
        } else if (customerValidate.equals("SUCCESS") && bookpage.equalsIgnoreCase("bookpage")) {
            HttpSession session = request.getSession();
            session.removeAttribute("fail");
            session.setAttribute("custPassword", custPassword);
            session.setAttribute("custEmail", custEmail);
            session.setAttribute("custFirstName", cb.getCustFirstName());
            getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
        } else {
            request.setAttribute("errMessage", customerValidate);
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
        }
    }

    //Tourism Company Login
    private void loginTourismCompany(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String compEmail = request.getParameter("email");
        String compPassword = request.getParameter("password");

        TourismCompanyBean tcb = new TourismCompanyBean();

        tcb.setCompanyEmail(compEmail);
        tcb.setCompanyPassword(compPassword);

        LoginDao ld = new LoginDao();

        String companyValidate = ld.authenticateTourismCompany(tcb);

        if (companyValidate.equals("SUCCESS")) {
            HttpSession session = request.getSession();
            session.removeAttribute("fail");
            session.setAttribute("companyEmail", compEmail);
            session.setAttribute("companyPassword", compPassword);
            session.setAttribute("companyName", tcb.getCompanyName());
            getServletContext().getRequestDispatcher("/TourismCompany/TourismCompanyHome.jsp").forward(request, response);
        } else {
            request.setAttribute("errMessage", companyValidate);
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
        }
    }

//    private void cancel(HttpServletRequest request, HttpServletResponse response) throws Exception {
//        request.getRequestDispatcher("/LoginServlet").forward(request, response);
//    }
}
