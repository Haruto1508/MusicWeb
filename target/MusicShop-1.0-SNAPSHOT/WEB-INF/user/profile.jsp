<%-- 
    Document   : profile
    Created on : May 30, 2025, 3:43:11 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <!-- Link bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

        <!-- Link Header -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.header.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.profile.css">

        <!-- Link Footer -->

    </head>
    <body>
        <!-- Header -->
        <%@include file="/WEB-INF/include/header.jsp" %>

        <!-- Content -->
        <div class="container info-box">
            <div class="row">
                <div class="col-md-4">
                    <div class="sidebar">
                        <div class="text-center">
                            <img src="${user.imageUrl}" alt="Ảnh đại diện" class="profile-img">
                            <h4>${user.fullName}</h4>
                        </div>
                        <hr>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/account?view=info" 
                                   class="${ view == 'info' or empty  view ? 'active' : ''}">
                                    <i class="fas fa-user-circle"></i> Thông tin tài khoản</a></li>
                            <li><a href="${pageContext.request.contextPath}/account?view=address" 
                                   class="${ view == 'address' ? 'active' : ''}">
                                    <i class="fas fa-map-marker-alt"></i> Địa chỉ</a></li>
                            <li><a href="${pageContext.request.contextPath}/account?view=order" 
                                   class="${ view == 'order' ? 'active' : ''}">
                                    <i class="fas fa-box"></i> Đơn hàng</a></li>
                            <li><a href="${pageContext.request.contextPath}/account?view=cart" 
                                   class="${ view == 'cart' ? 'active' : ''}">
                                    <i class="fas fa-shopping-cart"></i> Giỏ hàng</a></li>
                            <li><a href="${pageContext.request.contextPath}/account?view=setting" 
                                   class="${ view == 'setting' ? 'active' : ''}">
                                    <i class="fas fa-cog"></i> Cài đặt</a></li>
                            <li><a href="${pageContext.request.contextPath}/account?view=password" 
                                   class="${ view == 'password' ? 'active' : ''}">
                                    <i class="fas fa-lock"></i> Đổi mật khẩu</a></li> 
                        </ul>
                    </div>
                </div>
                <div class="col-md-8">
                    <c:choose>
                        <c:when test="${ view == 'info' or empty  view}">
                            <jsp:include page="/WEB-INF/user/info.jsp" />
                        </c:when>
                        <c:when test="${ view == 'address'}">
                            <jsp:include page="/WEB-INF/user/address.jsp" />
                        </c:when>
                        <c:when test="${ view == 'cart'}">
                            <jsp:include page="/WEB-INF/user/cart.jsp" />
                        </c:when>
                        <c:when test="${ view == 'order'}">
                            <jsp:include page="/WEB-INF/user/order.jsp" />
                        </c:when>
                        <c:when test="${ view == 'setting'}">
                            <jsp:include page="/WEB-INF/user/setting.jsp" />
                        </c:when>
                        <c:when test="${ view == 'password'}">
                            <jsp:include page="/WEB-INF/user/password.jsp" />
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
