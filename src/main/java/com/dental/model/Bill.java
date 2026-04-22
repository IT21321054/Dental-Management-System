package com.dental.model;

// =======================================================================
// MODEL CLASS: Bill
// Encapsulates the details of a billing invoice from the database
// =======================================================================
public class Bill {

    private int billId;
    private int patientId;
    private int treatmentId;
    private double totalAmount;
    private String paymentDate; // Can be null if status is 'Pending'
    private String paymentStatus; // 'Pending' or 'Paid'

    // Default constructor
    public Bill() {
    }

    // Constructor for creating a new bill
    public Bill(int patientId, int treatmentId, double totalAmount, String paymentStatus) {
        this.patientId = patientId;
        this.treatmentId = treatmentId;
        this.totalAmount = totalAmount;
        this.paymentStatus = paymentStatus;
    }

    // Getters and Setters
    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }

    public int getPatientId() { return patientId; }
    public void setPatientId(int patientId) { this.patientId = patientId; }

    public int getTreatmentId() { return treatmentId; }
    public void setTreatmentId(int treatmentId) { this.treatmentId = treatmentId; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public String getPaymentDate() { return paymentDate; }
    public void setPaymentDate(String paymentDate) { this.paymentDate = paymentDate; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
}