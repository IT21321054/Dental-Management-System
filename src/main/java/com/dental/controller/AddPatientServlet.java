package com.dental.controller;

import com.dental.dao.PatientDAO;
import com.dental.model.Patient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// =======================================================================
// CONTROLLER: AddPatientServlet
// Handles HTTP requests from the Add Patient form in patients.jsp
// =======================================================================
@WebServlet("/AddPatientServlet")
public class AddPatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Retrieve form data sent from patients.jsp
        String name = request.getParameter("patientName");
        String contactNo = request.getParameter("contactNo");

        // Step 2: Create a Model object and populate it with the form data
        Patient newPatient = new Patient(name, contactNo);

        // Step 3: Call the DAO method to save the data
        PatientDAO patientDAO = new PatientDAO();
        boolean isAdded = patientDAO.addPatient(newPatient);

        // Step 4: Redirect the user based on success or failure
        if (isAdded) {
            // If successful, send them back to the patients page (can add a success parameter later)
            response.sendRedirect("patients.jsp?status=success");
        } else {
            // If failed, send them back with an error parameter
            response.sendRedirect("patients.jsp?status=error");
        }
    }
}