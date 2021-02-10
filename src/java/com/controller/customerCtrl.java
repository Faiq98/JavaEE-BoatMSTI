/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.bean.CustomerBean;
import com.dao.CustomerDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author fhfai
 */
@MultipartConfig(maxFileSize = 16177216)
public class customerCtrl extends HttpServlet {

    private static final String customerRecord = null;
    private static String registerForm = "/Customer/RegisterCustomer.jsp"; //create
    private static String home = "/Customer/CustomerHome.jsp"; //retrieve
    private static String editForm = "/Customer/EditCustomer.jsp"; //update
    private static String editImageForm = "/Customer/EditImageCustomer.jsp"; //update
    private static String deleteForm = "/Customer/DeleteCustomer.jsp"; //delete
    private static String loginForm = "/Login.jsp";
    private static String index = "/index.jsp";
    private static String trip = "/Customer/Trip.jsp";
    private CustomerDao cd;

    public customerCtrl() {
        super();
        cd = new CustomerDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String redirect = "";
        String action = request.getParameter("action");
        System.out.println("customerCtrl: " + action);
        
        String test = request.getParameter("test");
        System.out.println("test "+test);

        if (action.equalsIgnoreCase("register")) {
            //register process
            try {
                CustomerBean cb = new CustomerBean();
                cb.setCustFirstName(request.getParameter("custFirstName"));
                cb.setCustLastName(request.getParameter("custLastName"));
                cb.setCustPhone(request.getParameter("custPhone"));
                cb.setCustEmail(request.getParameter("custEmail"));
                cb.setCustCountry(request.getParameter("custCountry"));
                cb.setCustPassword(request.getParameter("custPassword"));
                cd.registerCustomer(cb);
                redirect = loginForm;

            } catch (SQLException ex) {
                System.out.println("ex" + ex);
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(customerCtrl.class.getName()).log(Level.SEVERE, null, ex);
            }

        } else if (action.equalsIgnoreCase("dashboard")) {
            try {
                redirect = home;
            } catch (Exception ex) {
                System.out.println(ex);
            }
            redirect = home;
        } else if (action.equalsIgnoreCase("editImageForm")) {
            //go to editimage form
            String custEmail = request.getParameter("custEmail");
            request.setAttribute("custEmail", custEmail);
            redirect = editImageForm;
        } else if (action.equalsIgnoreCase("editImage")) {
            //go to editimage
            try {
                int result = 0;
                Part part = request.getPart("custImg");
                int custID = Integer.parseInt(request.getParameter("custID"));

                cd.updateCustImg(part, custID);
                if (result > 0) {
                    redirect = home;
                } else {
                    System.out.println("Error");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            redirect = home;
        } else if (action.equalsIgnoreCase("editForm")) {
            //go to edit form
            String custEmail = request.getParameter("custEmail");
            request.setAttribute("custEmail", custEmail);
            redirect = editForm;
        } else if (action.equalsIgnoreCase("edit")) {
            //edit process
            try {

                CustomerBean cb = new CustomerBean();
                cb.setCustID(Integer.parseInt(request.getParameter("custID")));
                cb.setCustFirstName(request.getParameter("custFirstName"));
                cb.setCustLastName(request.getParameter("custLastName"));
                cb.setCustPhone(request.getParameter("custPhone"));
                cb.setCustEmail(request.getParameter("custEmail"));
                cb.setCustCountry(request.getParameter("custCountry"));
//                cb.setCustPassword(request.getParameter("custPassword"));
                
                cd.updateCustomer(cb);
                request.setAttribute("cb", cb);
                redirect = home;

            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } else if (action.equalsIgnoreCase("deleteImage")) {
            int custID = Integer.parseInt(request.getParameter("custID"));
            cd.deleteCustImg(custID);
            redirect = home;
        } else if (action.equalsIgnoreCase("searchTrip")) {
            String fromLocation = request.getParameter("fromLocation");
            String toLocation = request.getParameter("toLocation");
            String departDate = request.getParameter("departDate");
            request.setAttribute("fromLocation", fromLocation);
            request.setAttribute("toLocation", toLocation);
            request.setAttribute("departDate", departDate);
            redirect = trip;
        } else if (action.equalsIgnoreCase("delete")) {
        } else {
            redirect = registerForm;
        }

        RequestDispatcher rd = request.getRequestDispatcher(redirect);
        rd.forward(request, response);
    }

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
