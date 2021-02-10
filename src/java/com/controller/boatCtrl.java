/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.bean.BoatBean;
import com.bean.TourismCompanyBean;
import com.dao.BoatDao;
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
public class boatCtrl extends HttpServlet {
    
    private static final String boatRecord = null;
    private static String addBoatForm = "/TourismCompany/AddBoat.jsp"; //create
    private static String tchome = "/TourismCompany/TourismCompanyHome.jsp"; //retrieve
    private static String editBoatForm = "/TourismCompany/EditBoat.jsp"; //update
    private static String deleteForm = "/TourismCompany/DeleteTourismCompany.jsp"; //delete
//    private static String loginForm = "/Login.jsp";
    private BoatDao bd;
    
    public boatCtrl(){
        super();
        bd = new BoatDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String redirect ="";
        String action = request.getParameter("action");
        
        if(action.equalsIgnoreCase("addBoatForm")){
            int companyID = Integer.parseInt(request.getParameter("companyID"));
            request.setAttribute("companyID", companyID);
            redirect = addBoatForm;
        }else if(action.equalsIgnoreCase("addBoat")){
            try{
                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyID(Integer.parseInt(request.getParameter("companyID")));
                
                BoatBean bb = new BoatBean();
                bb.setBoatID(request.getParameter("boatID"));
                bb.setCompanyID(tcb);
                bb.setBoatType(request.getParameter("boatType"));
                bb.setBoatCapacity(Integer.parseInt(request.getParameter("boatCapacity")));
                
                bd.addBoat(bb);
                redirect = tchome;
                
            }catch(Exception ex){
                System.out.println("Exception is: "+ex);
            }
        }else if(action.equalsIgnoreCase("editBoatForm")){
            String boatID = request.getParameter("boatID");
            request.setAttribute("boatID", boatID);
            redirect = editBoatForm;
        }else if(action.equalsIgnoreCase("editBoat")){
            try{
                BoatBean bb = new BoatBean();
                bb.setBoatID(request.getParameter("boatID"));
                bb.setBoatType(request.getParameter("boatType"));
                bb.setBoatCapacity(Integer.parseInt(request.getParameter("boatCapacity")));
                bd.updateBoat(bb);
                request.setAttribute("bb", bb);
                redirect = tchome;
            }catch(Exception ex){
                System.out.println("Exception is: "+ex);
            }
        }else if(action.equalsIgnoreCase("deleteBoat")){
            String boatID = request.getParameter("boatID");
            System.out.println(boatID);
            bd.deleteBoat(boatID);
            redirect = tchome;
        }else{
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
