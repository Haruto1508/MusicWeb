
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
                <h1 class="display-4 fw-bold mb-3">Khám phá thế giới nhạc cụ hiện đại</h1>
                <p class="lead mb-4">Đa dạng sản phẩm, chất lượng đảm bảo, giá tốt nhất cho mọi nghệ sĩ.</p>
                <a href="#" class="btn btn-lg shadow">Mua ngay <i class="fa-solid fa-arrow-right"></i></a>
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
                        <strong>MusicShop</strong> là địa chỉ tin cậy dành cho mọi nghệ sĩ và người yêu âm nhạc. Chúng tôi
                        cung cấp đa dạng các loại nhạc cụ như guitar, piano, trống, micro và phụ kiện với chất lượng đảm
                        bảo, giá cả cạnh tranh.
                    </p>
                    <p>
                        Đội ngũ tư vấn viên nhiệt tình, giàu kinh nghiệm luôn sẵn sàng hỗ trợ bạn lựa chọn sản phẩm phù hợp
                        nhất. MusicShop cam kết mang đến trải nghiệm mua sắm trực tuyến hiện đại, an toàn và tiện lợi.
                    </p>
                    <ul class="list-unstyled">
                        <li><i class="fa-solid fa-check text-primary me-2"></i>Sản phẩm chính hãng, bảo hành rõ ràng</li>
                        <li><i class="fa-solid fa-check text-primary me-2"></i>Giao hàng toàn quốc, thanh toán linh hoạt
                        </li>
                        <li><i class="fa-solid fa-check text-primary me-2"></i>Hỗ trợ kỹ thuật & hậu mãi tận tâm</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- Categories -->
        <section class="container py-5">
            <h2 class="text-center fw-bold mb-4">Danh mục nổi bật</h2>
            <div class="row g-4">
                <div class="col-6 col-md-3">
                    <a href="${pageContext.request.contextPath}/path?page=guitar" class="text-decoration-none text-dark">
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
                <div class="col-6 col-md-3">
                    <a href="${pageContext.request.contextPath}/path?page=accessory" class="text-decoration-none text-dark">
                        <div class="card text-center py-4">
                            <div class="category-icon mb-2"><i class="fa-solid fa-microphone"></i></div>
                            <h5 class="fw-semibold">Micro & Phụ kiện</h5>
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
                                            <a href="#" class="product-btn"><i class="fa-solid fa-cart-plus"></i> Thêm</a>
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
                                            <a href="#" class="product-btn"><i class="fa-solid fa-cart-plus"></i> Thêm</a>
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
                                                <a href="#" class="product-btn"><i class="fa-solid fa-cart-plus"></i> Thêm</a>
                                                <a href="${pageContext.request.contextPath}/product?id=${piano.productId}" class="product-btn"><i class="fa-solid fa-credit-card"></i> Mua</a>
                                            </div>
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
        <!-- Footer -->
        <%@ include file="/WEB-INF/include/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
