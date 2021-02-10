/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.bean.CustomerBean;
import com.util.DBConnection;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

/**
 *
 * @author fhfai
 */
@MultipartConfig(maxFileSize = 16177216)
public class CustomerDao {

    private Connection con;
    private int result;

//    public CustomerDao() {
//        con = DBConnection.createConnection();
//    }
    public String registerCustomer(CustomerBean cb) throws SQLException, NoSuchAlgorithmException {
        String custFirstName = cb.getCustFirstName();
        String custLastName = cb.getCustLastName();
        String custPhone = cb.getCustPhone();
        String custEmail = cb.getCustEmail();
        String custCountry = cb.getCustCountry();
        String custPassword = cb.getCustPassword();

        PreparedStatement ps = null;

        try {
            con = DBConnection.createConnection();
            String query = "insert into customer(custFirstName, custLastName, custPhone, custEmail, custCountry, custPassword) values (?,?,?,?,?,?)";
            ps = con.prepareStatement(query);
            ps.setString(1, custFirstName);
            ps.setString(2, custLastName);
            ps.setString(3, custPhone);
            ps.setString(4, custEmail);
            ps.setString(5, custCountry);

            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(custPassword.getBytes());
            byte[] bytes = md.digest();
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < bytes.length; i++) {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            String hashPassword = sb.toString();
            ps.setString(6, hashPassword);

            int i = ps.executeUpdate();

            if (i != 0) {
                return "SUCCESS";
            }

            ps.close();
            con.close();

        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE cdregistercustomer: " + se);
            }
        }
        return "Oops.. Something went wrong there..!";
    }

    public List<CustomerBean> retrieveAllCustomer() {
        List<CustomerBean> CustomerAll = new ArrayList<CustomerBean>();
        CustomerBean cb;
        try {
            con = DBConnection.createConnection();
            String query = "select * from customer";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                cb = new CustomerBean();
                cb.setCustID(rs.getInt(1));
                cb.setCustFirstName(rs.getString(2));
                cb.setCustLastName(rs.getString(3));
                Blob blob = rs.getBlob(4);

                InputStream inputStream = blob.getBinaryStream();
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead = -1;

                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }

                byte[] imageBytes = outputStream.toByteArray();
                String base64Image = Base64.getEncoder().encodeToString(imageBytes);

                inputStream.close();
                outputStream.close();

                cb.setCustImg(base64Image);
                cb.setCustPhone(rs.getString(5));
                cb.setCustEmail(rs.getString(6));
                cb.setCustCountry(rs.getString(7));
                cb.setCustPassword(rs.getString(8));

                CustomerAll.add(cb);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception is: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE cdretrieveallcustomer: " + se);
            }
        }
        return CustomerAll;
    }

    public CustomerBean oneCustomer(String custEmail) {
        CustomerBean cb = new CustomerBean();

        try {
            con = DBConnection.createConnection();
            String query = "select * from customer where custEmail =?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, custEmail);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                cb = new CustomerBean();
                cb.setCustID(rs.getInt(1));
                cb.setCustFirstName(rs.getString(2));
                cb.setCustLastName(rs.getString(3));
                cb.setCustPhone(rs.getString("custPhone"));
                Blob blob = rs.getBlob(4);

                InputStream inputStream = blob.getBinaryStream();
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead = -1;

                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }

                byte[] imageBytes = outputStream.toByteArray();
                String base64Image = Base64.getEncoder().encodeToString(imageBytes);

                inputStream.close();
                outputStream.close();

                cb.setCustImg(base64Image);
                cb.setCustPhone(rs.getString(5));
                cb.setCustEmail(rs.getString(6));
                cb.setCustCountry(rs.getString(7));
                cb.setCustPassword(rs.getString(8));
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception is oneCustomer: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE cdonecustomer: " + se);
            }
        }
        return cb;
    }

    public int updateCustomer(CustomerBean cb) {
        try {
            con = DBConnection.createConnection();
            String query = "update customer set custFirstName = ?, custLastName = ?, custPhone = ?, custEmail = ?, custCountry = ? where custID = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, cb.getCustFirstName());
//            pst.setBytes(2, tcb.getCompanyImg());
            pst.setString(2, cb.getCustLastName());
            pst.setString(3, cb.getCustPhone());
            pst.setString(4, cb.getCustEmail());
            pst.setString(5, cb.getCustCountry());
//            pst.setString(6, cb.getCustPassword());
            pst.setInt(6, cb.getCustID());
            result = pst.executeUpdate();

            pst.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception update is: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE cdupdatecustomer: " + se);
            }
        }
        return result;
    }

    public int updateCustImg(Part part, int custID) {
        try {
            con = DBConnection.createConnection();
            String query = "UPDATE `customer` SET `custImg` = ? WHERE `customer`.`custID` = ?";
            PreparedStatement pst = con.prepareStatement(query);
            InputStream is = part.getInputStream();
            pst.setBlob(1, is);
            pst.setInt(2, custID);
            result = pst.executeUpdate();

            pst.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception update is: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE cdupdatecustimg: " + se);
            }
        }
        return result;
    }

    public int deleteCustImg(int custID) {
        try {
            con = DBConnection.createConnection();
            String query = "UPDATE `customer` SET `custImg` = null WHERE `customer`.`custID` = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, custID);
            result = pst.executeUpdate();

            pst.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception update is: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE cddeletecustimg: " + se);
            }
        }
        return result;
    }

    public int deleteCust(int custID) {
        try {
            con = DBConnection.createConnection();
            String query = "delete from customer where custID=?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, custID);
            result = pst.executeUpdate();

            pst.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception is: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE cddeletecust: " + se);
            }
        }
        return result;
    }

}
