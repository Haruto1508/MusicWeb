<%-- 
   Document   : order
   Created on : May 24, 2025, 5:14:18 PM
   Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>




<div class="container my-5">
    <h2 class="mb-4 text-center text-primary"><i class="fa-solid fa-receipt me-2"></i>Your order</h2>

    <c:choose>
        <c:when test="${not empty orders}">
            <div class="row row-cols-1 g-4">
                <c:forEach var="order" items="${orders}">
                    <div class="col">
                        <div class="card shadow-sm border-0 order-card">
                            <!-- Tiêu đề đơn hàng -->
                            <div class="order-header d-flex justify-content-between align-items-center">
                                <span>🆔 Order ID <strong>${order.orderId}</strong></span>
                            </div>
                            <div class="card-body">
                                <!-- Thông tin đơn hàng -->
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <p class="mb-1 text-muted"><i class="fa-solid fa-calendar-alt me-1"></i> Order Date: 
                                            <c:choose>
                                                <c:when test="${order.orderDateAsDate != null}">
                                                    <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                </c:when>
                                                <c:otherwise>
                                                    No date
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                        <p class="mb-1 text-muted"><i class="fa-solid fa-money-bill-wave me-1"></i> Total amount: 
                                            <strong><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.000"/> VNĐ</strong>
                                        </p>
                                    </div>
                                    <div class="col-md-6 text-md-end">
                                        <p class="mb-2"><i class="fa-solid fa-box-open me-1"></i> Status: 
                                            <span class="${order.status.bootstrapClass} rounded-2 p-2 text-light">${order.status.label}</span>
                                        </p>
                                        <a href="${pageContext.request.contextPath}/order?id=${order.orderId}" class="btn btn-view-detail">
                                            <i class="fa-solid fa-eye me-1"></i> View Detail
                                        </a>
                                    </div>
                                </div>
                                <!-- Sản phẩm trong đơn hàng -->
                                <div class="border-top pt-3">
                                    <c:choose>
                                        <c:when test="${order.orderDetail != null}">
                                            <div class="order-item">
                                                <img src="${order.orderDetail.product.imageUrl}" alt="${order.orderDetail.product.name}" class="me-3">
                                                <div class="flex-grow-1">
                                                    <h6 class="mb-1">${order.orderDetail.product.name}</h6>
                                                    <p class="mb-1 text-muted">Quantity: ${order.orderDetail.quantity}</p>
                                                    <p class="mb-0 text-muted">Price: 
                                                        <fmt:formatNumber value="${order.orderDetail.price}" pattern="#,##0.000"/> VNĐ
                                                    </p>
                                                </div>
                                                <div class="text-end">
                                                    <p class="mb-0 fw-bold">
                                                        <fmt:formatNumber value="${order.orderDetail.price * order.orderDetail.quantity}" pattern="#,##0.000"/> VNĐ
                                                    </p>
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-muted text-center">There are no products in the order.</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info text-center py-4">
                <i class="fa-solid fa-cart-shopping me-2"></i> Bạn chưa có đơn hàng nào!
            </div>
        </c:otherwise>
    </c:choose>
</div>
<%@include file="/WEB-INF/include/btn-to-top.jsp" %>
