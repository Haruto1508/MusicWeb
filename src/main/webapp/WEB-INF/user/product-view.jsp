<%-- 
    Document   : productView
    Created on : Jun 17, 2025, 5:41:46 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Chi tiết sản phẩm - MusicShop</title>
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
                                    Price: <strong>${product.price} đ</strong>
                                </div>
                                <p class="text-muted">Quantity in stock: ${product.stockQuantity}</p>
                                <p>
                                    Brand: <strong>${product.brand.name}</strong><br>
                                    Category: <strong>${product.category.name}</strong><br>
                                    Date created: <strong>${product.createDateTime}</strong>
                                </p>
                                <div class="quantity">
                                    <label>Quantity:</label>
                                    <input type="number" name="quantity" id="userQuantityInput" class="form-control" value="1" min="1" max="${product.stockQuantity}">
                                </div>
                                <div class="actions mt-3">
                                    <button class="btn btn-danger add-to-cart" data-product-id="${product.productId}">
                                        <i class="fa fa-cart-plus"></i> Add to cart
                                    </button>
                                    <form id="buyNowForm" action="${pageContext.request.contextPath}/order-confirm" method="post" class="d-inline">
                                        <input type="hidden" name="productId" value="${product.productId}" />
                                        <input type="hidden" name="quantity" id="buyNowQuantity" value="" />
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fa fa-shopping-cart"></i> Buy now
                                        </button>
                                    </form>

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
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
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

        <%@ include file="/WEB-INF/include/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.getElementById('buyNowForm').addEventListener('submit', function (e) {
                const quantityInput = document.getElementById('userQuantityInput');
                const hiddenQuantity = document.getElementById('buyNowQuantity');
                hiddenQuantity.value = quantityInput.value;
            });
        </script>
    </body>
</html>
