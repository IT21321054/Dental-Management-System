<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dental.dao.BillingDAO" %>
<%@ page import="com.dental.model.Bill" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Bill - SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="navbar.jsp" />

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">Edit Billing Information</h4>
                    </div>
                    <div class="card-body">
                        <%
                            int billId = Integer.parseInt(request.getParameter("id"));
                            BillingDAO dao = new BillingDAO();
                            Bill bill = dao.getBillById(billId);

                            if (bill != null) {
                        %>
                        <form action="UpdateBillServlet" method="POST">
                            <input type="hidden" name="billId" value="<%= bill.getBillId() %>">

                            <div class="mb-3">
                                <label class="form-label">Patient ID</label>
                                <input type="number" class="form-control" name="patientId" value="<%= bill.getPatientId() %>" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Treatment ID</label>
                                <input type="number" class="form-control" name="treatmentId" value="<%= bill.getTreatmentId() %>" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Total Amount (Rs.)</label>
                                <input type="number" step="0.01" class="form-control" name="totalAmount" value="<%= bill.getTotalAmount() %>" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Payment Status</label>
                                <select class="form-select" name="status">
                                    <option value="Pending" <%= "Pending".equals(bill.getPaymentStatus()) ? "selected" : "" %>>Pending</option>
                                    <option value="Paid" <%= "Paid".equals(bill.getPaymentStatus()) ? "selected" : "" %>>Paid</option>
                                </select>
                            </div>
                            <div class="d-flex justify-content-between">
                                <a href="billing.jsp" class="btn btn-secondary">Cancel</a>
                                <button type="submit" class="btn btn-success">Update Bill</button>
                            </div>
                        </form>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>