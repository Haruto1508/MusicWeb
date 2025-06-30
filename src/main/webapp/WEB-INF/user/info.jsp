<%-- 
    Document   : profile
    Created on : May 30, 2025, 3:43:11 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.info.css"/>

<!-- Gán giá trị mặc định cho gender nếu null -->
<c:set var="genderValue" value="${empty user.gender ? 'Khác' : user.gender}" />

<div class="container">
    <h1 class="text-center fw-bold py-4">Thông tin</h1>
    <div class="card-body">
        <form id="userForm" action="${pageContext.request.contextPath}/updateUser" method="post">
            <!-- Tài khoản -->
            <div class="mb-3">
                <label class="info-label">Tên tài khoản:</label>
                <p class="info-value">${user.account}</p>
                <input type="text" class="form-control d-none" name="account" id="accountInput" value="${user.account}">
                <c:if test="${not empty accountError}">
                    <div id="usernameError" class="error-message">${accountError}</div>
                </c:if>
            </div>

            <!-- Họ tên -->
            <div class="mb-3">
                <label class="info-label">Tên người dùng:</label>
                <p class="info-value" id="nameDisplay">${user.fullName}</p>
                <input type="text" class="form-control d-none" name="fullName" id="nameInput" value="${user.fullName}">
            </div>

            <!-- Email -->
            <div class="mb-3">
                <label class="info-label">Email:</label>
                <p class="info-value" id="emailDisplay">${user.email}</p>
                <input type="email" class="form-control d-none" name="email" id="emailInput" value="${user.email}">
                <c:if test="${not empty emailError}">
                    <div id="emailError" class="error-message">${emailError}</div>
                </c:if>
            </div>

            <!-- Số điện thoại -->
            <div class="mb-3">
                <label class="info-label">Số điện thoại:</label>
                <p class="info-value" id="phoneDisplay">${user.phone}</p>
                <input type="text" class="form-control d-none" name="phone" id="phoneInput" value="${user.phone}">
                <c:if test="${not empty phoneError}">
                    <div id="phoneError" class="error-message">${phoneError}</div>
                </c:if>
            </div>

            <!-- Giới tính -->
            <div class="mb-3">
                <label class="info-label">Giới tính:</label>
                <p class="info-value" id="genderDisplay">${genderValue}</p>

                <div class="d-none gender-group">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="gender" id="genderMale" value="Nam"
                               <c:if test="${genderValue eq 'Nam'}">checked</c:if>>
                               <label class="form-check-label" for="genderMale">Nam</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" id="genderFemale" value="Nữ"
                            <c:if test="${genderValue eq 'Nữ'}">checked</c:if>>
                            <label class="form-check-label" for="genderFemale">Nữ</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" id="genderOther" value="Khác"
                            <c:if test="${genderValue ne 'Nam' and genderValue ne 'Nữ'}">checked</c:if>>
                            <label class="form-check-label" for="genderOther">Khác</label>
                        </div>
                    </div>  
                </div>

                <!-- Ngày sinh -->
                <div class="mb-3">
                    <label class="info-label">Ngày sinh</label>
                    <p class="info-value" id="birthdateDisplay" data-birthdate="${birthdateInputValue}">${birthdateTextValue}</p>
                <div class="row d-none" id="birthdateInputs">
                    <div class="col-4">
                        <select class="form-select" name="birth_day" id="birthDay">
                            <option value="">Ngày</option>
                            <c:forEach var="day" begin="1" end="31">
                                <option value="${day}" 
                                        <c:if test="${not empty birthdateInputValue and day == fn:substring(birthdateInputValue, 8, 10)}">selected</c:if>>
                                    ${day}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-4">
                        <select class="form-select" name="birth_month" id="birthMonth">
                            <option value="">Tháng</option>
                            <c:forEach var="month" begin="1" end="12">
                                <option value="${month}" 
                                        <c:if test="${not empty birthdateInputValue and month == fn:substring(birthdateInputValue, 5, 7)}">selected</c:if>>
                                    ${month}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-4">
                        <select class="form-select" name="birth_year" id="birthYear">
                            <option value="">Năm</option>
                            <c:forEach var="year" begin="1900" end="${currentYear}">
                                <option value="${year}" 
                                        <c:if test="${not empty birthdateInputValue and year == fn:substring(birthdateInputValue, 0, 4)}">selected</c:if>>
                                    ${year}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Nút điều khiển -->
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

<div>
    <div>
        <img src="src" alt="alt"/>
    </div>
    <input type="url" name="avatarUrl">
    <button><a href=""></a></button>
</div>

<!-- Script để chuyển sang chế độ chỉnh sửa -->
<script>
    const editBtn = document.getElementById("editBtn");
    const saveBtn = document.getElementById("saveBtn");

    editBtn.addEventListener("click", function () {
        // Ẩn p và hiện các input thông thường
        document.querySelectorAll(".info-value").forEach(el => el.classList.add("d-none"));
        document.querySelectorAll("input.form-control, .gender-group, select.form-select").forEach(el => el.classList.remove("d-none"));

        // Ẩn hiển thị birthdate text, hiện select
        document.getElementById("birthdateDisplay").classList.add("d-none");
        document.getElementById("birthdateInputs").classList.remove("d-none");

        // Ẩn/hiện nút
        editBtn.classList.add("d-none");
        saveBtn.classList.remove("d-none");
    });
</script>