<%-- 
    Document   : passwordChange
    Created on : Jun 21, 2025, 2:50:52 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.changePassword.css"/>

<div class="change-password-container">
    <div class="icon-lock">
        <i class="fa fa-lock"></i>
    </div>
    <h2 class="mb-4 text-center mt-4" style="color:#8b5cf6;">Đổi mật khẩu</h2>

    <form id="changePasswordForm" action="change-password" method="post">
        <div class="mb-3">
            <label for="oldPw" class="form-label">Mật khẩu hiện tại</label>
            <input type="password" class="form-control" id="oldPw" name="oldPw" placeholder="Nhập mật khẩu hiện tại" required>
            <c:if test="${not empty oldPwError}">
                <div class="text-danger mt-1">${oldPwError}</div>
            </c:if>
        </div>

        <div class="mb-3">
            <label for="newPw" class="form-label">Mật khẩu mới</label>
            <input type="password" class="form-control" id="newPw" name="newPw" placeholder="Nhập mật khẩu mới" required>
            <c:if test="${not empty newPwError}">
                <div class="text-danger mt-1">${newPwError}</div>
            </c:if>
        </div>

        <div class="mb-3">
            <label for="confirmPw" class="form-label">Xác nhận mật khẩu mới</label>
            <input type="password" class="form-control" id="confirmPw" name="confirmPw" placeholder="Nhập lại mật khẩu mới" required>
            <c:if test="${not empty confirmPwError}">
                <div class="text-danger mt-1">${confirmPwError}</div>
            </c:if>
        </div>

        <button type="submit" class="btn btn-primary w-100 mt-2">Đổi mật khẩu</button>
    </form>
</div>