<%-- 
    Document   : piano
    Created on : May 23, 2025, 9:26:31 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Link Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <!-- Link Header -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
        <!-- Link Footer -->
        <!-- Link CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/piano.product.css">
        <title>Piano Shop</title>
    </head>

    <body>
        <!-- Header -->
        <%@ include file="/WEB-INF/include/header.jsp" %>
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="logo"><i class="fa-solid fa-music"></i> Piano Shop</div>
            <form>
                <h3 style="font-size:1.1rem; color:#6d28d9; font-weight:700; margin-bottom:18px;">
                    <i class="fa-solid fa-filter"></i> Filter products
                </h3>
                <!-- Danh mục loại piano -->
                <div style="margin-bottom:18px;">
                    <div style="font-weight:600; margin-bottom:8px;">Piano type</div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="grand">
                        <label class="form-check-label" for="grand">Grand Piano</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="upright">
                        <label class="form-check-label" for="upright">Upright Piano</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="digital">
                        <label class="form-check-label" for="digital">Digital Piano</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="synthesizer">
                        <label class="form-check-label" for="synthesizer">Synthesizer</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="keyboard">
                        <label class="form-check-label" for="keyboard">Keyboard</label>
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
                        <label class="form-check-label" for="price1">Under 10 million</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="price" id="price2">
                        <label class="form-check-label" for="price2">10 - 30 million</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="price" id="price3">
                        <label class="form-check-label" for="price3">30 - 100 million</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="price" id="price4">
                        <label class="form-check-label" for="price4">Over 100 million</label>
                    </div>
                </div>
                <!-- Thương hiệu -->
                <div style="margin-bottom:18px;">
                    <div style="font-weight:600; margin-bottom:8px;">Brand</div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="yamaha">
                        <label class="form-check-label" for="yamaha">Yamaha</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="roland">
                        <label class="form-check-label" for="roland">Roland</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="kawai">
                        <label class="form-check-label" for="kawai">Kawai</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="casio">
                        <label class="form-check-label" for="casio">Casio</label>
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
                <h1>Explore the world of Piano</h1>
            </div>
            <div class="search-bar">
                <input type="text" class="search-input" placeholder="Tìm kiếm đàn piano...">
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
            <h2 class="products-title">All Piano products</h2>
            <div class="products-row">
                <!-- Piano 1 -->
                <c:choose>
                    <c:when test="${not empty pianos}">
                        <c:forEach var="piano" items="${pianos}">
                            <div class="product-card">
                                <div class="product-image">
                                    <img src="${piano.imageUrl}" alt="${piano.name}"/>
                                    <span class="badge sale">SALE</span>
                                </div>
                                <div class="product-info">
                                    <div class="product-name">${piano.name}</div>
                                    <div class="product-price">${piano.price} ₫</div>
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


                <!-- Thêm các sản phẩm piano khác tại đây -->
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