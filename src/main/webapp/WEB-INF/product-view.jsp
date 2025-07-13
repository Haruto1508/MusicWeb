<%-- 
    Document   : productView
    Created on : Jun 17, 2025, 5:41:46 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Product View - MusicShop</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product.view.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
    </head>
    <body>
        <%@ include file="/WEB-INF/include/header.jsp" %>
        <div class="container py-5">
            <c:choose>
                <c:when test="${not empty product}">
                    <div class="product-detail">
                        <div class="row">
                            <div class="col-md-6 product-images">
                                <span class="badge">Favourite</span>
                                <img src="${pageContext.request.contextPath}/${product.imageUrl}" alt="${product.name}" class="product-main-image">
                                <div class="product-thumbnail-images">
                                    <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=600&q=80" alt="Guitar Acoustic">
                                    <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=600&q=80" alt="Guitar Acoustic">
                                    <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=600&q=80" alt="Guitar Acoustic">
                                </div>
                            </div>
                            <div class="col-md-6 product-info">
                                <h1>${product.name}</h1>
                                <div class="rating">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star-half"></i>
                                    (150 Rate)
                                </div>
                                <div class="price">
                                    Price: <strong><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>đ</strong>
                                </div>
                                <p class="text-muted">Quantity in stock: ${product.stockQuantity}</p>
                                <p>
                                    Brand: <strong>${product.brand.name}</strong><br>
                                    Category: <strong>${not empty product.category.name ? product.category.name : 'product.category.name'} </strong><br>
                                    Material: <strong>${not empty product.material ? product.material : '...'}</strong><br>
                                    Year of manufacture: <strong>${product.yearOfManufacture != 0 ? product.yearOfManufacture : '...'}</strong><br>
                                    Made in: <strong>${not empty product.madeIn ? product.madeIn : '...'}</strong>
                                </p>
                                <div class="quantity d-flex align-items-center">
                                    <label for="userQuantityInput">Quantity: </label>
                                    <button type="button" class="btn btn-outline-secondary" onclick="changeQuantity(-1)">−</button>
                                    <input type="number" id="userQuantityInput" name="quantity" class="form-control text-center mx-2"
                                           value="1" min="1" max="${product.stockQuantity}" style="width: 60px;">
                                    <button type="button" class="btn btn-outline-secondary" onclick="changeQuantity(1)">+</button>
                                </div>
                                <div class="actions mt-3">
                                    <div class="d-flex">
                                        <c:if test="${product.stockQuantity > 0}">
                                            <form action="${pageContext.request.contextPath}/cart" method="get">
                                                <input type="hidden" name="productId" value="${product.productId}">
                                                <input type="hidden" name="quantity" id="addToCartQuantity" value="1">
                                                <input type="hidden" name="action" value="add">
                                                <button type="submit" class="btn btn-danger add-to-cart">
                                                    <i class="fa fa-cart-plus"></i> Add to cart
                                                </button>
                                            </form>
                                        </c:if>
                                        <c:if test="${product.stockQuantity == 0}">
                                            <button type="button" class="btn btn-danger add-to-cart" disabled>
                                                <i class="fa fa-cart-plus"></i> Sold out
                                            </button>
                                        </c:if>
                                        <form id="buyNowForm" action="${pageContext.request.contextPath}/order-confirm" method="post" class="d-inline">
                                            <input type="hidden" name="productId" value="${product.productId}" />
                                            <input type="hidden" name="quantity" id="buyNowQuantity" value="1" />
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fa fa-shopping-cart"></i> Buy now
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="product-description mt-5">
                            <h2>Product Description</h2>
                            <p>${product.description}</p>
                        </div>

                        <div class="product-reviews">
                            <h2>Product Reviews</h2>
                            <!-- Thêm các đánh giá sản phẩm ở đây -->
                        </div>
                        <div class="product-related">
                            <h2>Related Products</h2>
                            <div class="row">
                                <c:forEach var="product" items="${relatedList}">
                                    <div class="col-md-3">
                                        <div class="card">
                                            <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=200&q=80" class="card-img-top" alt="Guitar">
                                            <div class="card-body">
                                                <h5 class="card-title">${product.name}</h5>
                                                <p class="card-text">${product.price}</p>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/product?id=${product.productId}" class="text-decoration-none text-center text-dark">View detail</a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div>
                        <h3>Product does not exist!</h3>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <%@include file="/WEB-INF/include/toast.jsp" %>
        <%@ include file="/WEB-INF/include/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                        // Hàm cập nhật quantity cho cả hai form
                                        function updateQuantityForms() {
                                            const quantityInput = document.getElementById('userQuantityInput');
                                            const buyNowQuantity = document.getElementById('buyNowQuantity');
                                            const addToCartQuantity = document.getElementById('addToCartQuantity');

                                            buyNowQuantity.value = quantityInput.value;
                                            addToCartQuantity.value = quantityInput.value;
                                        }

                                        // Gắn sự kiện input cho userQuantityInput
                                        const quantityInput = document.getElementById('userQuantityInput');
                                        quantityInput.addEventListener('input', updateQuantityForms);

                                        // Hàm thay đổi số lượng khi nhấn nút + hoặc -
                                        function changeQuantity(delta) {
                                            const input = document.getElementById('userQuantityInput');
                                            let value = parseInt(input.value);
                                            const min = parseInt(input.min);
                                            const max = parseInt(input.max);

                                            value = Math.min(max, Math.max(min, value + delta));
                                            input.value = value;
                                            updateQuantityForms(); // Cập nhật giá trị cho các form
                                        }

                                        // Gán giá trị mặc định ban đầu
                                        updateQuantityForms();
        </script>
    </body>
</html>