<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dental.model.User" %>
<%
    // Retrieve the securely stored logged-in user from the Session
    User currentUser = (User) session.getAttribute("activeUser");
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="dashboard.jsp">
            <i class="bi bi-hospital"></i> Dental Clinic System
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="patients.jsp">Patients</a></li>
                <li class="nav-item"><a class="nav-link" href="appointments.jsp">Appointments</a></li>
                <li class="nav-item"><a class="nav-link" href="treatments.jsp">Treatments</a></li>
                <li class="nav-item"><a class="nav-link" href="doctors.jsp">Doctors</a></li>
                <li class="nav-item"><a class="nav-link" href="billing.jsp">Billing</a></li>
                <li class="nav-item"><a class="nav-link" href="inquiries.jsp">Inquiries</a></li>
                <li class="nav-item"><a class="nav-link text-warning" href="system_logs.jsp">Logs</a></li>
            </ul>

            <div class="d-flex align-items-center">
                <%
                    // If a user is logged in, show their name and the Logout button
                    if (currentUser != null) {
                %>
                    <span class="text-white me-3">
                        <i class="bi bi-person-circle"></i> Hi, <strong><%= currentUser.getUsername() %></strong>
                        <span class="badge bg-info text-dark ms-1"><%= currentUser.getRole() %></span>
                    </span>
                    <a href="LogoutServlet" class="btn btn-danger btn-sm fw-bold shadow-sm">
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </a>
                <%
                    // If NO user is logged in, show Login and Register buttons
                    } else {
                %>
                    <a href="login.jsp" class="btn btn-outline-light btn-sm fw-bold me-2">
                        <i class="bi bi-box-arrow-in-right"></i> Login
                    </a>
                    <a href="register.jsp" class="btn btn-warning btn-sm fw-bold text-dark">
                        <i class="bi bi-person-plus"></i> Register
                    </a>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</nav>