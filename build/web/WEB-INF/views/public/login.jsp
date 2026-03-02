<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!-- Bootstrap 5 CDN -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
        }
        .login-card {
            max-width: 420px;
            margin: 100px auto;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        .login-card .card-header {
            background-color: #343a40;
            color: white;
            text-align: center;
            border-radius: 12px 12px 0 0;
            padding: 20px;
            font-size: 1.3rem;
            font-weight: 600;
        }
    </style>
</head>
<body>

<div class="card login-card">
    <div class="card-header">
        Product Introduction System
    </div>
    <div class="card-body p-4">

        <h5 class="mb-4 text-center text-muted">Sign in to your account</h5>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger py-2">${errorMessage}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/login">
            <div class="mb-3">
                <label for="account" class="form-label">Username</label>
                <input type="text" class="form-control" id="account" name="account"
                       placeholder="Enter your username" required autofocus>
            </div>
            <div class="mb-3">
                <label for="pass" class="form-label">Password</label>
                <input type="password" class="form-control" id="pass" name="pass"
                       placeholder="Enter your password" required>
            </div>
            <div class="d-grid mt-4">
                <button type="submit" class="btn btn-dark btn-lg">Login</button>
            </div>
        </form>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
