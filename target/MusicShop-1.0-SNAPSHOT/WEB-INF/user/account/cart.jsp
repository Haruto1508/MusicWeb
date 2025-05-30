<%-- 
    Document   : cart
    Created on : May 28, 2025, 12:08:39 AM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cart</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <!-- Link Header -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.header.css">
        <!-- Link Footer -->
        <!-- Link CSS -->
        <style>
            body {
                background-color: #f8f9fa;
            }

            .cart-item {
                margin-bottom: 20px;
                border: 1px solid #ddd;
                border-radius: 10px;
                padding: 15px;
                display: flex;
                align-items: center;
            }

            .cart-item img {
                width: 100px;
                height: 100px;
                object-fit: cover;
                border-radius: 8px;
                margin-right: 15px;
            }

            .cart-item-details {
                flex-grow: 1;
            }

            .cart-item-quantity {
                display: flex;
                align-items: center;
            }

            .cart-item-quantity button {
                width: 30px;
                height: 30px;
                border: none;
                background-color: #f0f0f0;
                border-radius: 50%;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 5px;
            }

            .cart-item-quantity input {
                width: 40px;
                text-align: center;
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 5px;
            }

            .cart-total {
                margin-top: 20px;
                text-align: right;
            }

            .remove-item {
                color: red;
                cursor: pointer;
                margin-left: 10px;
            }

            .cart-buttons {
                display: flex;
                gap: 10px;
                margin-top: 10px;
            }
        </style>
    </head>

    <body>
        <!-- Header -->
        <%@include file="/WEB-INF/include/header.jsp" %>

        <!-- Content -->
        <div class="container">
            <h1>Giỏ hàng của bạn</h1>
            <c:choose>
                <c:when test="${not empty carts}">
                    <c:forEach var="cart" items="${carts}">
                        <div class="cart-item">
                            <img src="${cart.product.image}" alt="${cart.product.name}">
                            <div class="cart-item-details">
                                <h5>${cart.product.name}</h5>
                                <p>Giá: ${cart.product.price} VNĐ</p>
                                <p>Số lượng: ${cart.quantity}</p>
                                <div class="cart-buttons">
                                    <button class="btn btn-sm btn-outline-primary">Xem chi tiết</button>
                                    <button class="btn btn-sm btn-success">Mua ngay</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <h3>You have no cart now!</h3>
                </c:otherwise>
            </c:choose>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>