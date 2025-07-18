<%-- 
    Document   : guitar
    Created on : May 21, 2025, 12:20:11 AM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html lang="en">
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
        <!-- Link CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guitar.product.css"/>
    </head>

    <body>
        <!-- Header -->
        <%@ include file="/WEB-INF/include/header.jsp" %>
        <!-- Sidebar -->
        <div class="content-wrapper">
            <div class="d-flex">
                <div class="sidebar">
                    <form action="${pageContext.request.contextPath}/guitar" method="get">
                        <h3 style="font-size:1.1rem; color:#6d28d9; font-weight:700; margin-bottom:18px;">
                            <i class="fa-solid fa-filter"></i> Filter products
                        </h3>
                        <!-- Loại đàn -->
                        <div style="margin-bottom:18px;">
                            <div style="font-weight:600; margin-bottom:8px;">Guitar Type</div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="acoustic" name="type" value="acoustic" 
                                       <c:if test="${selectedTypes != null && fn:contains(fn:join(selectedTypes, ','), 'acoustic')}">checked</c:if>>
                                       <label class="form-check-label" for="acoustic">Acoustic</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="classic" name="type" value="classic" 
                                    <c:if test="${selectedTypes != null && fn:contains(fn:join(selectedTypes, ','), 'classic')}">checked</c:if>>
                                    <label class="form-check-label" for="classic">Classic</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="electric" name="type" value="electric" 
                                    <c:if test="${selectedTypes != null && fn:contains(fn:join(selectedTypes, ','), 'electric')}">checked</c:if>>
                                    <label class="form-check-label" for="electric">Electric</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="bass" name="type" value="bass" 
                                    <c:if test="${selectedTypes != null && fn:contains(fn:join(selectedTypes, ','), 'bass')}">checked</c:if>>
                                    <label class="form-check-label" for="bass">Bass</label>
                                </div>
                            </div>

                            <!-- Khoảng giá -->
                            <div style="margin-bottom:18px;">
                                <div style="font-weight:600; margin-bottom:8px;">Price range</div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="price" id="price0" value="1" 
                                    <c:if test="${selectedPrice == '1' || selectedPrice == null}">checked</c:if>>
                                    <label class="form-check-label" for="price0">All Products</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="price" id="price1" value="2" 
                                    <c:if test="${selectedPrice == '2'}">checked</c:if>>
                                    <label class="form-check-label" for="price1">Under 2 million</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="price" id="price2" value="3" 
                                    <c:if test="${selectedPrice == '3'}">checked</c:if>>
                                    <label class="form-check-label" for="price2">2 - 5 million</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="price" id="price3" value="4" 
                                    <c:if test="${selectedPrice == '4'}">checked</c:if>>
                                    <label class="form-check-label" for="price3">5 - 10 million</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="price" id="price4" value="5" 
                                    <c:if test="${selectedPrice == '5'}">checked</c:if>>
                                    <label class="form-check-label" for="price4">10 - 20 million</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="price" id="price5" value="6" 
                                    <c:if test="${selectedPrice == '6'}">checked</c:if>>
                                    <label class="form-check-label" for="price5">20 - 50 million</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="price" id="price6" value="7" 
                                    <c:if test="${selectedPrice == '7'}">checked</c:if>>
                                    <label class="form-check-label" for="price6">over 50 million</label>
                                </div>
                            </div>
                            <!-- Khác -->
                            <div style="margin-bottom:18px;">
                                <div style="font-weight:600; margin-bottom:8px;">Others</div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="sale" name="sale" value="true" 
                                    <c:if test="${isSale}">checked</c:if>>
                                    <label class="form-check-label" for="sale">On Sale</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="bestSeller" name="bestSeller" value="true" 
                                    <c:if test="${isBestSeller}">checked</c:if>>
                                    <label class="form-check-label" for="bestSeller">Best Seller</label>
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
                            <form action="${pageContext.request.contextPath}/guitar" method="get">
                            <div class="d-flex align-items-center">
                                <input type="text" class="search-input" name="search" placeholder="Search for products..." value="${searchQuery}">
                                <button type="submit" class="search-btn ms-2"><i class="fa-solid fa-magnifying-glass"></i></button>
                            </div>
                        </form>
                    </div>

                    <h2 class="products-title">All Guitars products</h2>
                    <c:choose>
                        <c:when test="${not empty guitars}">
                            <div class="products-row">
                                <c:forEach var="guitar" items="${guitars}">
                                    <div class="product-card">
                                        <div class="product-image">
                                            <img src="${guitar.imageUrl}" alt="${guitar.name}">
                                        </div>
                                        <div class="product-info">
                                            <div class="product-name">${guitar.name}</div>
                                            <div class="product-price">
                                                <strong><fmt:formatNumber value="${guitar.price}" type="number" pattern="#,##0"/> VNÐ</strong>
                                            </div>
                                            <div class="product-actions">
                                                <a href="${pageContext.request.contextPath}/product?id=${guitar.productId}" class="text-decoration-none text-white">
                                                    <button class="product-button buy">
                                                        <i class="fa-solid fa-bolt"></i> Buy now
                                                    </button>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <%@include file="/WEB-INF/include/unfind-product.jsp" %>
                        </c:otherwise>
                    </c:choose>

                    <!-- Pagination -->
                    <nav aria-label="Guitar pagination" class="d-flex justify-content-center mt-4">
                        <ul class="pagination pagination-pill">
                            <!-- Nút Prev -->
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="guitar?page=${currentPage - 1}<c:if test="${selectedTypes != null}">&${fn:join(selectedTypes, '&type=')}</c:if><c:if test="${selectedPrice != null && selectedPrice != '1'}">&price=${selectedPrice}</c:if><c:if test="${isSale}">&sale=true</c:if><c:if test="${isBestSeller}">&bestSeller=true</c:if><c:if test="${searchQuery != null && not empty searchQuery}">&search=${searchQuery}</c:if>" aria-label="Previous">
                                            <i class="fas fa-chevron-left"></i>
                                        </a>
                                    </li>
                            </c:if>

                            <!-- Trang 1 -->
                            <li class="page-item ${currentPage == 1 ? 'active' : ''}">
                                <a class="page-link" href="guitar?page=1<c:if test="${selectedTypes != null}">&${fn:join(selectedTypes, '&type=')}</c:if><c:if test="${selectedPrice != null && selectedPrice != '1'}">&price=${selectedPrice}</c:if><c:if test="${isSale}">&sale=true</c:if><c:if test="${isBestSeller}">&bestSeller=true</c:if><c:if test="${searchQuery != null && not empty searchQuery}">&search=${searchQuery}</c:if>">1</a>
                                </li>

                                <!-- Dấu ... trái -->
                            <c:if test="${currentPage > 4}">
                                <li class="page-item disabled"><a class="page-link">...</a></li>
                                </c:if>

                            <!-- Tính begin/end -->
                            <c:set var="pageBegin" value="${currentPage - 2}" />
                            <c:if test="${pageBegin < 2}">
                                <c:set var="pageBegin" value="2" />
                            </c:if>

                            <c:set var="pageEnd" value="${currentPage + 2}" />
                            <c:if test="${pageEnd >= totalPages}">
                                <c:set var="pageEnd" value="${totalPages - 1}" />
                            </c:if>

                            <!-- Các trang ở giữa -->
                            <c:forEach begin="${pageBegin}" end="${pageEnd}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="guitar?page=${i}<c:if test="${selectedTypes != null}">&${fn:join(selectedTypes, '&type=')}</c:if><c:if test="${selectedPrice != null && selectedPrice != '1'}">&price=${selectedPrice}</c:if><c:if test="${isSale}">&sale=true</c:if><c:if test="${isBestSeller}">&bestSeller=true</c:if><c:if test="${searchQuery != null && not empty searchQuery}">&search=${searchQuery}</c:if>">${i}</a>
                                    </li>
                            </c:forEach>

                            <!-- Dấu ... phải -->
                            <c:if test="${currentPage < totalPages - 3}">
                                <li class="page-item disabled"><a class="page-link">...</a></li>
                                </c:if>

                            <!-- Trang cuối -->
                            <c:if test="${totalPages > 1}">
                                <li class="page-item ${currentPage == totalPages ? 'active' : ''}">
                                    <a class="page-link" href="guitar?page=${totalPages}<c:if test="${selectedTypes != null}">&${fn:join(selectedTypes, '&type=')}</c:if><c:if test="${selectedPrice != null && selectedPrice != '1'}">&price=${selectedPrice}</c:if><c:if test="${isSale}">&sale=true</c:if><c:if test="${isBestSeller}">&bestSeller=true</c:if><c:if test="${searchQuery != null && not empty searchQuery}">&search=${searchQuery}</c:if>">${totalPages}</a>
                                    </li>
                            </c:if>

                            <!-- Nút Next -->
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="guitar?page=${currentPage + 1}<c:if test="${selectedTypes != null}">&${fn:join(selectedTypes, '&type=')}</c:if><c:if test="${selectedPrice != null && selectedPrice != '1'}">&price=${selectedPrice}</c:if><c:if test="${isSale}">&sale=true</c:if><c:if test="${isBestSeller}">&bestSeller=true</c:if><c:if test="${searchQuery != null && not empty searchQuery}">&search=${searchQuery}</c:if>" aria-label="Next">
                                            <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        <%@ include file="/WEB-INF/include/footer.jsp" %>
        <%@include file="/WEB-INF/include/btn-to-top.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>