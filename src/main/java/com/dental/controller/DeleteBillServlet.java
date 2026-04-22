package com.dental.controller;

import com.dental.dao.BillingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteBillServlet")
public class DeleteBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the bill ID from the URL parameter (?id=X)
        String idParam = request.getParameter("id");

        if (idParam != null) {
            int billId = Integer.parseInt(idParam);

            BillingDAO dao = new BillingDAO();
            boolean isDeleted = dao.deleteBill(billId);

            if (isDeleted) {
                // Successful deletion: Redirect back with success message
                response.sendRedirect("billing.jsp?status=del_success");
            } else {
                // Failed (maybe due to constraints): Redirect back with error message
                response.sendRedirect("billing.jsp?status=del_error");
            }
        }
    }
}