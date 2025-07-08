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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/order.view.css"/>
    </head>
    <body>
        <%@ include file="/WEB-INF/include/header.jsp" %>
        
        <!-- Đặt ngôn ngữ mặc định cho định dạng tiền tệ -->
        <fmt:setLocale value="vi_VN"/>

        <div class="container">
            <div class="order-confirmation">
                <!-- Thông tin đơn hàng -->
                <div class="order-info">
                    <h2><i class="fa fa-info-circle me-2"></i>Thông tin đơn hàng</h2>
                    <div><strong>Mã đơn hàng:</strong> #${order.orderId}</div>
                    <div>
                        <strong>Ngày đặt hàng:</strong> 
                        <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" />
                    </div>
                    <div>
                        <strong>Trạng thái:</strong> 
                        <span class="badge bg-warning text-dark">
                            <i class="fa fa-clock me-1"></i>${order.status}
                        </span>
                    </div>
                </div>

                <!-- Sản phẩm -->
                <div class="order-summary">
                    <h2><i class="fa fa-shopping-cart me-2"></i>Sản phẩm</h2>
                    <c:forEach var="detail" items="${order.orderDetails}">
                        <div class="order-item">
                            <img src="${detail.product.imageUrl}" alt="${detail.product.name}" width="100">
                            <div class="item-info">
                                <div class="item-name">${detail.product.name}</div>
                                <div>Số lượng: ${detail.quantity}</div>
                                <div class="item-price">
                                    <fmt:formatNumber value="${detail.price}" type="currency" currencySymbol="đ" groupingUsed="true" />
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <div class="total">
                        <span>Tổng cộng:</span>
                        <span><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="đ" groupingUsed="true"/></span>
                    </div>
                    <div class="total">
                        <span>Giảm giá:</span>
                        <span><fmt:formatNumber value="${order.discountAmount}" type="currency" currencySymbol="đ" groupingUsed="true"/></span>
                    </div>
                    <div class="total">
                        <span>Phí vận chuyển:</span>
                        <span><fmt:formatNumber value="30000" type="currency" currencySymbol="đ" groupingUsed="true"/></span>
                    </div>
                    <div class="total">
                        <span>Tổng thanh toán:</span>
                        <strong><fmt:formatNumber value="${order.finalAmount}" type="currency" currencySymbol="đ" groupingUsed="true"/></strong>
                    </div>
                </div>

                <!-- Địa chỉ giao hàng -->
                <div class="shipping-address">
                    <h2><i class="fa fa-map-marker-alt me-2"></i>Địa chỉ giao hàng</h2>
                    <div><strong>Tên người nhận:</strong> ${order.receiverName}</div>
                    <div><strong>Số điện thoại:</strong> ${order.orderPhone}</div>
                    <div><strong>Địa chỉ:</strong> ${order.fullAddress}</div>
                </div>

                <!-- Phương thức thanh toán -->
                <div class="payment-method">
                    <h2><i class="fa fa-credit-card me-2"></i>Phương thức thanh toán</h2>
                    <div><strong>${order.paymentMethod}</strong></div>
                    <div>Trạng thái: ${order.paymentStatus}</div>
                </div>

                <!-- Thông tin vận chuyển -->
                <div class="shipping-info">
                    <h2><i class="fa fa-truck me-2"></i>Thông tin vận chuyển</h2>
                    <div><strong>Đơn vị vận chuyển:</strong> ${order.shippingMethod}</div>
                    <div><strong>Mã vận đơn:</strong> ${order.trackingNumber}</div>
                    <div>
                        <strong>Ước tính giao hàng:</strong>
                        <fmt:formatDate value="${order.estimatedDelivery}" pattern="dd/MM/yyyy" />
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="/WEB-INF/include/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>