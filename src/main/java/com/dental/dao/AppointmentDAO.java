package com.dental.dao;

import com.dental.model.Appointment;
import com.dental.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// =======================================================================
// DATA ACCESS OBJECT: AppointmentDAO
// Handles all database operations for the Appointments table
// =======================================================================
public class AppointmentDAO {

    // 1. Method to insert a new appointment (CREATE)
    public boolean addAppointment(Appointment app) {
        boolean isSuccess = false;
        String sql = "INSERT INTO Appointments (patient_id, dentist_id, appointment_date, status) VALUES (?, ?, ?, ?)";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, app.getPatientId());
            stmt.setInt(2, app.getDentistId());
            // HTML datetime-local uses 'T' between date and time. MySQL prefers a space.
            stmt.setString(3, app.getAppointmentDate().replace("T", " "));
            stmt.setString(4, app.getStatus());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // 2. Method to fetch all appointments (READ)
    public List<Appointment> getAllAppointments() {
        List<Appointment> appList = new ArrayList<>();
        String sql = "SELECT * FROM Appointments ORDER BY appointment_date DESC";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Appointment app = new Appointment();
                app.setAppointmentId(rs.getInt("appointment_id"));
                app.setPatientId(rs.getInt("patient_id"));
                app.setDentistId(rs.getInt("dentist_id"));
                app.setAppointmentDate(rs.getString("appointment_date"));
                app.setStatus(rs.getString("status"));

                appList.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appList;
    }
    // =======================================================================
    // METHOD: updateAppointmentStatus
    // Updates the status of an appointment (e.g., to 'Completed' or 'Cancelled')
    // =======================================================================
    public boolean updateAppointmentStatus(int appId, String newStatus) {
        boolean isSuccess = false;
        // SQL query to update only the status field for a specific appointment
        String sql = "UPDATE Appointments SET status = ? WHERE appointment_id = ?";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set the new status and the appointment ID
            stmt.setString(1, newStatus);
            stmt.setInt(2, appId);

            // Execute the update
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }
}