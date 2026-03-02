<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${product.productName}</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; }
        .product-image {
            width: 100%;
            max-height: 420px;
            object-fit: cover;
            border-radius: 12px;
        }
        .no-image {
            width: 100%;
            height: 420px;
            background: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
            color: #adb5bd;
            font-size: 6rem;
        }
        .price-box {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            border: 1px solid #dee2e6;
        }
        .original-price {
            text-decoration: line-through;
            color: #adb5bd;
        }
        .final-price {
            font-size: 1.8rem;
            font-weight: 700;
            color: #212529;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/public/publicHeader.jsp" %>

<div class="container mt-4 mb-5">

    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index">Home</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/portfolio">Products</a></li>
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/portfolio?typeId=${product.type.typeId}">
                    ${product.type.categoryName}
                </a>
            </li>
            <li class="breadcrumb-item active">${product.productName}</li>
        </ol>
    </nav>

    <div class="row g-5">

        <!-- Image -->
        <div class="col-md-5">
            <c:choose>
                <c:when test="${not empty product.productImage}">
                    <img src="${pageContext.request.contextPath}${product.productImage}"
                         alt="${product.productName}" class="product-image shadow-sm">
                </c:when>
                <c:otherwise>
                    <div class="no-image shadow-sm">📦</div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Info -->
        <div class="col-md-7">
            <span class="badge bg-secondary mb-2">${product.type.categoryName}</span>
            <h2 class="fw-bold">${product.productName}</h2>
            <p class="text-muted small">Product ID: ${product.productId} &nbsp;|&nbsp; Unit: ${product.unit}</p>
            <p class="text-muted small">Posted: ${product.postedDate} &nbsp;|&nbsp; By: ${product.account.lastName} ${product.account.firstName}</p>

            <p class="mt-3">${product.brief}</p>

            <!-- Price box -->
            <div class="price-box mt-4">
                <c:choose>
                    <c:when test="${product.discount > 0}">
                        <p class="mb-1 original-price">
                            <fmt:formatNumber value="${product.price}" type="number"/> VND
                        </p>
                        <p class="final-price text-danger">
                            <fmt:formatNumber
                                value="${product.price * (100 - product.discount) / 100}"
                                type="number"/> VND
                        </p>
                        <span class="badge bg-danger">-${product.discount}% OFF</span>
                    </c:when>
                    <c:otherwise>
                        <p class="final-price">
                            <fmt:formatNumber value="${product.price}" type="number"/> VND
                        </p>
                    </c:otherwise>
                </c:choose>
            </div>

            <a href="${pageContext.request.contextPath}/portfolio"
               class="btn btn-outline-dark mt-4">← Back to Portfolio</a>
        </div>

    </div>
</div>

<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
