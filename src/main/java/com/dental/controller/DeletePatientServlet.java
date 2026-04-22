package com.dental.controller;

import com.dental.dao.PatientDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// =======================================================================
// CONTROLLER: DeletePatientServlet
// Handles GET requests to delete a patient based on the ID in the URL
// =======================================================================
@WebServlet("/DeletePatientServlet")
public class DeletePatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // We use doGet because the delete link in the JSP uses a URL parameter (GET request)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the patient ID from the URL (e.g., ?id=1)
        int id = Integer.parseInt(request.getParameter("id"));

        // Call the DAO to perform the deletion
        PatientDAO dao = new PatientDAO();
        boolean isDeleted = dao.deletePatient(id);

        // Redirect back to the patients page
        if (isDeleted) {
            response.sendRedirect("patients.jsp?status=deleted");
        } else {
            response.sendRedirect("patients.jsp?status=error");
        }
    }
}