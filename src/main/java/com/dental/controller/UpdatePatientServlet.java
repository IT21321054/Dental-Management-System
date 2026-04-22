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
// CONTROLLER: UpdatePatientServlet
// Handles POST requests to update a patient's details
// =======================================================================
@WebServlet("/UpdatePatientServlet")
public class UpdatePatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve updated data from the editPatient.jsp form
        int id = Integer.parseInt(request.getParameter("patientId")); // From hidden field
        String name = request.getParameter("patientName");
        String contactNo = request.getParameter("contactNo");

        // Populate the Model object
        Patient updatedPatient = new Patient();
        updatedPatient.setPatientId(id);
        updatedPatient.setName(name);
        updatedPatient.setContactNo(contactNo);

        // Call DAO to update the database
        PatientDAO dao = new PatientDAO();
        boolean isUpdated = dao.updatePatient(updatedPatient);

        // Redirect back to the main patient list
        if (isUpdated) {
            response.sendRedirect("patients.jsp?status=updated");
        } else {
            response.sendRedirect("patients.jsp?status=error");
        }
    }
}