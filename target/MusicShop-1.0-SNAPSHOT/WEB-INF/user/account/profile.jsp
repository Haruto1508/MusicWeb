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
    <!-- Các thẻ meta, title, link CSS -->
</head>
<body>
    <%@include file="/WEB-INF/include/header.jsp" %>
    
    <div class="container-fluid info-box">
        <div class="row">
            <div class="col-md-4">
                <div class="sidebar">
                    <div class="text-center">
                        <img src="${user.avatarUrl}" alt="Ảnh đại diện" class="profile-img">
                        <h4>${user.name}</h4>
                    </div>
                    <hr>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/profile?view=info" 
                              class="${param.view == 'info' or empty param.view ? 'active' : ''}">
                            <i class="fas fa-user-circle"></i> Information</a></li>
                        <li><a href="${pageContext.request.contextPath}/profile?view=order" 
                              class="${param.view == 'order' ? 'active' : ''}">
                            <i class="fas fa-box"></i> Order</a></li>
                        <li><a href="${pageContext.request.contextPath}/profile?view=cart" 
                              class="${param.view == 'cart' ? 'active' : ''}">
                            <i class="fas fa-shopping-cart"></i> Cart</a></li>
                        <li><a href="${pageContext.request.contextPath}/profile?view=setting" 
                              class="${param.view == 'setting' ? 'active' : ''}">
                            <i class="fas fa-cog"></i> Setting</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-md-8">
                <c:choose>
                    <c:when test="${param.view == 'info' or empty param.view}">
                        <jsp:include page="profile/info.jsp" />
                    </c:when>
                    <c:when test="${param.view == 'cart'}">
                        <jsp:include page="profile/cart.jsp" />
                    </c:when>
                    <c:when test="${param.view == 'order'}">
                        <jsp:include page="profile/orders.jsp" />
                    </c:when>
                    <c:when test="${param.view == 'setting'}">
                        <jsp:include page="profile/settings.jsp" />
                    </c:when>
                </c:choose>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
