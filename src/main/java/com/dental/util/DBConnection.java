package com.dental.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {


    private static final String URL = "jdbc:mysql://localhost:3306/dental_db";
    private static final String USER = "root";
    private static final String PASSWORD = "kanishka";

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }


    public static void main(String[] args) {
        try {
            Connection con = getConnection();
            if (con != null && !con.isClosed()) {
                System.out.println("✅ Database Connection Successful!");
            } else {
                System.out.println("❌ Database Connection Failed!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}