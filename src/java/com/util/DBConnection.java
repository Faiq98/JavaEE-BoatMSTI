/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author fhfai
 */
public class DBConnection {

    private static Connection con;

    public static Connection createConnection() {
        con = null;
        String url = "jdbc:mysql://localhost:3306/bmstidb";
        String username = "root";
        String password = "";

        try {
            try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException ex) {
                ex.printStackTrace();
            }
            con = DriverManager.getConnection(url, username, password);
            System.out.println("Printing connection object: " + con);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return con;
    }

    public void closeConnection() {
        try {
            con.close();
            System.out.println("Close Connection");

        } catch (SQLException e) {
            e.getMessage();
        }
    }
}
