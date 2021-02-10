/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.bean.BoatServiceBean;
import com.bean.CustomerBean;
import com.bean.FeedbackBean;
import com.bean.FeedbackTopicBean;
import com.dao.FeedbackDao;
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
public class feedbackCtrl extends HttpServlet {

    private static final String boatRecord = null;
    private static String feedback = "/Customer/Feedback.jsp"; //create
    private static String chome = "/Customer/CustomerHome.jsp"; //retrieve
//    private static String editFeedbackForm = "/Customer/Feedback.jsp"; //update
//    private static String deleteFeedback = "/Customer/Feedback.jsp"; //delete
//    private static String loginForm = "/Login.jsp";
    private FeedbackDao fd;

    public feedbackCtrl() {
        super();
        fd = new FeedbackDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String redirect = "";
        String action = request.getParameter("action");

        if (action.equalsIgnoreCase("addFeedbackForm")) {
            int serviceID = Integer.parseInt(request.getParameter("serviceID"));
            request.setAttribute("serviceID", serviceID);
            redirect = feedback;
        } else if (action.equalsIgnoreCase("addFeedback")) {
            try {
                FeedbackBean fb = new FeedbackBean();

                CustomerBean cb = new CustomerBean();
                cb.setCustID(Integer.parseInt(request.getParameter("custID")));

                BoatServiceBean bsb = new BoatServiceBean();
                bsb.setServiceID(Integer.parseInt(request.getParameter("serviceID")));

                FeedbackTopicBean ftb = new FeedbackTopicBean();
                ftb.setTopicID(Integer.parseInt(request.getParameter("topicID")));

                fb.setCustID(cb);
                fb.setServiceID(bsb);
                fb.setFeedbackRating(Integer.parseInt(request.getParameter("feedbackRating")));
                fb.setTopicID(ftb);
                fb.setFeedbackCustomer(request.getParameter("feedbackCustomer"));
                fb.setFeedbackDate(request.getParameter("feedbackDate"));
                fd.addFeedback(fb);
                redirect = chome;

            } catch (Exception ex) {
                System.out.println("Exception addFeedbackCtrl: " + ex);
                redirect = chome;
            }
        } else if (action.equalsIgnoreCase("editFeedbackForm")) {
            int feedbackID = Integer.parseInt(request.getParameter("feedbackID"));
            request.setAttribute("feedbackID", feedbackID);
            redirect = feedback;
        } else if (action.equalsIgnoreCase("editFeedback")) {
            try {
                FeedbackBean fb = new FeedbackBean();

                FeedbackTopicBean ftb = new FeedbackTopicBean();
                ftb.setTopicID(Integer.parseInt(request.getParameter("topicID")));

                fb.setFeedbackID(Integer.parseInt(request.getParameter("feedbackID")));
                fb.setFeedbackRating(Integer.parseInt(request.getParameter("feedbackRating")));
                fb.setTopicID(ftb);
                fb.setFeedbackCustomer(request.getParameter("feedbackCustomer"));
                fb.setFeedbackDate(request.getParameter("feedbackDate"));
                fd.updateFeedback(fb);

                redirect = chome;

            } catch (Exception ex) {
                System.out.println("Exception editFeedbackCtrl: " + ex);
            }
        } else if (action.equalsIgnoreCase("deleteFeedback")) {
            int feedbackID = Integer.parseInt(request.getParameter("feedbackID"));
            fd.deleteFeedback(feedbackID);
            redirect = chome;
        } else {
            redirect = chome;
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
