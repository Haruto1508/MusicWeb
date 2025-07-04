<%-- 
    Document   : register
    Created on : May 17, 2025, 4:41:08 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Đăng ký - MusicShop</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(120deg, #8b5cf6 60%, #6d28d9 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .register-container {
                background: #fff;
                border-radius: 18px;
                box-shadow: 0 4px 32px rgba(139,92,246,0.12);
                padding: 0;
                width: 98vw;
                max-width: 900px;
                display: flex;
                overflow: hidden;
                margin: 24px 0;
            }
            .register-img {
                background: url('https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=600&q=80') center/cover no-repeat;
                width: 380px;
                min-height: 500px;
                display: none;
            }
            @media (min-width: 992px) {
                .register-img {
                    display: block;
                }
            }
            .register-box {
                flex: 1;
                padding: 2.5rem 2rem;
            }
            .register-logo {
                font-size: 2rem;
                color: #8b5cf6;
                font-weight: bold;
                margin-bottom: 1.5rem;
                text-align: center;
            }
            .input-group-text {
                background: #f3f4f6;
                border: none;
                color: #8b5cf6;
            }
            .form-control:focus {
                border-color: #8b5cf6;
                box-shadow: 0 0 0 0.2rem rgba(139,92,246,.15);
            }
            .btn-primary {
                background: #8b5cf6;
                border: none;
            }
            .btn-primary:hover {
                background: #6d28d9;
            }
            .error-message {
                color: red;
                font-size: 0.8rem;
                margin-top: 0.25rem;
            }
        </style>
    </head>
    <body>
        <div class="register-container">
            <div class="register-box">
                <div class="register-logo">
                    <i class="fa-solid fa-music"></i> MusicShop
                </div>

                <c:if test="${not empty registerError}">
                    <div class="alert alert-danger mt-3">
                        ${registerError}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div class="mb-3">
                        <label class="form-label">
                            Full Name
                            <small class="text-muted d-block">Ít nhất 3 ký tự, chỉ gồm chữ và khoảng trắng</small>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                            <input type="text" class="form-control ${not empty fullNameError ? 'is-invalid' : ''}" 
                                   name="full_name" value="${full_name}" required>
                        </div>
                        <c:if test="${not empty fullNameError}">
                            <div class="error-message">${fullNameError}</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            Account
                            <small class="text-muted d-block">3-20 ký tự, chữ, số, gạch dưới</small>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-regular fa-user"></i></span>
                            <input type="text" class="form-control ${not empty accountError ? 'is-invalid' : ''}" 
                                   name="account" value="${account}" required>
                        </div>
                        <c:if test="${not empty accountError}">
                            <div class="error-message">${accountError}</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            Email
                            <small class="text-muted d-block">Ví dụ: ten@example.com</small>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                            <input type="email" class="form-control ${not empty emailError ? 'is-invalid' : ''}" 
                                   name="email" value="${email}" required>
                        </div>
                        <c:if test="${not empty emailError}">
                            <div class="error-message">${emailError}</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            Phone
                            <small class="text-muted d-block">Bắt đầu bằng 0, gồm 10-11 chữ số</small>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
                            <input type="tel" class="form-control ${not empty phoneError ? 'is-invalid' : ''}" 
                                   name="phone" value="${phone}" required>
                        </div>
                        <c:if test="${not empty phoneError}">
                            <div class="error-message">${phoneError}</div>
                        </c:if>
                    </div>
                        
                    <div class="mb-3">
                        <label class="form-label">
                            Password
                            <small class="text-muted d-block">Ít nhất 8 ký tự, có chữ hoa, thường, số, ký tự đặc biệt</small>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                            <input type="password" class="form-control ${not empty passwordError ? 'is-invalid' : ''}" 
                                   name="password" required>
                        </div>
                        <c:if test="${not empty passwordError}">
                            <div class="error-message">${passwordError}</div>
                        </c:if>
                    </div>

                    <button type="submit" class="btn btn-primary w-100"><i class="fa-solid fa-user-plus me-2"></i>Register</button>
                    <div class="text-center mt-3">
                        <span class="form-text">Already have an account? <a href="${pageContext.request.contextPath}/path?page=login">Login</a></span>
                    </div>
                </form>
            </div>
            <div class="register-img"></div>
        </div>
    </body>
</html>
