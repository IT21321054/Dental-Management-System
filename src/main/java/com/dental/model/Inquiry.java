package com.dental.model;

// =======================================================================
// MODEL CLASS: Inquiry
// Encapsulates the details of a patient's inquiry/message
// =======================================================================
public class Inquiry {

    private int inquiryId;
    private int patientId;
    private String subject;
    private String message;
    private String status; // 'Open' (Unanswered) or 'Answered'

    // Default constructor
    public Inquiry() {
    }

    // Constructor for creating a new inquiry
    public Inquiry(int patientId, String subject, String message, String status) {
        this.patientId = patientId;
        this.subject = subject;
        this.message = message;
        this.status = status;
    }

    // Getters and Setters
    public int getInquiryId() { return inquiryId; }
    public void setInquiryId(int inquiryId) { this.inquiryId = inquiryId; }

    public int getPatientId() { return patientId; }
    public void setPatientId(int patientId) { this.patientId = patientId; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}