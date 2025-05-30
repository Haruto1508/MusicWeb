<%-- 
    Document   : accessory
    Created on : May 24, 2025, 10:54:24 AM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Phụ kiện nhạc cụ</title>
        <!-- Link Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <!-- Link Header -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.header.css">
        <!-- Link Footer -->
        <!-- Link CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/accessory.product.css">
    </head>
    <body>
        <!-- Header -->
        <%@ include file="/WEB-INF/include/header.jsp" %>
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="logo">
                <i class="fa-solid fa-guitar"></i> Phụ kiện
            </div>
            <form>
                <h3 style="font-size:1.1rem; color:#6d28d9; font-weight:700; margin-bottom:18px;">
                    <i class="fa-solid fa-filter"></i> Lọc sản phẩm
                </h3>
                <!-- Loại nhạc cụ -->
                <div style="margin-bottom:18px;">
                    <div style="font-weight:600; margin-bottom:8px;">Loại nhạc cụ</div>
                    <div class="form-check">
                        <input type="checkbox" id="guitar">
                        <label for="guitar">Guitar</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" id="piano">
                        <label for="piano">Piano</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" id="violin">
                        <label for="violin">Violin</label>
                    </div>
                </div>
                <!-- Loại phụ kiện -->
                <div style="margin-bottom:18px;">
                    <div style="font-weight:600; margin-bottom:8px;">Loại phụ kiện</div>
                    <div class="form-check">
                        <input type="checkbox" id="strings">
                        <label for="strings">Dây đàn</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" id="capo">
                        <label for="capo">Capo</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" id="picks">
                        <label for="picks">Pick / Móng gảy</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" id="cases">
                        <label for="cases">Bao đàn / Case</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" id="stands">
                        <label for="stands">Chân đế / Stand</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" id="tuners">
                        <label for="tuners">Máy lên dây</label>
                    </div>
                </div>
                <!-- Giá -->
                <div style="margin-bottom:18px;">
                    <div style="font-weight:600; margin-bottom:8px;">Giá</div>
                    <div class="form-check">
                        <input type="radio" name="price" id="price1">
                        <label for="price1">Dưới 100k</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" name="price" id="price2">
                        <label for="price2">100k - 500k</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" name="price" id="price3">
                        <label for="price3">500k - 1 triệu</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" name="price" id="price4">
                        <label for="price4">Trên 1 triệu</label>
                    </div>
                </div>
                <button class="btn btn-primary" style="width:100%">
                    <i class="fa-solid fa-filter"></i> Áp dụng
                </button>
            </form>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Category Tabs -->
            <div class="category-tabs">
                <div class="category-tab active">Tất cả phụ kiện</div>
                <div class="category-tab">Phụ kiện Guitar</div>
                <div class="category-tab">Phụ kiện Piano</div>
                <div class="category-tab">Phụ kiện Violin</div>
            </div>

            <!-- Products Grid -->
            <div class="products-row">
                <!-- Guitar Strings -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://example.com/guitar-strings.jpg" alt="Dây đàn Guitar">
                    </div>
                    <div class="product-info">
                        <div class="product-type">Phụ kiện Guitar</div>
                        <div class="product-name">Dây đàn Guitar Alice A206</div>
                        <div class="product-price">120.000 ₫</div>
                        <div class="product-actions">
                            <button class="btn btn-primary">Mua ngay</button>
                            <button class="btn btn-cart">
                                <i class="fa-solid fa-cart-plus"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Piano Cover -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://example.com/piano-cover.jpg" alt="Bao phủ Piano">
                    </div>
                    <div class="product-info">
                        <div class="product-type">Phụ kiện Piano</div>
                        <div class="product-name">Bao phủ Piano điện Roland</div>
                        <div class="product-price">450.000 ₫</div>
                        <div class="product-actions">
                            <button class="btn btn-primary">Mua ngay</button>
                            <button class="btn btn-cart">
                                <i class="fa-solid fa-cart-plus"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Violin Strings -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://example.com/violin-strings.jpg" alt="Dây Violin">
                    </div>
                    <div class="product-info">
                        <div class="product-type">Phụ kiện Violin</div>
                        <div class="product-name">Dây Violin Dominant</div>
                        <div class="product-price">680.000 ₫</div>
                        <div class="product-actions">
                            <button class="btn btn-primary">Mua ngay</button>
                            <button class="btn btn-cart">
                                <i class="fa-solid fa-cart-plus"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <!-- Violin Strings -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://example.com/violin-strings.jpg" alt="Dây Violin">
                    </div>
                    <div class="product-info">
                        <div class="product-type">Phụ kiện Violin</div>
                        <div class="product-name">Dây Violin Dominant</div>
                        <div class="product-price">680.000 ₫</div>
                        <div class="product-actions">
                            <button class="btn btn-primary">Mua ngay</button>
                            <button class="btn btn-cart">
                                <i class="fa-solid fa-cart-plus"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <!-- Violin Strings -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://example.com/violin-strings.jpg" alt="Dây Violin">
                    </div>
                    <div class="product-info">
                        <div class="product-type">Phụ kiện Violin</div>
                        <div class="product-name">Dây Violin Dominant</div>
                        <div class="product-price">680.000 ₫</div>
                        <div class="product-actions">
                            <button class="btn btn-primary">Mua ngay</button>
                            <button class="btn btn-cart">
                                <i class="fa-solid fa-cart-plus"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <!-- Violin Strings -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://example.com/violin-strings.jpg" alt="Dây Violin">
                    </div>
                    <div class="product-info">
                        <div class="product-type">Phụ kiện Violin</div>
                        <div class="product-name">Dây Violin Dominant</div>
                        <div class="product-price">680.000 ₫</div>
                        <div class="product-actions">
                            <button class="btn btn-primary">Mua ngay</button>
                            <button class="btn btn-cart">
                                <i class="fa-solid fa-cart-plus"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <!-- Violin Strings -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://example.com/violin-strings.jpg" alt="Dây Violin">
                    </div>
                    <div class="product-info">
                        <div class="product-type">Phụ kiện Violin</div>
                        <div class="product-name">Dây Violin Dominant</div>
                        <div class="product-price">680.000 ₫</div>
                        <div class="product-actions">
                            <button class="btn btn-primary">Mua ngay</button>
                            <button class="btn btn-cart">
                                <i class="fa-solid fa-cart-plus"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Thêm các sản phẩm khác tại đây -->
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>