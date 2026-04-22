package com.dental.controller;

import com.dental.dao.BillingDAO;
import com.dental.model.Bill;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// =======================================================================
// CONTROLLER: AddBillServlet
// Handles the form submission to generate a new patient invoice
// =======================================================================
@WebServlet("/AddBillServlet")
public class AddBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve data from the billing.jsp form
        int patientId = Integer.parseInt(request.getParameter("patientId"));
        int treatmentId = Integer.parseInt(request.getParameter("treatmentId"));
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        String status = "Pending"; // New bills are always 'Pending' initially

        // Populate Model
        Bill newBill = new Bill(patientId, treatmentId, totalAmount, status);

        // Save via DAO
        BillingDAO dao = new BillingDAO();
        boolean isAdded = dao.addBill(newBill);

        // Redirect based on result
        if (isAdded) {
            response.sendRedirect("billing.jsp?status=success");
        } else {
            response.sendRedirect("billing.jsp?status=error");
        }
    }
}