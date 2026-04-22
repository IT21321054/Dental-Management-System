<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.dental.dao.SystemLogDAO" %>
<%@ page import="com.dental.model.SystemLog" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>System Logs - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body class="bg-light">

    <jsp:include page="navbar.jsp" />

    <div class="container mt-5">
        <h2 class="mb-4"><i class="bi bi-shield-lock-fill text-danger"></i> System Activity Logs</h2>

        <div class="card shadow-sm border-danger">
            <div class="card-header bg-danger text-white fw-bold">
                <h5 class="mb-0">Recent User Activities</h5>
            </div>
            <div class="card-body">
                <table class="table table-bordered table-striped text-center">
                    <thead class="table-dark">
                        <tr>
                            <th>Log ID</th>
                            <th>User ID</th>
                            <th>Action Description</th>
                            <th>Date & Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                                                    SystemLogDAO dao = new SystemLogDAO();
                                                    List<SystemLog> logs = dao.getAllLogs();

                                                    if (logs != null && !logs.isEmpty()) {
                                                        for (SystemLog log : logs) {
                                                %>
                                                            <tr>
                                                                <td><%= log.getLogId() %></td>

                                                                <td><span class="badge bg-secondary">User : <%= log.getUserId() %></span></td>

                                                                <td class="text-start fw-bold"><%= log.getActionDescription() %></td>

                                                                <td class="text-muted"><%= (log.getTimestamp() != null) ? log.getTimestamp() : "Unknown Time" %></td>
                                                            </tr>
                                                <%
                                                        }
                                                    } else {
                                                %>
                                                        <tr>
                                                            <td colspan="4" class="text-center text-muted p-4">
                                                                <i class="bi bi-shield-check fs-2 d-block mb-2"></i>
                                                                No system activity logs found.
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>