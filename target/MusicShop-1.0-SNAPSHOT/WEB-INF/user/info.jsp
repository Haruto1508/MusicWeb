<%-- 
    Document   : info
    Created on : May 30, 2025, 3:43:11 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Set default gender value if null -->
<c:set var="genderValue" value="${not empty tempGender ? tempGender : user.gender.gender}" />
<c:if test="${not empty birthdateInputValue}">
    <c:set var="birthYear" value="${fn:substring(birthdateInputValue, 0, 4)}" />
    <fmt:parseNumber var="birthYearInt" integerOnly="true" value="${birthYear}" />
</c:if>

<div class="container">
    <h2 class="text-center fw-bold py-4 text-primary">User's Profile</h2>

    <div class="card-body">
        <div class="row">
            <!-- User Information Section (Left 9 columns) -->
            <div class="col-9">
                <!-- Form for updating user information -->
                <form id="userForm" action="${pageContext.request.contextPath}/updateUser" method="post">
                    <div class="form-row">
                        <!-- Account -->
                        <div class="info-row">
                            <label class="info-label">Account:</label>
                            <p class="info-value">${user.account}</p>
                            <input type="text" class="form-control d-none" name="account" id="accountInput"
                                   value="${not empty tempAccount ? tempAccount : user.account}">
                            <c:if test="${not empty accountError}">
                                <div class="text-danger small">${accountError}</div>
                            </c:if>
                        </div>

                        <!-- Full Name -->
                        <div class="info-row">
                            <label class="info-label">Full Name:</label>
                            <p class="info-value">${user.fullName}</p>
                            <input type="text" class="form-control d-none" name="fullName" id="nameInput"
                                   value="${not empty tempFullName ? tempFullName : user.fullName}">
                            <c:if test="${not empty fullNameError}">
                                <div class="text-danger small">${fullNameError}</div>
                            </c:if>
                        </div>

                        <!-- Email -->
                        <div class="info-row">
                            <label class="info-label">Email:</label>
                            <p class="info-value">${user.email}</p>
                            <input type="email" class="form-control d-none" name="email" id="emailInput"
                                   value="${not empty tempEmail ? tempEmail : user.email}">
                            <c:if test="${not empty emailError}">
                                <div class="text-danger small">${emailError}</div>
                            </c:if>
                        </div>

                        <!-- Phone -->
                        <div class="info-row">
                            <label class="info-label">Phone:</label>
                            <p class="info-value">${user.phone}</p>
                            <input type="text" class="form-control d-none" name="phone" id="phoneInput"
                                   value="${not empty tempPhone ? tempPhone : user.phone}">
                            <c:if test="${not empty phoneError}">
                                <div class="text-danger small">${phoneError}</div>
                            </c:if>
                        </div>

                        <!-- Gender -->
                        <div class="info-row">
                            <label class="info-label">Gender:</label>
                            <p class="info-value">${genderTextValue}</p>
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
                                <c:if test="${not empty genderError}">
                                    <div class="text-danger small">${genderError}</div>
                                </c:if>
                            </div>
                        </div>

                        <!-- Birthdate -->
                        <div class="info-row">
                            <label class="info-label">Birthdate:</label>
                            <p class="info-value" id="birthdateDisplay">${birthdateTextValue}</p>
                            <div class="d-none birthdate-inputs">
                                <select class="form-select" name="birth_day" id="birthDay">
                                    <option value="">Day</option>
                                    <c:forEach var="day" begin="1" end="31">
                                        <option value="${day}"
                                                <c:if test="${not empty birth_day ? birth_day == day : (not empty birthdateInputValue ? fn:substring(birthdateInputValue, 8, 10) * 1 == day : false)}">selected</c:if>>
                                            ${day}
                                        </option>
                                    </c:forEach>
                                </select>
                                <select class="form-select" name="birth_month" id="birthMonth">
                                    <option value="">Month</option>
                                    <c:forEach var="month" begin="1" end="12">
                                        <option value="${month}"
                                                <c:if test="${not empty birth_month ? birth_month == month : (not empty birthdateInputValue ? fn:substring(birthdateInputValue, 5, 7) * 1 == month : false)}">selected</c:if>>
                                            ${month}
                                        </option>
                                    </c:forEach>
                                </select>
                                <select class="form-select" name="birth_year" id="birthYear">
                                    <option value="">Year</option>
                                    <c:forEach var="year" begin="1900" end="${currentYear}">
                                        <option value="${year}"
                                                <c:if test="${not empty birth_year ? birth_year == year : (not empty birthdateInputValue ? fn:substring(birthdateInputValue, 0, 4) == year : false)}">selected</c:if>>
                                            ${year}
                                        </option>
                                    </c:forEach>
                                </select>
                                <c:if test="${not empty birthdateError}">
                                    <div class="text-danger small">${birthdateError}</div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- Buttons for user form -->
                    <div class="button-group">
                        <button type="button" class="btn btn-primary" id="editUserBtn">
                            <i class="fas fa-edit"></i> Edit Profile
                        </button>
                        <button type="submit" class="btn btn-success d-none" id="saveUserBtn">
                            <i class="fas fa-save"></i> Save Profile
                        </button>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </div>
                </form>
            </div>

            <!-- Avatar Section (Right 3 columns) -->
            <div class="col-3 avatar-section">
                <!-- Form for updating avatar -->
                <form id="avatarForm" action="${pageContext.request.contextPath}/avatar" method="post" enctype="multipart/form-data">
                    <label>Avatar:</label>
                    <div class="info-value text-center">
                        <c:choose>
                            <c:when test="${not empty user.imageUrl}">
                                <img src="${pageContext.request.contextPath}${user.imageUrl}?t=${System.currentTimeMillis()}"
                                     alt="Profile Picture" class="profile-img rounded-circle">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/assets/images/default-avatar.png"
                                     alt="Default Avatar" class="profile-img rounded-circle">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="edit-mode d-none">
                        <label for="avatarInput" class="custom-file-upload">
                            <i class="fas fa-upload"></i> Choose Image
                        </label>
                        <input type="file" class="form-control-file" name="avatar" id="avatarInput" accept="image/jpeg,image/png,image/gif">
                        <div id="avatarPreview" class="mt-2 d-none">
                            <img id="previewImage" src="#" alt="Avatar Preview" class="preview-img rounded-circle">
                        </div>
                        <div id="avatarErrorClient" class="error-message d-none"></div>
                        <c:if test="${not empty updateFail}">
                            <div class="error-message">${updateFail}</div>
                        </c:if>
                        <button type="submit" class="btn btn-success d-none mt-2" id="saveAvatarBtn">
                            <i class="fas fa-save"></i> Save Avatar
                        </button>
                    </div>
                    <div class="text-center mt-2">
                        <button type="button" class="btn btn-primary" id="editAvatarBtn">Edit Avatar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    window.addEventListener("DOMContentLoaded", function () {
        const editUserBtn = document.getElementById("editUserBtn");
        const saveUserBtn = document.getElementById("saveUserBtn");
        const userForm = document.getElementById("userForm");
        const editAvatarBtn = document.getElementById("editAvatarBtn");
        const saveAvatarBtn = document.getElementById("saveAvatarBtn");
        const avatarForm = document.getElementById("avatarForm");
        const avatarInput = document.getElementById("avatarInput");
        const avatarPreview = document.getElementById("avatarPreview");
        const previewImage = document.getElementById("previewImage");
        const avatarErrorClient = document.getElementById("avatarErrorClient");

        // Toggle edit mode for user form
        if (editUserBtn && saveUserBtn && userForm) {
            editUserBtn.addEventListener("click", function () {
                userForm.querySelectorAll(".info-value").forEach(el => el.classList.add("d-none"));
                userForm.querySelectorAll(".form-control, .gender-group, .birthdate-inputs").forEach(el => el.classList.remove("d-none"));
                editUserBtn.classList.add("d-none");
                saveUserBtn.classList.remove("d-none");
            });
        }

        // Toggle edit mode for avatar form
        if (editAvatarBtn && saveAvatarBtn && avatarForm) {
            editAvatarBtn.addEventListener("click", function () {
                avatarForm.querySelector(".info-value").classList.add("d-none");
                avatarForm.querySelector(".edit-mode").classList.remove("d-none");
                editAvatarBtn.classList.add("d-none");
                saveAvatarBtn.classList.remove("d-none");
            });
        }

        // Handle avatar preview
        if (avatarInput) {
            avatarInput.addEventListener("change", function (e) {
                const file = e.target.files[0];
                avatarErrorClient.classList.add("d-none");
                avatarPreview.classList.add("d-none");

                if (file) {
                    // Validate file format
                    const validTypes = ["image/jpeg", "image/png", "image/gif"];
                    if (!validTypes.includes(file.type)) {
                        avatarErrorClient.textContent = "Please select a valid image file (JPG, PNG, GIF).";
                        avatarErrorClient.classList.remove("d-none");
                        avatarInput.value = "";
                        return;
                    }
                    // Validate file size (max 5MB)
                    if (file.size > 5 * 1024 * 1024) {
                        avatarErrorClient.textContent = "Image size must be less than 5MB.";
                        avatarErrorClient.classList.remove("d-none");
                        avatarInput.value = "";
                        return;
                    }
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        previewImage.src = e.target.result;
                        avatarPreview.classList.remove("d-none");
                    };
                    reader.readAsDataURL(file);
                }
            });
        }

        // Validate avatar before form submission
        if (avatarForm) {
            avatarForm.addEventListener("submit", function (e) {
                const avatarInput = document.getElementById("avatarInput");
                const avatarErrorClient = document.getElementById("avatarErrorClient");

                if (!avatarInput.files[0]) {
                    e.preventDefault();
                    avatarErrorClient.textContent = "Please select an image file.";
                    avatarErrorClient.classList.remove("d-none");
                }
            });
        }

        // Auto-trigger edit mode if update fails
    <c:if test="${not empty updateFail}">
        editAvatarBtn.click();
    </c:if>
    <c:if test="${not empty updateFail}">
        editUserBtn.click();
    </c:if>
    });
</script>