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
public class TourismCompanyBean implements java.io.Serializable {
    
    private int companyID;
    private String companyName;
    private String companyAbout;
    private String companyImg;
    private String companyLicense;
    private String companyPhone;
    private String companyEmail;
    private String companyAddress1;
    private String companyAddress2;
    private AddressBean addPoscode;
    private String companyPassword;
    
    public TourismCompanyBean(){
    }
//    
//    public TourismCompanyBean(AddressBean addPoscode){
//        setAddPoscode(addPoscode);
//    }
//    
//    public TourismCompanyBean(int companyID, String companyName, byte[] companyImg, String companyLicense, String companyPhone, String companyEmail, String Address1, String Address2, AddressBean addPoscode, String companyPassword){
//        setCompanyID(companyID);
//        setCompanyName(companyName);
//        setCompanyImg(companyImg);
//        setCompanyLicense(companyLicense);
//        setCompanyPhone(companyPhone);
//        setCompanyEmail(companyEmail);
//        setAddress1(Address1);
//        setAddress2(Address2);
//        setAddPoscode(addPoscode);
//        setCompanyPassword(companyPassword);
//    }

    public int getCompanyID() {
        return companyID;
    }

    public void setCompanyID(int companyID) {
        this.companyID = companyID;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getCompanyAbout() {
        return companyAbout;
    }

    public void setCompanyAbout(String companyAbout) {
        this.companyAbout = companyAbout;
    }

    
    
    public String getCompanyImg() {
        return companyImg;
    }

    public void setCompanyImg(String companyImg) {
        this.companyImg = companyImg;
    }

    public String getCompanyLicense() {
        return companyLicense;
    }

    public void setCompanyLicense(String companyLicense) {
        this.companyLicense = companyLicense;
    }

    public String getCompanyPhone() {
        return companyPhone;
    }

    public void setCompanyPhone(String companyPhone) {
        this.companyPhone = companyPhone;
    }

    public String getCompanyEmail() {
        return companyEmail;
    }

    public void setCompanyEmail(String companyEmail) {
        this.companyEmail = companyEmail;
    }

    public String getCompanyAddress1() {
        return companyAddress1;
    }

    public void setCompanyAddress1(String companyAddress1) {
        this.companyAddress1 = companyAddress1;
    }

    public String getCompanyAddress2() {
        return companyAddress2;
    }

    public void setCompanyAddress2(String companyAddress2) {
        this.companyAddress2 = companyAddress2;
    }

    public AddressBean getAddPoscode() {
        return addPoscode;
    }

    public void setAddPoscode(AddressBean addPoscode) {
        this.addPoscode = addPoscode;
    }

    public String getCompanyPassword() {
        return companyPassword;
    }

    public void setCompanyPassword(String companyPassword) {
        this.companyPassword = companyPassword;
    }
    
    
}
