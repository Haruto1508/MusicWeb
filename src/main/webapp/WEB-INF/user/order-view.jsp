<%-- 
    Document   : order-view
    Created on : Jun 30, 2025, 11:43:01 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết đơn hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

        <!-- Link CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/order.view.css"/>
    </head>
    <body>
        <%@ include file="/WEB-INF/include/header.jsp" %>

        <div class="container">
            <div class="order-confirmation">
                <!-- Thông tin đơn hàng -->
                <div class="order-info">
                    <h2><i class="fa fa-info-circle me-2"></i>Order information</h2>
                    <div><strong>Order ID:</strong> #${order.orderId}</div>
                    <div>
                        <strong>Order date:</strong> 
                        <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" />
                    </div>
                    <div>
                        <strong>Status:</strong> 
                        <span class="badge bg-warning text-dark">
                            <i class="fa fa-clock me-1"></i>${order.status}
                        </span>
                    </div>
                </div>

                <!-- Sản phẩm -->
                <div class="order-summary">
                    <h2><i class="fa fa-shopping-cart me-2"></i>Product</h2>

                    <c:forEach var="detail" items="${order.orderDetails}">
                        <div class="order-item">
                            <img src="${detail.product.imageUrl}" alt="${detail.product.name}" width="100">
                            <div class="item-info">
                                <div class="item-name">${detail.product.name}</div>
                                <div>Quantity: ${detail.quantity}</div>
                                <div class="item-price">
                                    <fmt:formatNumber value="${detail.price}" type="currency" currencySymbol="đ" groupingUsed="true" />
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <div class="total">
                        <span>Total:</span>
                        <span><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="đ" groupingUsed="true"/></span>
                    </div>
                    <div class="total">
                        <span>Discount:</span>
                        <span><fmt:formatNumber value="${order.discountAmount}" type="currency" currencySymbol="đ" groupingUsed="true"/></span>
                    </div>
                    <div class="total">
                        <span>Shipping fee:</span>
                        <span>30.000đ</span>
                    </div>
                    <div class="total">
                        <span>Total payment:</span>
                        <strong><fmt:formatNumber value="${order.finalAmount}" type="currency" currencySymbol="đ" groupingUsed="true"/></strong>
                    </div>
                </div>

                <!-- Địa chỉ giao hàng -->
                <div class="shipping-address">
                    <h2><i class="fa fa-map-marker-alt me-2"></i>Shipping address</h2>
                    <div><strong>Name:</strong> ${order.receiverName}</div>
                    <div><strong>Number Phone:</strong> ${order.orderPhone}</div>
                    <div><strong>Address:</strong> ${order.fullAddress}</div>
                </div>

                <!-- Phương thức thanh toán -->
                <div class="payment-method">
                    <h2><i class="fa fa-credit-card me-2"></i>Payment method</h2>
                    <div><strong>${order.paymentMethod}</strong></div>
                    <div>Status: ${order.paymentStatus}</div>
                </div>

                <!-- Thông tin vận chuyển -->
                <div class="shipping-info">
                    <h2><i class="fa fa-truck me-2"></i>Shipping Information</h2>
                    <div><strong>Shipping unit:</strong> ${order.shippingMethod}</div>
                    <div><strong>Bill of lading code:</strong> ${order.trackingNumber}</div>
                    <div>
                        <strong>Delivery Estimate:</strong>
                        <fmt:formatDate value="${order.estimatedDelivery}" pattern="dd/MM/yyyy" />
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="/WEB-INF/include/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>