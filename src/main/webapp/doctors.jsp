<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.dental.dao.UserDAO" %>
<%@ page import="com.dental.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Doctors Management - SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body class="bg-light">

    <jsp:include page="navbar.jsp" />

    <div class="container mt-5">
        <h2 class="mb-4 text-primary"><i class="bi bi-person-badge"></i> Doctors Management</h2>

        <div class="row">
            <div class="col-md-4">
                <div class="card shadow-sm border-primary">
                    <div class="card-header bg-primary text-white fw-bold">
                        Register New Dentist
                    </div>
                    <div class="card-body">
                        <form action="AddDoctorServlet" method="POST">
                            <div class="mb-3">
                                <label class="form-label">Doctor Name (Username)</label>
                                <input type="text" class="form-control" name="docName" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Email Address</label>
                                <input type="email" class="form-control" name="email" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Temporary Password</label>
                                <input type="password" class="form-control" name="password" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 fw-bold">
                                <i class="bi bi-person-plus"></i> Register Doctor
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-dark text-white fw-bold">
                        Our Dental Specialists
                    </div>
                    <div class="card-body">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Doctor Name</th>
                                    <th>Email</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    UserDAO dao = new UserDAO();
                                    List<User> doctors = dao.getAllDoctors();

                                    if (doctors != null && !doctors.isEmpty()) {
                                        for (User doc : doctors) {
                                %>
                                            <tr>
                                                <td><%= doc.getUserId() %></td>
                                                <td class="fw-bold">Dr. <%= doc.getUsername() %></td>
                                                <td><%= doc.getEmail() %></td>
                                                <td>
                                                    <% if("Active".equalsIgnoreCase(doc.getStatus())) { %>
                                                        <span class="badge bg-success">Active</span>
                                                    <% } else { %>
                                                        <span class="badge bg-danger">Inactive</span>
                                                    <% } %>
                                                </td>
                                            </tr>
                                <%
                                        }
                                    } else {
                                %>
                                        <tr>
                                            <td colspan="4" class="text-center text-muted p-3">No doctors registered yet.</td>
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