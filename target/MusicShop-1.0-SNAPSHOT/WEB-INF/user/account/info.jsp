<%-- 
    Document   : info
    Created on : May 24, 2025, 2:50:06 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thông tin người dùng</title>
        <!-- Link Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <!-- Link Header -->
        <!-- Link Footer -->
        <!-- Link CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.header.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.info.css">
    </head>
    <body>
        <!-- Header -->
        <%@include file="/WEB-INF/include/header.jsp" %>
        
        <!-- Main -->
        <div class="container-fluid info-box">
            <div class="row">
                <div class="col-md-4">
                    <div class="sidebar">
                        <div class="text-center">
                            <img src="https://via.placeholder.com/120" alt="Ảnh đại diện" class="profile-img">
                            <h4>Rem</h4>
                        </div>
                        <hr>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/profile?view=info"><i class="fas fa-user-circle"></i> Information</a></li>
                            <li><a href="${pageContext.request.contextPath}/profile?view=order"><i class="fas fa-box"></i> Order</a></li>
                            <li><a href="${pageContext.request.contextPath}/profile?view=cart"><i class="fas fa-heart"></i> Cart</a></li>
                            <li><a href="${pageContext.request.contextPath}/profile?view=setting"><i class="fas fa-cog"></i> Setting</a></li>

                        </ul>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card">
                        <h1 class="text-center fw-bold py-4">Information</h1>
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="info-label">Full Name:</label>
                                <p class="info-value">${user.fullName}</p>
                            </div>
                            <div class="mb-3">
                                <label class="info-label">Email:</label>
                                <p class="info-value">${user.email}</p>
                            </div>
                            <div class="mb-3">
                                <label class="info-label">Phone:</label>
                                <p class="info-value">${user.phone}</p>
                            </div>
                            <div class="mb-3">
                                <label class="info-label">Address:</label>
                                <p class="info-value">${user.address}</p>
                            </div>
                            <div class="mb-3">
                                <label class="info-label">Created date:</label>
                                <p class="info-value">${user.createDateTime}</p>
                            </div>
                            <hr>
                            <div class="text-center">
                                <button class="btn btn-primary"><i class="fas fa-edit"></i> Edit</button>
                                <button class="btn btn-danger"><i class="fas fa-sign-out-alt"></i> Logout</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>