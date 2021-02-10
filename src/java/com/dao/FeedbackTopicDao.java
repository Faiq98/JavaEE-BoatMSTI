/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.bean.FeedbackTopicBean;
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
public class FeedbackTopicDao {

    private Connection con;
    private int result;

//    public FeedbackTopicDao() {
//        con = DBConnection.createConnection();
//    }
    public int addTopic(FeedbackTopicBean ftb) throws SQLException {
        int topicID = ftb.getTopicID();
        String topic = ftb.getTopic();

        PreparedStatement ps = null;

        try {
            con = DBConnection.createConnection();
            String query = "insert into feedback_topic(topic) values(?)";
            ps = con.prepareStatement(query);
            ps.setString(1, topic);

            result = ps.executeUpdate();

            ps.close();
            con.close();

        } catch (Exception ex) {
            System.out.println("Exception addTopic: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE ftdaddtopic: " + se);
            }
        }
        return result;
    }

    public List<FeedbackTopicBean> allTopic() {
        List<FeedbackTopicBean> allTopic = new ArrayList<FeedbackTopicBean>();
        FeedbackTopicBean ftb;
        try {
            con = DBConnection.createConnection();
            String query = "select * from feedback_topic";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ftb = new FeedbackTopicBean();
                ftb.setTopicID(rs.getInt(1));
                ftb.setTopic(rs.getString(2));
                allTopic.add(ftb);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception allTopic: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE ftdalltopic: " + se);
            }
        }
        return allTopic;
    }

    public int deleteFeedbackTopic(int topicID) {
        try {
            con = DBConnection.createConnection();
            String query = "delete from feedback_topic where topicID=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, topicID);
            result = ps.executeUpdate();

            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception deleteFeedbackTopic: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE ftddeletefeedbacktopic: " + se);
            }
        }
        return result;
    }
}
