<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.dental.dao.AppointmentDAO" %>
<%@ page import="com.dental.model.Appointment" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Appointments - Dental Clinic</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body class="bg-light">

    <jsp:include page="navbar.jsp" />

    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="bi bi-calendar-check text-success"></i> Appointment Scheduling</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addAppointmentModal">
                + Book Appointment
            </button>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <table class="table table-striped text-center">
                    <thead class="table-dark">
                        <tr>
                            <th>App. ID</th>
                            <th>Patient ID</th>
                            <th>Dentist ID</th>
                            <th>Date & Time</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                                                    // Create an instance of the DAO to interact with the database
                                                    AppointmentDAO dao = new AppointmentDAO();
                                                    // Fetch all appointments into a list
                                                    List<Appointment> appointments = dao.getAllAppointments();

                                                    // Check if the list contains data
                                                    if (appointments != null && !appointments.isEmpty()) {
                                                        // Loop through each appointment object in the list
                                                        for (Appointment app : appointments) {
                                                %>
                                                            <tr>
                                                                <td><%= app.getAppointmentId() %></td>
                                                                <td><%= app.getPatientId() %></td>
                                                                <td><%= app.getDentistId() %></td>
                                                                <td><%= app.getAppointmentDate() %></td>

                                                                <td>
                                                                    <% if("Scheduled".equals(app.getStatus())) { %>
                                                                        <span class="badge bg-warning text-dark"><%= app.getStatus() %></span>
                                                                    <% } else if("Completed".equals(app.getStatus())) { %>
                                                                        <span class="badge bg-success"><%= app.getStatus() %></span>
                                                                    <% } else { %>
                                                                        <span class="badge bg-danger"><%= app.getStatus() %></span>
                                                                    <% } %>
                                                                </td>

                                                                <td>
                                                                    <a href="UpdateAppStatusServlet?id=<%= app.getAppointmentId() %>&status=Completed" class="btn btn-sm btn-success">
                                                                        <i class="bi bi-check-circle"></i> Done
                                                                    </a>
                                                                    <a href="UpdateAppStatusServlet?id=<%= app.getAppointmentId() %>&status=Cancelled" class="btn btn-sm btn-danger">
                                                                        <i class="bi bi-x-circle"></i> Cancel
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                <%
                                                        } // End of the for loop
                                                    } else {
                                                %>
                                                        <tr>
                                                            <td colspan="6" class="text-center text-muted">No appointments found.</td>
                                                        </tr>
                                                <%
                                                    }
                                                %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="modal fade" id="addAppointmentModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Book New Appointment</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="AddAppointmentServlet" method="POST">
                        <div class="mb-3">
                            <label class="form-label">Patient ID</label>
                            <input type="number" class="form-control" name="patientId" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Dentist ID</label>
                            <input type="number" class="form-control" name="dentistId" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Appointment Date & Time</label>
                            <input type="datetime-local" class="form-control" name="appDateTime" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Save Appointment</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>