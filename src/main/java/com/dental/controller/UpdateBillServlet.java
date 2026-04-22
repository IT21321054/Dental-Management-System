package com.dental.controller;

import com.dental.dao.BillingDAO;
import com.dental.model.Bill;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UpdateBillServlet")
public class UpdateBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve data from the Edit form
        int billId = Integer.parseInt(request.getParameter("billId"));
        int patientId = Integer.parseInt(request.getParameter("patientId"));
        int treatmentId = Integer.parseInt(request.getParameter("treatmentId"));
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        String status = request.getParameter("status");

        // Create a Bill object with updated details
        Bill updatedBill = new Bill();
        updatedBill.setBillId(billId);
        updatedBill.setPatientId(patientId);
        updatedBill.setTreatmentId(treatmentId);
        updatedBill.setTotalAmount(totalAmount);
        updatedBill.setPaymentStatus(status);

        // Call DAO to save changes
        BillingDAO dao = new BillingDAO();
        boolean isUpdated = dao.updateBill(updatedBill);

        if (isUpdated) {
            response.sendRedirect("billing.jsp?status=upd_success");
        } else {
            response.sendRedirect("billing.jsp?status=upd_error");
        }
    }
}