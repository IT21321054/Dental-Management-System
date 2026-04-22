<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dental Management System - Home</title>
</head>
<body class="bg-light">

    <jsp:include page="navbar.jsp" />

    <div class="container mt-5">
        <div class="row align-items-center">

            <div class="col-md-6 text-center text-md-start">
                <h1 class="display-4 fw-bold text-primary">Welcome to SmileCare</h1>
                <p class="lead text-secondary mt-3">
                    A complete management solution for modern dental clinics.
                    Manage patients, appointments, and treatment histories effortlessly.
                </p>
                <a href="appointments.jsp" class="btn btn-primary btn-lg mt-3 shadow-sm">Book Appointment</a>
                <a href="patients.jsp" class="btn btn-outline-secondary btn-lg mt-3 ms-2 shadow-sm">Patient Portal</a>
            </div>

            <div class="col-md-6 mt-4 mt-md-0 text-center">
                <img src="https://images.unsplash.com/photo-1606811841689-23dfddce3e95?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Dental Clinic" class="img-fluid rounded shadow">
            </div>
        </div>
    </div>

    <footer class="text-center text-muted mt-5 py-4 border-top">
        <p>&copy; 2026 Dental Management System. All Rights Reserved.</p>
    </footer>

</body>
</html>