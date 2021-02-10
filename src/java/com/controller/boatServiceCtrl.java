/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.bean.BoatBean;
import com.bean.BoatServiceBean;
import com.bean.TourismCompanyBean;
import com.dao.ServiceDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author fhfai
 */
public class boatServiceCtrl extends HttpServlet {

    private static final String boatServiceRecord = null;
    private static String addBoatServiceForm = "/TourismCompany/AddBoatService.jsp"; //create
    private static String tchome = "/TourismCompany/TourismCompanyHome.jsp"; //retrieve
    private static String editBoatServiceForm = "/TourismCompany/EditBoatService.jsp"; //update
    private static String deleteForm = "/TourismCompany/DeleteTourismCompany.jsp"; //delete
//    private static String loginForm = "/Login.jsp";
    private ServiceDao sd;

    public boatServiceCtrl() {
        super();
        sd = new ServiceDao();
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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet boatServiceCtrl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet boatServiceCtrl at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String redirect = "";
        String action = request.getParameter("action");

        if (action.equalsIgnoreCase("addBoatServiceForm")) {
            int companyID = Integer.parseInt(request.getParameter("companyID"));
            request.setAttribute("companyID", companyID);
            redirect = addBoatServiceForm;
        } else if (action.equalsIgnoreCase("addBoatService")) {
            try {
                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyID(Integer.parseInt(request.getParameter("companyID")));

                BoatBean bb = new BoatBean();
                bb.setBoatID(request.getParameter("boatID"));

                BoatServiceBean bsb = new BoatServiceBean();
                bsb.setCompanyID(tcb);
                bsb.setBoatID(bb);
                bsb.setServiceName(request.getParameter("serviceName"));
//                bsb.setServiceType(request.getParameter("serviceType"));
                bsb.setFromLocation(request.getParameter("fromLocation"));
                bsb.setToLocation(request.getParameter("toLocation"));
                bsb.setDepartureTime(request.getParameter("departureTime"));
                bsb.setAdultPrice(Double.parseDouble(request.getParameter("AdultPrice")));
                bsb.setChildPrice(Double.parseDouble(request.getParameter("ChildPrice")));
                bsb.setInfantPrice(Double.parseDouble(request.getParameter("InfantPrice")));

                sd.addBoatService(bsb);
                redirect = tchome;

            } catch (Exception ex) {
                System.out.println("Exception is: " + ex);
            }
        } else if (action.equalsIgnoreCase("editBoatServiceForm")) {
            String serviceID = request.getParameter("serviceID");
            request.setAttribute("serviceID", serviceID);
            redirect = editBoatServiceForm;
        } else if (action.equalsIgnoreCase("editBoatService")) {
            try {
                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyID(Integer.parseInt(request.getParameter("companyID")));

                BoatBean bb = new BoatBean();
                bb.setBoatID(request.getParameter("boatID"));

                BoatServiceBean bsb = new BoatServiceBean();
                bsb.setServiceID(Integer.parseInt(request.getParameter("serviceID")));
                bsb.setCompanyID(tcb);
                bsb.setBoatID(bb);
                bsb.setServiceName(request.getParameter("serviceName"));
//                bsb.setServiceType(request.getParameter("serviceType"));
                bsb.setFromLocation(request.getParameter("fromLocation"));
                bsb.setToLocation(request.getParameter("toLocation"));
                bsb.setDepartureTime(request.getParameter("departureTime"));
                bsb.setAdultPrice(Double.parseDouble(request.getParameter("AdultPrice")));
                bsb.setChildPrice(Double.parseDouble(request.getParameter("ChildPrice")));
                bsb.setInfantPrice(Double.parseDouble(request.getParameter("InfantPrice")));                
                
                sd.updateBoatService(bsb);
                request.setAttribute("bsb", bsb);
                redirect = tchome;
            
            } catch (Exception ex) {
                System.out.println("Exception editBoatService: " + ex);
            }
        } else if (action.equalsIgnoreCase("deleteBoatService")) {
            String serviceID = request.getParameter("serviceID");
            sd.deleteBoatService(serviceID);
            redirect = tchome;
        } else {
            redirect = tchome;
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
