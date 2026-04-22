package com.dental.dao;

import com.dental.model.Bill;
import com.dental.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// =======================================================================
// DATA ACCESS OBJECT: BillingDAO
// Handles all database operations for the Billing table
// =======================================================================
public class BillingDAO {

    // 1. Method to create a new bill (CREATE)
    public boolean addBill(Bill bill) {
        boolean isSuccess = false;
        // payment_date is not included in the INSERT query because it is usually set later when the bill is 'Paid'
        String sql = "INSERT INTO Billing (patient_id, treatment_id, total_amount, payment_status) VALUES (?, ?, ?, ?)";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bill.getPatientId());
            stmt.setInt(2, bill.getTreatmentId());
            stmt.setDouble(3, bill.getTotalAmount());
            stmt.setString(4, bill.getPaymentStatus());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // 2. Method to fetch all bills (READ)
    public List<Bill> getAllBills() {
        List<Bill> billList = new ArrayList<>();
        String sql = "SELECT * FROM Billing ORDER BY bill_id DESC";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("bill_id"));
                bill.setPatientId(rs.getInt("patient_id"));
                bill.setTreatmentId(rs.getInt("treatment_id"));
                bill.setTotalAmount(rs.getDouble("total_amount"));
                bill.setPaymentDate(rs.getString("payment_date"));
                bill.setPaymentStatus(rs.getString("payment_status"));

                billList.add(bill);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return billList;
    }
    // =======================================================================
    // METHOD: updateBillStatus
    // Updates the payment status to 'Paid' and automatically sets today's date
    // =======================================================================
    public boolean updateBillStatus(int billId, String newStatus) {
        boolean isSuccess = false;

        // SQL query: We update the status AND use CURRENT_DATE() to record exactly when it was paid
        String sql = "UPDATE Billing SET payment_status = ?, payment_date = CURRENT_DATE() WHERE bill_id = ?";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newStatus);
            stmt.setInt(2, billId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            System.err.println("Database Error in updateBillStatus: " + e.getMessage());
            e.printStackTrace();
        }
        return isSuccess;
    }
    // =======================================================================
    // METHOD: getBillById
    // Fetches a single billing record from the database using the bill ID
    // =======================================================================
    public Bill getBillById(int billId) {
        Bill bill = null;
        String sql = "SELECT * FROM Billing WHERE bill_id = ?";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, billId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    bill = new Bill();
                    bill.setBillId(rs.getInt("bill_id"));
                    bill.setPatientId(rs.getInt("patient_id"));
                    bill.setTreatmentId(rs.getInt("treatment_id"));
                    bill.setTotalAmount(rs.getDouble("total_amount"));
                    bill.setPaymentDate(rs.getString("payment_date"));
                    bill.setPaymentStatus(rs.getString("payment_status"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bill;
    }
    // =======================================================================
    // METHOD: deleteBill
    // Deletes a specific billing record using its ID
    // =======================================================================
    public boolean deleteBill(int billId) {
        boolean isSuccess = false;
        String sql = "DELETE FROM billing WHERE bill_id = ?";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, billId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            // Logs error if foreign key constraint or DB connection fails
            System.err.println("Error deleting bill: " + e.getMessage());
            e.printStackTrace();
        }
        return isSuccess;
    }
    // =======================================================================
    // METHOD: updateBill
    // Updates an existing billing record in the database
    // =======================================================================
    public boolean updateBill(Bill bill) {
        boolean isSuccess = false;
        String sql = "UPDATE billing SET patient_id = ?, treatment_id = ?, total_amount = ?, payment_status = ? WHERE bill_id = ?";

        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bill.getPatientId());
            stmt.setInt(2, bill.getTreatmentId());
            stmt.setDouble(3, bill.getTotalAmount());
            stmt.setString(4, bill.getPaymentStatus());
            stmt.setInt(5, bill.getBillId());

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