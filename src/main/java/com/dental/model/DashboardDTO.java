package com.dental.model;

public class DashboardDTO {
    private int totalPatients;
    private int todayAppointments;
    private double totalRevenue;
    private int pendingInquiries;

    // Getters and Setters
    public int getTotalPatients() { return totalPatients; }
    public void setTotalPatients(int totalPatients) { this.totalPatients = totalPatients; }

    public int getTodayAppointments() { return todayAppointments; }
    public void setTodayAppointments(int todayAppointments) { this.todayAppointments = todayAppointments; }

    public double getTotalRevenue() { return totalRevenue; }
    public void setTotalRevenue(double totalRevenue) { this.totalRevenue = totalRevenue; }

    public int getPendingInquiries() { return pendingInquiries; }
    public void setPendingInquiries(int pendingInquiries) { this.pendingInquiries = pendingInquiries; }

    // New variables for Chart
    private int paidBillsCount;
    private int pendingBillsCount;

    // Getters and Setters for Chart Data
    public int getPaidBillsCount() { return paidBillsCount; }
    public void setPaidBillsCount(int paidBillsCount) { this.paidBillsCount = paidBillsCount; }

    public int getPendingBillsCount() { return pendingBillsCount; }
    public void setPendingBillsCount(int pendingBillsCount) { this.pendingBillsCount = pendingBillsCount; }
}