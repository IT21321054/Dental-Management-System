CREATE DATABASE IF NOT EXISTS dental_db;
USE dental_db;


CREATE TABLE IF NOT EXISTS Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    contact_no VARCHAR(15)
);


CREATE TABLE IF NOT EXISTS Treatments (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    treatment_date DATE NOT NULL,
    treatment_type VARCHAR(100),
    notes TEXT,
    cost DECIMAL(10,2),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- =======================================================================
-- DENTAL MANAGEMENT SYSTEM - COMPLETE DATABASE SCHEMA
-- =======================================================================

-- Create the database if it doesn't exist and select it for use
CREATE DATABASE IF NOT EXISTS dental_db;
USE dental_db;

-- =======================================================================
-- PARENT TABLES (Must be created first due to Foreign Key dependencies)
-- =======================================================================

-- Table for storing patient basic details
CREATE TABLE IF NOT EXISTS Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    contact_no VARCHAR(15)
);

-- FUNCTION 1: User Registration and Authentication
-- Table for Admin, Receptionist, Dentist, and Patient accounts
CREATE TABLE IF NOT EXISTS Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL, -- Roles: 'Admin', 'Receptionist', 'Dentist', 'Patient'
    email VARCHAR(100),
    status VARCHAR(20) DEFAULT 'Active'
);

-- =======================================================================
-- CHILD TABLES (Contain Foreign Keys linking to Parent Tables)
-- =======================================================================

-- FUNCTION 4: Treatment History Management (Team Leader's Module)
-- Links to Patients table
CREATE TABLE IF NOT EXISTS Treatments (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    treatment_date DATE NOT NULL,
    treatment_type VARCHAR(100),
    notes TEXT,
    cost DECIMAL(10,2),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- FUNCTION 2: Appointment Scheduling
-- Links to Patients and Users (Dentist) tables
CREATE TABLE IF NOT EXISTS Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    dentist_id INT, -- Links to the Users table where role is 'Dentist'
    appointment_date DATETIME NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled', -- Status: 'Scheduled', 'Completed', 'Cancelled'
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (dentist_id) REFERENCES Users(user_id)
);

-- FUNCTION 3: Patient Record Management
-- Links to Patients table for extended medical history
CREATE TABLE IF NOT EXISTS Medical_History (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    allergies TEXT,
    past_surgeries TEXT,
    blood_group VARCHAR(5),
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- FUNCTION 5: Billing and Payments
-- Links to Patients and Treatments tables
CREATE TABLE IF NOT EXISTS Billing (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    treatment_id INT,
    total_amount DECIMAL(10,2) NOT NULL,
    payment_date DATE,
    payment_status VARCHAR(20) DEFAULT 'Pending', -- Status: 'Pending', 'Paid'
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (treatment_id) REFERENCES Treatments(treatment_id)
);

-- FUNCTION 6: Admin Management and Reporting
-- Links to Users table to track activities
CREATE TABLE IF NOT EXISTS System_Logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    action_description VARCHAR(255) NOT NULL,
    log_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- FUNCTION 7: Patient Dashboard
-- Links to Patients table for their inquiries/messages
CREATE TABLE IF NOT EXISTS Patient_Inquiries (
    inquiry_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    subject VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    reply TEXT,
    status VARCHAR(20) DEFAULT 'Open', -- Status: 'Open', 'Answered'
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);