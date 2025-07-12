<%-- 
    Document   : address
    Created on : May 30, 2025, 15:01:39 AM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/choices.js/public/assets/styles/choices.min.css">
<!-- Address Section -->
<div class="address-container">
    <!-- Header -->
    <div class="text-center mb-4">
        <h2 class="text-primary fw-bold">
            My Addresses
        </h2>
    </div>
    <!-- Address List -->
    <div class="row g-4">
        <c:choose>
            <c:when test="${not empty addresses}">
                <c:forEach var="address" items="${addresses}">
                    <div class="col-12">
                        <div class="card address-card shadow-sm border-0 rounded-4 p-3">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h5 class="fw-semibold mb-1 text-dark">
                                        <i class="fas fa-user text-primary me-2"></i>
                                        ${address.receiverName}
                                        <c:if test="${address.isDefault}">
                                            <span class="badge bg-success ms-2">Default</span>
                                        </c:if>
                                    </h5>
                                    <span class="badge bg-info text-dark">${address.type}</span>
                                </div>
                                <div class="btn-group">
                                    <button class="btn btn-outline-primary btn-sm" 
                                            onclick="openAddressModal('edit', ${address.addressId}, '${address.receiverName.replace("'", "\\'")}', '${address.receiverPhone}', '${address.street.replace("'", "\\'")}', '${address.ward != null ? address.ward.replace("'", "\\'") : ''}', '${address.district != null ? address.district.replace("'", "\\'") : ''}', '${address.city.replace("'", "\\'")}', ${address.isDefault})"
                                            data-bs-toggle="modal" data-bs-target="#addressModal">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <form method="post" action="${pageContext.request.contextPath}/address">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="addressId" value="${address.addressId}">
                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this address?')">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <p class="mb-1"><i class="fas fa-phone text-success me-2"></i><strong>Phone: </strong> ${address.receiverPhone}</p>
                                <p class="mb-1"><i class="fas fa-map-marker-alt text-danger me-2"></i><strong>Address: </strong> ${address.getFullAddress()}</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="card address-card shadow text-center mt-5 py-5 w-100">
                    <i class="fas fa-map-marker-alt fa-3x text-muted mb-3"></i>
                    <h5 class="text-muted">No Addresses Found</h5>
                    <p class="text-muted">You have not added any addresses yet.</p>
                </div>
            </c:otherwise>
        </c:choose>
        <!-- Add Address Button -->
        <div class="text-center mt-5">
            <button type="button" class="btn btn-primary" onclick="openAddressModal('add')" data-bs-toggle="modal" data-bs-target="#addressModal">
                <i class="fas fa-plus me-2"></i> Add New Address
            </button>
        </div>
    </div>

    <!-- Address Modal -->
    <div class="modal fade" id="addressModal" tabindex="-1" aria-labelledby="addressModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="addressForm" method="post" action="${pageContext.request.contextPath}/address">
                    <input type="hidden" name="action" id="formAction" value="add">
                    <input type="hidden" name="addressId" id="addressId" value="${editAddressId != null ? editAddressId : ''}">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addressModalLabel">${updateFail != null ? 'Edit Address' : 'Add New Address'}</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3 align-items-center">
                            <label for="receiverName" class="col-sm-4 col-form-label text-end">Full Name <span class="text-danger">*</span></label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="Enter full name" value="${receiverName != null ? receiverName : ''}">
                                <div class="invalid-feedback" id="nameError">${nameError != null ? nameError : ''}</div>
                            </div>
                        </div>
                        <div class="row mb-3 align-items-center">
                            <label for="receiverPhone" class="col-sm-4 col-form-label text-end">Phone Number <span class="text-danger">*</span></label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="Enter phone number" value="${receiverPhone != null ? receiverPhone : ''}">
                                <div class="invalid-feedback" id="phoneError">${phoneError != null ? phoneError : ''}</div>
                            </div>
                        </div>
                        <div class="row mb-3 align-items-center">
                            <label for="street" class="col-sm-4 col-form-label text-end">Street & House No. <span class="text-danger">*</span></label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="street" name="street" placeholder="e.g., 123 ABC Street" value="${street != null ? street : ''}">
                                <div class="invalid-feedback" id="streetError">${streetError != null ? streetError : ''}</div>
                            </div>
                        </div>
                        <div class="row mb-3 align-items-center">
                            <label for="ward" class="col-sm-4 col-form-label text-end">Ward/Commune</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="ward" name="ward" value="${ward != null ? ward : ''}">
                                <div class="invalid-feedback" id="wardError">${wardError != null ? wardError : ''}</div>
                            </div>
                        </div>
                        <div class="row mb-3 align-items-center">
                            <label for="district" class="col-sm-4 col-form-label text-end">District</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="district" name="district" value="${district != null ? district : ''}">
                                <div class="invalid-feedback" id="districtError">${districtError != null ? districtError : ''}</div>
                            </div>
                        </div>
                        <div class="row mb-3 align-items-center">
                            <label for="city" class="col-sm-4 col-form-label text-end">City/Province <span class="text-danger">*</span></label>
                            <div class="col-sm-8">
                                <select id="city" name="city" class="form-select" required>
                                    <option value="" disabled ${city == null ? 'selected' : ''}>-- Select City/Province --</option>
                                </select>
                                <div class="invalid-feedback" id="cityError">${cityError != null ? cityError : ''}</div>
                            </div>
                        </div>
                        <div class="row mb-3 align-items-center">
                            <label class="col-sm-4 col-form-label text-end">Set as Default Address?</label>
                            <div class="col-sm-8">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="isDefault" name="isDefault" value="true" ${isDefault ? 'checked' : ''}>
                                    <label class="form-check-label" for="isDefault">Yes, set as default</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary" id="submitButton">${updateFail != null ? 'Update Address' : 'Save Address'}</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


</div>

<script src="https://cdn.jsdelivr.net/npm/choices.js/public/assets/scripts/choices.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
// List of Vietnam provinces/cities
                const vietnamProvinces = [
                    "An Giang", "Bà Rịa - Vũng Tàu", "Bắc Giang", "Bắc Kạn", "Bạc Liêu", "Bắc Ninh", "Bến Tre", "Bình Định",
                    "Bình Dương", "Bình Phước", "Bình Thuận", "Cà Mau", "Cần Thơ", "Cao Bằng", "Đà Nẵng", "Đắk Lắk", "Đắk Nông",
                    "Điện Biên", "Đồng Nai", "Đồng Tháp", "Gia Lai", "Hà Giang", "Hà Nam", "Hà Nội", "Hà Tĩnh", "Hải Dương",
                    "Hải Phòng", "Hậu Giang", "Hòa Bình", "Hưng Yên", "Khánh Hòa", "Kiên Giang", "Kon Tum", "Lai Châu", "Lâm Đồng",
                    "Lạng Sơn", "Lào Cai", "Long An", "Nam Định", "Nghệ An", "Ninh Bình", "Ninh Thuận", "Phú Thọ", "Phú Yên",
                    "Quảng Bình", "Quảng Nam", "Quảng Ngãi", "Quảng Ninh", "Quảng Trị", "Sóc Trăng", "Sơn La", "Tây Ninh",
                    "Thái Bình", "Thái Nguyên", "Thanh Hóa", "Thừa Thiên Huế", "Tiền Giang", "TP. Hồ Chí Minh", "Trà Vinh",
                    "Tuyên Quang", "Vĩnh Long", "Vĩnh Phúc", "Yên Bái"
                ];

// Populate city select
                function populateCitySelect(selectId) {
                    const select = document.getElementById(selectId);
                    if (!select) {
                        console.error(`Select element with ID ${selectId} not found.`);
                        return;
                    }
                    select.innerHTML = '<option value="" disabled selected>-- Select City/Province --</option>';
                    vietnamProvinces.forEach(city => {
                        const option = document.createElement("option");
                        option.value = city;
                        option.textContent = city;
                        select.appendChild(option);
                    });
                }

// Initialize Choices.js
                function initializeChoices(selectId) {
                    const select = document.getElementById(selectId);
                    if (!select) {
                        console.error(`Cannot initialize Choices.js: Select element with ID ${selectId} not found.`);
                        return null;
                    }
                    return new Choices(select, {
                        searchEnabled: true,
                        itemSelectText: '',
                        shouldSort: false,
                        placeholder: true,
                        placeholderValue: '-- Select City/Province --'
                    });
                }

// Open modal for add or edit
                function openAddressModal(mode, id, receiverName, receiverPhone, street, ward, district, city, isDefault) {
                    const modal = document.getElementById('addressModal');
                    const modalTitle = document.getElementById('addressModalLabel');
                    const submitButton = document.getElementById('submitButton');
                    const formAction = document.getElementById('formAction');
                    const addressId = document.getElementById('addressId');
                    const receiverNameInput = document.getElementById('receiverName');
                    const receiverPhoneInput = document.getElementById('receiverPhone');
                    const streetInput = document.getElementById('street');
                    const wardInput = document.getElementById('ward');
                    const districtInput = document.getElementById('district');
                    const citySelect = document.getElementById('city');
                    const isDefaultInput = document.getElementById('isDefault');

                    // Reset form
                    const fields = ['name', 'phone', 'street', 'ward', 'district', 'city'];
                    fields.forEach(field => {
                        const input = document.getElementById(field === 'name' ? 'receiverName' : field);
                        const error = document.getElementById(field + 'Error');
                        if (error && input) {
                            error.textContent = '';
                            input.classList.remove('is-invalid');
                        }
                    });
                    receiverNameInput.value = '';
                    receiverPhoneInput.value = '';
                    streetInput.value = '';
                    wardInput.value = '';
                    districtInput.value = '';
                    citySelect.value = '';
                    isDefaultInput.checked = false;

                    // Configure modal based on mode
                    if (mode === 'edit') {
                        modalTitle.textContent = 'Edit Address';
                        submitButton.textContent = 'Update Address';
                        formAction.value = 'update';
                        addressId.value = id || '';
                        receiverNameInput.value = receiverName || '';
                        receiverPhoneInput.value = receiverPhone || '';
                        streetInput.value = street || '';
                        wardInput.value = ward || '';
                        districtInput.value = district || '';
                        citySelect.value = city || '';
                        isDefaultInput.checked = isDefault === true || isDefault === 'true';
                        const choicesInstance = Choices.getInstance(citySelect);
                        if (choicesInstance) {
                            choicesInstance.setChoiceByValue(city || '');
                        }
                    } else {
                        modalTitle.textContent = 'Add New Address';
                        submitButton.textContent = 'Save Address';
                        formAction.value = 'add';
                        addressId.value = '';
                    }

                    // Ensure modal is shown
                    const bootstrapModal = new bootstrap.Modal(modal);
                    bootstrapModal.show();
                }

// Validation functions
                function validateName(name) {
                    if (!name || !name.trim())
                        return "Please enter full name.";
                    if (!/^[\p{L}\s'.-]{2,50}$/u.test(name.trim()))
                        return "Full name must be 2-50 characters, letters only.";
                    return "";
                }

                function validatePhone(phone) {
                    if (!phone || !phone.trim())
                        return "Please enter phone number.";
                    if (!/^0[2-9]\d{8,9}$/.test(phone))
                        return "Phone number must be 10-11 digits, starting with 03, 05, 07, 08, or 09.";
                    return "";
                }

                function validateStreet(street) {
                    if (!street || !street.trim())
                        return "Please enter street and house number.";
                    if (!/^[\p{L}\p{N}\s,.\-\/]{5,100}$/u.test(street.trim()))
                        return "Street must be 5-100 characters, valid characters only.";
                    return "";
                }

                function validateWard(ward) {
                    if (ward && !/^[\p{L}\p{N}\s\-\/]{2,50}$/u.test(ward.trim()))
                        return "Ward/commune must be 2-50 characters.";
                    return "";
                }

                function validateDistrict(district) {
                    if (district && !/^[\p{L}\p{N}\s\-\/]{2,50}$/u.test(district.trim()))
                        return "District must be 2-50 characters.";
                    return "";
                }

                function validateCity(city) {
                    if (!city)
                        return "Please select city/province.";
                    if (!vietnamProvinces.includes(city))
                        return "Please select a valid city/province.";
                    return "";
                }

// Initialize when DOM is ready
                document.addEventListener('DOMContentLoaded', function () {
                    // Initialize city dropdown
                    if (document.getElementById('city')) {
                        populateCitySelect('city');
                        const choicesInstance = initializeChoices('city');
                        const city = '<%= session.getAttribute("city") != null ? session.getAttribute("city") : "" %>';
                        if (city && choicesInstance) {
                            choicesInstance.setChoiceByValue(city);
                        }
                    }

                    // Auto-open modal if there are errors or edit data
                    const hasEditData = '<%= session.getAttribute("updateFail") != null || session.getAttribute("addFail") != null %>' === 'true';
                    if (hasEditData) {
                        const modal = new bootstrap.Modal(document.getElementById('addressModal'));
                        modal.show();
                        const isEdit = '<%= session.getAttribute("editAddressId") != null %>' === 'true';
                        if (isEdit) {
                            document.getElementById('addressModalLabel').textContent = 'Edit Address';
                            document.getElementById('submitButton').textContent = 'Update Address';
                            document.getElementById('formAction').value = 'update';
                        }
                    }

                    // Restrict phone input to numbers
                    const phoneInput = document.getElementById('receiverPhone');
                    if (phoneInput) {
                        phoneInput.addEventListener('input', function (e) {
                            this.value = this.value.replace(/[^0-9]/g, '');
                        });
                    }

                    // Validate address form
                    const addressForm = document.getElementById('addressForm');
                    if (addressForm) {
                        addressForm.addEventListener('submit', function (e) {
                            e.preventDefault();

                            const receiverNameInput = document.getElementById('receiverName');
                            const receiverPhoneInput = document.getElementById('receiverPhone');
                            const streetInput = document.getElementById('street');
                            const wardInput = document.getElementById('ward');
                            const districtInput = document.getElementById('district');
                            const citySelect = document.getElementById('city');

                            const name = receiverNameInput ? receiverNameInput.value : '';
                            const phone = receiverPhoneInput ? receiverPhoneInput.value : '';
                            const street = streetInput ? streetInput.value : '';
                            const ward = wardInput ? wardInput.value : '';
                            const district = districtInput ? districtInput.value : '';
                            const city = citySelect ? citySelect.value : '';

                            // Reset errors
                            const fields = ['name', 'phone', 'street', 'ward', 'district', 'city'];
                            fields.forEach(field => {
                                const input = document.getElementById(field === 'name' ? 'receiverName' : field);
                                const error = document.getElementById(field + 'Error');
                                if (error && input) {
                                    error.textContent = '';
                                    input.classList.remove('is-invalid');
                                }
                            });

                            let hasError = false;

                            const nameMsg = validateName(name);
                            if (nameMsg) {
                                document.getElementById('nameError').textContent = nameMsg;
                                receiverNameInput.classList.add('is-invalid');
                                hasError = true;
                            }
                            const phoneMsg = validatePhone(phone);
                            if (phoneMsg) {
                                document.getElementById('phoneError').textContent = phoneMsg;
                                receiverPhoneInput.classList.add('is-invalid');
                                hasError = true;
                            }
                            const streetMsg = validateStreet(street);
                            if (streetMsg) {
                                document.getElementById('streetError').textContent = streetMsg;
                                streetInput.classList.add('is-invalid');
                                hasError = true;
                            }
                            const wardMsg = validateWard(ward);
                            if (wardMsg) {
                                document.getElementById('wardError').textContent = wardMsg;
                                wardInput.classList.add('is-invalid');
                                hasError = true;
                            }
                            const districtMsg = validateDistrict(district);
                            if (districtMsg) {
                                document.getElementById('districtError').textContent = districtMsg;
                                districtInput.classList.add('is-invalid');
                                hasError = true;
                            }
                            const cityMsg = validateCity(city);
                            if (cityMsg) {
                                document.getElementById('cityError').textContent = cityMsg;
                                citySelect.classList.add('is-invalid');
                                hasError = true;
                            }

                            if (!hasError) {
                                this.submit();
                            }
                        });
                    }
                });
</script>