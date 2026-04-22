package com.dental.dao;

import com.dental.model.Patient;
import com.dental.util.DBConnection; // Assuming this is your Singleton connection class

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;

// =======================================================================
// DATA ACCESS OBJECT: PatientDAO
// Handles all database operations (CRUD) for the Patients table
// =======================================================================
public class PatientDAO {

    // Method to insert a new patient into the database
    public boolean addPatient(Patient patient) {
        boolean isSuccess = false;

        // SQL query with placeholders (?) to prevent SQL Injection attacks
        String sql = "INSERT INTO Patients (name, contact_no) VALUES (?, ?)";

        // Using try-with-resources to automatically close the database connection
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set the values for the placeholders from the Patient object
            stmt.setString(1, patient.getName());
            stmt.setString(2, patient.getContactNo());

            // Execute the query
            int rowsAffected = stmt.executeUpdate();

            // If rowsAffected is greater than 0, the insertion was successful
            if (rowsAffected > 0) {
                isSuccess = true;
            }

        } catch (SQLException e) {
            // Log the error message for debugging purposes
            System.err.println("Database Error in AddPatient: " + e.getMessage());
            e.printStackTrace();
        }

        return isSuccess;
    }
    public List<Patient> getAllPatients() {
        List<Patient> patientList = new ArrayList<>();
        String sql = "SELECT * FROM Patients"; // SQL query to get all records

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            // Loop through each row in the result set
            while (rs.next()) {
                Patient patient = new Patient();

                // Extract data from the current row and set it to the Patient object
                patient.setPatientId(rs.getInt("patient_id"));
                patient.setName(rs.getString("name"));
                patient.setContactNo(rs.getString("contact_no"));

                // Add the populated Patient object to our list
                patientList.add(patient);
            }

        } catch (SQLException e) {
            System.err.println("Database Error in getAllPatients: " + e.getMessage());
            e.printStackTrace();
        }

        return patientList;
    }
    // =======================================================================
    // METHOD: deletePatient
    // Deletes a patient record from the database using their patient ID
    // =======================================================================
    public boolean deletePatient(int id) {
        boolean isSuccess = false;
        // SQL query to delete the specific row where patient_id matches
        String sql = "DELETE FROM Patients WHERE patient_id = ?";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set the ID parameter in the SQL query
            stmt.setInt(1, id);

            // Execute the deletion
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }

        } catch (SQLException e) {
            System.err.println("Database Error in deletePatient: " + e.getMessage());
            e.printStackTrace();
        }
        return isSuccess;
    }
    // =======================================================================
    // METHOD: getPatientById
    // Fetches a single patient's details to populate the Edit form
    // =======================================================================
    public Patient getPatientById(int id) {
        Patient patient = null;
        String sql = "SELECT * FROM Patients WHERE patient_id = ?";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    patient = new Patient();
                    patient.setPatientId(rs.getInt("patient_id"));
                    patient.setName(rs.getString("name"));
                    patient.setContactNo(rs.getString("contact_no"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patient;
    }

    // =======================================================================
    // METHOD: updatePatient
    // Updates an existing patient's details in the database
    // =======================================================================
    public boolean updatePatient(Patient patient) {
        boolean isSuccess = false;
        String sql = "UPDATE Patients SET name = ?, contact_no = ? WHERE patient_id = ?";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, patient.getName());
            stmt.setString(2, patient.getContactNo());
            stmt.setInt(3, patient.getPatientId());

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