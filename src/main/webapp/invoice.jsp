<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dental.dao.BillingDAO" %>
<%@ page import="com.dental.model.Bill" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Print Invoice - SmileCare Dental</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* CSS to hide the print button itself when the physical document is printed */
        @media print {
            .no-print {
                display: none !important;
            }
        }
        .invoice-box {
            max-width: 800px;
            margin: auto;
            padding: 30px;
            border: 1px solid #eee;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
        }
    </style>
</head>
<body class="bg-white p-5">

    <%
        // Fetch the bill details based on the ID passed in the URL
        String idParam = request.getParameter("id");
        if (idParam != null) {
            int billId = Integer.parseInt(idParam);
            BillingDAO dao = new BillingDAO();
            Bill bill = dao.getBillById(billId);

            if (bill != null) {
    %>
                <div class="invoice-box">
                    <div class="text-center mb-4">
                        <h2 class="fw-bold">SmileCare Dental Clinic</h2>
                        <p class="text-muted">123 Health Avenue, Colombo | Tel: 011-2345678</p>
                        <hr>
                        <h4>OFFICIAL INVOICE</h4>
                    </div>

                    <div class="row mb-4">
                        <div class="col-sm-6">
                            <strong>Invoice No:</strong> #INV-00<%= bill.getBillId() %><br>
                            <strong>Patient ID:</strong> <%= bill.getPatientId() %><br>
                            <strong>Treatment ID:</strong> <%= bill.getTreatmentId() %>
                        </div>
                        <div class="col-sm-6 text-end">
                            <strong>Status:</strong> <%= bill.getPaymentStatus() %><br>
                            <strong>Payment Date:</strong> <%= (bill.getPaymentDate() != null) ? bill.getPaymentDate() : "N/A" %>
                        </div>
                    </div>

                    <table class="table table-bordered">
                        <thead class="table-light">
                            <tr>
                                <th>Description</th>
                                <th class="text-end">Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Dental Treatment Services (Ref: <%= bill.getTreatmentId() %>)</td>
                                <td class="text-end">Rs. <%= String.format("%.2f", bill.getTotalAmount()) %></td>
                            </tr>
                            <tr>
                                <td class="text-end fw-bold">Grand Total</td>
                                <td class="text-end fw-bold">Rs. <%= String.format("%.2f", bill.getTotalAmount()) %></td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="text-center mt-5 no-print">
                        <button onclick="window.print()" class="btn btn-primary btn-lg"><i class="bi bi-printer"></i> Print Document</button>
                        <a href="billing.jsp" class="btn btn-secondary btn-lg ms-2">Back to Billing</a>
                    </div>
                </div>

                <script>
                    window.onload = function() {
                        window.print();
                    };
                </script>
    <%
            } else {
                out.println("<h3 class='text-danger text-center'>Invoice not found!</h3>");
            }
        }
    %>

</body>
</html>