<%-- 
    Document   : cart
    Created on : May 28, 2025, 12:08:39 AM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.cart.css"/>
<div class="container">
    <h2 class="mb-4">🛒 Your Cart</h2>

    <c:choose>
        <c:when test="${not empty carts}">
            <div class="list-group">
                <c:forEach var="cart" items="${carts}">
                    <div class="row cart-item align-items-center shadow-sm">
                        <div class="col-md-2 text-center">
                            <img src="${cart.product.imageUrl}" alt="${cart.product.name}">
                        </div>
                        <div class="col-md-6">
                            <h5 class="mb-1">${cart.product.name}</h5>
                            <p class="mb-1 text-muted">Price: ${cart.product.price} VNĐ</p>
                            <p class="mb-1 text-muted">Quantity: ${cart.quantity}</p>
                        </div>
                        <div class="col-md-4 text-end cart-buttons">
                            <a href="${pageContext.request.contextPath}/product?id=${cart.product.productId}" class="btn btn-outline-primary btn-sm">🔍 See details</a>
                            <a href="${pageContext.request.contextPath}/product?id=${cart.product.productId}" class="btn btn-success btn-sm">💳 Buy now</a>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Tổng tiền -->
            <div class="mt-4 text-end">
                <p class="cart-total">Total amount: 
                    <strong>
                        <c:out value="${total}" /> VNĐ
                    </strong>
                </p>
                <a href="checkout-all" class="btn btn-primary">🧾 Pay all</a>
            </div>
        </c:when>

        <c:otherwise>
            <div class="alert alert-info text-center mt-5">
                🛒 Your cart is empty!
            </div>
        </c:otherwise>
    </c:choose>
</div>

