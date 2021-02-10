/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bean;

/**
 *
 * @author fhfai
 */
public class FeedbackBean {
    private int feedbackID;
    private CustomerBean custID;
    private BoatServiceBean serviceID;
    private int feedbackRating;
    private FeedbackTopicBean topicID;
    private String feedbackCustomer;
    private String feedbackDate;

    public int getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(int feedbackID) {
        this.feedbackID = feedbackID;
    }

    public CustomerBean getCustID() {
        return custID;
    }

    public void setCustID(CustomerBean custID) {
        this.custID = custID;
    }
    
    public BoatServiceBean getServiceID() {
        return serviceID;
    }

    public void setServiceID(BoatServiceBean serviceID) {
        this.serviceID = serviceID;
    }

    public int getFeedbackRating() {
        return feedbackRating;
    }

    public void setFeedbackRating(int feedbackRating) {
        this.feedbackRating = feedbackRating;
    }

    public FeedbackTopicBean getTopicID() {
        return topicID;
    }

    public void setTopicID(FeedbackTopicBean topicID) {
        this.topicID = topicID;
    }

    public String getFeedbackCustomer() {
        return feedbackCustomer;
    }

    public void setFeedbackCustomer(String feedbackCustomer) {
        this.feedbackCustomer = feedbackCustomer;
    }

    public String getFeedbackDate() {
        return feedbackDate;
    }

    public void setFeedbackDate(String feedbackDate) {
        this.feedbackDate = feedbackDate;
    }
}
