/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.bean.CustomerBean;
import com.bean.TourismCompanyBean;
import com.util.DBConnection;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.http.HttpSession;

/**
 *
 * @author fhfai
 */
public class LoginDao {

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    String query = null;

    //Tourism Company Auth
    public String authenticateTourismCompany(TourismCompanyBean tourismCompanyBean) throws NoSuchAlgorithmException {
        String companyEmail = tourismCompanyBean.getCompanyEmail();
        String companyPassword = tourismCompanyBean.getCompanyPassword();

        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(companyPassword.getBytes());
        byte[] bytes = md.digest();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < bytes.length; i++) {
            sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
        }
        String hashPassword = sb.toString();

        String companyEmailDB = "";
        String companyPasswordDB = "";

        try {
            con = DBConnection.createConnection();
            query = "select companyEmail, companyName, companyPassword from tourismcompany";
            pst = con.prepareStatement(query);
            rs = pst.executeQuery();

            while (rs.next()) {
                companyEmailDB = rs.getString("companyEmail");
                companyPasswordDB = rs.getString("companyPassword");
                tourismCompanyBean.setCompanyName(rs.getString("companyName"));

                if (companyEmail.equals(companyEmailDB) && hashPassword.equals(companyPasswordDB)) {
                    return "SUCCESS";
                }
            }

            rs.close();
            pst.close();
            con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE ldauthtourismcompany: " + se);
            }
        }
        return "Invalid user credentials";
    }

    //Customer Auth
    public String authenticateCustomer(CustomerBean customerBean) throws NoSuchAlgorithmException {
        String custEmail = customerBean.getCustEmail();
        String custPassword = customerBean.getCustPassword();

        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(custPassword.getBytes());
        byte[] bytes = md.digest();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < bytes.length; i++) {
            sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
        }
        String hashPassword = sb.toString();

        String custEmailDB = "";
        String custPasswordDB = "";

        try {
            con = DBConnection.createConnection();
            query = "select custEmail, custPassword, custFirstName from customer";
            pst = con.prepareStatement(query);
            rs = pst.executeQuery();

            while (rs.next()) {
                custEmailDB = rs.getString("custEmail");
                custPasswordDB = rs.getString("custPassword");
                customerBean.setCustFirstName(rs.getString("custFirstName"));

                if (custEmail.equals(custEmailDB) && hashPassword.equals(custPasswordDB)) {
                    return "SUCCESS";
                }
            }

            rs.close();
            pst.close();
            con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE ldauthcustomer: " + se);
            }
        }
        return "Invalid user credentials. Please try again";
    }

}
