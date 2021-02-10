/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.bean.PaymentBean;
import com.util.DBConnection;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

/**
 *
 * @author fhfai
 */
@MultipartConfig(maxFileSize = 16177216)
public class PaymentDao {

    private Connection con;
    private int result;

//    public PaymentDao() {
//        con = DBConnection.createConnection();
//    }

    public int addPayment(PaymentBean pb, Part part) throws SQLException {
        String referenceNo = pb.getReferenceNo();
        double paymentAmount = pb.getPaymentAmount();

        PreparedStatement ps = null;

        try {
            con = DBConnection.createConnection();
            String query = "insert into payment_info(referenceNo, paymentAmount, paymentReceipt) values(?,?,?)";
            ps = con.prepareStatement(query);
            ps.setString(1, referenceNo);
            ps.setDouble(2, paymentAmount);
            InputStream is = part.getInputStream();
            ps.setBlob(3, is);

            result = ps.executeUpdate();
            
            ps.close();
            con.close();

        } catch (Exception ex) {
            System.out.println("Exception paymentDao is: " + ex);
        }finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE pdaddpayment: " + se);
            }
        }
        return result;
    }

    public int deletePayment(String referenceNo) {
        try {
            con = DBConnection.createConnection();
            String query = "delete from payment_info where referenceNo = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, referenceNo);
            result = ps.executeUpdate();
            
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("deletePayment: " + ex);
        }finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE pddeletepayment: " + se);
            }
        }
        return result;
    }

    public PaymentBean paymentByRef(String ref) {
        PaymentBean pb = new PaymentBean();
        try {
            con = DBConnection.createConnection();
            String query = "select * from payment_info where referenceNo = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, ref);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                pb.setReferenceNo(rs.getString(1));
                pb.setPaymentDate(rs.getString(2));
                pb.setPaymentAmount(rs.getDouble(3));

                Blob blob = rs.getBlob(4);
                InputStream is = blob.getBinaryStream();
                ByteArrayOutputStream os = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead = -1;

                while ((bytesRead = is.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }

                byte[] fileBytes = os.toByteArray();
                String base64File = Base64.getEncoder().encodeToString(fileBytes);

                is.close();
                os.close();

                pb.setPaymentReceipt(base64File);
            }
            
            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("paymentByRef: " + ex);
        }finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE pdpaymentbyref: " + se);
            }
        }
        return pb;
    }

}
