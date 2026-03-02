<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3">
    <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/index">
        🛍 Product Intro
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#publicNav">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="publicNav">
        <ul class="navbar-nav me-auto">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/index">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/portfolio">Products</a>
            </li>
        </ul>

        <c:choose>
            <c:when test="${not empty sessionScope.loggedInUser}">
                <a href="${pageContext.request.contextPath}/private/dashboard"
                   class="btn btn-outline-light btn-sm me-2">Dashboard</a>
                <a href="${pageContext.request.contextPath}/logout"
                   class="btn btn-outline-danger btn-sm">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login"
                   class="btn btn-outline-light btn-sm">Login</a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
