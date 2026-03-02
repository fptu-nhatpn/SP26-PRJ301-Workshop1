<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>body { background: #f0f2f5; }</style>
</head>
<body>

<%@ include file="/WEB-INF/views/private/header.jsp" %>

<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="mb-0">List of products</h4>
        <a href="${pageContext.request.contextPath}/private/products/update"
           class="btn btn-dark btn-sm">+ Add product</a>
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
                        <th>ID</th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Unit</th>
                        <th>Price</th>
                        <th>Discount</th>
                        <th>Posted Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${products}">
                        <tr>
                            <td>${p.productId}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty p.productImage}">
                                        <img src="${pageContext.request.contextPath}/${p.productImage}"
                                             alt="${p.productName}"
                                             style="width:50px;height:50px;object-fit:cover;border-radius:4px;">
                                    </c:when>
                                    <c:otherwise>—</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${p.productName}</td>
                            <td>${p.type.categoryName}</td>
                            <td>${p.unit}</td>
                            <td><fmt:formatNumber value="${p.price}" type="number"/> VND</td>
                            <td>${p.discount}%</td>
                            <td>${p.postedDate}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/private/products/update?id=${p.productId}"
                                   class="btn btn-primary btn-sm">Update</a>
                                <a href="${pageContext.request.contextPath}/private/products/delete?id=${p.productId}"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Delete this product?')">Delete</a>
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
