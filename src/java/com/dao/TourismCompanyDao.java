/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.bean.TourismCompanyBean;
import com.bean.AddressBean;
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
import java.sql.Statement;
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
public class TourismCompanyDao {

    private Connection con;
    private int result;

//    public TourismCompanyDao() {
//        con = DBConnection.createConnection();
//    }
    public String registerTourismCompany(TourismCompanyBean tcb) throws SQLException, NoSuchAlgorithmException {
        String compName = tcb.getCompanyName();
        String compLicense = tcb.getCompanyLicense();
        String compPhone = tcb.getCompanyPhone();
        String compEmail = tcb.getCompanyEmail();
        String address1 = tcb.getCompanyAddress1();
        String address2 = tcb.getCompanyAddress2();

        int addPoscode = tcb.getAddPoscode().getAddPoscode();

        String compPassword = tcb.getCompanyPassword();

        PreparedStatement ps = null;

        try {
            con = DBConnection.createConnection();
            String query = "insert into tourismcompany(companyName, companyLicense, companyPhone, companyEmail, companyAddress1, companyAddress2, addPoscode, companyPassword) values (?,?,?,?,?,?,?,?)";
            ps = con.prepareStatement(query);
            ps.setString(1, compName);
            ps.setString(2, compLicense);
            ps.setString(3, compPhone);
            ps.setString(4, compEmail);
            ps.setString(5, address1);
            ps.setString(6, address2);
            ps.setInt(7, addPoscode);
            
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(compPassword.getBytes());
            byte[] bytes = md.digest();
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < bytes.length; i++) {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            String hashPassword = sb.toString();
            ps.setString(8, hashPassword);

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
                System.out.println("SE tcdregistertourismcompany: " + se);
            }
        }
        return "Oops.. Something went wrong there..!";
    }

    public int updateTourismCompany(TourismCompanyBean tcb) {
        try {
            con = DBConnection.createConnection();
            String query = "UPDATE `tourismcompany` SET `companyName` = ?, `companyAbout` = ?, `companyLicense` = ?, `companyPhone` = ?, `companyEmail` = ?, `companyAddress1` = ?, `companyAddress2` = ?, `addPoscode` = ? WHERE `tourismcompany`.`companyID` = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, tcb.getCompanyName());
            pst.setString(2, tcb.getCompanyAbout());
            pst.setString(3, tcb.getCompanyLicense());
            pst.setString(4, tcb.getCompanyPhone());
            pst.setString(5, tcb.getCompanyEmail());
            pst.setString(6, tcb.getCompanyAddress1());
            pst.setString(7, tcb.getCompanyAddress2());
            pst.setObject(8, tcb.getAddPoscode().getAddPoscode());
//            pst.setString(9, tcb.getCompanyPassword());
            pst.setInt(9, tcb.getCompanyID());
            result = pst.executeUpdate();
            System.out.println("run update company: "+tcb.getAddPoscode().getAddPoscode());

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
                System.out.println("SE tcdupdatetourismcompany: " + se);
            }
        }
        return result;
    }

    public int deleteTourismCompany(int companyID) {
        try {
            con = DBConnection.createConnection();
            String query = "delete from tourismcompany where companyID=?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, companyID);
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
                System.out.println("SE tcddeletetourismcompany: " + se);
            }
        }
        return result;
    }

    public TourismCompanyBean oneTourismCompany(String companyEmail) {
        TourismCompanyBean tcb = new TourismCompanyBean();

        try {
            con = DBConnection.createConnection();
            String query = "SELECT tourismcompany.companyID, tourismcompany.companyName, tourismcompany.companyAbout, tourismcompany.companyImg, tourismcompany.companyLicense, tourismcompany.companyPhone, tourismcompany.companyEmail, tourismcompany.companyAddress1, tourismcompany.companyAddress2, address_info.addPoscode, address_info.addCity, address_info.addState, tourismcompany.companyPassword FROM tourismcompany INNER JOIN address_info ON tourismcompany.addPoscode = address_info.addPoscode WHERE tourismcompany.companyEmail = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, companyEmail);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                tcb.setCompanyID(rs.getInt(1));
                tcb.setCompanyName(rs.getString(2));
                tcb.setCompanyAbout(rs.getString(3));
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

                tcb.setCompanyImg(base64Image);
                tcb.setCompanyLicense(rs.getString(5));
                tcb.setCompanyPhone(rs.getString(6));
                tcb.setCompanyEmail(rs.getString(7));
                tcb.setCompanyAddress1(rs.getString(8));
                tcb.setCompanyAddress2(rs.getString(9));

                AddressBean ab = new AddressBean();
                ab.setAddPoscode(rs.getInt(10));
                ab.setAddCity(rs.getString(11));
                ab.setAddState(rs.getString(12));
                tcb.setAddPoscode(ab);

                tcb.setCompanyPassword(rs.getString(13));
//
//                tcb = new TourismCompanyBean(rs.getInt(1), rs.getString(2), rs.getBytes(3),
//                        rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8),
//                        ab, rs.getString(12));
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception is onecompany: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE tcdonetourismcompany: " + se);
            }
        }
        return tcb;
    }

    public List<TourismCompanyBean> retrieveAllTourismCompany() {
        List<TourismCompanyBean> TourismCompanyAll = new ArrayList<TourismCompanyBean>();
        TourismCompanyBean tcb;
        try {
            con = DBConnection.createConnection();
            String query = "select * from tourismcompany";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery(query);
            while (rs.next()) {
                tcb = new TourismCompanyBean();
                tcb.setCompanyID(rs.getInt(1));
                tcb.setCompanyName(rs.getString(2));

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

                tcb.setCompanyImg(base64Image);
                tcb.setCompanyLicense(rs.getString(5));
                tcb.setCompanyPhone(rs.getString(6));
                tcb.setCompanyEmail(rs.getString(7));
                tcb.setCompanyAddress1(rs.getString(8));
                tcb.setCompanyAddress2(rs.getString(9));
                tcb.setCompanyPassword(rs.getString(11));

                TourismCompanyAll.add(tcb);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception is retreiveALlTourismCompany: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE tcdretrievetourismcompany: " + se);
            }
        }
        return TourismCompanyAll;
    }

    public int updateCompanyImg(Part part, String companyID) {
        try {
            con = DBConnection.createConnection();
            System.out.println("masok dao");
            String query = "UPDATE `tourismcompany` SET `companyImg` = ? WHERE `tourismcompany`.`companyID` = ?";
            PreparedStatement pst = con.prepareStatement(query);
            InputStream is = part.getInputStream();
            pst.setBlob(1, is);
            pst.setString(2, companyID);
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
                System.out.println("SE tcdupdatettourismcompanyimg: " + se);
            }
        }
        return result;
    }

    public int deleteCompanyImg(String companyID) {
        try {
            con = DBConnection.createConnection();
            String query = "UPDATE `tourismcompany` SET `companyImg` = null WHERE `tourismcompany`.`companyID` = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, companyID);
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
                System.out.println("SE tcddeletecompanyimg: " + se);
            }
        }
        return result;
    }
}
