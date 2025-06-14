<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row">
    <div class="col-md-8">
        <div class="card">
            <h1 class="text-center fw-bold py-4">Thông tin</h1>
            <div class="card-body">
                <form id="userForm" action="${pageContext.request.contextPath}/account" method="post">
                    <input type="hidden" name="action" value="updateInfo">

                    <div class="mb-3">
                        <label class="info-label">Tên tài khoản:</label>
                        <p class="info-value">${user.account}</p>
                    </div>

                    <div class="mb-3">
                        <label class="info-label">Tên người dùng:</label>
                        <p class="info-value" id="nameDisplay">${user.fullName}</p>
                        <input type="text" class="form-control d-none" name="fullName" id="nameInput" value="${user.fullName}">
                    </div>

                    <div class="mb-3">
                        <label class="info-label">Email:</label>
                        <p class="info-value" id="emailDisplay">${user.email}</p>
                        <input type="email" class="form-control d-none" name="email" id="emailInput" value="${user.email}">
                    </div>

                    <div class="mb-3">
                        <label class="info-label">Số điện thoại:</label>
                        <p class="info-value" id="phoneDisplay">${user.phone}</p>
                        <input type="text" class="form-control d-none" name="phone" id="phoneInput" value="${user.phone}">
                    </div>

                    <div class="mb-3">
                        <label class="info-label">Giới tính:</label>
                        <p class="info-value" id="genderDisplay">${user.gender}</p>
                        <input type="text" class="form-control d-none" name="gender" id="genderInput" value="${user.gender}">
                    </div>

                    <div class="mb-3">
                        <label class="info-label">Ngày sinh</label>
                        <p class="info-value">
                            <fmt:formatDate value="${birthdateSql}" pattern="dd/MM/yyyy"/>
                        </p>
                        <input type="date" class="form-control" name="birthdate" value="<fmt:formatDate value='${birthdateSql}' pattern='yyyy-MM-dd'/>">
                    </div>

                    <hr>
                    <div class="text-center">
                        <button type="button" class="btn btn-primary" id="editBtn"><i class="fas fa-edit"></i> Chỉnh sửa</button>
                        <button type="submit" class="btn btn-success d-none" id="saveBtn"><i class="fas fa-save"></i> Lưu thay đổi</button>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById("editBtn").addEventListener("click", function () {
        // Ẩn các <p> và hiện <input>
        document.querySelectorAll(".info-value").forEach(el => el.classList.add("d-none"));
        document.querySelectorAll("input.form-control").forEach(el => el.classList.remove("d-none"));

        // Ẩn nút Edit, hiện nút Save
        document.getElementById("editBtn").classList.add("d-none");
        document.getElementById("saveBtn").classList.remove("d-none");
    });
</script>
