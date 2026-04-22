<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Dental Clinic System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f0f4f8; /* Soft blue background */
        }
        .login-card {
            width: 100%;
            max-width: 400px;
            border-radius: 15px;
        }
    </style>
</head>
<body>

    <div class="card shadow-lg login-card border-0">
        <div class="card-body p-5">
            <div class="text-center mb-4">
                <h2 class="text-primary fw-bold"><i class="bi bi-tooth"></i> SmileCare</h2>
                <p class="text-muted">Sign in to your account</p>
            </div>

            <form action="LoginServlet" method="POST">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                        <input type="text" class="form-control" id="username" name="username" placeholder="Enter username" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                        <input type="password" class="form-control" name="password" id="password" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100 fw-bold mb-3">
                    Login
                </button>

                <div class="text-center">
                    <small>Don't have an account? <a href="register.jsp" class="text-decoration-none">Register here</a></small>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>