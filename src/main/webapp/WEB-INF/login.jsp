<%-- 
    Document   : login
    Created on : May 17, 2025, 4:41:02 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login - MusicShop</title>
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
            .login-container {
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
            .login-img {
                background: url('https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=600&q=80') center/cover no-repeat;
                width: 380px;
                min-height: 440px;
                display: none;
            }
            @media (min-width: 992px) {
                .login-container {
                    max-width: 900px;
                    flex-direction: row;
                }
                .login-img {
                    display: block;
                }
            }
            @media (max-width: 991.98px) {
                .login-container {
                    flex-direction: column;
                    max-width: 98vw;
                }
                .login-img {
                    display: none;
                }
            }
            .login-box {
                flex: 1;
                padding: 2.5rem 2rem;
                display: flex;
                flex-direction: column;
                justify-content: center;
                min-width: 0;
            }
            @media (max-width: 575.98px) {
                .login-box {
                    padding: 1.5rem 0.5rem;
                }
            }
            .login-logo {
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
            .form-text {
                font-size: 0.95rem;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="login-box">
                <div class="login-logo">
                    <i class="fa-solid fa-music"></i> MusicShop
                </div>
                <!-- Hiển thị thông báo lỗi -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger mt-3">
                        ${error}
                    </div>
                </c:if>

                <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label">Tên đăng nhập</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                            <input type="text" class="form-control" id="username" name="info" value="${not empty info ? info : ''}" placeholder="Nhập tên đăng nhập" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Mật khẩu</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required>
                        </div>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="rememberMe">
                        <label class="form-check-label" for="rememberMe">Ghi nhớ đăng nhập</label>
                    </div>
                    <button type="submit" class="btn btn-primary w-100"><i class="fa-solid fa-arrow-right-to-bracket me-2"></i>Đăng nhập</button>
                    <div class="text-center mt-3">
                        <span class="form-text">Chưa có tài khoản? <a href="${pageContext.request.contextPath}/path?page=register ">Đăng ký</a></span>
                    </div>
                </form>
            </div>
            <div class="login-img"></div>
        </div>
    </body>
</html>