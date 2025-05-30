<%-- 
<<<<<<< HEAD
   Document   : newjsp
   Created on : May 24, 2025, 5:14:18 PM
   Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đơn hàng của tôi</title>
        <!-- Link Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <!-- Link Header -->
        <!-- Link Footer -->
        <!-- Link CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.header.css">
        <style>
            body {
                background-color: #f8f9fa;
            }

            .card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            }

            .order-item {
                margin-bottom: 20px;
                border: 1px solid #ddd;
                border-radius: 10px;
                padding: 15px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .order-item h5 {
                margin-bottom: 0;
            }
        </style>
    </head>
    <!-- Header -->
    <%@include file="/WEB-INF/include/header.jsp" %>
    <body>
        <div class="container">
            <h1>My Order</h1>
            <c:choose>
                <c:when test="${not empty orders}">
                    <c:forEach var="order" items="${orders}">
                        <div class="order-item">
                            <div>
                                <h5>Order ID: ${order.orderId}</h5>
                                <p>Price: ${order.totalAmount}</p>
                            </div>
                            <div>
                                <button class="btn btn-primary btn-sm">Xem chi tiết</button>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <h3>You have no order now!</h3>
                </c:otherwise>
            </c:choose>

            
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>
