package com.dental.dao;

import com.dental.model.SystemLog;
import com.dental.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// =======================================================================
// DATA ACCESS OBJECT: SystemLogDAO
// Handles database operations for the System_Logs table
// =======================================================================
public class SystemLogDAO {

    // 1. Method to insert a new log (Will be used in the background by other Servlets later)
    public boolean addLog(int userId, String actionDescription) {
        boolean isSuccess = false;
        // The timestamp column in MySQL usually defaults to CURRENT_TIMESTAMP automatically
        String sql = "INSERT INTO System_Logs (user_id, action_description) VALUES (?, ?)";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, actionDescription);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // 2. Method to fetch all logs to display on the Admin Dashboard (READ)
    public List<SystemLog> getAllLogs() {
        List<SystemLog> logList = new ArrayList<>();
        // Fetch logs ordering by the newest first
        String sql = "SELECT * FROM System_Logs ORDER BY log_id DESC";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                SystemLog log = new SystemLog();
                log.setLogId(rs.getInt("log_id"));
                log.setUserId(rs.getInt("user_id"));
                log.setActionDescription(rs.getString("action_description"));

                // MySQL DATETIME can be retrieved as a string for easy display
                log.setTimestamp(rs.getString("log_date"));

                logList.add(log);
            }
        } catch (SQLException e) {
            System.err.println("Database Error in getAllLogs: " + e.getMessage());
            e.printStackTrace();
        }
        return logList;
    }
}