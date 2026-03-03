<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Category Form</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <style>body { background: #f0f2f5; }</style>
</head>
<body>

<%@ include file="/WEB-INF/views/private/header.jsp" %>

<div class="container mt-4" style="max-width: 600px;">

    <h4 class="mb-4">
        <c:choose>
            <c:when test="${not empty category}">Update category</c:when>
            <c:otherwise>New category</c:otherwise>
        </c:choose>
    </h4>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger py-2">${errorMessage}</div>
    </c:if>

    <div class="card shadow-sm">
        <div class="card-body p-4">
            <form method="post"
                  action="${pageContext.request.contextPath}/private/categories/update">

                <c:if test="${not empty category}">
                    <input type="hidden" name="typeId" value="${category.typeId}">
                </c:if>

                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">Category name:</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" name="categoryName"
                               value="${category.categoryName}"
                               placeholder="Category name" required>
                    </div>
                </div>

                <div class="row mb-4 align-items-start">
                    <label class="col-sm-4 col-form-label fw-semibold">Memo:</label>
                    <div class="col-sm-8">
                        <textarea class="form-control" name="memo" rows="3"
                                  placeholder="Description / notes">${category.memo}</textarea>
                    </div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-dark">Save</button>
                    <a href="${pageContext.request.contextPath}/private/categories"
                       class="btn btn-outline-secondary">Cancel</a>
                </div>

            </form>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
