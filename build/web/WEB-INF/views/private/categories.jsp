<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Categories</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>body { background: #f0f2f5; }</style>
</head>
<body>

<%@ include file="/WEB-INF/views/private/header.jsp" %>

<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="mb-0">List of categories</h4>
        <a href="${pageContext.request.contextPath}/private/categories/update"
           class="btn btn-dark btn-sm">+ Add category</a>
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
                        <th>Type ID</th>
                        <th>Category name</th>
                        <th>Memo</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${categories}">
                        <tr>
                            <td>${c.typeId}</td>
                            <td>${c.categoryName}</td>
                            <td>${c.memo}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/private/categories/update?id=${c.typeId}"
                                   class="btn btn-primary btn-sm">Update</a>
                                <a href="${pageContext.request.contextPath}/private/categories/delete?id=${c.typeId}"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Delete this category?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
