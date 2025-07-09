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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
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
                    <i class="fa-solid fa-filter"></i> Filter products
                </h3>
                <!-- Danh mục loại đàn (checkbox) -->
                <div style="margin-bottom:18px;">
                    <div style="font-weight:600; margin-bottom:8px;">Type of guitar</div>
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
                        <label class="form-check-label" for="electric">Electric</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="bass">
                        <label class="form-check-label" for="bass">Bass</label>
                    </div>
                </div>
                <!-- Khoảng giá (nhiều lựa chọn hơn) -->
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
                        <label class="form-check-label" for="price4">10 - 20 million</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="price" id="price5">
                        <label class="form-check-label" for="price5">20 - 50 million</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="price" id="price6">
                        <label class="form-check-label" for="price6">Over 50 million</label>
                    </div>
                </div>
                <!-- Sale & Bán chạy -->
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
                <button type="submit" class="product-button" style="margin-top:10px;">
                    <i class="fa-solid fa-filter"></i> Apply
                </button>
            </form>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="banner">
                <h1>Explore the world of Guitar</h1>
            </div>

            <div class="search-bar">
                <input type="text" class="search-input" placeholder="Search for products...">
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
            <h2 class="products-title">Recommended Guitars</h2>
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
                                        <button class="product-button buy"><i class="fa-solid fa-bolt"></i> Buy now</button>
                                        <button class="product-button cart"><i class="fa-solid fa-cart-plus"></i></button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted text-center w-100">No products recommended yet.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <nav aria-label="Page navigation example" class="d-flex justify-content-center mt-4">
                <ul class="pagination">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="guitar?page=${currentPage - 1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="guitar?page=${i}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="guitar?page=${currentPage + 1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>