package com.dental.controller;

import com.dental.dao.BillingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// =======================================================================
// CONTROLLER: UpdateBillStatusServlet
// Handles requests to mark a specific bill as 'Paid'
// =======================================================================
@WebServlet("/UpdateBillStatusServlet")
public class UpdateBillStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Using doGet because the request comes from a URL link (<a> tag in the JSP)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Retrieve the bill ID from the URL parameter (e.g., ?id=3)
        int id = Integer.parseInt(request.getParameter("id"));

        // 2. The status to update to is strictly 'Paid'
        String status = "Paid";

        // 3. Call the DAO method
        BillingDAO dao = new BillingDAO();
        boolean isUpdated = dao.updateBillStatus(id, status);

        // 4. Redirect back to the billing dashboard
        if (isUpdated) {
            // Success: reload page to see the updated badge
            response.sendRedirect("billing.jsp?status=paid");
        } else {
            // Error handling
            response.sendRedirect("billing.jsp?status=error");
        }
    }
}