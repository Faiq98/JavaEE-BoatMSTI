/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.bean.BoatBean;
import com.bean.BoatServiceBean;
import com.bean.TourismCompanyBean;
import com.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author fhfai
 */
public class ServiceDao {

    private Connection con;
    private int result;

//    public ServiceDao() {
//        con = DBConnection.createConnection();
//    }
    public int addBoatService(BoatServiceBean bsb) throws SQLException {
        int companyID = bsb.getCompanyID().getCompanyID();
        String boatID = bsb.getBoatID().getBoatID();
        String serviceName = bsb.getServiceName();
//        String serviceType = bsb.getServiceType();
        String fromLocation = bsb.getFromLocation();
        String toLocation = bsb.getToLocation();
        String departureTime = bsb.getDepartureTime();
        double AdultPrice = bsb.getAdultPrice();
        double ChildPrice = bsb.getChildPrice();
        double InfantPrice = bsb.getInfantPrice();

        PreparedStatement ps = null;

        try {
            con = DBConnection.createConnection();
            String query = "insert into boatservice_info(companyID, boatID, serviceName, fromLocation, toLocation, departureTime, AdultPrice, ChildPrice, InfantPrice) values(?,?,?,?,?,?,?,?,?)";
            ps = con.prepareStatement(query);
            ps.setObject(1, companyID);
            ps.setObject(2, boatID);
            ps.setString(3, serviceName);
//            ps.setString(4, serviceType);
            ps.setString(4, fromLocation);
            ps.setString(5, toLocation);
            ps.setString(6, departureTime);
            ps.setDouble(7, AdultPrice);
            ps.setDouble(8, ChildPrice);
            ps.setDouble(9, InfantPrice);

            result = ps.executeUpdate();

            ps.close();
            con.close();

        } catch (Exception ex) {
            System.out.println("Exception is addboatservice: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE sdaddboatservice: " + se);
            }
        }
        return result;
    }

    public int updateBoatService(BoatServiceBean bsb) {
        try {
            con = DBConnection.createConnection();
            String query = "update boatservice_info set boatID=?, serviceName=?, fromLocation=?, toLocation=?, departureTime=?, AdultPrice=?, ChildPrice=?, InfantPrice=? where serviceID=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setObject(1, bsb.getBoatID().getBoatID());
            ps.setString(2, bsb.getServiceName());
//            ps.setString(3, bsb.getServiceType());
            ps.setString(3, bsb.getFromLocation());
            ps.setString(4, bsb.getToLocation());
            ps.setString(5, bsb.getDepartureTime());
            ps.setDouble(6, bsb.getAdultPrice());
            ps.setDouble(7, bsb.getChildPrice());
            ps.setDouble(8, bsb.getInfantPrice());
            ps.setInt(9, bsb.getServiceID());

            result = ps.executeUpdate();

            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception updateBoatService: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE sdupdateboatservice: " + se);
            }
        }
        return result;
    }

    public int deleteBoatService(String boatID) {
        try {
            con = DBConnection.createConnection();
            String query = "delete from boatservice_info where serviceID=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, boatID);
            result = ps.executeUpdate();

            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception is deleteboatservice: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE sddeleteboatservice: " + se);
            }
        }
        return result;
    }

    public List<BoatServiceBean> retrieveAllBoatServiceByID(int companyID) {
        List<BoatServiceBean> BoatServiceAllByID = new ArrayList<BoatServiceBean>();
        BoatServiceBean bsb;
        try {
            con = DBConnection.createConnection();
            String query = "select * from boatservice_info where companyID=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, companyID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                bsb = new BoatServiceBean();
                bsb.setServiceID(rs.getInt("serviceID"));

                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyID(rs.getInt("companyID"));

                bsb.setCompanyID(tcb);

                BoatBean bb = new BoatBean();
                bb.setBoatID(rs.getString("boatID"));

                bsb.setBoatID(bb);

                bsb.setServiceName(rs.getString("serviceName"));
//                bsb.setServiceType(rs.getString(6));
                bsb.setFromLocation(rs.getString("fromLocation"));
                bsb.setToLocation(rs.getString("toLocation"));
                bsb.setDepartureTime(rs.getString("departureTime"));
                bsb.setAdultPrice(rs.getDouble("AdultPrice"));
                bsb.setChildPrice(rs.getDouble("ChildPrice"));
                bsb.setInfantPrice(rs.getDouble("InfantPrice"));

                BoatServiceAllByID.add(bsb);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception is at retrieve all: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE sdretrieveallboatservicebyid: " + se);
            }
        }
        return BoatServiceAllByID;
    }

    public List<BoatServiceBean> retrieveAllBoatService() {
        List<BoatServiceBean> BoatServiceAllByID = new ArrayList<BoatServiceBean>();
        BoatServiceBean bsb;
        try {
            con = DBConnection.createConnection();
            String query = "select * from boatservice_info inner join tourismcompany on boatservice_info.companyID = tourismcompany.companyID";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                bsb = new BoatServiceBean();
                bsb.setServiceID(rs.getInt("serviceID"));

                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyID(rs.getInt("companyID"));
                tcb.setCompanyName(rs.getString("companyName"));

                bsb.setCompanyID(tcb);

                BoatBean bb = new BoatBean();
                bb.setBoatID(rs.getString("boatID"));

                bsb.setBoatID(bb);

                bsb.setServiceName(rs.getString("serviceName"));
//                bsb.setServiceType(rs.getString(6));
                bsb.setFromLocation(rs.getString("fromLocation"));
                bsb.setToLocation(rs.getString("toLocation"));
                bsb.setDepartureTime(rs.getString("departureTime"));
                bsb.setAdultPrice(rs.getDouble("AdultPrice"));
                bsb.setChildPrice(rs.getDouble("ChildPrice"));
                bsb.setInfantPrice(rs.getDouble("InfantPrice"));

                BoatServiceAllByID.add(bsb);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception is at retrieve all: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE sdretrieveall: " + se);
            }
        }
        return BoatServiceAllByID;
    }

//    public List<BoatServiceBean> BoatServiceByLocation(String fromLocation, String toLocation, String departDate) {
//        List<BoatServiceBean> BoatServiceAllByID = new ArrayList<BoatServiceBean>();
//        BoatServiceBean bsb;
//        try {
//            System.out.println("serviceDao: " + fromLocation + " to " + toLocation+" DepartDate "+departDate);
//            String query = "select boatservice_info.serviceID, tourismcompany.companyID, tourismcompany.companyName, boat_info.boatID, boat_info.boatType, boat_info.boatCapacity, boatservice_info.serviceName, boatservice_info.fromLocation, boatservice_info.toLocation, boatservice_info.departureTime, boatservice_info.AdultPrice, boatservice_info.ChildPrice, boatservice_info.InfantPrice  from boatservice_info inner join boat_info using(boatID) inner join tourismcompany on tourismcompany.companyID = boatservice_info.companyID where fromLocation =? and toLocation =?";
////            String query = "select boatservice_info.serviceID, tourismcompany.companyID, tourismcompany.companyName, boat_info.boatID, boat_info.boatType, boat_info.boatCapacity, boatservice_info.serviceName, boatservice_info.fromLocation, boatservice_info.toLocation, boatservice_info.departureTime, boatservice_info.AdultPrice, boatservice_info.ChildPrice, boatservice_info.InfantPrice, bookingticket_info.departDate from boatservice_info inner join boat_info using(boatID) join tourismcompany on tourismcompany.companyID = boatservice_info.companyID left join bookingticket_info on bookingticket_info.serviceID = boatservice_info.serviceID where fromLocation =? and toLocation =? and bookingticket_info.departDate is null or bookingticket_info.departDate=?";
//            PreparedStatement ps = con.prepareStatement(query);
//            ps.setString(1, fromLocation);
//            ps.setString(2, toLocation);
////            ps.setString(3, departDate);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//
//                bsb = new BoatServiceBean();
//                bsb.setServiceID(rs.getInt(1));
//
//                TourismCompanyBean tcb = new TourismCompanyBean();
//                tcb.setCompanyID(rs.getInt(2));
//                tcb.setCompanyName(rs.getString(3));
//
//                bsb.setCompanyID(tcb);
//
//                BoatBean bb = new BoatBean();
//                bb.setBoatID(rs.getString(4));
//                bb.setBoatType(rs.getString(5));
//                bb.setBoatCapacity(rs.getInt(6));
//
//                bsb.setBoatID(bb);
//
//                bsb.setServiceName(rs.getString(7));
////                bsb.setServiceType(rs.getString(6));
//                bsb.setFromLocation(rs.getString(8));
//                bsb.setToLocation(rs.getString(9));
//                bsb.setDepartureTime(rs.getString(10));
//                bsb.setAdultPrice(rs.getDouble(11));
//                bsb.setChildPrice(rs.getDouble(12));
//                bsb.setInfantPrice(rs.getDouble(13));
//
//                BoatServiceAllByID.add(bsb);
//            }
//        } catch (Exception ex) {
//            System.out.println("Exception is at retrieve all: " + ex);
//        }
//        return BoatServiceAllByID;
//    }
    public BoatServiceBean BoatServiceById(int serviceID) {
        BoatServiceBean bsb = new BoatServiceBean();
        try {
            con = DBConnection.createConnection();
            String query = "select * from boatservice_info inner join tourismcompany using(companyID) inner join boat_info using(boatID) where serviceID = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, serviceID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                bsb = new BoatServiceBean();
                bsb.setServiceID(rs.getInt("serviceID"));
                bsb.setServiceName(rs.getString("serviceName"));
                bsb.setFromLocation(rs.getString("fromLocation"));
                bsb.setToLocation(rs.getString("toLocation"));
                bsb.setDepartureTime(rs.getString("departureTime"));
                bsb.setAdultPrice(rs.getDouble("AdultPrice"));
                bsb.setChildPrice(rs.getDouble("ChildPrice"));
                bsb.setInfantPrice(rs.getDouble("InfantPrice"));

                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyID(rs.getInt("companyID"));
                tcb.setCompanyName(rs.getString("companyName"));
                tcb.setCompanyPhone(rs.getString("companyPhone"));
                tcb.setCompanyEmail(rs.getString("companyEmail"));
                bsb.setCompanyID(tcb);

                BoatBean bb = new BoatBean();
                bb.setBoatID(rs.getString("boatID"));
                bb.setBoatType(rs.getString("boatType"));
                bb.setBoatCapacity(rs.getInt("boatCapacity"));
                bsb.setBoatID(bb);
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
                System.out.println("SE sdboatservicebyid: " + se);
            }
        }
        return bsb;
    }
}
