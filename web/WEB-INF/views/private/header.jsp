<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3">

    <a class="navbar-brand" href="${pageContext.request.contextPath}/private/dashboard">
        Welcome to
        <c:choose>
            <c:when test="${sessionScope.loggedInUser.roleInSystem == 1}">
                <strong class="text-warning">admin</strong>
            </c:when>
            <c:otherwise>
                <strong class="text-info">staff</strong>
            </c:otherwise>
        </c:choose>
        [${sessionScope.loggedInUser.lastName} ${sessionScope.loggedInUser.firstName}]
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarMain">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarMain">
        <ul class="navbar-nav me-auto">

            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/private/dashboard">Home</a>
            </li>

            <%-- Accounts: admin only --%>
            <c:if test="${sessionScope.loggedInUser.roleInSystem == 1}">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">Accounts</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/private/accounts">List accounts</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/private/accounts/update">Add account</a></li>
                    </ul>
                </li>
            </c:if>

            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">Categories</a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/private/categories">List categories</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/private/categories/update">Add category</a></li>
                </ul>
            </li>

            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">Products</a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/private/products">List products</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/private/products/update">Add product</a></li>
                </ul>
            </li>

        </ul>

        <a class="btn btn-outline-light btn-sm ms-auto"
           href="${pageContext.request.contextPath}/logout">&#x2192; Logout</a>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
