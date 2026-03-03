<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f0f2f5; }
        .stat-card { border-radius: 12px; color: white; padding: 32px 24px; text-align: center; }
        .stat-card h2 { font-size: 3rem; font-weight: 700; margin: 0; }
        .stat-card p  { margin: 8px 0 0; font-size: 1rem; opacity: .85; }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/private/header.jsp" %>

<div class="container mt-5">
    <h4 class="mb-4">Dashboard</h4>
    <div class="row g-4">
        <div class="col-md-4">
            <div class="stat-card bg-primary shadow-sm">
                <h2>${totalAccounts}</h2>
                <p>Total Accounts</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card bg-success shadow-sm">
                <h2>${totalCategories}</h2>
                <p>Total Categories</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card bg-warning shadow-sm">
                <h2>${totalProducts}</h2>
                <p>Total Products</p>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
