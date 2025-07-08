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
        <h3 class="text-primary fw-bold">
            <i class="fas fa-map-marker-alt me-2"></i> My Addresses
        </h3>
    </div>

    <!-- Address List -->
<!-- Address List -->
<div class="row g-4">
    <c:choose>
        <c:when test="${not empty addresses}">
            <c:forEach var="address" items="${addresses}">
                <div class="col-12">
                    <div class="card address-card shadow-sm border-0 rounded-4 p-3">
                        <div class="d-flex justify-content-between align-items-start">
                            <!-- Recipient Information -->
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
                            <!-- Action Buttons -->
                            <div class="btn-group">
                                <form method="post" action="${pageContext.request.contextPath}/address">
                                    <input type="hidden" name="action" value="getAddress">
                                    <input type="hidden" name="addressId" value="${address.addressId}">
                                    <button class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editModal">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                </form>
                                <form method="post" action="${pageContext.request.contextPath}/address">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="addressId" value="${address.addressId}">
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this address?')">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                        <!-- Address Details -->
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
</div>

<!-- Edit Address Modal -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="post" action="${pageContext.request.contextPath}/address">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="addressId" id="editAddressId">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Edit Address</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row mb-3 align-items-center">
                        <label for="editReceiverName" class="col-sm-4 col-form-label text-end">Full Name <span class="text-danger">*</span></label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control ${not empty nameError ? 'is-invalid' : ''}" 
                                   id="editReceiverName" name="receiverName" required
                                   value="${receiverName != null ? receiverName : ''}">
                            <div class="invalid-feedback" id="editNameError">
                                <c:out value="${nameError}" />
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <label for="editReceiverPhone" class="col-sm-4 col-form-label text-end">Phone Number <span class="text-danger">*</span></label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control ${not empty phoneError ? 'is-invalid' : ''}" 
                                   id="editReceiverPhone" name="receiverPhone" required
                                   value="${receiverPhone != null ? receiverPhone : ''}">
                            <div class="invalid-feedback" id="editPhoneError">
                                <c:out value="${phoneError}" />
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <label for="editStreet" class="col-sm-4 col-form-label text-end">Street & House No. <span class="text-danger">*</span></label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control ${not empty streetError ? 'is-invalid' : ''}" 
                                   id="editStreet" name="street" required
                                   value="${street != null ? street : ''}">
                            <div class="invalid-feedback" id="editStreetError">
                                <c:out value="${streetError}" />
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <label for="editWard" class="col-sm-4 col-form-label text-end">Ward/Commune</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="editWard" name="ward"
                                   value="${ward != null ? ward : ''}">
                            <div class="invalid-feedback" id="editWardError"></div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <label for="editDistrict" class="col-sm-4 col-form-label text-end">District</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="editDistrict" name="district"
                                   value="${district != null ? district : ''}">
                            <div class="invalid-feedback" id="editDistrictError"></div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <label for="editCity" class="col-sm-4 col-form-label text-end">City/Province <span class="text-danger">*</span></label>
                        <div class="col-sm-8">
                            <select id="editCity" name="city" class="form-select ${not empty cityError ? 'is-invalid' : ''}" required>
                                <option value="" disabled>-- Select City/Province --</option>
                            </select>
                            <div class="invalid-feedback" id="editCityError">
                                <c:out value="${cityError}" />
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 col-form-label text-end">Set Default Address?</label>
                        <div class="col-sm-8">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="editIsDefault" name="isDefault" value="true">
                                <label class="form-check-label" for="editIsDefault">
                                    Yes, set as default
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save Address</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Add Address Modal (Horizontal Form) -->
<div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="addAddressForm" method="post" action="${pageContext.request.contextPath}/address">
                <input type="hidden" name="action" value="add">
                <div class="modal-header">
                    <h5 class="modal-title" id="addModalLabel">Add New Address</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row mb-3 align-items-center">
                        <label for="receiverName" class="col-sm-4 col-form-label text-end">Full Name <span class="text-danger">*</span></label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control ${not empty nameError ? 'is-invalid' : ''}" 
                                   id="receiverName" name="receiverName" placeholder="Enter full name"
                                   value="${receiverName != null ? receiverName : ''}">
                            <div class="invalid-feedback" id="nameError">
                                <c:out value="${nameError}" />
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <label for="receiverPhone" class="col-sm-4 col-form-label text-end">Phone Number <span class="text-danger">*</span></label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control ${not empty phoneError ? 'is-invalid' : ''}" 
                                   id="receiverPhone" name="receiverPhone" placeholder="Enter phone number"
                                   value="${receiverPhone != null ? receiverPhone : ''}">
                            <div class="invalid-feedback" id="phoneError">
                                <c:out value="${phoneError}" />
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <label for="street" class="col-sm-4 col-form-label text-end">Street & House No. <span class="text-danger">*</span></label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control ${not empty streetError ? 'is-invalid' : ''}" 
                                   id="street" name="street" placeholder="e.g., 123 ABC Street"
                                   value="${street != null ? street : ''}">
                            <div class="invalid-feedback" id="streetError">
                                <c:out value="${streetError}" />
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <label for="ward" class="col-sm-4 col-form-label text-end">Ward/Commune</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="ward" name="ward"
                                   value="${ward != null ? ward : ''}">
                            <div class="invalid-feedback" id="wardError"></div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <label for="district" class="col-sm-4 col-form-label text-end">District</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="district" name="district"
                                   value="${district != null ? district : ''}">
                            <div class="invalid-feedback" id="districtError"></div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <label for="city" class="col-sm-4 col-form-label text-end">City/Province <span class="text-danger">*</span></label>
                        <div class="col-sm-8">
                            <select id="city" name="city" class="form-select ${not empty cityError ? 'is-invalid' : ''}" required>
                                <option value="" disabled>-- Select City/Province --</option>
                            </select>
                            <div class="invalid-feedback" id="cityError">
                                <c:out value="${cityError}" />
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <label class="col-sm-4 col-form-label text-end">Set Default Address?</label>
                        <div class="col-sm-8">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="isDefault" name="isDefault" value="true"
                                       <c:if test="${not empty receiverName}">${receiverName}</c:if>>
                                <label class="form-check-label" for="isDefault">
                                    Yes, set as default
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save Address</button>
                </div>
            </form>
        </div>
    </div>
</div>
                                
                                
<script src="https://cdn.jsdelivr.net/npm/choices.js/public/assets/scripts/choices.min.js"></script>
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

    // Populate city select for a given selectId
    function populateCitySelect(selectId) {
        const select = document.getElementById(selectId);
        if (!select) {
            console.error(`Select element with ID ${selectId} not found.`);
            return;
        }
        // Clear existing options to prevent duplicates
        select.innerHTML = '<option value="" disabled selected>-- Select City/Province --</option>';
        vietnamProvinces.forEach(city => {
            const option = document.createElement("option");
            option.value = city;
            option.textContent = city;
            select.appendChild(option);
        });
        console.log(`Populated ${selectId} with ${vietnamProvinces.length} provinces.`);
    }

    // Initialize Choices.js for a select element
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

    // Edit address function
    function editAddress(id, street, ward, district, city) {
        const editAddressId = document.getElementById('editAddressId');
        const editStreet = document.getElementById('editStreet');
        const editWard = document.getElementById('editWard');
        const editDistrict = document.getElementById('editDistrict');
        const editCitySelect = document.getElementById('editCity');

        if (editAddressId)
            editAddressId.value = id;
        if (editStreet)
            editStreet.value = street;
        if (editWard)
            editWard.value = ward || '';
        if (editDistrict)
            editDistrict.value = district || '';
        if (editCitySelect) {
            editCitySelect.value = city;
            const choicesInstance = Choices.getInstance(editCitySelect);
            if (choicesInstance) {
                choicesInstance.setChoiceByValue(city);
            }
        } else {
            console.error('Edit city select element not found.');
        }
    }

    // Validation functions with regex
    // Validate name (cho phép tiếng Việt)
    function validateName(name) {
        if (!name || !name.trim())
            return "Please enter full name.";
        if (!/^[\p{L}\s'.-]{2,50}$/u.test(name.trim()))
            return "Full name must be 2-50 characters, letters only.";
        return "";
    }

    // Validate phone
    function validatePhone(phone) {
        if (!phone || !phone.trim())
            return "Please enter phone number.";
        if (!/^0[35789]\d{8}$/.test(phone))
            return "Phone number must be 10 digits, start with 03, 05, 07, 08, or 09.";
        return "";
    }

    // Validate street (cho phép tiếng Việt, số, dấu câu cơ bản)
    function validateStreet(street) {
        if (!street || !street.trim())
            return "Please enter street and house number.";
        if (!/^[\p{L}\p{N}\s,.\-\/]{5,100}$/u.test(street.trim()))
            return "Street must be 5-100 characters, valid characters only.";
        return "";
    }

    // Validate ward (cho phép tiếng Việt)
    function validateWard(ward) {
        if (ward && !/^[\p{L}\p{N}\s\-\/]{2,50}$/u.test(ward.trim()))
            return "Ward/commune must be 2-50 characters.";
        return "";
    }

    // Validate district (cho phép tiếng Việt)
    function validateDistrict(district) {
        if (district && !/^[\p{L}\p{N}\s\-\/]{2,50}$/u.test(district.trim()))
            return "District must be 2-50 characters.";
        return "";
    }

    // Validate city
    function validateCity(city) {
        if (!city)
            return "Please select city/province.";
        if (!vietnamProvinces.includes(city))
            return "Please select a valid city/province.";
        return "";
    }

    // Initialize when DOM is ready
    document.addEventListener('DOMContentLoaded', function () {
        console.log('DOM loaded, initializing address.js');
        // Initialize city dropdowns
        if (document.getElementById('city')) {
            populateCitySelect('city');
            initializeChoices('city');
        } else {
            console.warn('City select element not found on page load.');
        }
        if (document.getElementById('editCity')) {
            populateCitySelect('editCity');
            initializeChoices('editCity');
        } else {
            console.warn('Edit city select element not found on page load.');
        }

        // Restrict phone input to numbers
        const phoneInput = document.getElementById('receiverPhone');
        if (phoneInput) {
            phoneInput.addEventListener('input', function (e) {
                this.value = this.value.replace(/[^0-9]/g, '');
            });
        } else {
            console.warn('Receiver phone input not found.');
        }

        // Validate add address form
        const addAddressForm = document.getElementById('addAddressForm');
        if (addAddressForm) {
            addAddressForm.addEventListener('submit', function (e) {
                e.preventDefault();

                // Explicitly check for elements
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
                    if (receiverNameInput) {
                        document.getElementById('nameError').textContent = nameMsg;
                        receiverNameInput.classList.add('is-invalid');
                    }
                    hasError = true;
                }
                const phoneMsg = validatePhone(phone);
                if (phoneMsg) {
                    if (receiverPhoneInput) {
                        document.getElementById('phoneError').textContent = phoneMsg;
                        receiverPhoneInput.classList.add('is-invalid');
                    }
                    hasError = true;
                }
                const streetMsg = validateStreet(street);
                if (streetMsg) {
                    if (streetInput) {
                        document.getElementById('streetError').textContent = streetMsg;
                        streetInput.classList.add('is-invalid');
                    }
                    hasError = true;
                }
                const wardMsg = validateWard(ward);
                if (wardMsg) {
                    if (wardInput) {
                        document.getElementById('wardError').textContent = wardMsg;
                        wardInput.classList.add('is-invalid');
                    }
                    hasError = true;
                }
                const districtMsg = validateDistrict(district);
                if (districtMsg) {
                    if (districtInput) {
                        document.getElementById('districtError').textContent = districtMsg;
                        districtInput.classList.add('is-invalid');
                    }
                    hasError = true;
                }
                const cityMsg = validateCity(city);
                if (cityMsg) {
                    if (citySelect) {
                        document.getElementById('cityError').textContent = cityMsg;
                        citySelect.classList.add('is-invalid');
                    }
                    hasError = true;
                }

                if (!hasError) {
                    this.submit();
                }
            });
        } else {
            console.warn('Add address form not found.');
        }
    });
</script>