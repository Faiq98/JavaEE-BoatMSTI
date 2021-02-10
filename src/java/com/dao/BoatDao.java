package com.dao;

import com.bean.BoatBean;
import com.bean.TourismCompanyBean;
import com.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoatDao {

    private Connection con;
    private int result;

//    public BoatDao() {
//        con = DBConnection.createConnection();
//    }

    public int addBoat(BoatBean bb) throws SQLException {
        String boatID = bb.getBoatID();
        int companyID = bb.getCompanyID().getCompanyID();
        String boatType = bb.getBoatType();
        int boatCapacity = bb.getBoatCapacity();

        PreparedStatement ps = null;

        try {
            con = DBConnection.createConnection();
            String query = "insert into boat_info(boatID, companyID, boatType, boatCapacity) values(?,?,?,?)";
            ps = con.prepareStatement(query);
            ps.setString(1, boatID);
            ps.setObject(2, companyID);
            ps.setString(3, boatType);
            ps.setInt(4, boatCapacity);

            result = ps.executeUpdate();

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
                System.out.println("SE addBoat: " + se);
            }
        }
        return result;
    }

    public int updateBoat(BoatBean bb) {
        try {
            con = DBConnection.createConnection();
            String query = "update boat_info set boatType=?, boatCapacity=? where boatID=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, bb.getBoatType());
            ps.setInt(2, bb.getBoatCapacity());
            ps.setString(3, bb.getBoatID());
            result = ps.executeUpdate();

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
                System.out.println("SE updateBoat: " + se);
            }
        }
        return result;
    }

    public int deleteBoat(String boatID) {
        try {
            con = DBConnection.createConnection();
            String query = "delete from boat_info where boatID=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, boatID);
            result = ps.executeUpdate();

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
                System.out.println("SE deleteBoat: " + se);
            }
        }
        return result;
    }

    public List<BoatBean> retrieveAllBoatByID(int companyID) {
        List<BoatBean> BoatAllByID = new ArrayList<BoatBean>();
        BoatBean bb;
        try {
            con = DBConnection.createConnection();
            String query = "select * from boat_info where companyID=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, companyID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                bb = new BoatBean();
                bb.setBoatID(rs.getString(1));

                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyID(rs.getInt(2));

                bb.setCompanyID(tcb);
                bb.setBoatType(rs.getString(3));
                bb.setBoatCapacity(rs.getInt(4));
                BoatAllByID.add(bb);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception is retreiveALlBoatByID: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE retrieveAllBoatByID: " + se);
            }
        }
        return BoatAllByID;
    }

    public BoatBean BoatById(String boatID) {
        BoatBean bb = new BoatBean();
        try {
            con = DBConnection.createConnection();
            String query = "select * from boat_info where boatID=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, boatID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                bb.setBoatID(rs.getString(1));

                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyID(2);

                bb.setCompanyID(tcb);
                bb.setBoatType(rs.getString(3));
                bb.setBoatCapacity(rs.getInt(4));
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
                System.out.println("SE BoatByID: " + se);
            }
        }
        return bb;
    }
}
