<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dental.dao.PatientDAO" %>
<%@ page import="com.dental.model.Patient" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Patient - Dental Clinic System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="navbar.jsp" />

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm">
                    <div class="card-header bg-warning text-dark fw-bold">
                        Edit Patient Details
                    </div>
                    <div class="card-body">
                        <%
                            // Get the patient ID from the URL parameters
                            int id = Integer.parseInt(request.getParameter("id"));
                            PatientDAO dao = new PatientDAO();
                            // Fetch existing data to populate the form
                            Patient patient = dao.getPatientById(id);

                            if (patient != null) {
                        %>
                        <form action="UpdatePatientServlet" method="POST">
                            <input type="hidden" name="patientId" value="<%= patient.getPatientId() %>">

                            <div class="mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" class="form-control" name="patientName" value="<%= patient.getName() %>" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Contact Number</label>
                                <input type="text" class="form-control" name="contactNo" value="<%= patient.getContactNo() %>" required>
                            </div>

                            <button type="submit" class="btn btn-warning w-100 fw-bold">Update Patient</button>
                            <a href="patients.jsp" class="btn btn-secondary w-100 mt-2">Cancel</a>
                        </form>
                        <%
                            } else {
                                out.println("<p class='text-danger'>Patient not found.</p>");
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>