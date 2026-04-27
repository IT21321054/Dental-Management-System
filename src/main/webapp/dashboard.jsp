<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.dental.util.DBConnection" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.dental.dao.DashboardDAO" %>
<%@ page import="com.dental.model.DashboardDTO" %>
<%@ page import="com.dental.model.User" %>

<%
    // 1. VALIDATION: Check if user is logged in
    User currentUser = (User) session.getAttribute("activeUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp?auth=required");
        return; // Stop page execution
    }

    // 2. VALIDATION: Role-based Access Control (Only Admin/Dentist can view Dashboard)
    if ("Patient".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect("index.jsp?error=unauthorized");
        return; // Stop page execution
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .summary-card {
            transition: transform 0.2s;
        }
        .summary-card:hover {
            transform: translateY(-5px);
        }
        .icon-box {
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }
    </style>
</head>
<body class="bg-light">

    <jsp:include page="navbar.jsp" />

    <%
        // Fetch the summary data securely
        DashboardDAO dao = new DashboardDAO();
        DashboardDTO summary = dao.getDashboardSummary();

        // 3. VALIDATION: Prevent NullPointerException if DB connection fails
        if (summary == null) {
            summary = new DashboardDTO();
        }
    %>

    <div class="container mt-5 mb-5">
        <h2 class="mb-4 text-dark fw-bold"><i class="bi bi-speedometer2 text-primary"></i> Clinic Dashboard</h2>

       <div class="row mb-4">

                   <div class="col-md-3">
                       <div class="card shadow-sm border-0 summary-card border-bottom border-success border-4"
                            onclick="window.location.href='billing.jsp'"
                            style="cursor: pointer;" title="Click to view full Billing Report">
                           <div class="card-body d-flex align-items-center">
                               <div class="icon-box bg-success bg-opacity-10 text-success me-3">
                                   <i class="bi bi-cash-stack fs-3"></i>
                               </div>
                               <div>
                                   <p class="text-muted mb-0 small text-uppercase fw-bold">Total Revenue</p>
                                   <h4 class="mb-0 fw-bold text-dark">Rs. <%= String.format("%,.2f", summary.getTotalRevenue()) %></h4>
                               </div>
                           </div>
                       </div>
                   </div>

                   <div class="col-md-3">
                       <div class="card shadow-sm border-0 summary-card border-bottom border-primary border-4"
                            onclick="window.location.href='appointments.jsp'"
                            style="cursor: pointer;" title="Click to view all Appointments">
                           <div class="card-body d-flex align-items-center">
                               <div class="icon-box bg-primary bg-opacity-10 text-primary me-3">
                                   <i class="bi bi-calendar-check fs-3"></i>
                               </div>
                               <div>
                                   <p class="text-muted mb-0 small text-uppercase fw-bold">Today's Appointments</p>
                                   <h4 class="mb-0 fw-bold text-dark"><%= summary.getTodayAppointments() %></h4>
                               </div>
                           </div>
                       </div>
                   </div>

                   <div class="col-md-3">
                       <div class="card shadow-sm border-0 summary-card border-bottom border-info border-4"
                            onclick="window.location.href='patients.jsp'"
                            style="cursor: pointer;" title="Click to view Patients Directory">
                           <div class="card-body d-flex align-items-center">
                               <div class="icon-box bg-info bg-opacity-10 text-info me-3">
                                   <i class="bi bi-people fs-3"></i>
                               </div>
                               <div>
                                   <p class="text-muted mb-0 small text-uppercase fw-bold">Total Patients</p>
                                   <h4 class="mb-0 fw-bold text-dark"><%= summary.getTotalPatients() %></h4>
                               </div>
                           </div>
                       </div>
                   </div>

                   <div class="col-md-3">
                       <div class="card shadow-sm border-0 summary-card border-bottom border-warning border-4"
                            onclick="window.location.href='inquiries.jsp'"
                            style="cursor: pointer;" title="Click to view Pending Inquiries">
                           <div class="card-body d-flex align-items-center">
                               <div class="icon-box bg-warning bg-opacity-10 text-warning me-3">
                                   <i class="bi bi-envelope-exclamation fs-3"></i>
                               </div>
                               <div>
                                   <p class="text-muted mb-0 small text-uppercase fw-bold">Pending Inquiries</p>
                                   <h4 class="mb-0 fw-bold text-dark"><%= summary.getPendingInquiries() %></h4>
                               </div>
                           </div>
                       </div>
                   </div>
               </div>

        <div class="row mb-4">
            <div class="col-md-12">
                <h5 class="fw-bold mb-3">Quick Actions</h5>
                <div class="d-flex gap-3">
                    <a href="billing.jsp" class="btn btn-outline-success"><i class="bi bi-receipt"></i> Generate Bill</a>
                    <a href="appointments.jsp" class="btn btn-outline-primary"><i class="bi bi-calendar-plus"></i> New Appointment</a>
                    <a href="patients.jsp" class="btn btn-outline-info"><i class="bi bi-person-plus"></i> Register Patient</a>
                    <a href="inquiries.jsp" class="btn btn-outline-warning text-dark"><i class="bi bi-reply"></i> Answer Inquiries</a>
                </div>
            </div>
        </div>

        <div class="row mt-5">
            <div class="col-md-5">
                <div class="card shadow-sm border-0 h-100">
                    <div class="card-header bg-white fw-bold text-dark border-bottom py-3">
                        <i class="bi bi-pie-chart-fill text-primary"></i> Payment Status Overview
                    </div>
                    <div class="card-body d-flex justify-content-center align-items-center">
                        <canvas id="paymentChart" style="max-width: 300px; max-height: 300px;"></canvas>
                    </div>
                </div>
            </div>

            <div class="col-md-7">
                <div class="card shadow-sm border-0 h-100">
                    <div class="card-header bg-white fw-bold text-dark border-bottom py-3">
                        <i class="bi bi-calendar-day-fill text-primary"></i> Today's Appointments
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover table-striped mb-0 text-center">
                                <thead class="table-light text-muted small text-uppercase">
                                    <tr>
                                        <th>Appt ID</th>
                                        <th>Patient ID</th>
                                        <th>Doctor/Dentist</th>
                                        <th>Time</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        // Fetch today's appointments directly from DB
                                        try {
                                            Connection con = DBConnection.getConnection();
                                            String todayDate = LocalDate.now().toString();
                                            String sql = "SELECT * FROM appointments WHERE DATE(appointment_date) = ?";
                                            PreparedStatement ps = con.prepareStatement(sql);
                                            ps.setString(1, todayDate);
                                            ResultSet rs = ps.executeQuery();

                                            boolean hasAppointments = false;
                                            while (rs.next()) {
                                                hasAppointments = true;
                                    %>
                                                <tr>
                                                    <td class="py-3">#<%= rs.getInt("appointment_id") %></td>
                                                    <td class="py-3">Patient-<%= rs.getInt("patient_id") %></td>
                                                    <td class="py-3">Dentist-<%= rs.getInt("dentist_id") %></td>
                                                    <td class="py-3"><span class="badge bg-primary"><%= rs.getString("appointment_date") %></span></td>
                                                </tr>
                                    <%
                                            }
                                            if (!hasAppointments) {
                                    %>
                                                <tr><td colspan="4" class="text-muted py-4">No appointments scheduled for today.</td></tr>
                                    <%
                                            }
                                            con.close();
                                        } catch (Exception e) {
                                            out.print("<tr><td colspan='4' class='text-danger py-4'>Error loading appointments.</td></tr>");
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const ctx = document.getElementById('paymentChart').getContext('2d');
            const paymentChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ['Paid Bills', 'Pending Bills'],
                    datasets: [{
                        label: 'Invoice Status',
                        data: [<%= summary.getPaidBillsCount() %>, <%= summary.getPendingBillsCount() %>],
                        backgroundColor: [
                            'rgba(25, 135, 84, 0.8)',  // Success Green
                            'rgba(255, 193, 7, 0.8)'   // Warning Yellow
                        ],
                        borderColor: [
                            'rgba(25, 135, 84, 1)',
                            'rgba(255, 193, 7, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>