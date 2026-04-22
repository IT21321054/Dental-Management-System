package com.dental.dao;

import com.dental.model.Inquiry;
import com.dental.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// =======================================================================
// DATA ACCESS OBJECT: InquiryDAO
// Handles database operations for the patient_inquiries table
// =======================================================================
public class InquiryDAO {

    // 1. Method to insert a new inquiry from a patient (CREATE)
    public boolean addInquiry(Inquiry inquiry) {
        boolean isSuccess = false;
        String sql = "INSERT INTO patient_inquiries (patient_id, subject, message, status) VALUES (?, ?, ?, ?)";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, inquiry.getPatientId());
            stmt.setString(2, inquiry.getSubject());
            stmt.setString(3, inquiry.getMessage());
            stmt.setString(4, inquiry.getStatus());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // 2. Method to fetch all inquiries to display on the Dashboard (READ)
    public List<Inquiry> getAllInquiries() {
        List<Inquiry> inquiryList = new ArrayList<>();
        // Fetch newest inquiries first
        String sql = "SELECT * FROM patient_inquiries ORDER BY inquiry_id DESC";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Inquiry inq = new Inquiry();
                inq.setInquiryId(rs.getInt("inquiry_id"));
                inq.setPatientId(rs.getInt("patient_id"));
                inq.setSubject(rs.getString("subject"));
                inq.setMessage(rs.getString("message"));
                inq.setStatus(rs.getString("status"));

                inquiryList.add(inq);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return inquiryList;
    }
}