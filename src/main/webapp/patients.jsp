<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %><%@ page import="com.dental.dao.PatientDAO" %><%@ page import="com.dental.model.Patient" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Management - Dental Clinic System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body class="bg-light">

    <jsp:include page="navbar.jsp" />

    <div class="container mt-5">
        <h2 class="mb-4"><i class="bi bi-people-fill text-primary"></i> Patient Management</h2>

        <div class="row">

            <div class="col-md-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Add New Patient</h5>
                    </div>
                    <div class="card-body">
                        <form action="AddPatientServlet" method="POST">
                            <div class="mb-3">
                                <label for="patientName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="patientName" name="patientName" required>
                            </div>
                            <div class="mb-3">
                                <label for="contactNo" class="form-label">Contact Number</label>
                                <input type="text" class="form-control" id="contactNo" name="contactNo" required>
                            </div>
                            <button type="submit" class="btn btn-success w-100">
                                <i class="bi bi-person-plus"></i> Register Patient
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-dark text-white">
                        <h5 class="mb-0">Registered Patients</h5>
                    </div>
                    <div class="card-body">
                        <table class="table table-hover table-bordered">
                            <thead class="table-light">
                                <tr>
                                    <th>Patient ID</th>
                                    <th>Name</th>
                                    <th>Contact No.</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                        // Create an instance of PatientDAO
                                        PatientDAO dao = new PatientDAO();
                                        // Call the method to get all patients from the database
                                        List<Patient> patients = dao.getAllPatients();

                                        // Check if the list is not empty
                                        if (patients != null && !patients.isEmpty()) {
                                            // Loop through each patient in the list
                                            for (Patient p : patients) {
                                    %>
                                                <tr>
                                                    <td><%= p.getPatientId() %></td>
                                                    <td><%= p.getName() %></td>
                                                    <td><%= p.getContactNo() %></td>
                                                    <td>
                                                        <a href="editPatient.jsp?id=<%= p.getPatientId() %>" class="btn btn-sm btn-outline-primary">Edit</a>
                                                        <a href="DeletePatientServlet?id=<%= p.getPatientId() %>" class="btn btn-sm btn-outline-danger">Delete</a>
                                                    </td>
                                                </tr>
                                    <%
                                            } // End of loop
                                        } else {
                                    %>
                                            <tr>
                                                <td colspan="4" class="text-center text-muted">No patients found in the database.</td>
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