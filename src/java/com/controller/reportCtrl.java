/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.bean.ReportBean;
import com.bean.TourismCompanyBean;
import com.dao.ReportDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author fhfai
 */
public class reportCtrl extends HttpServlet {

    private static final String reportRecord = null;
    //private static String addBoatForm = "/TourismCompany/AddBoat.jsp"; //create
    private static String reportPage = "/TourismCompany/Report.jsp"; //retrieve
    private static String editReportForm = "/TourismCompany/EditReport.jsp"; //update
//    private static String deleteForm = "/TourismCompany/DeleteTourismCompany.jsp"; //delete
//    private static String loginForm = "/Login.jsp";
    private ReportDao rd;

    public reportCtrl() {
        super();
        rd = new ReportDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String redirect = "";
        String action = request.getParameter("action");

        if (action.equalsIgnoreCase("addReport")) {
            try {
                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyID(Integer.parseInt(request.getParameter("companyID")));

                ReportBean rb = new ReportBean();
                rb.setCompanyID(tcb);
                rb.setTotalCustomer(Integer.parseInt(request.getParameter("totalCustomer")));
                rb.setSales(Double.parseDouble(request.getParameter("sales")));

                rd.addReport(rb);
                redirect = reportPage;

            } catch (Exception ex) {
                System.out.println("Exception rc is addreport: " + ex);
            }
        } else if (action.equalsIgnoreCase("editReportForm")) {
            Integer reportID = Integer.parseInt(request.getParameter("reportID"));
            redirect = editReportForm;
        } else if (action.equalsIgnoreCase("editReport")) {
            ReportBean rb = new ReportBean();
            rb.setReportID(Integer.parseInt(request.getParameter("reportID")));
            rb.setReportDate(request.getParameter("reportDate"));
            rb.setTotalCustomer(Integer.parseInt(request.getParameter("totalCustomer")));
            rb.setSales(Double.parseDouble(request.getParameter("sales")));
            rd.updateReport(rb);
            redirect = reportPage;
        } else if (action.equalsIgnoreCase("deleteReport")) {
            Integer reportID = Integer.parseInt(request.getParameter("reportID"));
            rd.deleteReport(reportID);
            redirect = reportPage;
        } else {
            redirect = reportPage;
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
