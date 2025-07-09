<%-- 
   Document   : order
   Created on : May 24, 2025, 5:14:18 PM
   Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.order.css"/>

<div class="container">
    <h2 class="mb-4">🧾 Your Orders</h2>

    <c:choose>
        <c:when test="${not empty orders}">
            <div class="row row-cols-1 g-4">
                <c:forEach var="order" items="${orders}">
                    <div class="col">
                        <div class="card shadow-sm border-0 order-item">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div>
                                        <h5 class="card-title mb-1">🆔 Order ID: <strong>${order.orderId}</strong></h5>
                                        <p class="mb-0">📅 Day: ${order.orderDate}</p>
                                        <p class="mb-0">💰 Total: <strong>${order.totalAmount} VNĐ</strong></p>  
                                        <p class="mb-0">📦 Status:
                                            <span class="badge bg-${badgeClass}">
                                                ${statusText}
                                            </span>
                                        </p>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/order?id=${order.orderId}" class="btn btn-outline-primary btn-sm">
                                        View detail
                                    </a>
                                </div>

                                <!-- Danh sách sản phẩm trong đơn -->
                                <c:forEach var="item" items="${order.orderDetails}">
                                    <div class="d-flex align-items-center border-top pt-3 pb-2">
                                        <img src="${item.product.imageUrl}" alt="${item.product.name}" class="me-3" style="width: 60px; height: 60px; object-fit: cover; border-radius: 8px;">
                                        <div>
                                            <h6 class="mb-1">${item.product.name}</h6>
                                            <p class="mb-0">SL: ${item.quantity} × ${item.price} VNĐ</p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info text-center" role="alert">
                🛒 You have no orders yet!
            </div>
        </c:otherwise>
    </c:choose>
</div>