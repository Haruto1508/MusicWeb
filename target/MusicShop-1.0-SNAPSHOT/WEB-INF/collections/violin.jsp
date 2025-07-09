<%-- 
    Document   : violin
    Created on : May 23, 2025, 1:18:31 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Violin Shop</title>
        <!-- Link Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <!-- Link Header -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
        <!-- Link Footer -->
        <!-- Link CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/violin.product.css">
    </head>
    <body>
        <!-- Header -->
        <%@ include file="/WEB-INF/include/header.jsp" %>
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="logo"><i class="fa-solid fa-violin"></i> Violin Shop</div>
            <form>
                <h3 style="font-size:1.1rem; color:#6d28d9; font-weight:700; margin-bottom:18px;">
                    <i class="fa-solid fa-filter"></i> Filter products
                </h3>
                <!-- Danh mục loại violin -->
                <div style="margin-bottom:18px;">
                    <div style="font-weight:600; margin-bottom:8px;">Violin type</div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="fullsize">
                        <label class="form-check-label" for="fullsize">4/4 (Full size)</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="threequarter">
                        <label class="form-check-label" for="threequarter">3/4</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="halvesize">
                        <label class="form-check-label" for="halvesize">1/2</label>
                    </div>

                </div>
                <!-- Khoảng giá -->
                <div style="margin-bottom:18px;">
                    <div style="font-weight:600; margin-bottom:8px;">Price range</div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="price" id="price0">
                        <label class="form-check-label" for="price0">All</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="price" id="price1">
                        <label class="form-check-label" for="price1">Under 2 million</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="price" id="price2">
                        <label class="form-check-label" for="price2">2 - 5 million</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="price" id="price3">
                        <label class="form-check-label" for="price3">5 - 10 million</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="price" id="price4">
                        <label class="form-check-label" for="price4">Over 10 million</label>
                    </div>
                </div>
                <!-- Khác -->
                <div style="margin-bottom:18px;">
                    <div style="font-weight:600; margin-bottom:8px;">Other</div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="sale">
                        <label class="form-check-label" for="sale">On sale</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="banchay">
                        <label class="form-check-label" for="banchay">Best Seller</label>
                    </div>
                </div>
                <button type="submit" class="product-button buy" style="width:100%;margin-top:10px;">
                    <i class="fa-solid fa-filter"></i> Apply
                </button>
            </form>
        </div>
        <!-- Main Content -->
        <div class="main-content">
            <div class="banner">
                <h1>Explore the world of Violin</h1>
            </div>
            <div class="search-bar">
                <input type="text" class="search-input" placeholder="Search for violin products...">
                <button class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
            </div>
            
            <nav aria-label="Page navigation example" class="d-flex justify-content-center">
                <ul class="pagination">
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
            <h2 class="products-title">All Violin products</h2>
            <div class="products-row">
                <c:choose>
                    <c:when test="${not empty violins}">
                        <c:forEach var="violin" items="${violins}">
                            <div class="product-card">
                                <div class="product-image">
                                    <img src="${violin.imageUrl}" alt="${violin.name}" />
                                    <span class="badge sale">SALE</span>
                                </div>
                                <div class="product-info">
                                    <div class="product-name">${violin.name}</div>
                                    <div class="product-price">${violin.price} ₫</div>
                                    <div class="product-actions">
                                        <button class="product-button buy"><i class="fa-solid fa-bolt"></i> Buy now</button>
                                        <button class="product-button cart"><i class="fa-solid fa-cart-plus"></i></button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div id="no-products-message">No products available.</div>  
                    </c:otherwise>
                </c:choose>

                <!-- Thêm các sản phẩm violin khác tại đây -->
            </div>
            
            <nav aria-label="Page navigation example" class="d-flex justify-content-center">
                <ul class="pagination">
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>