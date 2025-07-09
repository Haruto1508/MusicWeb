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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
<style>
    .form-container {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    padding: 2rem;
    max-width: 800px;
    margin: 0 auto;
}
.form-horizontal .form-group {
    margin-bottom: 1.8rem;
    align-items: center;
}
.form-horizontal label {
    font-weight: 600;
    color: #2c3e50;
    font-size: 1.1rem;
    text-align: right;
    padding-right: 1rem;
}
.info-value {
    margin-bottom: 0;
    color: #34495e;
    font-size: 1rem;
    line-height: 1.5;
}
.form-control, .form-select {
    border: 1px solid #ced4da;
    border-radius: 5px;
    padding: 0.5rem 0.75rem;
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
}
.form-control:focus, .form-select:focus {
    border-color: #007bff;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
    outline: none;
}
.gender-group .form-check {
    margin-right: 1.5rem;
    margin-top: 0.5rem;
}
.gender-group .form-check-input {
    cursor: pointer;
}
.gender-group .form-check-label {
    color: #34495e;
    font-size: 0.95rem;
}
.birthdate-selects .form-select {
    padding: 0.5rem 0.75rem;
}
.error-message {
    font-size: 0.85rem;
    color: #dc3545;
    margin-top: 0.3rem;
}
.btn-custom {
    padding: 0.6rem 1.8rem;
    font-size: 1rem;
    font-weight: 500;
    border-radius: 8px;
    border: none;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}
.btn-custom i {
    margin-right: 0.5rem;
}
.btn-primary-custom {
    background: linear-gradient(135deg, #007bff, #0056b3);
    color: #fff;
}
.btn-primary-custom:hover {
    background: linear-gradient(135deg, #0056b3, #003d80);
    transform: scale(1.05);
    box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
}
.btn-success-custom {
    background: linear-gradient(135deg, #28a745, #1e7e34);
    color: #fff;
}
.btn-success-custom:hover {
    background: linear-gradient(135deg, #1e7e34, #166429);
    transform: scale(1.05);
    box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
}
.btn-danger-custom {
    background: linear-gradient(135deg, #dc3545, #b02a37);
    color: #fff;
}
.btn-danger-custom:hover {
    background: linear-gradient(135deg, #b02a37, #8b232f);
    transform: scale(1.05);
    box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
}
.btn-container {
    display: flex;
    justify-content: center;
    gap: 1.5rem;
    margin-top: 2.5rem;
}
</style>
<!-- Gán giá trị mặc định cho gender nếu null -->
<c:set var="genderValue" value="${not empty sessionScope.tempGender ? sessionScope.tempGender : user.gender.gender}" />

<div class="container form-container">
    <h1 class="text-center fw-bold py-4" style="color: #2c3e50;">User Information</h1>
    <c:if test="${not empty sessionScope.updateSuccess}">
        <div class="alert alert-success">${sessionScope.updateSuccess}</div>
    </c:if>
    <c:if test="${not empty sessionScope.updateFail}">
        <div class="alert alert-danger">${sessionScope.updateFail}</div>
    </c:if>

    <div class="card-body">
        <form id="userForm" action="${pageContext.request.contextPath}/updateUser" method="post" class="form-horizontal">
            <!-- Account -->
            <div class="form-group row">
                <label class="col-sm-3 col-form-label">Account:</label>
                <div class="col-sm-9">
                    <p class="info-value">${user.account}</p>
                    <input type="text" class="form-control d-none" name="account" id="accountInput"
                           value="${not empty sessionScope.tempAccount ? sessionScope.tempAccount : user.account}">
                    <c:if test="${not empty sessionScope.accountError}">
                        <div class="text-danger error-message">${sessionScope.accountError}</div>
                    </c:if>
                </div>
            </div>

            <!-- Full Name -->
            <div class="form-group row">
                <label class="col-sm-3 col-form-label">Full Name:</label>
                <div class="col-sm-9">
                    <p class="info-value">${user.fullName}</p>
                    <input type="text" class="form-control d-none" name="fullName" id="nameInput"
                           value="${not empty sessionScope.tempFullName ? sessionScope.tempFullName : user.fullName}">
                    <c:if test="${not empty sessionScope.fullNameError}">
                        <div class="text-danger error-message">${sessionScope.fullNameError}</div>
                    </c:if>
                </div>
            </div>

            <!-- Email -->
            <div class="form-group row">
                <label class="col-sm-3 col-form-label">Email:</label>
                <div class="col-sm-9">
                    <p class="info-value">${user.email}</p>
                    <input type="email" class="form-control d-none" name="email" id="emailInput"
                           value="${not empty sessionScope.tempEmail ? sessionScope.tempEmail : user.email}">
                    <c:if test="${not empty sessionScope.emailError}">
                        <div class="text-danger error-message">${sessionScope.emailError}</div>
                    </c:if>
                </div>
            </div>

            <!-- Phone -->
            <div class="form-group row">
                <label class="col-sm-3 col-form-label">Phone:</label>
                <div class="col-sm-9">
                    <p class="info-value">${user.phone}</p>
                    <input type="text" class="form-control d-none" name="phone" id="phoneInput"
                           value="${not empty sessionScope.tempPhone ? sessionScope.tempPhone : user.phone}">
                    <c:if test="${not empty sessionScope.phoneError}">
                        <div class="text-danger error-message">${sessionScope.phoneError}</div>
                    </c:if>
                </div>
            </div>

            <!-- Gender -->
            <div class="form-group row">
                <label class="col-sm-3 col-form-label">Gender:</label>
                <div class="col-sm-9">
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
                                   <c:if test="${genderValue == 3}">checked</c:if> >
                            <label class="form-check-label" for="genderOther">Other</label>
                        </div>
                        <c:if test="${not empty sessionScope.genderError}">
                            <div class="text-danger error-message">${sessionScope.genderError}</div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Birthdate -->
            <div class="form-group row">
                <label class="col-sm-3 col-form-label">Birthdate:</label>
                <div class="col-sm-9">
                    <p class="info-value" id="birthdateDisplay">${sessionScope.birthdateTextValue}</p>
                    <div class="row d-none birthdate-selects" id="birthdateInputs">
                        <div class="col-4">
                            <select class="form-select" name="birth_day" id="birthDay">
                                <option value="">Day</option>
                                <c:forEach var="day" begin="1" end="31">
                                    <option value="${day}" 
                                            <c:if test="${not empty sessionScope.birth_day ? sessionScope.birth_day == day : fn:substring(sessionScope.birthdateInputValue,8,10) == day}">selected</c:if>>
                                        ${day}
                                    </option>
                                </c:forEach>
                            </select>
                            <c:if test="${not empty sessionScope.birthdateDayError}">
                                <div class="text-danger error-message">${sessionScope.birthdateDayError}</div>
                            </c:if>
                        </div>
                        <div class="col-4">
                            <select class="form-select" name="birth_month" id="birthMonth">
                                <option value="">Month</option>
                                <c:forEach var="month" begin="1" end="12">
                                    <option value="${month}" 
                                            <c:if test="${not empty sessionScope.birth_month ? sessionScope.birth_month == month : fn:substring(sessionScope.birthdateInputValue,5,7) == month}">selected</c:if>>
                                        ${month}
                                    </option>
                                </c:forEach>
                            </select>
                            <c:if test="${not empty sessionScope.birthdateMonthError}">
                                <div class="text-danger error-message">${sessionScope.birthdateMonthError}</div>
                            </c:if>
                        </div>
                        <div class="col-4">
                            <select class="form-select" name="birth_year" id="birthYear">
                                <option value="">Year</option>
                                <c:forEach var="year" begin="1900" end="${sessionScope.currentYear}">
                                    <option value="${year}" 
                                            <c:if test="${not empty sessionScope.birth_year ? sessionScope.birth_year == year : fn:substring(sessionScope.birthdateInputValue,0,4) == year}">selected</c:if>>
                                        ${year}
                                    </option>
                                </c:forEach>
                            </select>
                            <c:if test="${not empty sessionScope.birthdateYearError}">
                                <div class="text-danger error-message">${sessionScope.birthdateYearError}</div>
                            </c:if>
                        </div>
                        <c:if test="${not empty sessionScope.birthdateError}">
                            <div class="text-danger error-message col-12 mt-1">${sessionScope.birthdateError}</div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Buttons -->
            <div class="btn-container">
                <button type="button" class="btn btn-primary-custom btn-custom" id="editBtn">
                    <i class="fas fa-edit"></i> Edit
                </button>
                <button type="submit" class="btn btn-success-custom btn-custom d-none" id="saveBtn">
                    <i class="fas fa-save"></i> Save
                </button>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger-custom btn-custom">
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
    const userForm = document.getElementById("userForm");

    // Log để kiểm tra các phần tử
    console.log("Elements:", {
        editBtn: editBtn,
        saveBtn: saveBtn,
        userForm: userForm
    });

    if (!userForm) {
        console.error("Form element not found");
        return;
    }
    if (!editBtn || !saveBtn) {
        console.error("Edit or Save button not found");
        return;
    }

    // Chuyển sang chế độ chỉnh sửa khi nhấp vào nút Edit
    editBtn.addEventListener("click", function () {
        console.log("Edit button clicked");
        document.querySelectorAll(".info-value").forEach(el => el.classList.add("d-none"));
        document.querySelectorAll("input.form-control, .gender-group, select.form-select").forEach(el => el.classList.remove("d-none"));
        document.getElementById("birthdateDisplay").classList.add("d-none");
        document.getElementById("birthdateInputs").classList.remove("d-none");
        editBtn.classList.add("d-none");
        saveBtn.classList.remove("d-none");
    });

    // Tự động kích hoạt chế độ chỉnh sửa nếu có updateFail
    <c:if test="${not empty sessionScope.updateFail}">
        console.log("Auto-triggering edit mode due to updateFail");
        editBtn.click();
    </c:if>

    // Log khi form được gửi
    userForm.addEventListener("submit", function (e) {
        console.log("Form submit event triggered");
        const birthDayEl = document.getElementById("birthDay");
        const birthMonthEl = document.getElementById("birthMonth");
        const birthYearEl = document.getElementById("birthYear");
        const birthDay = birthDayEl ? birthDayEl.value : "";
        const birthMonth = birthMonthEl ? birthMonthEl.value : "";
        const birthYear = birthYearEl ? birthYearEl.value : "";
        console.log("Form submitted with values:", { birthDay, birthMonth, birthYear });
    });
});
</script>