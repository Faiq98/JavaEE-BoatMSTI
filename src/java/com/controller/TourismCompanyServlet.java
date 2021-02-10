/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.bean.TourismCompanyBean;
import com.dao.TourismCompanyDao;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author fhfai
 */
public class TourismCompanyServlet extends HttpServlet {

    public TourismCompanyServlet() {
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
        String theCommand = request.getParameter("command");
        try {
            switch (theCommand) {
                case "registerTourismCompany":
                    registerTourismCompany(request, response);
                    break;
                case "loadTourismCompany":
                    loadTourismCompany(request, response);
                    break;
                case "updateTourismCompany":
                    updateTourismCompany(request, response);
                    break;
                case "deleteTourismCompany":
                    deleteTourismCompany(request, response);
                default:
                    loadTourismCompany(request, response);
                    break;
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

    private void registerTourismCompany(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            String compName = request.getParameter("companyName");
            String compAddress = request.getParameter("companyAddress");
            String compPhone = request.getParameter("companyPhone");
            String compEmail = request.getParameter("companyEmail");
            String compPassword = request.getParameter("companyPassword");

            TourismCompanyBean tcb = new TourismCompanyBean();

            tcb.setCompanyName(compName);
//            tcb.setCompanyAddress(compAddress);
            tcb.setCompanyPhone(compPhone);
            tcb.setCompanyEmail(compEmail);
            tcb.setCompanyPassword(compPassword);

            TourismCompanyDao tcd = new TourismCompanyDao();

            String companyRegister = tcd.registerTourismCompany(tcb);

            if (companyRegister.equals("SUCCESS")) {
                request.getRequestDispatcher("/Login.jsp").forward(request, response);
            } else {
                request.setAttribute("errMessage", companyRegister);
                request.getRequestDispatcher("TourismCompany/RegisterTourismCompany.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    private void loadTourismCompany(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String companyEmail = request.getParameter("companyEmail");
        System.out.println(companyEmail);

        TourismCompanyDao tcd = new TourismCompanyDao();
        TourismCompanyBean tcb = tcd.oneTourismCompany(companyEmail);
        request.setAttribute("TourismCompanyBean", tcb);

        RequestDispatcher rd = request.getRequestDispatcher("/TourismCompany/EditTourismCompany.jsp");
        rd.forward(request, response);

    }

    private void updateTourismCompany(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int compID = Integer.parseInt(request.getParameter("companyID"));
        String compName = request.getParameter("companyName");
        String compAddress = request.getParameter("companyAddress");
        String compPhone = request.getParameter("companyPhone");
        String compEmail = request.getParameter("companyEmail");
        String compPassword = request.getParameter("companyPassword");

        TourismCompanyDao tcd = new TourismCompanyDao();
        TourismCompanyBean tcb = new TourismCompanyBean();

        tcb.setCompanyID(compID);
        tcb.setCompanyName(compName);
//        tcb.setCompanyAddress(compAddress);
        tcb.setCompanyPhone(compPhone);
        tcb.setCompanyEmail(compEmail);
        tcb.setCompanyPassword(compPassword);

        int result = tcd.updateTourismCompany(tcb);
        if (result > 0) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert(\"Success Update the record\")");
            out.println("</script>");
            request.setAttribute("theMessage", "Success Update Record");
//            RequestDispatcher rd = request.getRequestDispatcher("");
//            rd.forward(request, response);
        }else{
            System.out.println("fail");
        }
    }

    private void deleteTourismCompany(HttpServletRequest request, HttpServletResponse response) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
