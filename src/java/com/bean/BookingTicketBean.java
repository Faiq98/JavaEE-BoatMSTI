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
public class BookingTicketBean {
    
    private int bookID;
    private CustomerBean custID;
    private BoatServiceBean serviceID;
    private PaymentBean referenceNo;
    private String bookDate;
    private String departDate;
    private String returnDate;
    private int bookAdult;
    private int bookChild;
    private int bookInfant;
    private int totalBook;
    private String status;

    public int getBookID() {
        return bookID;
    }

    public void setBookID(int bookID) {
        this.bookID = bookID;
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

    public PaymentBean getReferenceNo() {
        return referenceNo;
    }

    public void setReferenceNo(PaymentBean referenceNo) {
        this.referenceNo = referenceNo;
    }

    public String getBookDate() {
        return bookDate;
    }

    public void setBookDate(String bookDate) {
        this.bookDate = bookDate;
    }
    
    

    public String getDepartDate() {
        return departDate;
    }

    public void setDepartDate(String departDate) {
        this.departDate = departDate;
    }

    public String getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(String returnDate) {
        this.returnDate = returnDate;
    }

    public int getBookAdult() {
        return bookAdult;
    }

    public void setBookAdult(int bookAdult) {
        this.bookAdult = bookAdult;
    }

    public int getBookChild() {
        return bookChild;
    }

    public void setBookChild(int bookChild) {
        this.bookChild = bookChild;
    }

    public int getBookInfant() {
        return bookInfant;
    }

    public void setBookInfant(int bookInfant) {
        this.bookInfant = bookInfant;
    }

    public int getTotalBook() {
        return totalBook;
    }

    public void setTotalBook(int totalBook) {
        this.totalBook = totalBook;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
