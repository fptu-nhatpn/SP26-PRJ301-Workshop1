<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>body { background: #f0f2f5; }</style>
</head>
<body>

<%@ include file="/WEB-INF/views/private/header.jsp" %>

<div class="container mt-4" style="max-width: 750px;">

    <h4 class="mb-4">
        <c:choose>
            <c:when test="${not empty product}">Update product</c:when>
            <c:otherwise>Add new product</c:otherwise>
        </c:choose>
    </h4>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger py-2">${errorMessage}</div>
    </c:if>

    <div class="card shadow-sm">
        <div class="card-body p-4">
            <form method="post"
                  action="${pageContext.request.contextPath}/private/products/update"
                  enctype="multipart/form-data">

                <c:if test="${not empty product}">
                    <input type="hidden" name="originalProductId" value="${product.productId}">
                </c:if>

                <!-- Product ID -->
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">Product ID</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" name="productId"
                               value="${product.productId}"
                               placeholder="Product ID"
                               ${not empty product ? 'readonly' : ''}
                               required>
                    </div>
                </div>

                <!-- Product Name -->
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">Product name</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" name="productName"
                               value="${product.productName}"
                               placeholder="Product name" required>
                    </div>
                </div>

                <!-- Image -->
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">Product image</label>
                    <div class="col-sm-8">
                        <input type="file" class="form-control" name="productImageFile"
                               accept="image/*">
                        <c:if test="${not empty product.productImage}">
                            <small class="text-muted mt-1 d-block">
                                Current: ${product.productImage} (leave blank to keep)
                            </small>
                        </c:if>
                    </div>
                </div>

                <!-- Brief -->
                <div class="row mb-3 align-items-start">
                    <label class="col-sm-4 col-form-label fw-semibold">Brief</label>
                    <div class="col-sm-8">
                        <textarea class="form-control" name="brief" rows="3"
                                  placeholder="Short description">${product.brief}</textarea>
                    </div>
                </div>

                <!-- Posted Date -->
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">Posted date</label>
                    <div class="col-sm-8">
                        <input type="date" class="form-control" name="postedDate"
                               value="${product.postedDate}" required>
                    </div>
                </div>

                <!-- Category -->
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">Category</label>
                    <div class="col-sm-8">
                        <select class="form-select" name="typeId" required>
                            <option value="">-- Select category --</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.typeId}"
                                    ${product.type.typeId == cat.typeId ? 'selected' : ''}>
                                    ${cat.categoryName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <!-- Posted by (Account) -->
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">Posted by</label>
                    <div class="col-sm-8">
                        <select class="form-select" name="accountId" required>
                            <option value="">-- Select account --</option>
                            <c:forEach var="acc" items="${accounts}">
                                <option value="${acc.account}"
                                    ${product.account.account == acc.account ? 'selected' : ''}>
                                    ${acc.lastName} ${acc.firstName} (${acc.account})
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <!-- Unit -->
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">Unit</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" name="unit"
                               value="${product.unit}"
                               placeholder="e.g. pcs, kg, box" required>
                    </div>
                </div>

                <!-- Price -->
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">Price (VND)</label>
                    <div class="col-sm-8">
                        <input type="number" class="form-control" name="price"
                               value="${product.price}"
                               min="0" placeholder="Price" required>
                    </div>
                </div>

                <!-- Discount -->
                <div class="row mb-4 align-items-center">
                    <label class="col-sm-4 col-form-label fw-semibold">Discount (%)</label>
                    <div class="col-sm-8">
                        <input type="number" class="form-control" name="discount"
                               value="${not empty product ? product.discount : 0}"
                               min="0" max="100">
                    </div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-dark">Save</button>
                    <a href="${pageContext.request.contextPath}/private/products"
                       class="btn btn-outline-secondary">Cancel</a>
                </div>

            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
