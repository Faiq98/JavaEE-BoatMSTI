package com.bean;

public class ReportBean {

    private int reportID;
    private TourismCompanyBean companyID;
    private String reportDate;
    private int totalCustomer;
    private double sales;

    public int getReportID() {
        return reportID;
    }

    public void setReportID(int reportID) {
        this.reportID = reportID;
    }

    public TourismCompanyBean getCompanyID() {
        return companyID;
    }

    public void setCompanyID(TourismCompanyBean companyID) {
        this.companyID = companyID;
    }

    public String getReportDate() {
        return reportDate;
    }

    public void setReportDate(String reportDate) {
        this.reportDate = reportDate;
    }

    public int getTotalCustomer() {
        return totalCustomer;
    }

    public void setTotalCustomer(int totalCustomer) {
        this.totalCustomer = totalCustomer;
    }

    public double getSales() {
        return sales;
    }

    public void setSales(double sales) {
        this.sales = sales;
    }
    
    
}
