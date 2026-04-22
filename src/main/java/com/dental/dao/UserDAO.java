package com.dental.dao;

import com.dental.model.User;
import com.dental.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// =======================================================================
// DATA ACCESS OBJECT: UserDAO
// Handles database operations for the Users table
// =======================================================================
public class UserDAO {

    // 1. Method to add a new Doctor (User)
    public boolean addDoctor(User doctor) {
        boolean isSuccess = false;
        String sql = "INSERT INTO Users (username, password, role, email, status) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, doctor.getUsername());
            stmt.setString(2, doctor.getPassword());
            stmt.setString(3, doctor.getRole()); // Will be set to 'Dentist'
            stmt.setString(4, doctor.getEmail());
            stmt.setString(5, doctor.getStatus()); // Usually 'Active'

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // 2. Method to fetch only the Doctors from the Users table
    public List<User> getAllDoctors() {
        List<User> doctorList = new ArrayList<>();
        // Fetch only users who have the role of 'Dentist'
        String sql = "SELECT * FROM Users WHERE role = 'Dentist' ORDER BY user_id DESC";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                User doc = new User();
                doc.setUserId(rs.getInt("user_id"));
                doc.setUsername(rs.getString("username"));
                doc.setEmail(rs.getString("email"));
                doc.setStatus(rs.getString("status"));
                // We typically do NOT fetch/display the password for security reasons

                doctorList.add(doc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doctorList;
    }
    // =======================================================================
    // METHOD: authenticateUser
    // Checks if the provided username and password match a record in the database
    // =======================================================================
    public User authenticateUser(String username, String password) {
        User user = null;
        // Query to find a user with the exact matching username and password
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // If a match is found, create a User object with their details
                    user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setRole(rs.getString("role"));
                    user.setEmail(rs.getString("email"));
                    user.setStatus(rs.getString("status"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user; // Will return null if no match is found
    }
    // =======================================================================
    // METHOD: registerUser
    // Registers a new user (defaulting to 'Patient' role) in the system
    // =======================================================================
    public boolean registerUser(User user) {
        boolean isSuccess = false;
        String sql = "INSERT INTO Users (username, password, role, email, status) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getRole());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getStatus());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            System.err.println("Database Error during Registration: " + e.getMessage());
            e.printStackTrace();
        }
        return isSuccess;
    }
}