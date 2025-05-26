<%-- 
    Document   : guitar
    Created on : May 21, 2025, 12:20:11 AM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Guitar Shop</title>
        <!-- Link bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

        <!-- Link Header -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.header.css">
        <!-- Link Footer -->
         
        <!-- Link CSS -->
        <link rel="stylesheet" href="assets/css/guitar.product.css"/>
    </head>

    <body>
        <!-- Header -->
        <%@ include file="/WEB-INF/include/header.jsp" %>
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="logo"><i class="fa-solid fa-guitar"></i> Guitar Shop</div>
            <form>
                <h3 style="font-size:1.1rem; color:#6d28d9; font-weight:700; margin-bottom:18px;">
                    <i class="fa-solid fa-filter"></i> Lọc sản phẩm
                </h3>
                <!-- Danh mục loại đàn (checkbox) -->
                <div style="margin-bottom:18px;">
                    <div style="font-weight:600; margin-bottom:8px;">Loại đàn</div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="acoustic">
                        <label class="form-check-label" for="acoustic">Acoustic</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="classic">
                        <label class="form-check-label" for="classic">Classic</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="electric">
                        <label class="form-check-label" for="electric">Điện</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="bass">
                        <label class="form-check-label" for="bass">Bass</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="ukulele">
                        <label class="form-check-label" for="ukulele">Ukulele</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="twelve-string">
                        <label class="form-check-label" for="twelve-string">12 dây</label>
                    </div>
                </div>
                <!-- Khoảng giá (nhiều lựa chọn hơn) -->
                <div style="margin-bottom:18px;">
                    <div style="font-weight:600; margin-bottom:8px;">Khoảng giá</div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="price" id="price0">
                        <label class="form-check-label" for="price0">Tất cả</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="price" id="price1">
                        <label class="form-check-label" for="price1">Dưới 2 triệu</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="price" id="price2">
                        <label class="form-check-label" for="price2">2 - 5 triệu</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="price" id="price3">
                        <label class="form-check-label" for="price3">5 - 10 triệu</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="price" id="price4">
                        <label class="form-check-label" for="price4">10 - 20 triệu</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="price" id="price5">
                        <label class="form-check-label" for="price5">20 - 50 triệu</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="price" id="price6">
                        <label class="form-check-label" for="price6">Trên 50 triệu</label>
                    </div>
                </div>
                <!-- Sale & Bán chạy -->
                <div style="margin-bottom:18px;">
                    <div style="font-weight:600; margin-bottom:8px;">Khác</div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="sale">
                        <label class="form-check-label" for="sale">Đang giảm giá</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="banchay">
                        <label class="form-check-label" for="banchay">Bán chạy</label>
                    </div>
                </div>
                <button type="submit" class="product-button" style="margin-top:10px;">
                    <i class="fa-solid fa-filter"></i> Áp dụng
                </button>
            </form>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="banner">
                <h1>Khám phá thế giới Guitar</h1>
            </div>

            <div class="search-bar">
                <input type="text" class="search-input" placeholder="Tìm kiếm sản phẩm...">
                <button class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
            </div>

            <h2 class="products-title">Guitar đề xuất</h2>
            <div class="products-row">
                <c:choose>
                    <c:when test="${not empty guitars}">
                        <c:forEach var="guitar" items="${guitars}">
                            <div class="product-card">
                                <div class="product-image">
                                    <img src="${guitar.imageUrl}" alt="${guitar.name}">

                                </div>
                                <div class="product-info">
                                    <div class="product-name">${guitar.name}</div>
                                    <div class="product-price">${guitar.price} ₫</div>
                                    <div class="product-actions">
                                        <button class="product-button buy"><i class="fa-solid fa-bolt"></i> Mua ngay</button>
                                        <button class="product-button cart"><i class="fa-solid fa-cart-plus"></i></button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted text-center w-100">Chưa có sản phẩm đề xuất.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>