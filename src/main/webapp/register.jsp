<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - SmileCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        /* CSS to center the card exactly like the login page */
        body {
            background-color: #f0f4f8; /* Soft light blue/grey background */
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }
        .register-card {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            width: 100%;
            max-width: 400px;
        }
    </style>
</head>
<body>

    <div class="register-card">
        <div class="text-center mb-4">
            <h2 class="text-primary fw-bold mb-1">SmileCare</h2>
            <p class="text-muted">Create your new account</p>
        </div>

        <% if(request.getParameter("error") != null) { %>
            <div class="alert alert-danger text-center p-2 mb-3">
                <i class="bi bi-exclamation-circle"></i> Registration failed. Username may already exist.
            </div>
        <% } %>

        <form action="RegisterServlet" method="POST">
            <div class="mb-3">
                <label class="form-label text-muted small">Username</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                    <input type="text" class="form-control bg-light" name="username" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label text-muted small">Email Address</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="bi bi-envelope"></i></span>
                    <input type="email" class="form-control bg-light" name="email" required>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label text-muted small">Password</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="bi bi-lock"></i></span>
                    <input type="password" class="form-control bg-light" name="password" required>
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 fw-bold py-2 mb-3">Register Now</button>

            <div class="text-center text-muted small">
                Already have an account? <a href="login.jsp" class="text-decoration-none">Login here</a>
            </div>
        </form>
    </div>

</body>
</html>