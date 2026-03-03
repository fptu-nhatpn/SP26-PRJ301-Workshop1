<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Accounts</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <style>body { background: #f0f2f5; }</style>
</head>
<body>

<%@ include file="/WEB-INF/views/private/header.jsp" %>

<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="mb-0">List of accounts in system</h4>
        <a href="${pageContext.request.contextPath}/private/accounts/update"
           class="btn btn-dark btn-sm">+ Add account</a>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show py-2">
            ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card shadow-sm">
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-dark">
                    <tr>
                        <th>Account</th>
                        <th>Full name</th>
                        <th>Birth day</th>
                        <th>Gender</th>
                        <th>Phone</th>
                        <th>Role in system</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="a" items="${accounts}">
                        <tr>
                            <td>${a.account}</td>
                            <td>${a.lastName} ${a.firstName}</td>
                            <td>${a.birthday}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${a.gender}">Male</c:when>
                                    <c:otherwise>Female</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${a.phone}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${a.roleInSystem == 1}">Administrator</c:when>
                                    <c:otherwise>Staff</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/private/accounts/update?id=${a.account}"
                                   class="btn btn-primary btn-sm">Update</a>

                                <c:choose>
                                    <c:when test="${a.isUse}">
                                        <a href="${pageContext.request.contextPath}/private/accounts/toggleStatus?id=${a.account}&status=false"
                                           class="btn btn-secondary btn-sm"
                                           onclick="return confirm('Deactivate this account?')">Deactivate</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/private/accounts/toggleStatus?id=${a.account}&status=true"
                                           class="btn btn-success btn-sm"
                                           onclick="return confirm('Activate this account?')">Active</a>
                                    </c:otherwise>
                                </c:choose>

                                <a href="${pageContext.request.contextPath}/private/accounts/delete?id=${a.account}"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Delete this account permanently?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
