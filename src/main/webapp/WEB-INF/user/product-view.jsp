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
                                    <input type="number" class="form-control" value="1" min="1" max="${product.stockQuantity}">
                                </div>
                                <div class="actions mt-3">
                                    <button class="btn btn-danger add-to-cart" data-product-id="${product.productId}">
                                        <i class="fa fa-cart-plus"></i> Add to cart
                                    </button>
                                    <button class="btn btn-primary buy-now" data-bs-toggle="modal" data-bs-target="#orderModal">
                                        <i class="fa fa-shopping-cart"></i> Buy now
                                    </button>
                                    <button class="btn btn-outline-secondary add-to-wishlist" data-product-id="${product.productId}">
                                        <i class="fa fa-heart"></i> Favourite
                                    </button>
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

        <!-- Order Modal -->
        <div class="modal fade" id="orderModal" tabindex="-1" aria-labelledby="orderModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="orderModalLabel">Thông tin khách hàng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="mb-3">
                                <label for="name" class="form-label">Họ và tên</label>
                                <input type="text" class="form-control" id="name" placeholder="Nhập họ và tên" required>
                            </div>
                            <div class="mb-3">
                                <label for="phone" class="form-label">Number Phone</label>
                                <input type="tel" class="form-control" id="phone" placeholder="Nhập số điện thoại" required>
                            </div>
                            <div class="mb-3">
                                <label for="address" class="form-label">Address</label>
                                <input type="text" class="form-control" id="address" placeholder="Nhập địa chỉ" required>
                            </div>
                            <div class="mb-3">
                                <label for="payment" class="form-label">Payment method</label>
                                <select class="form-select" id="payment">
                                    <option>Cash on Delivery</option>
                                    <option>Credit card</option>
                                    <option>E-wallet</option>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="button" class="btn btn-primary">Đặt hàng</button>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="/WEB-INF/include/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.querySelectorAll('.add-to-cart').forEach(button => {
                button.addEventListener('click', function () {
                    const productId = this.dataset.productId;
                    alert(`\u0110\u00e3 th\u00eam s\u1ea3n ph\u1ea9m ${productId} v\u00e0o gi\u1ecf h\u00e0ng (ch\u01b0a x\u1eed l\u00fd logic)`);
                });
            });

            document.querySelectorAll('.add-to-wishlist').forEach(button => {
                button.addEventListener('click', function () {
                    const productId = this.dataset.productId;
                    alert(`\u0110\u00e3 th\u00eam s\u1ea3n ph\u1ea9m ${productId} v\u00e0o danh s\u00e1ch y\u00eau th\u00edch (ch\u01b0a x\u1eed l\u00fd logic)`);
                });
            });
        </script>
    </body>
</html>
