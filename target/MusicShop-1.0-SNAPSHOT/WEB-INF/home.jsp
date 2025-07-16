
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

        <!-- Hero Section -->
        <section class="hero" aria-labelledby="hero-title">
            <div class="container">
                <h1 id="hero-title">Discover Premium Musical Instruments</h1>
                <p class="lead mb-4">Explore a wide range of high-quality guitars, violins, pianos, and more.</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-lg shadow" aria-label="Shop now">Shop Now <i class="fa-solid fa-arrow-right ms-2"></i></a>
            </div>
        </section>

        <!-- About Section -->
        <section class="container py-5" id="about">
            <div class="row align-items-center">
                <div class="col-md-6 mb-4 mb-md-0">
                    <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=600&q=80"
                         alt="Music Shop showcase" class="img-fluid rounded-4 shadow" loading="lazy">
                </div>
                <div class="col-md-6">
                    <h2 class="fw-bold mb-3">About MusicShop</h2>
                    <p>
                        <strong>MusicShop</strong> is your one-stop destination for musical instruments and accessories. From guitars to pianos, we offer premium products with exceptional quality and competitive prices.
                    </p>
                    <p>
                        Our dedicated team provides personalized support to help you find the perfect instrument. Enjoy a seamless shopping experience with nationwide delivery and top-notch customer service.
                    </p>
                    <ul class="list-unstyled">
                        <li><i class="fa-solid fa-check text-primary me-2"></i>Authentic products with clear warranties</li>
                        <li><i class="fa-solid fa-check text-primary me-2"></i>Fast, reliable nationwide delivery</li>
                        <li><i class="fa-solid fa-check text-primary me-2"></i>Expert support and after-sales service</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- Categories Section -->
        <section class="container py-5">
            <h2 class="section-title">Explore Our Categories</h2>
            <div class="row g-4">
                <div class="col-6 col-md-4">
                    <a href="${pageContext.request.contextPath}/guitar?page=1" class="text-decoration-none text-dark" aria-label="View Guitars">
                        <div class="category-card text-center py-4 h-100">
                            <div class="category-icon mb-2"><i class="fa-solid fa-guitar"></i></div>
                            <h5 class="fw-semibold">Guitar</h5>
                        </div>
                    </a>
                </div>
                <div class="col-6 col-md-4">
                    <a href="${pageContext.request.contextPath}/violin?page=1" class="text-decoration-none text-dark" aria-label="View Violins">
                        <div class="category-card text-center py-4 h-100">
                            <div class="category-icon mb-2"><i class="fa-solid fa-violin"></i></div>
                            <h5 class="fw-semibold">Violin</h5>
                        </div>
                    </a>
                </div>
                <div class="col-6 col-md-4">
                    <a href="${pageContext.request.contextPath}/piano?page=1" class="text-decoration-none text-dark" aria-label="View Pianos">
                        <div class="category-card text-center py-4 h-100">
                            <div class="category-icon mb-2"><i class="fa-solid fa-keyboard"></i></div>
                            <h5 class="fw-semibold">Piano & Keyboard</h5>
                        </div>
                    </a>
                </div>
            </div>
        </section>

        <!-- Featured Products: Guitar -->
        <section class="container py-5">
            <h2 class="section-title">Guitars</h2>
            <div id="guitarCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:choose>
                        <c:when test="${not empty guitars}">
                            <c:forEach var="guitar" items="${guitars}" varStatus="status">
                                <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                    <div class="row g-4">
                                        <div class="col-12 col-md-4">
                                            <div class="home-card">
                                                <img src="${guitar.imageUrl}" alt="${guitar.name}" class="home-card-img" loading="lazy">
                                                <h5 class="home-card-title">${guitar.name}</h5>
                                                <p class="home-card-text">${guitar.description}</p>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <span class="home-card-price">${guitar.price}đ</span>
                                                    <div class="d-flex gap-2">
                                                        <a href="#" class="home-card-btn" aria-label="Add ${guitar.name} to cart"><i class="fa-solid fa-cart-plus"></i> Add</a>
                                                        <a href="${pageContext.request.contextPath}/product?id=${guitar.productId}" class="home-card-btn" aria-label="Buy ${guitar.name}"><i class="fa-solid fa-credit-card"></i> Buy</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="carousel-item active">
                                <p class="text-center text-muted w-100 py-5">No guitars available.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#guitarCarousel" data-bs-slide="prev" aria-label="Previous Guitar">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#guitarCarousel" data-bs-slide="next" aria-label="Next Guitar">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                </button>
                <div class="carousel-indicators">
                    <c:forEach var="guitar" items="${guitars}" varStatus="status">
                        <button type="button" data-bs-target="#guitarCarousel" data-bs-slide-to="${status.index}" class="${status.index == 0 ? 'active' : ''}" aria-label="Slide ${status.index + 1}"></button>
                    </c:forEach>
                </div>
            </div>
        </section>

        <!-- Featured Products: Violin -->
        <section class="container py-5">
            <h2 class="section-title">Violins</h2>
            <div id="violinCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:choose>
                        <c:when test="${not empty violins}">
                            <c:forEach var="violin" items="${violins}" varStatus="status">
                                <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                    <div class="row g-4">
                                        <div class="col-12 col-md-4">
                                            <div class="home-card">
                                                <img src="${violin.imageUrl}" alt="${violin.name}" class="home-card-img" loading="lazy">
                                                <h5 class="home-card-title">${violin.name}</h5>
                                                <p class="home-card-text">${violin.description}</p>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <span class="home-card-price">${violin.price}đ</span>
                                                    <div class="d-flex gap-2">
                                                        <a href="#" class="home-card-btn" aria-label="Add ${violin.name} to cart"><i class="fa-solid fa-cart-plus"></i> Add</a>
                                                        <a href="${pageContext.request.contextPath}/product?id=${violin.productId}" class="home-card-btn" aria-label="Buy ${violin.name}"><i class="fa-solid fa-credit-card"></i> Buy</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="carousel-item active">
                                <p class="text-center text-muted w-100 py-5">No violins available.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#violinCarousel" data-bs-slide="prev" aria-label="Previous Violin">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#violinCarousel" data-bs-slide="next" aria-label="Next Violin">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                </button>
                <div class="carousel-indicators">
                    <c:forEach var="violin" items="${violins}" varStatus="status">
                        <button type="button" data-bs-target="#violinCarousel" data-bs-slide-to="${status.index}" class="${status.index == 0 ? 'active' : ''}" aria-label="Slide ${status.index + 1}"></button>
                    </c:forEach>
                </div>
            </div>
        </section>

        <!-- Featured Products: Piano -->
        <section class="container py-5">
            <h2 class="section-title">Pianos</h2>
            <div id="pianoCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:choose>
                        <c:when test="${not empty pianos}">
                            <c:forEach var="piano" items="${pianos}" varStatus="status">
                                <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                    <div class="row g-4">
                                        <div class="col-12 col-md-4">
                                            <div class="home-card">
                                                <img src="${piano.imageUrl}" alt="${piano.name}" class="home-card-img" loading="lazy">
                                                <h5 class="home-card-title">${piano.name}</h5>
                                                <p class="home-card-text">${piano.description}</p>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <span class="home-card-price">${piano.price}đ</span>
                                                    <div class="d-flex gap-2">
                                                        <a href="#" class="home-card-btn" aria-label="Add ${piano.name} to cart"><i class="fa-solid fa-cart-plus"></i> Add</a>
                                                        <a href="${pageContext.request.contextPath}/product?id=${piano.productId}" class="home-card-btn" aria-label="Buy ${piano.name}"><i class="fa-solid fa-credit-card"></i> Buy</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="carousel-item active">
                                <p class="text-center text-muted w-100 py-5">No pianos available.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#pianoCarousel" data-bs-slide="prev" aria-label="Previous Piano">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#pianoCarousel" data-bs-slide="next" aria-label="Next Piano">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                </button>
                <div class="carousel-indicators">
                    <c:forEach var="piano" items="${pianos}" varStatus="status">
                        <button type="button" data-bs-target="#pianoCarousel" data-bs-slide-to="${status.index}" class="${status.index == 0 ? 'active' : ''}" aria-label="Slide ${status.index + 1}"></button>
                    </c:forEach>
                </div>
            </div>
        </section>

        <!-- Toast and Footer -->
        <%@include file="/WEB-INF/include/toast.jsp" %>
        <%@ include file="/WEB-INF/include/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Initialize carousels
            document.addEventListener('DOMContentLoaded', () => {
                const carousels = document.querySelectorAll('.carousel');
                carousels.forEach(carousel => {
                    new bootstrap.Carousel(carousel, {
                        interval: 5000,
                        wrap: true
                    });
                });
            });
        </script>
    </body>
</html>
