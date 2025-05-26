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
                .register-container {
                    max-width: 900px;
                    flex-direction: row;
                }
                .register-img {
                    display: block;
                }
            }
            @media (max-width: 991.98px) {
                .register-container {
                    flex-direction: column;
                    max-width: 98vw;
                }
                .register-img {
                    display: none;
                }
            }
            .register-box {
                flex: 1;
                padding: 2.5rem 2rem;
                display: flex;
                flex-direction: column;
                justify-content: center;
                min-width: 0;
            }
            @media (max-width: 575.98px) {
                .register-box {
                    padding: 1.5rem 0.5rem;
                }
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
            .form-text {
                font-size: 0.95rem;
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
                <!-- Hiển thị thông báo lỗi -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger mt-3">
                        ${error}
                    </div>
                </c:if>
                <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post">
                    <div class="mb-3">
                        <label for="fullname" class="form-label">FullName</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                            <input type="text" class="form-control" id="fullname" name="full_name" placeholder="Enter fullname" pattern="^[a-zA-Z\s]{3,}$" title="Họ và tên phải có ít nhất 3 ký tự và chỉ chứa chữ cái và khoảng trắng" required>
                        </div>
                        <div id="fullnameError" class="error-message"></div>
                    </div>
                    <div class="mb-3">
                        <label for="username" class="form-label">Account</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-regular fa-user"></i></span>
                            <input type="text" class="form-control" id="username" name="userName" placeholder="Enter account" pattern="^[a-zA-Z0-9_]{3,20}$" title="Tên đăng nhập phải từ 3-20 ký tự, chỉ chứa chữ cái, số và dấu gạch dưới" required>
                        </div>
                        <div id="usernameHelp" class="form-text">Account is unique.</div>
                        <div id="usernameError" class="error-message"></div>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" title="Nhập đúng định dạng email (ví dụ: example@domain.com)">
                        </div>
                        <div id="emailError" class="error-message"></div>
                    </div>
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
                            <input type="tel" class="form-control" id="phone" name="phone" placeholder="Enter phone" pattern="^0[0-9]{9,10}$" title="Số điện thoại phải bắt đầu bằng số 0 và có 10-11 chữ số">
                        </div>
                        <div id="phoneError" class="error-message"></div>
                    </div>
                    <div class="mb-3">
                        <label for="address" class="form-label">Address</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span>
                            <input type="text" class="form-control" id="address" name="address" placeholder="Enter address">
                        </div>
                        <div id="addressError" class="error-message"></div>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" title="Mật khẩu phải có ít nhất 8 ký tự, bao gồm cả chữ và số" required>
                        </div>
                        <div id="passwordError" class="error-message"></div>
                    </div>
                    <button type="submit" class="btn btn-primary w-100" disabled><i class="fa-solid fa-user-plus me-2"></i>Register</button>
                    <div class="text-center mt-3">
                        <span class="form-text">Already have an account? <a href="${pageContext.request.contextPath}/WEB-INF/login.jsp">Login</a></span>
                    </div>
                </form>
            </div>
            <div class="register-img"></div>
        </div>
        <script>
            const registerForm = document.getElementById('registerForm');
            const submitButton = registerForm.querySelector('button[type="submit"]');

            // Hàm kiểm tra và hiển thị lỗi
            function validateField(fieldId, pattern, errorMessageId, errorMessage) {
                const input = document.getElementById(fieldId);
                const errorDiv = document.getElementById(errorMessageId);

                input.addEventListener('input', function () {
                    if (!input.value.match(pattern)) {
                        errorDiv.textContent = errorMessage;
                        input.classList.add('is-invalid'); // Thêm class báo lỗi cho input
                    } else {
                        errorDiv.textContent = '';
                        input.classList.remove('is-invalid'); // Xóa class báo lỗi
                    }
                    updateSubmitButtonState(); // Cập nhật trạng thái nút submit
                });
            }

            validateField('fullname', /^[a-zA-Z\s]{3,}$/, 'fullnameError', 'Họ và tên phải có ít nhất 3 ký tự và chỉ chứa chữ cái và khoảng trắng');
            validateField('username', /^[a-zA-Z0-9_]{3,20}$/, 'usernameError', 'Tên đăng nhập phải từ 3-20 ký tự, chỉ chứa chữ cái, số và dấu gạch dưới');
            validateField('email', /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/, 'emailError', 'Nhập đúng định dạng email (ví dụ: example@domain.com)');
            validateField('phone', /^0[0-9]{9,10}$/, 'phoneError', 'Số điện thoại phải bắt đầu bằng số 0 và có 10-11 chữ số');
            validateField('password', /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/, 'passwordError', 'Mật khẩu phải có ít nhất 8 ký tự, bao gồm cả chữ và số');

            // Hàm kiểm tra xem tất cả các trường đã hợp lệ hay chưa
            function areAllFieldsValid() {
                const invalidInputs = registerForm.querySelectorAll('.is-invalid');
                return invalidInputs.length === 0; // Trả về true nếu không có input nào có class 'is-invalid'
            }
        </script>
    </body>
</html>