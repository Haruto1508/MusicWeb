/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


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
function editAddress(id, name, phone, street, ward, district, city, isDefault) {
    const editAddressId = document.getElementById('editAddressId');
    const editReceiverName = document.getElementById('editReceiverName');
    const editReceiverPhone = document.getElementById('editReceiverPhone');
    const editStreet = document.getElementById('editStreet');
    const editWard = document.getElementById('editWard');
    const editDistrict = document.getElementById('editDistrict');
    const editCitySelect = document.getElementById('editCity');
    const editIsDefault = document.getElementById('editIsDefault');

    if (editAddressId)
        editAddressId.value = id || '';
    if (editReceiverName)
        editReceiverName.value = name || '';
    if (editReceiverPhone)
        editReceiverPhone.value = phone || '';
    if (editStreet)
        editStreet.value = street || '';
    if (editWard)
        editWard.value = ward || '';
    if (editDistrict)
        editDistrict.value = district || '';
    if (editIsDefault)
        editIsDefault.checked = isDefault === true || isDefault === 'true';

    if (editCitySelect) {
        editCitySelect.value = city || '';
        const choicesInstance = Choices.getInstance(editCitySelect);
        if (choicesInstance) {
            choicesInstance.setChoiceByValue(city || '');
        } else {
            console.warn('Choices.js instance not found for editCity select.');
        }
    } else {
        console.error('Edit city select element not found.');
    }
}

// Validation functions with regex
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
    if (!/^0[35789]\d{8}$/.test(phone))
        return "Phone number must be 10 digits, start with 03, 05, 07, 08, or 09.";
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
    console.log('DOM loaded, initializing address section');

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
    const phoneInputs = [document.getElementById('receiverPhone'), document.getElementById('editReceiverPhone')];
    phoneInputs.forEach(input => {
        if (input) {
            input.addEventListener('input', function (e) {
                this.value = this.value.replace(/[^0-9]/g, '');
            });
        } else {
            console.warn('Phone input not found.');
        }
    });

    // Validate add address form
    const addAddressForm = document.getElementById('addAddressForm');
    if (addAddressForm) {
        addAddressForm.addEventListener('submit', function (e) {
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

    // Validate edit address form
    const editAddressForm = document.querySelector('#editModal form');
    if (editAddressForm) {
        editAddressForm.addEventListener('submit', function (e) {
            e.preventDefault();

            const receiverNameInput = document.getElementById('editReceiverName');
            const receiverPhoneInput = document.getElementById('editReceiverPhone');
            const streetInput = document.getElementById('editStreet');
            const wardInput = document.getElementById('editWard');
            const districtInput = document.getElementById('editDistrict');
            const citySelect = document.getElementById('editCity');

            const name = receiverNameInput ? receiverNameInput.value : '';
            const phone = receiverPhoneInput ? receiverPhoneInput.value : '';
            const street = streetInput ? streetInput.value : '';
            const ward = wardInput ? wardInput.value : '';
            const district = districtInput ? districtInput.value : '';
            const city = citySelect ? citySelect.value : '';

            // Reset errors
            const fields = ['name', 'phone', 'street', 'ward', 'district', 'city'];
            fields.forEach(field => {
                const input = document.getElementById(field === 'name' ? 'editReceiverName' : field === 'phone' ? 'editReceiverPhone' : `edit${field.charAt(0).toUpperCase() + field.slice(1)}`);
                const error = document.getElementById(`edit${field.charAt(0).toUpperCase() + field.slice(1)}Error`);
                if (error && input) {
                    error.textContent = '';
                    input.classList.remove('is-invalid');
                }
            });

            let hasError = false;

            const nameMsg = validateName(name);
            if (nameMsg) {
                if (receiverNameInput) {
                    document.getElementById('editNameError').textContent = nameMsg;
                    receiverNameInput.classList.add('is-invalid');
                }
                hasError = true;
            }
            const phoneMsg = validatePhone(phone);
            if (phoneMsg) {
                if (receiverPhoneInput) {
                    document.getElementById('editPhoneError').textContent = phoneMsg;
                    receiverPhoneInput.classList.add('is-invalid');
                }
                hasError = true;
            }
            const streetMsg = validateStreet(street);
            if (streetMsg) {
                if (streetInput) {
                    document.getElementById('editStreetError').textContent = streetMsg;
                    streetInput.classList.add('is-invalid');
                }
                hasError = true;
            }
            const wardMsg = validateWard(ward);
            if (wardMsg) {
                if (wardInput) {
                    document.getElementById('editWardError').textContent = wardMsg;
                    wardInput.classList.add('is-invalid');
                }
                hasError = true;
            }
            const districtMsg = validateDistrict(district);
            if (districtMsg) {
                if (districtInput) {
                    document.getElementById('editDistrictError').textContent = districtMsg;
                    districtInput.classList.add('is-invalid');
                }
                hasError = true;
            }
            const cityMsg = validateCity(city);
            if (cityMsg) {
                if (citySelect) {
                    document.getElementById('editCityError').textContent = cityMsg;
                    citySelect.classList.add('is-invalid');
                }
                hasError = true;
            }

            if (!hasError) {
                this.submit();
            }
        });
    } else {
        console.warn('Edit address form not found.');
    }

    // Reopen edit modal on validation failure
    <c:if test="${not empty updateFail && not empty editAddressId}">
        editAddress(
        '${editAddressId}',
        '${receiverName != null ? receiverName : ''}',
        '${receiverPhone != null ? receiverPhone : ''}',
        '${street != null ? street : ''}',
        '${ward != null ? ward : ''}',
        '${district != null ? district : ''}',
        '${city != null ? city : ''}',
        ${isDefault != null && isDefault ? 'true' : 'false'}
        );
        var editModal = new bootstrap.Modal(document.getElementById('editModal'));
        editModal.show();
    </c:if>
});