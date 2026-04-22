<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.dental.util.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Treatment Record</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<jsp:include page="navbar.jsp" />

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-warning text-dark text-center">
                    <h5 class="mb-0">Update Treatment Record</h5>
                </div>
                <div class="card-body">
                    <%
                        // Retrieve the treatment ID passed in the URL
                        String idParam = request.getParameter("id");
                        if (idParam != null && !idParam.isEmpty()) {
                            try {
                                int treatmentId = Integer.parseInt(idParam);
                                Connection con = DBConnection.getConnection();

                                // Fetch the existing data for this specific treatment
                                String sql = "SELECT * FROM Treatments WHERE treatment_id = ?";
                                PreparedStatement ps = con.prepareStatement(sql);
                                ps.setInt(1, treatmentId);
                                ResultSet rs = ps.executeQuery();

                                if (rs.next()) {
                    %>
                                    <form action="UpdateTreatmentServlet" method="POST">

                                        <input type="hidden" name="treatmentId" value="<%= rs.getInt("treatment_id") %>">

                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label text-muted small fw-bold">Patient ID</label>
                                                <input type="number" class="form-control" name="patientId" value="<%= rs.getInt("patient_id") %>" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label text-muted small fw-bold">Treatment Date</label>
                                                <input type="date" class="form-control" name="treatmentDate" value="<%= rs.getDate("treatment_date") %>" required>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label text-muted small fw-bold">Treatment Type</label>
                                                <select class="form-select" name="treatmentType">
                                                    <% String currentType = rs.getString("treatment_type"); %>
                                                    <option value="Cleaning" <%= "Cleaning".equals(currentType) ? "selected" : "" %>>Teeth Cleaning</option>
                                                    <option value="Filling" <%= "Filling".equals(currentType) ? "selected" : "" %>>Cavity Filling</option>
                                                    <option value="Extraction" <%= "Extraction".equals(currentType) ? "selected" : "" %>>Tooth Extraction</option>
                                                    <option value="Root Canal" <%= "Root Canal".equals(currentType) ? "selected" : "" %>>Root Canal</option>
                                                </select>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label text-muted small fw-bold">Cost (Rs.)</label>
                                                <input type="number" step="0.01" class="form-control" name="cost" value="<%= rs.getDouble("cost") %>" required>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label text-muted small fw-bold">Doctor's Notes</label>
                                            <textarea class="form-control" name="notes" rows="2"><%= rs.getString("notes") != null ? rs.getString("notes") : "" %></textarea>
                                        </div>
                                        <div class="text-end mt-4">
                                            <a href="treatments.jsp" class="btn btn-secondary px-4 me-2">Cancel</a>
                                            <button type="submit" class="btn btn-warning px-4 shadow-sm">Update Record</button>
                                        </div>
                                    </form>
                    <%
                                }
                                con.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                                out.println("<div class='alert alert-danger'>Error loading record data.</div>");
                            }
                        } else {
                            out.println("<div class='alert alert-warning'>Invalid Treatment ID.</div>");
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>