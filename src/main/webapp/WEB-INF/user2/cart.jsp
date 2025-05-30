<%-- 
    Document   : cart
    Created on : May 28, 2025, 12:08:39 AM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container my-5">
    <h2 class="mb-4">🛒 Giỏ hàng của bạn</h2>

    <c:choose>
        <c:when test="${not empty carts}">
            <div class="list-group">
                <c:forEach var="cart" items="${carts}">
                    <div class="row cart-item align-items-center">
                        <div class="col-md-2 text-center">
                            <img src="${cart.product.imageUrl}" alt="${cart.product.name}">
                        </div>
                        <div class="col-md-6">
                            <h5 class="mb-1">${cart.product.name}</h5>
                            <p class="mb-1 text-muted">Giá: ${cart.product.price} VNĐ</p>
                            <p class="mb-1 text-muted">Số lượng: ${cart.quantity}</p>
                        </div>
                        <div class="col-md-4 text-end cart-buttons">
                            <a href="product-detail?productId=${cart.product.productId}" class="btn btn-outline-primary btn-sm">🔍 Xem chi tiết</a>
                            <a href="checkout?productId=${cart.product.productId}" class="btn btn-success btn-sm">💳 Mua ngay</a>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Tổng tiền -->
            <div class="mt-4 text-end">
                <p class="cart-total">Tổng tiền: 
                    <strong>
                        <c:out value="${totalPrice}" /> VNĐ
                    </strong>
                </p>
                <a href="checkout-all" class="btn btn-primary">🧾 Thanh toán tất cả</a>
            </div>
        </c:when>

        <c:otherwise>
            <div class="alert alert-info text-center mt-5">
                🛒 Giỏ hàng của bạn đang trống!
            </div>
        </c:otherwise>
    </c:choose>
</div>

