package com.controller;

import com.bean.AddressBean;
import com.bean.TourismCompanyBean;
import com.dao.TourismCompanyDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

//@WebServlet("/tourismCompany")
@MultipartConfig(maxFileSize = 16177216)
public class tourismCompanyCtrl extends HttpServlet {

    private static final String tourismCompanyRecord = null;
    private static String registerForm = "/TourismCompany/RegisterTourismCompany.jsp"; //create
    private static String home = "/TourismCompany/TourismCompanyHome.jsp"; //retrieve
    private static String editForm = "/TourismCompany/EditTourismCompany.jsp"; //update
    private static String editImageForm = "/TourismCompany/EditImageTourismCompany.jsp"; //update
    private static String deleteForm = "/TourismCompany/DeleteTourismCompany.jsp"; //delete
    private static String customerList = "/TourismCompany/CustomerList.jsp";
    private static String report = "/TourismCompany/Report.jsp";
    private static String loginForm = "/Login.jsp";
    private TourismCompanyDao tcd;

    public tourismCompanyCtrl() {
        super();
        tcd = new TourismCompanyDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String redirect = "";
        String action = request.getParameter("action");
        System.out.println("tourismCompanyCtrl: " + action);

        if (action.equalsIgnoreCase("register")) {
            //register process
            try {
                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyName(request.getParameter("companyName"));
                tcb.setCompanyLicense(request.getParameter("companyLicense"));
                tcb.setCompanyPhone(request.getParameter("companyPhone"));
                tcb.setCompanyEmail(request.getParameter("companyEmail"));
                tcb.setCompanyAddress1(request.getParameter("companyAddress1"));
                tcb.setCompanyAddress2(request.getParameter("companyAddress2"));

                AddressBean ab = new AddressBean();
                ab.setAddPoscode(Integer.parseInt(request.getParameter("addPoscode")));

                tcb.setAddPoscode(ab);
                tcb.setCompanyPassword(request.getParameter("companyPassword"));
//                System.out.println(tcb.getCompanyName());
//                System.out.println(tcb.getCompanyLicense());
//                System.out.println(tcb.getCompanyPhone());
//                System.out.println(tcb.getCompanyEmail());
//                System.out.println(tcb.getCompanyAddress1());
//                System.out.println(tcb.getCompanyAddress2());
//                System.out.println(tcb.getAddPoscode().getAddPoscode());
//                System.out.println(tcb.getCompanyPassword());
                tcd.registerTourismCompany(tcb);
                redirect = loginForm;

            } catch (SQLException ex) {
                Logger.getLogger(tourismCompanyCtrl.class.getName()).log(Level.SEVERE, null, ex);
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(tourismCompanyCtrl.class.getName()).log(Level.SEVERE, null, ex);
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
            String companyEmail = request.getParameter("companyEmail");
            request.setAttribute("companyEmail", companyEmail);
            redirect = editImageForm;
        } else if (action.equalsIgnoreCase("editImage")) {
            //go to editimage
            try {
                int result = 0;
                Part part = request.getPart("companyImg");
                String companyID = request.getParameter("companyID");

                tcd.updateCompanyImg(part, companyID);
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
            String companyEmail = request.getParameter("companyEmail");
            request.setAttribute("companyEmail", companyEmail);
            redirect = editForm;
        } else if (action.equalsIgnoreCase("edit")) {
            //edit process
            try {
                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyID(Integer.parseInt(request.getParameter("companyID")));
                tcb.setCompanyName(request.getParameter("companyName"));
                tcb.setCompanyLicense(request.getParameter("companyLicense"));
                tcb.setCompanyAbout(request.getParameter("companyAbout"));
                tcb.setCompanyPhone(request.getParameter("companyPhone"));
                tcb.setCompanyEmail(request.getParameter("companyEmail"));
                tcb.setCompanyAddress1(request.getParameter("companyAddress1"));
                tcb.setCompanyAddress2(request.getParameter("companyAddress2"));

                AddressBean ab = new AddressBean();
                ab.setAddPoscode(Integer.parseInt(request.getParameter("addPoscode")));

                tcb.setAddPoscode(ab);
//                tcb.setCompanyPassword(request.getParameter("companyPassword"));

                tcd.updateTourismCompany(tcb);
                request.setAttribute("tcb", tcb);
                redirect = home;

            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } else if (action.equalsIgnoreCase("customerList")) {
            redirect = customerList;
        } else if(action.equalsIgnoreCase("report")){
            redirect = report;
        } else if (action.equalsIgnoreCase("deleteImage")) {
            String companyID = request.getParameter("companyID");
            tcd.deleteCompanyImg(companyID);
            redirect = home;
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
