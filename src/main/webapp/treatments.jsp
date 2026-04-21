<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Treatment History Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">🦷 Dental Clinic System</a>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-success text-white text-center">
                    <h4>Add New Treatment Record</h4>
                </div>
                <div class="card-body">
                    <form action="AddTreatmentServlet" method="POST">
                        <div class="mb-3">
                            <label class="form-label">Patient ID</label>
                            <input type="number" class="form-control" name="patientId" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Treatment Date</label>
                            <input type="date" class="form-control" name="treatmentDate" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Treatment Type</label>
                            <select class="form-select" name="treatmentType">
                                <option value="Cleaning">Teeth Cleaning</option>
                                <option value="Filling">Cavity Filling</option>
                                <option value="Extraction">Tooth Extraction</option>
                                <option value="Root Canal">Root Canal</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Cost (Rs.)</label>
                            <input type="number" step="0.01" class="form-control" name="cost" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Doctor's Notes</label>
                            <textarea class="form-control" name="notes" rows="3"></textarea>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Save Record</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>