package com.dental.controller;

import com.dental.dao.AppointmentDAO;
import com.dental.model.Appointment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// =======================================================================
// CONTROLLER: AddAppointmentServlet
// Handles the form submission to book a new appointment
// =======================================================================
@WebServlet("/AddAppointmentServlet")
public class AddAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve data from the appointments.jsp form
        int patientId = Integer.parseInt(request.getParameter("patientId"));
        int dentistId = Integer.parseInt(request.getParameter("dentistId"));
        String appDateTime = request.getParameter("appDateTime");
        String status = "Scheduled"; // Default status for new appointments

        // Populate Model
        Appointment newApp = new Appointment(patientId, dentistId, appDateTime, status);

        // Save via DAO
        AppointmentDAO dao = new AppointmentDAO();
        boolean isAdded = dao.addAppointment(newApp);

        // Redirect based on result
        if (isAdded) {
            response.sendRedirect("appointments.jsp?status=success");
        } else {
            response.sendRedirect("appointments.jsp?status=error");
        }
    }
}