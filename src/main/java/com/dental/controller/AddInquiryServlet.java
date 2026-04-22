package com.dental.controller;

import com.dental.dao.InquiryDAO;
import com.dental.model.Inquiry;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// =======================================================================
// CONTROLLER: AddInquiryServlet
// Handles the form submission when a patient sends a new inquiry
// =======================================================================
@WebServlet("/AddInquiryServlet")
public class AddInquiryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve data from the inquiries.jsp form
        int patientId = Integer.parseInt(request.getParameter("patientId"));
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // A new inquiry is always 'Open' until the staff answers it
        String status = "Open";

        // Populate Model
        Inquiry newInquiry = new Inquiry(patientId, subject, message, status);

        // Save via DAO
        InquiryDAO dao = new InquiryDAO();
        boolean isAdded = dao.addInquiry(newInquiry);

        // Redirect based on result
        if (isAdded) {
            response.sendRedirect("inquiries.jsp?status=success");
        } else {
            response.sendRedirect("inquiries.jsp?status=error");
        }
    }
}