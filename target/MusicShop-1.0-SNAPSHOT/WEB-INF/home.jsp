
<%-- 
    Document   : home
    Created on : May 17, 2025, 3:46:27 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Music Shop - Trang chủ</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

        <!-- Link Header -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
        <!-- Link Footer -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
        <!-- Link CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.css"/>
    </head>

    <body>
        <!-- Header -->
        <%@ include file="/WEB-INF/include/header.jsp" %>
        <!-- Hero section -->
        <section class="hero">
            <div class="container">
                <h1 class="display-4 fw-bold mb-3">Explore the world of modern musical instruments</h1>
                <p class="lead mb-4">Diverse products, guaranteed quality, best price for all artists.</p>
                <a href="#" class="btn btn-lg shadow">Buy now <i class="fa-solid fa-arrow-right"></i></a>
            </div>
        </section>

        <!-- About section -->
        <section class="container py-5" id="about">
            <div class="row align-items-center">
                <div class="col-md-6 mb-4 mb-md-0">
                    <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=600&q=80"
                         alt="Music Shop" class="img-fluid rounded-4 shadow">
                </div>
                <div class="col-md-6">
                    <h2 class="fw-bold mb-3">About MusicShop</h2>
                    <p>
                        <strong>MusicShop</strong> is a trusted address for all artists and music lovers. We provide a variety of musical instruments such as guitars, pianos, drums, microphones and accessories with guaranteed quality and competitive prices.
                    </p>
                    <p>
                        Our team of enthusiastic and experienced consultants are always ready to help you choose the most suitable product. MusicShop is committed to providing a modern, safe and convenient online shopping experience.
                    </p>
                    <ul class="list-unstyled">
                        <li><i class="fa-solid fa-check text-primary me-2"></i>Genuine products, clear warranty</li>
                        <li><i class="fa-solid fa-check text-primary me-2"></i>Nationwide delivery, flexible payment
                        </li>
                        <li><i class="fa-solid fa-check text-primary me-2"></i>Dedicated technical & after-sales support</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- Categories -->
        <section class="container py-5">
            <h2 class="text-center fw-bold mb-4">Featured Categories</h2>
            <div class="row g-4">
                <div class="col-6 col-md-3">
                    <a href="${pageContext.request.contextPath}/guitar?page=1" class="text-decoration-none text-dark">
                        <div class="card text-center py-4 h-100">
                            <div class="category-icon mb-2"><i class="fa-solid fa-guitar"></i></div>
                            <h5 class="fw-semibold">Guitar</h5>
                        </div>
                    </a>
                </div>
                <div class="col-6 col-md-3">
                    <a href="${pageContext.request.contextPath}/path?page=violin" class="text-decoration-none text-dark">
                        <div class="card text-center py-4">
                            <div class="category-icon mb-2"><i class="fa-solid fa-violin"></i></div>
                            <h5 class="fw-semibold">Violin</h5>
                        </div>
                    </a>
                </div>
                <div class="col-6 col-md-3">
                    <a href="${pageContext.request.contextPath}/path?page=piano" class="text-decoration-none text-dark">
                        <div class="card text-center py-4">
                            <div class="category-icon mb-2"><i class="fa-solid fa-keyboard"></i></div>
                            <h5 class="fw-semibold">Piano & Keyboard</h5>
                        </div>
                    </a>
                </div>
            </div>
        </section>

        <!-- Featured products (CSS thuần card) -->
        <section class="container">
            <h1 class="text-center fw-bold mb-4">Guitar</h1>
            <div class="home-card-row">
                <c:choose>
                    <c:when test="${not empty guitars}">
                        <c:forEach var="guitar" items="${guitars}">
                            <div class="home-col">
                                <div class="product-card">
                                    <img src="${guitar.imageUrl}" alt="${guitar.name}" class="product-img">
                                    <div class="product-body">
                                        <h5 class="product-title">${guitar.name}</h5>
                                        <p class="product-desc">${guitar.description}</p>
                                        <div class="product-footer">
                                            <span class="product-price">${guitar.price}đ</span>
                                            <a href="#" class="product-btn"><i class="fa-solid fa-cart-plus"></i> Add</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="text-center text-muted w-100">No data yet.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <section class="container">
            <h1 class="text-center fw-bold mb-4">Violin</h1>
            <div class="home-card-row">
                <c:choose>
                    <c:when test="${not empty violins}">
                        <c:forEach var="violin" items="${violins}">
                            <div class="home-col">
                                <div class="product-card">
                                    <img src="${violin.imageUrl}" alt="${violin.name}" class="product-img">
                                    <div class="product-body">
                                        <h5 class="product-title">${violin.name}</h5>
                                        <p class="product-desc">${violin.description}</p>
                                        <div class="product-footer">
                                            <span class="product-price">${violin.price}đ</span>
                                            <a href="#" class="product-btn"><i class="fa-solid fa-cart-plus"></i> Add</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="text-center text-muted w-100">Chưa có dữ liệu.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <section class="container">
            <h1 class="text-center fw-bold mb-4">Piano</h1>
            <div class="home-card-row">
                <c:choose>
                    <c:when test="${not empty pianos}">
                        <c:forEach var="piano" items="${pianos}">
                            <div class="home-col">
                                <div class="product-card">
                                    <img src="${piano.imageUrl}" alt="${piano.name}" class="product-img">
                                    <div class="product-body">
                                        <h5 class="product-title">${piano.name}</h5>
                                        <p class="product-desc">${piano.description}</p>
                                        <div class="product-footer d-flex justify-content-between align-items-center">
                                            <span class="product-price">${piano.price}đ</span>
                                            <div class="d-flex gap-2">
                                                <a href="#" class="product-btn"><i class="fa-solid fa-cart-plus"></i> Add</a>
                                                <a href="${pageContext.request.contextPath}/product?id=${piano.productId}" class="product-btn"><i class="fa-solid fa-credit-card"></i> Buy</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="text-center text-muted w-100">No data yet.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
        <!-- Footer -->
        <%@ include file="/WEB-INF/include/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
