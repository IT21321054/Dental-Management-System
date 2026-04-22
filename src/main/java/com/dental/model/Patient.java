package com.dental.model;

// =======================================================================
// MODEL CLASS: Patient
// Encapsulates the details of a patient from the database
// =======================================================================
public class Patient {

    // Private fields matching the database columns
    private int patientId;
    private String name;
    private String contactNo;

    // Default constructor (Required for standard JavaBeans)
    public Patient() {
    }

    // Parameterized constructor (Used when inserting a new patient, ID is auto-generated)
    public Patient(String name, String contactNo) {
        this.name = name;
        this.contactNo = contactNo;
    }

    // Getters and Setters to access the private fields securely
    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }
}