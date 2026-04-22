<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.dental.dao.InquiryDAO" %>
<%@ page import="com.dental.model.Inquiry" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Patient Inquiries - Dental Clinic</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body class="bg-light">

    <jsp:include page="navbar.jsp" />

    <div class="container mt-5">
        <h2 class="mb-4"><i class="bi bi-chat-dots-fill text-info"></i> Patient Inquiries</h2>

        <div class="row">

            <div class="col-md-4">
                <div class="card shadow-sm border-info">
                    <div class="card-header bg-info text-dark fw-bold">
                        Submit a New Inquiry
                    </div>
                    <div class="card-body">
                        <form action="AddInquiryServlet" method="POST">
                            <div class="mb-3">
                                <label class="form-label">Patient ID</label>
                                <input type="number" class="form-control" name="patientId" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Subject</label>
                                <input type="text" class="form-control" name="subject" placeholder="e.g., Pain after filling" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Message</label>
                                <textarea class="form-control" name="message" rows="4" placeholder="Describe your issue..." required></textarea>
                            </div>
                            <button type="submit" class="btn btn-info w-100 fw-bold text-dark">
                                <i class="bi bi-send"></i> Send Inquiry
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-dark text-white fw-bold">
                        Your Recent Inquiries
                    </div>
                    <div class="card-body">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Subject</th>
                                    <th>Message</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                                                    // Create DAO instance and fetch all inquiries
                                                                    InquiryDAO dao = new InquiryDAO();
                                                                    List<Inquiry> inquiries = dao.getAllInquiries();

                                                                    // Check if the list has data
                                                                    if (inquiries != null && !inquiries.isEmpty()) {
                                                                        // Loop through each inquiry
                                                                        for (Inquiry inq : inquiries) {
                                                                %>
                                                                            <tr>
                                                                                <td class="fw-bold"><%= inq.getSubject() %></td>
                                                                                <td><%= inq.getMessage() %></td>

                                                                                <td>
                                                                                    <% if("Answered".equalsIgnoreCase(inq.getStatus())) { %>
                                                                                        <span class="badge bg-success"><i class="bi bi-check2-all"></i> Answered</span>
                                                                                    <% } else { %>
                                                                                        <span class="badge bg-warning text-dark"><i class="bi bi-envelope"></i> Open</span>
                                                                                    <% } %>
                                                                                </td>
                                                                            </tr>
                                                                <%
                                                                        } // End of loop
                                                                    } else {
                                                                %>
                                                                        <tr>
                                                                            <td colspan="3" class="text-center text-muted p-4">
                                                                                <i class="bi bi-inbox fs-2 d-block mb-2"></i>
                                                                                You have no recent inquiries.
                                                                            </td>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>