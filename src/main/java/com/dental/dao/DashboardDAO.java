package com.dental.dao;

import com.dental.model.DashboardDTO;
import com.dental.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

public class DashboardDAO {

    public DashboardDTO getDashboardSummary() {
        DashboardDTO dto = new DashboardDTO();
        String today = LocalDate.now().toString(); // Gets current date in YYYY-MM-DD format

        try (Connection conn = new DBConnection().getConnection()) {

            // 1. Get Total Patients
            try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM patients")) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) dto.setTotalPatients(rs.getInt(1));
            }

            // 2. Get Today's Appointments
            try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM appointments WHERE appointment_date = ?")) {
                stmt.setString(1, today);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) dto.setTodayAppointments(rs.getInt(1));
            }

            // 3. Get Total Revenue (Sum of all 'Paid' bills)
            try (PreparedStatement stmt = conn.prepareStatement("SELECT SUM(total_amount) FROM billing WHERE payment_status = 'Paid'")) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) dto.setTotalRevenue(rs.getDouble(1));
            }

            // 4. Get Pending Inquiries
            try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM patient_inquiries WHERE status = 'Open'")) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) dto.setPendingInquiries(rs.getInt(1));
            }
            // 5. Get Paid Bills Count (For Chart)
            try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM billing WHERE payment_status = 'Paid'")) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) dto.setPaidBillsCount(rs.getInt(1));
            }

            // 6. Get Pending Bills Count (For Chart)
            try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM billing WHERE payment_status = 'Pending'")) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) dto.setPendingBillsCount(rs.getInt(1));
            }
        } catch (SQLException e) {
            System.err.println("Dashboard Data Fetch Error: " + e.getMessage());
        }
        return dto;
    }
}