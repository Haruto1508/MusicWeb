<%-- 
    Document   : profile
    Created on : May 30, 2025, 3:43:11 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.info.css"/>

<!-- Gán giá trị mặc định cho gender nếu null -->
<c:set var="genderValue" value="${not empty tempGender ? tempGender : user.gender.gender}" />
<c:if test="${not empty birthdateInputValue}">
    <c:set var="birthYear" value="${fn:substring(birthdateInputValue, 0, 4)}" />
    <fmt:parseNumber var="birthYearInt" integerOnly="true" value="${birthYear}" />
</c:if>

<div class="container">
    <h1 class="text-center fw-bold py-4">User Information</h1>

    <div class="card-body">
        <form id="userForm" action="${pageContext.request.contextPath}/updateUser" method="post">
            <!-- Account -->
            <div class="mb-3">
                <label class="info-label">Account:</label>
                <p class="info-value">${user.account}</p>
                <input type="text" class="form-control d-none" name="account" id="accountInput"
                       value="${not empty tempAccount ? tempAccount : user.account}">
                <div id="accountErrorClient" class="text-danger small d-none"></div>
                <c:if test="${not empty accountError}">
                    <div class="text-danger small">${accountError}</div>
                </c:if>
            </div>

            <!-- Full Name -->
            <div class="mb-3">
                <label class="info-label">Full Name</label>
                <p class="info-value">${user.fullName}</p>
                <input type="text" class="form-control d-none" name="fullName" id="nameInput"
                       value="${not empty tempFullName ? tempFullName : user.fullName}">
                <c:if test="${not empty fullNameError}">
                    <div class="text-danger small">${fullNameError}</div>
                </c:if>
            </div>

            <!-- Email -->
            <div class="mb-3">
                <label class="info-label">Email:</label>
                <p class="info-value">${user.email}</p>
                <input type="email" class="form-control d-none" name="email" id="emailInput"
                       value="${not empty tempEmail ? tempEmail : user.email}">
                <div id="emailErrorClient" class="text-danger small d-none"></div>
                <c:if test="${not empty emailError}">
                    <div class="text-danger small">${emailError}</div>
                </c:if>
            </div>

            <!-- Phone -->
            <div class="mb-3">
                <label class="info-label">Phone:</label>
                <p class="info-value">${user.phone}</p>
                <input type="text" class="form-control d-none" name="phone" id="phoneInput"
                       value="${not empty tempPhone ? tempPhone : user.phone}">

                <div id="phoneErrorClient" class="text-danger small d-none"></div>
                <c:if test="${not empty phoneError}">
                    <div class="text-danger small">${phoneError}</div>
                </c:if>
            </div>

            <!-- Gender -->
            <div class="mb-3">
                <label class="info-label">Gender:</label>
                <p class="info-value">${user.gender.label}</p>
                <div class="d-none gender-group">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="gender" id="genderMale" value="1"
                               <c:if test="${genderValue == 1}">checked</c:if> >
                               <label class="form-check-label" for="genderMale">Male</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" id="genderFemale" value="2"
                            <c:if test="${genderValue == 2}">checked</c:if> >
                            <label class="form-check-label" for="genderFemale">Female</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" id="genderOther" value="3"
                            <c:if test="${genderValue == 0}">checked</c:if> >
                            <label class="form-check-label" for="genderOther">Other</label>
                        </div>
                    </div>
                </div>

                <!-- Birthdate -->
                <div class="mb-3">
                    <label class="info-label">Birthdate:</label>
                    <p class="info-value" id="birthdateDisplay">${birthdateTextValue}</p>
                <div class="row d-none" id="birthdateInputs">
                    <div class="col-4">
                        <select class="form-select" name="birth_day" id="birthDay">
                            <option value="">Day</option>
                            <c:forEach var="day" begin="1" end="31">
                                <option value="${day}" 
                                        <c:if test="${fn:substring(birthdateInputValue,8,10) == day}">selected</c:if>>
                                    ${day}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-4">
                        <select class="form-select" name="birth_month" id="birthMonth">
                            <option value="">Month</option>
                            <c:forEach var="month" begin="1" end="12">
                                <option value="${month}" 
                                        <c:if test="${fn:substring(birthdateInputValue,5,7) == month}">selected</c:if>>
                                    ${month}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-4">
                        <select class="form-select" name="birth_year" id="birthYear">
                            <option value="">Year</option>
                            <c:forEach var="year" begin="1990" end="${currentYear}">
                                <option value="${year}" <c:if test="${fn:substring(birthdateInputValue,0,4) == year}">selected</c:if>>${year}</option>

                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Buttons -->
            <hr>
            <div class="text-center">
                <button type="button" class="btn btn-primary" id="editBtn">
                    <i class="fas fa-edit"></i> Edit
                </button>
                <button type="submit" class="btn btn-success d-none" id="saveBtn">
                    <i class="fas fa-save"></i> Save
                </button>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </form>
    </div>
</div>

<script>
window.addEventListener("DOMContentLoaded", function () {
    const editBtn = document.getElementById("editBtn");
    const saveBtn = document.getElementById("saveBtn");

    editBtn.addEventListener("click", function () {
        document.querySelectorAll(".info-value").forEach(el => el.classList.add("d-none"));
        document.querySelectorAll("input.form-control, .gender-group, select.form-select").forEach(el => el.classList.remove("d-none"));
        document.getElementById("birthdateDisplay").classList.add("d-none");
        document.getElementById("birthdateInputs").classList.remove("d-none");
        editBtn.classList.add("d-none");
        saveBtn.classList.remove("d-none");
    });

    // 👇 Gọi click nếu updateFail
    <c:if test="${not empty updateFail}">
        editBtn.click();
    </c:if>

    // Validate client khi submit form
    document.getElementById("userForm").addEventListener("submit", function (e) {
        let isValid = true;

        // Ẩn tất cả lỗi trước khi kiểm tra
        ["accountErrorClient", "fullNameErrorClient", "emailErrorClient", "phoneErrorClient", "genderErrorClient", "birthdateErrorClient"].forEach(id => {
            const el = document.getElementById(id);
            if (el) {
                el.textContent = "";
                el.classList.add("d-none");
            }
        });

        // Lấy giá trị các input
        const account = document.getElementById("accountInput").value.trim();
        const name = document.getElementById("nameInput").value.trim();
        const email = document.getElementById("emailInput").value.trim();
        const phone = document.getElementById("phoneInput").value.trim();
        const genderEls = document.getElementsByName("gender");
        const birthDay = document.getElementById("birthDay").value;
        const birthMonth = document.getElementById("birthMonth").value;
        const birthYear = document.getElementById("birthYear").value;

        // Kiểm tra account không được rỗng
        if (!account) {
            const el = document.getElementById("accountErrorClient");
            el.textContent = "Account is required";
            el.classList.remove("d-none");
            isValid = false;
        }

        // Kiểm tra full name không rỗng
        if (!name) {
            const el = document.getElementById("fullNameErrorClient");
            el.textContent = "Full name is required";
            el.classList.remove("d-none");
            isValid = false;
        }

        // Kiểm tra email hợp lệ
        const emailPattern = /^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$/;
        if (!email) {
            const el = document.getElementById("emailErrorClient");
            el.textContent = "Email is required";
            el.classList.remove("d-none");
            isValid = false;
        } else if (!emailPattern.test(email)) {
            const el = document.getElementById("emailErrorClient");
            el.textContent = "Invalid email address";
            el.classList.remove("d-none");
            isValid = false;
        }

        // Kiểm tra phone, nếu có thì phải đúng định dạng 10 hoặc 11 chữ số
        const phonePattern = /^\d{10,11}$/;
        if (phone && !phonePattern.test(phone)) {
            const el = document.getElementById("phoneErrorClient");
            el.textContent = "Phone must be 10 or 11 digits";
            el.classList.remove("d-none");
            isValid = false;
        }

        // Kiểm tra gender đã chọn
        let genderChecked = false;
        for (let i = 0; i < genderEls.length; i++) {
            if (genderEls[i].checked) {
                genderChecked = true;
                break;
            }
        }
        if (!genderChecked) {
            let el = document.getElementById("genderErrorClient");
            if (!el) {
                // Nếu chưa có thẻ báo lỗi gender, tạo mới
                const genderGroup = document.querySelector(".gender-group");
                el = document.createElement("div");
                el.id = "genderErrorClient";
                el.classList.add("text-danger", "small");
                genderGroup.appendChild(el);
            }
            el.textContent = "Please select a gender";
            el.classList.remove("d-none");
            isValid = false;
        }

        // Kiểm tra ngày sinh hợp lệ: tất cả hoặc không chọn
        if ((birthDay || birthMonth || birthYear) && !(birthDay && birthMonth && birthYear)) {
            let el = document.getElementById("birthdateErrorClient");
            if (!el) {
                const birthdateInputs = document.getElementById("birthdateInputs");
                el = document.createElement("div");
                el.id = "birthdateErrorClient";
                el.classList.add("text-danger", "small", "mt-1");
                birthdateInputs.appendChild(el);
            }
            el.textContent = "Please select complete birthdate (day, month, year)";
            el.classList.remove("d-none");
            isValid = false;
        } else if (birthDay && birthMonth && birthYear) {
            // Kiểm tra ngày hợp lệ (ví dụ 31/02 không hợp lệ)
            const dateStr = `${birthYear}-${birthMonth.padStart(2, '0')}-${birthDay.padStart(2, '0')}`;
            const dateObj = new Date(dateStr);
            if (dateObj.getFullYear() != birthYear || (dateObj.getMonth() + 1) != birthMonth || dateObj.getDate() != birthDay) {
                let el = document.getElementById("birthdateErrorClient");
                if (!el) {
                    const birthdateInputs = document.getElementById("birthdateInputs");
                    el = document.createElement("div");
                    el.id = "birthdateErrorClient";
                    el.classList.add("text-danger", "small", "mt-1");
                    birthdateInputs.appendChild(el);
                }
                el.textContent = "Invalid birthdate";
                el.classList.remove("d-none");
                isValid = false;
            }
        }

        if (!isValid) {
            e.preventDefault();
        }
    });
});
</script>
