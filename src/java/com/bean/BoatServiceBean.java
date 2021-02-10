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
public class BoatServiceBean {
    private int serviceID;
    private TourismCompanyBean companyID;
    private BoatBean boatID;
    private String serviceName;
    private byte[] serviceImg;
//    private String serviceType;
    private String fromLocation;
    private String toLocation;
    private String departureTime;
    private double AdultPrice;
    private double ChildPrice;
    private double InfantPrice;

    public int getServiceID() {
        return serviceID;
    }

    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
    }

    public TourismCompanyBean getCompanyID() {
        return companyID;
    }

    public void setCompanyID(TourismCompanyBean companyID) {
        this.companyID = companyID;
    }

    public BoatBean getBoatID() {
        return boatID;
    }

    public void setBoatID(BoatBean boatID) {
        this.boatID = boatID;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public byte[] getServiceImg() {
        return serviceImg;
    }

    public void setServiceImg(byte[] serviceImg) {
        this.serviceImg = serviceImg;
    }

//    public String getServiceType() {
//        return serviceType;
//    }
//
//    public void setServiceType(String serviceType) {
//        this.serviceType = serviceType;
//    }

    public String getFromLocation() {
        return fromLocation;
    }

    public void setFromLocation(String fromLocation) {
        this.fromLocation = fromLocation;
    }

    public String getToLocation() {
        return toLocation;
    }

    public void setToLocation(String toLocation) {
        this.toLocation = toLocation;
    }

    public String getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(String departureTime) {
        this.departureTime = departureTime;
    }

    public double getAdultPrice() {
        return AdultPrice;
    }

    public void setAdultPrice(double AdultPrice) {
        this.AdultPrice = AdultPrice;
    }

    public double getChildPrice() {
        return ChildPrice;
    }

    public void setChildPrice(double ChildPrice) {
        this.ChildPrice = ChildPrice;
    }

    public double getInfantPrice() {
        return InfantPrice;
    }

    public void setInfantPrice(double InfantPrice) {
        this.InfantPrice = InfantPrice;
    }
    
    
}
