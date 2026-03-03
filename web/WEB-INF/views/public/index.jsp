<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product Introduction</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: #f8f9fa;
            }
            .hero {
                background: linear-gradient(135deg, #343a40 0%, #495057 100%);
                color: white;
                padding: 80px 0;
                text-align: center;
            }
            .hero h1 {
                font-size: 2.8rem;
                font-weight: 700;
            }
            .hero p  {
                font-size: 1.2rem;
                opacity: .85;
            }
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
            .product-card .no-image {
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
        </style>
    </head>
    <body>

        <%@ include file="/WEB-INF/views/public/publicHeader.jsp" %>

        <!-- Hero -->
        <div class="hero">
            <div class="container">
                <h1>Welcome to Product Introduction</h1>
                <p class="mb-4">Discover our wide range of quality products</p>
                <a href="${pageContext.request.contextPath}/portfolio"
                   class="btn btn-light btn-lg px-5">Browse All Products</a>
            </div>
        </div>

        <!-- Featured Products -->
        <div class="container mt-5 mb-5">
            <h4 class="mb-4 fw-semibold">Featured Products</h4>

            <c:choose>
                <c:when test="${empty featuredProducts}">
                    <p class="text-muted">No products available yet.</p>
                </c:when>
                <c:otherwise>
                    <div class="row g-4">
                        <c:forEach var="p" items="${featuredProducts}">
                            <div class="col-sm-6 col-md-4">
                                <div class="card product-card position-relative">

                                    <c:if test="${p.discount > 0}">
                                        <span class="badge bg-danger badge-discount">-${p.discount}%</span>
                                    </c:if>

                                    <c:choose>
                                        <c:when test="${not empty p.productImage}">
                                            <img src="${pageContext.request.contextPath}${p.productImage}"
                                                 alt="${p.productName}" class="card-img-top">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="no-image">📦</div>
                                        </c:otherwise>
                                    </c:choose>

                                    <div class="card-body d-flex flex-column">
                                        <h6 class="card-title fw-semibold">${p.productName}</h6>
                                        <p class="text-muted small mb-1">${p.type.categoryName}</p>
                                        <p class="card-text small text-truncate">${p.brief}</p>
                                        <div class="mt-auto d-flex justify-content-between align-items-center">
                                            <span class="fw-bold text-dark">
                                                <fmt:formatNumber value="${p.price}" type="number"/> VND
                                            </span>
                                            <a href="${pageContext.request.contextPath}/product?id=${p.productId}"
                                               class="btn btn-dark btn-sm">View</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="text-center mt-4 pb-5">
                        <a href="${pageContext.request.contextPath}/portfolio"
                           class="btn btn-outline-dark px-5 py">View All Products →</a>
                    </div>

                    <%-- ── SALE BANNER + DISCOUNTED PRODUCTS ─────────────────────── --%>
                    <c:if test="${not empty onSaleProducts}">

                        <%-- Banner --%>
                        <div style="background: linear-gradient(135deg, #dc3545, #ff6b6b);
                             color: white; padding: 40px 0; text-align: center;">
                            <div class="container">
                                <h2 class="fw-bold mb-1">🔥 Flash Sale</h2>
                                <p class="mb-3" style="opacity:.9">Limited time offers — don't miss out!</p>
                                <a href="${pageContext.request.contextPath}/portfolio"
                                   class="btn btn-light btn-lg px-5 fw-semibold">Shop Now</a>
                            </div>
                        </div>

                        <%-- Discounted products grid --%>
                        <div class="container mt-4 mb-2">
                            <h4 class="mb-4 fw-semibold">🏷 On Sale</h4>
                            <div class="row g-4">
                                <c:forEach var="p" items="${onSaleProducts}">
                                    <div class="col-sm-6 col-md-4 col-lg-3">
                                        <div class="card product-card position-relative">

                                            <span class="badge bg-danger badge-discount">-${p.discount}%</span>

                                            <c:choose>
                                                <c:when test="${not empty p.productImage}">
                                                    <img src="${pageContext.request.contextPath}/${p.productImage}"
                                                         alt="${p.productName}" class="card-img-top"
                                                         style="height:200px;object-fit:cover;">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="no-image">📦</div>
                                                </c:otherwise>
                                            </c:choose>

                                            <div class="card-body d-flex flex-column">
                                                <h6 class="card-title fw-semibold">${p.productName}</h6>
                                                <p class="text-muted small mb-1">${p.type.categoryName}</p>

                                                <%-- Prices --%>
                                                <div class="mt-auto">
                                                    <span class="text-decoration-line-through text-muted small me-1">
                                                        <fmt:formatNumber value="${p.price}" type="number"/> VND
                                                    </span>
                                                    <span class="fw-bold text-danger">
                                                        <fmt:formatNumber
                                                            value="${p.price * (100 - p.discount) / 100}"
                                                            type="number"/> VND
                                                    </span>
                                                </div>

                                                <a href="${pageContext.request.contextPath}/product?id=${p.productId}"
                                                   class="btn btn-danger btn-sm mt-2">View Deal</a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                    </c:if>
                    <%-- ── END SALE SECTION ────────────────────────────────────────── --%>
                </c:otherwise>
            </c:choose>
        </div>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
