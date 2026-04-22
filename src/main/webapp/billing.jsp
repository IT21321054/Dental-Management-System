<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.dental.dao.BillingDAO" %>
<%@ page import="com.dental.model.Bill" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Billing Management - Dental Clinic</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body class="bg-light">

    <jsp:include page="navbar.jsp" />

    <div class="container mt-5">
        <h2 class="mb-4"><i class="bi bi-receipt text-warning"></i> Billing & Payments</h2>

        <%
            String status = request.getParameter("status");
            if ("success".equals(status)) {
        %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill"></i> Invoice generated successfully!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } else if ("invalid_amount".equals(status)) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill"></i> Error: The amount must be greater than zero.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } else if ("db_error".equals(status)) { %>
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <i class="bi bi-database-exclamation"></i> Database Error: Ensure Patient ID and Treatment ID exist.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <div class="row">
            <div class="col-md-4">
                <div class="card shadow-sm border-warning">
                    <div class="card-header bg-warning text-dark fw-bold">
                        Create New Invoice
                    </div>
                    <div class="card-body">
                        <form action="AddBillServlet" method="POST" id="billingForm" onsubmit="return validateBillingForm()">
                            <div class="mb-3">
                                <label class="form-label">Patient ID</label>
                                <input type="number" class="form-control" name="patientId" id="patientId" min="1" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Treatment ID</label>
                                <input type="number" class="form-control" name="treatmentId" id="treatmentId" min="1" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Total Amount (Rs.)</label>
                                <div class="input-group">
                                    <span class="input-group-text">Rs.</span>
                                    <input type="number" step="0.01" class="form-control" name="totalAmount" id="totalAmount" min="0.01" required>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-warning w-100 fw-bold">
                                Generate Bill
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-dark text-white">
                        Recent Invoices
                    </div>
                    <div class="card-body">
                        <table class="table table-hover text-center">
                            <thead class="table-light">
                                <tr>
                                    <th>Bill ID</th>
                                    <th>Patient ID</th>
                                    <th>Amount (Rs.)</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    // DAO access to fetch billing records
                                    BillingDAO dao = new BillingDAO();
                                    List<Bill> bills = dao.getAllBills();

                                    if (bills != null && !bills.isEmpty()) {
                                        for (Bill b : bills) {
                                %>
                                            <tr>
                                                <td><%= b.getBillId() %></td>
                                                <td><%= b.getPatientId() %></td>
                                                <td>Rs. <%= String.format("%.2f", b.getTotalAmount()) %></td>
                                                <td>
                                                    <% if("Paid".equalsIgnoreCase(b.getPaymentStatus())) { %>
                                                        <span class="badge bg-success"><i class="bi bi-check-circle"></i> Paid</span>
                                                    <% } else { %>
                                                        <span class="badge bg-warning text-dark"><i class="bi bi-hourglass-split"></i> Pending</span>
                                                    <% } %>
                                                </td>
                                                <td>
                                                    <% if("Pending".equalsIgnoreCase(b.getPaymentStatus())) { %>
                                                        <a href="UpdateBillStatusServlet?id=<%= b.getBillId() %>" class="btn btn-sm btn-success">
                                                            <i class="bi bi-cash"></i> Mark Paid
                                                        </a>
                                                    <% } %>
                                                    <a href="invoice.jsp?id=<%= b.getBillId() %>" target="_blank" class="btn btn-sm btn-outline-primary">
                                                        <i class="bi bi-printer"></i> Print
                                                    </a>

                                                    <a href="editBill.jsp?id=<%= b.getBillId() %>" class="btn btn-sm btn-outline-info">
                                                        <i class="bi bi-pencil-square"></i> Edit
                                                    </a>

                                                    <a href="DeleteBillServlet?id=<%= b.getBillId() %>"
                                                       class="btn btn-sm btn-outline-danger"
                                                       onclick="return confirm('Are you sure you want to delete this bill?');">
                                                        <i class="bi bi-trash"></i> Delete
                                                    </a>
                                                </td>
                                            </tr>
                                <%
                                        }
                                    } else {
                                %>
                                        <tr>
                                            <td colspan="5" class="text-center text-muted">No invoices found.</td>
                                        </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function validateBillingForm() {
            // Get form values
            const patientId = document.getElementById("patientId").value;
            const treatmentId = document.getElementById("treatmentId").value;
            const amount = document.getElementById("totalAmount").value;

            // Logical Check: Ensure IDs are not negative or zero
            if (patientId <= 0 || treatmentId <= 0) {
                alert("Invalid IDs. Patient and Treatment IDs must be greater than zero.");
                return false;
            }

            // Logical Check: Ensure amount is a reasonable positive number
            if (parseFloat(amount) <= 0) {
                alert("The total amount must be a positive value.");
                return false;
            }

            // Optional: Confirm if amount is unusually large (e.g., > 1,000,000)
            if (parseFloat(amount) > 1000000) {
                return confirm("The amount entered is over Rs. 1,000,000. Is this correct?");
            }

            return true; // Form is valid
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>