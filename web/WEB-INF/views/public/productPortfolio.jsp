<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product Portfolio</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; }
        .product-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            transition: transform .2s, box-shadow .2s;
            height: 100%;
        }
        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.12);
        }
        .product-card img {
            height: 200px;
            object-fit: cover;
            border-radius: 12px 12px 0 0;
        }
        .no-image {
            height: 200px;
            background: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px 12px 0 0;
            color: #adb5bd;
            font-size: 3rem;
        }
        .badge-discount {
            position: absolute;
            top: 12px;
            right: 12px;
        }
        .filter-btn { border-radius: 20px; margin: 4px; }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/public/publicHeader.jsp" %>

<div class="container mt-4 mb-5">

    <h4 class="mb-3 fw-semibold">Product Portfolio</h4>

    <!-- Category filter buttons -->
    <div class="mb-4">
        <a href="${pageContext.request.contextPath}/portfolio"
           class="btn ${empty selectedTypeId ? 'btn-dark' : 'btn-outline-dark'} filter-btn">
            All
        </a>
        <c:forEach var="cat" items="${categories}">
            <a href="${pageContext.request.contextPath}/portfolio?typeId=${cat.typeId}"
               class="btn ${selectedTypeId == cat.typeId ? 'btn-dark' : 'btn-outline-dark'} filter-btn">
                ${cat.categoryName}
            </a>
        </c:forEach>
    </div>

    <!-- Product grid -->
    <c:choose>
        <c:when test="${empty products}">
            <div class="text-center text-muted py-5">
                <p style="font-size:3rem">📦</p>
                <p>No products found in this category.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <c:forEach var="p" items="${products}">
                    <div class="col-sm-6 col-md-4 col-lg-3">
                        <div class="card product-card position-relative">

                            <c:if test="${p.discount > 0}">
                                <span class="badge bg-danger badge-discount">-${p.discount}%</span>
                            </c:if>

                            <c:choose>
                                <c:when test="${not empty p.productImage}">
                                    <img src="${pageContext.request.contextPath}${p.productImage}"
                                         alt="${p.productName}">
                                </c:when>
                                <c:otherwise>
                                    <div class="no-image">📦</div>
                                </c:otherwise>
                            </c:choose>

                            <div class="card-body d-flex flex-column">
                                <h6 class="card-title fw-semibold">${p.productName}</h6>
                                <p class="text-muted small mb-1">${p.type.categoryName}</p>
                                <p class="card-text small text-truncate flex-grow-1">${p.brief}</p>
                                <div class="mt-2 d-flex justify-content-between align-items-center">
                                    <span class="fw-bold">
                                        <fmt:formatNumber value="${p.price}" type="number"/> VND
                                    </span>
                                    <a href="${pageContext.request.contextPath}/product?id=${p.productId}"
                                       class="btn btn-dark btn-sm">Detail</a>
                                </div>
                            </div>

                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
