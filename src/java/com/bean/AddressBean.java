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
public class AddressBean {
    
    private int addPoscode;
    private String addCity;
    private String addState;

    public AddressBean(){}
    
    public AddressBean(int addPoscode){
        setAddPoscode(addPoscode);
    }
    
    public AddressBean(int addPoscode, String addCity, String addState){
        setAddPoscode(addPoscode);
        setAddCity(addCity);
        setAddState(addState);
    }
    
    public int getAddPoscode() {
        return addPoscode;
    }

    public void setAddPoscode(int addPoscode) {
        this.addPoscode = addPoscode;
    }

    public String getAddCity() {
        return addCity;
    }

    public void setAddCity(String addCity) {
        this.addCity = addCity;
    }

    public String getAddState() {
        return addState;
    }

    public void setAddState(String addState) {
        this.addState = addState;
    }
    
    
    
}
