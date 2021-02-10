/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.bean.BoatServiceBean;
import com.bean.CustomerBean;
import com.bean.FeedbackBean;
import com.bean.FeedbackTopicBean;
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
public class FeedbackDao {

    private Connection con;
    private int result;

//    public FeedbackDao(){
//        con = DBConnection.createConnection();
//    }
    public int addFeedback(FeedbackBean fb) throws SQLException {

        int custID = fb.getCustID().getCustID();
        int serviceID = fb.getServiceID().getServiceID();
        int feedbackRating = fb.getFeedbackRating();
        int topicID = fb.getTopicID().getTopicID();
        String feedbackCustomer = fb.getFeedbackCustomer();
        String feedbackDate = fb.getFeedbackDate();

        PreparedStatement ps = null;

        try {
            con = DBConnection.createConnection();
            String query = "insert into feedback_info(custID, serviceID, feedbackRating, topicID, feedbackCustomer, feedbackDate) values(?,?,?,?,?,?)";
            ps = con.prepareStatement(query);
            ps.setObject(1, custID);
            ps.setObject(2, serviceID);
            ps.setInt(3, feedbackRating);
            ps.setObject(4, topicID);
            ps.setString(5, feedbackCustomer);
            ps.setString(6, feedbackDate);

            result = ps.executeUpdate();

            ps.close();
            con.close();

        } catch (Exception ex) {
            System.out.println("Exception fd_add: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE fdaddfeedback: " + se);
            }
        }
        return result;
    }

    public int updateFeedback(FeedbackBean fb) {
        try {
            con = DBConnection.createConnection();
            String query = "update feedback_info set feedbackRating=?, topicID=?, feedbackCustomer=?, feedbackDate=? where feedbackID=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, fb.getFeedbackRating());
            ps.setObject(2, fb.getTopicID().getTopicID());
            ps.setString(3, fb.getFeedbackCustomer());
            ps.setString(4, fb.getFeedbackDate());
            ps.setInt(5, fb.getFeedbackID());
            result = ps.executeUpdate();

            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception fd_updateFeedback: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE fdupdatefeedback: " + se);
            }
        }
        return result;
    }

    public int deleteFeedback(int feedbackID) {
        try {
            con = DBConnection.createConnection();
            String query = "delete from feedback_info where feedbackID=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, feedbackID);
            result = ps.executeUpdate();

            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception fd_deleteFeedback: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE fddeletefeedback: " + se);
            }
        }
        return result;
    }

    public List<FeedbackBean> FeedbackByCust(int custID) {
        List<FeedbackBean> FeedbackByCust = new ArrayList<FeedbackBean>();
        FeedbackBean fb;
        try {
            con = DBConnection.createConnection();
            String query = "select * from feedback_info inner join boatservice_info using(serviceID) inner join feedback_topic using(topicID) inner join tourismcompany using(companyID) where custID=? order by feedbackID desc";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, custID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                fb = new FeedbackBean();

                CustomerBean cb = new CustomerBean();
                cb.setCustID(rs.getInt("custID"));

                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyName(rs.getString("companyName"));

                BoatServiceBean bsb = new BoatServiceBean();
                bsb.setServiceID(rs.getInt("serviceID"));
                bsb.setCompanyID(tcb);
                bsb.setFromLocation(rs.getString("fromLocation"));
                bsb.setToLocation(rs.getString("toLocation"));

                FeedbackTopicBean ftb = new FeedbackTopicBean();
                ftb.setTopicID(rs.getInt("topicID"));
                ftb.setTopic(rs.getString("topic"));

                fb.setFeedbackID(rs.getInt("feedbackID"));
                fb.setCustID(cb);
                fb.setServiceID(bsb);
                fb.setFeedbackRating(rs.getInt("feedbackRating"));
                fb.setTopicID(ftb);
                fb.setFeedbackCustomer(rs.getString("feedbackCustomer"));
                fb.setFeedbackDate(rs.getString("feedbackDate"));
                FeedbackByCust.add(fb);

            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception fd_feedbackbycust: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE fdfeedbackbycust: " + se);
            }
        }
        return FeedbackByCust;
    }

    //display feedback
    public List<FeedbackBean> displayFeedback(int compID) {
        List<FeedbackBean> FeedbackByCust = new ArrayList<FeedbackBean>();
        FeedbackBean fb;
        try {
            con = DBConnection.createConnection();
            String query = "select * from feedback_info inner join boatservice_info using(serviceID) inner join feedback_topic using(topicID) inner join customer using(custID) where companyID=? order by feedbackID desc";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, compID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                fb = new FeedbackBean();

                CustomerBean cb = new CustomerBean();
                cb.setCustID(rs.getInt("custID"));
                cb.setCustFirstName(rs.getString("custFirstName"));

                BoatServiceBean bsb = new BoatServiceBean();
                bsb.setServiceID(rs.getInt("serviceID"));
                bsb.setServiceName(rs.getString("serviceName"));
                bsb.setFromLocation(rs.getString("fromLocation"));
                bsb.setToLocation(rs.getString("toLocation"));

                FeedbackTopicBean ftb = new FeedbackTopicBean();
                ftb.setTopicID(rs.getInt("topicID"));
                ftb.setTopic(rs.getString("topic"));

                fb.setFeedbackID(rs.getInt("feedbackID"));
                fb.setCustID(cb);
                fb.setServiceID(bsb);
                fb.setFeedbackRating(rs.getInt("feedbackRating"));
                fb.setTopicID(ftb);
                fb.setFeedbackCustomer(rs.getString("feedbackCustomer"));
                fb.setFeedbackDate(rs.getString("feedbackDate"));
                FeedbackByCust.add(fb);

            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception fd_feedbackbycust: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE fdfeedbackbycust: " + se);
            }
        }
        return FeedbackByCust;
    }
    
    public List<FeedbackBean> FeedbackByService(int serviceID) {
        List<FeedbackBean> FeedbackByService = new ArrayList<FeedbackBean>();
        FeedbackBean fb;
        try {
            con = DBConnection.createConnection();
            String query = "select * from feedback_info inner join customer using(custID) inner join boatservice_info using(serviceID) inner join feedback_topic using(topicID) where serviceID = ? order by feedback_info.feedbackDate desc";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, serviceID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                fb = new FeedbackBean();

                CustomerBean cb = new CustomerBean();
                cb.setCustID(rs.getInt("custID"));
                cb.setCustFirstName(rs.getString("custFirstName"));

                BoatServiceBean bsb = new BoatServiceBean();
                bsb.setServiceID(rs.getInt("serviceID"));
                bsb.setServiceName(rs.getString("serviceName"));

                FeedbackTopicBean ftb = new FeedbackTopicBean();
                ftb.setTopicID(rs.getInt("topicID"));
                ftb.setTopic(rs.getString("topic"));

                fb.setFeedbackID(rs.getInt("feedbackID"));
                fb.setCustID(cb);
                fb.setServiceID(bsb);
                fb.setFeedbackRating(rs.getInt("feedbackRating"));
                fb.setTopicID(ftb);
                fb.setFeedbackCustomer(rs.getString("feedbackCustomer"));
                fb.setFeedbackDate(rs.getString("feedbackDate"));
                FeedbackByService.add(fb);

            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception fd_feedbackbyservice: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE fdfeedbackbyservice: " + se);
            }
        }
        return FeedbackByService;
    }

    public FeedbackBean FeedbackById(int feedbackID) {
        FeedbackBean fb = new FeedbackBean();
        try {
            con = DBConnection.createConnection();
            String query = "select * from feedback_info inner join boatservice_info using(serviceID) inner join feedback_topic using(topicID) inner join tourismcompany using(companyID) where feedbackID=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, feedbackID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                fb = new FeedbackBean();

                CustomerBean cb = new CustomerBean();
                cb.setCustID(rs.getInt("custID"));

                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyName(rs.getString("companyName"));

                BoatServiceBean bsb = new BoatServiceBean();
                bsb.setServiceID(rs.getInt("serviceID"));
                bsb.setCompanyID(tcb);
                bsb.setFromLocation(rs.getString("fromLocation"));
                bsb.setToLocation(rs.getString("toLocation"));

                FeedbackTopicBean ftb = new FeedbackTopicBean();
                ftb.setTopicID(rs.getInt("topicID"));
                ftb.setTopic(rs.getString("topic"));

                fb.setFeedbackID(rs.getInt("feedbackID"));
                fb.setCustID(cb);
                fb.setServiceID(bsb);
                fb.setFeedbackRating(rs.getInt("feedbackRating"));
                fb.setTopicID(ftb);
                fb.setFeedbackCustomer(rs.getString("feedbackCustomer"));
                fb.setFeedbackDate(rs.getString("feedbackDate"));
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception feebackbyid: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE fdfeedbackbyid: " + se);
            }
        }
        return fb;
    }
}
