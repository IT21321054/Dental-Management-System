package com.dental.controller;

import com.dental.dao.AppointmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// =======================================================================
// CONTROLLER: UpdateAppStatusServlet
// Handles requests to change the status of an appointment from the table buttons
// =======================================================================
@WebServlet("/UpdateAppStatusServlet")
public class UpdateAppStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get the appointment ID and the new status from the URL
        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        // 2. Call the DAO to update the database
        AppointmentDAO dao = new AppointmentDAO();
        boolean isUpdated = dao.updateAppointmentStatus(id, status);

        // 3. Redirect back to the appointments page
        if (isUpdated) {
            response.sendRedirect("appointments.jsp?status=updated");
        } else {
            response.sendRedirect("appointments.jsp?status=error");
        }
    }
}