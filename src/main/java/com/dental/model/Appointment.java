package com.dental.model;

// =======================================================================
// MODEL CLASS: Appointment
// Encapsulates the details of an appointment from the database
// =======================================================================
public class Appointment {

    private int appointmentId;
    private int patientId;
    private int dentistId;
    private String appointmentDate; // Stored as String for easy parsing from HTML datetime-local
    private String status;

    // Default constructor
    public Appointment() {
    }

    // Constructor for creating a new appointment
    public Appointment(int patientId, int dentistId, String appointmentDate, String status) {
        this.patientId = patientId;
        this.dentistId = dentistId;
        this.appointmentDate = appointmentDate;
        this.status = status;
    }

    // Getters and Setters
    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public int getDentistId() {
        return dentistId;
    }

    public void setDentistId(int dentistId) {
        this.dentistId = dentistId;
    }

    public String getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(String appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}