<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.dental.util.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Treatment History Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<jsp:include page="navbar.jsp" />

<div class="container mt-5">

    <div class="row justify-content-center mb-5">
        <div class="col-md-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white text-center">
                    <h5 class="mb-0">Add New Treatment Record</h5>
                </div>
                <div class="card-body">
                    <form action="AddTreatmentServlet" method="POST" onsubmit="return validateForm()">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label text-muted small fw-bold">Patient ID</label>
                                <input type="number" class="form-control" name="patientId" min="1" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label text-muted small fw-bold">Treatment Date</label>
                                <input type="date" class="form-control" id="treatmentDate" name="treatmentDate" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label text-muted small fw-bold">Treatment Type</label>
                                <select class="form-select" name="treatmentType" required>
                                    <option value="" selected disabled>Choose type...</option>
                                    <option value="Cleaning">Teeth Cleaning</option>
                                    <option value="Filling">Cavity Filling</option>
                                    <option value="Extraction">Tooth Extraction</option>
                                    <option value="Root Canal">Root Canal</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label text-muted small fw-bold">Cost (Rs.)</label>
                                <input type="number" step="0.01" class="form-control" name="cost" min="0" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-muted small fw-bold">Doctor's Notes</label>
                            <textarea class="form-control" name="notes" rows="2" maxlength="500"></textarea>
                        </div>
                        <div class="text-end">
                            <button type="submit" class="btn btn-success px-4 shadow-sm">Save Record</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="card shadow-sm border-0 mb-5">
        <div class="card-body p-0">
            <h5 class="p-3 mb-0 bg-white border-bottom">Recent Treatments</h5>
            <div class="table-responsive">
                <table class="table table-hover table-striped mb-0 text-center">
                    <thead class="table-light text-muted small text-uppercase">
                        <tr>
                            <th>ID</th>
                            <th>Patient ID</th>
                            <th>Date</th>
                            <th>Type</th>
                            <th>Cost (Rs.)</th>
                            <th>Notes</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // Establish database connection and retrieve data
                            try {
                                Connection con = DBConnection.getConnection();
                                // Use ORDER BY DESC to display the most recently added records at the top
                                String sql = "SELECT * FROM Treatments ORDER BY treatment_id DESC";
                                Statement st = con.createStatement();
                                ResultSet rs = st.executeQuery(sql);

                                // Iterate through the result set and display each record in a table row
                                while (rs.next()) {
                        %>
                                    <tr>
                                        <td><%= rs.getInt("treatment_id") %></td>
                                        <td><%= rs.getInt("patient_id") %></td>
                                        <td><span class="badge bg-info text-dark"><%= rs.getDate("treatment_date") %></span></td>
                                        <td><%= rs.getString("treatment_type") %></td>
                                        <td><%= rs.getDouble("cost") %></td>
                                        <td><small class="text-muted"><%= rs.getString("notes") %></small></td>
                                        <td>
                                            <div class="btn-group btn-group-sm">
                                                <a href="updateTreatment.jsp?id=<%= rs.getInt("treatment_id") %>" class="btn btn-outline-primary" title="Edit">
                                                    <i class="bi bi-pencil"></i> Edit
                                                </a>
                                                <a href="DeleteTreatmentServlet?id=<%= rs.getInt("treatment_id") %>" class="btn btn-outline-danger" title="Delete" onclick="return confirm('Are you sure you want to delete this record?');">
                                                    <i class="bi bi-trash"></i> Delete
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                        <%
                                } // End of the while loop
                                con.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>

<script>
    // 1. Function to set maximum selectable date as TODAY
    window.onload = function() {
        var today = new Date().toISOString().split('T')[0];
        document.getElementById("treatmentDate").setAttribute('max', today);
    };

    // 2. Comprehensive form validation
    function validateForm() {
        var treatmentDate = document.getElementById("treatmentDate").value;
        var today = new Date().toISOString().split('T')[0];

        // Ensure date is not in the future
        if (treatmentDate > today) {
            alert("Treatment date cannot be in the future)");
            return false;
        }
        return true;
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>