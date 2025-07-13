/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


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

function populateCitySelect(selectId) {
    const select = document.getElementById(selectId);
    if (!select)
        return;
    select.innerHTML = '<option value="" disabled selected>-- Select City/Province --</option>';
    vietnamProvinces.forEach(city => {
        const option = document.createElement("option");
        option.value = city;
        option.textContent = city;
        select.appendChild(option);
    });
}

function openAddressModal(mode, id, receiverName, receiverPhone, street, ward, district, city, isDefault) {
    const modal = document.getElementById('addressModal');
    const formAction = document.getElementById('formAction');
    const addressId = document.getElementById('addressId');
    const receiverNameInput = document.getElementById('receiverName');
    const receiverPhoneInput = document.getElementById('receiverPhone');
    const streetInput = document.getElementById('street');
    const wardInput = document.getElementById('ward');
    const districtInput = document.getElementById('district');
    const citySelect = document.getElementById('city');
    const isDefaultInput = document.getElementById('isDefault');

    [receiverNameInput, receiverPhoneInput, streetInput, wardInput, districtInput, citySelect].forEach(input => {
        if (input)
            input.classList.remove('is-invalid');
    });
    ["nameError", "phoneError", "streetError", "wardError", "districtError", "cityError"].forEach(id => {
        const error = document.getElementById(id);
        if (error)
            error.textContent = "";
    });

    if (mode === 'edit') {
        formAction.value = 'update';
        addressId.value = id || '';
        receiverNameInput.value = receiverName || '';
        receiverPhoneInput.value = receiverPhone || '';
        streetInput.value = street || '';
        wardInput.value = ward || '';
        districtInput.value = district || '';
        citySelect.value = city || '';
        isDefaultInput.checked = isDefault === true || isDefault === 'true';
    } else {
        formAction.value = 'add';
        addressId.value = '';
        receiverNameInput.value = '';
        receiverPhoneInput.value = '';
        streetInput.value = '';
        wardInput.value = '';
        districtInput.value = '';
        citySelect.value = '';
        isDefaultInput.checked = false;
    }

    new bootstrap.Modal(modal).show();
}

function validateInput(input, validatorFn, errorId) {
    const error = document.getElementById(errorId);
    const message = validatorFn(input.value);
    if (message) {
        input.classList.add('is-invalid');
        error.textContent = message;
        return true;
    } else {
        input.classList.remove('is-invalid');
        error.textContent = '';
        return false;
    }
}

function validateName(name) {
    if (!name.trim())
        return "Please enter full name.";
    if (!/^[\p{L}\s'.-]{2,50}$/u.test(name.trim()))
        return "Full name must be 2-50 characters, letters only.";
    return "";
}

function validatePhone(phone) {
    if (!phone.trim())
        return "Please enter phone number.";
    if (!/^0[2-9]\d{8,9}$/.test(phone))
        return "Phone number must be 10-11 digits, starting with 03, 05, 07, 08, or 09.";
    return "";
}

function validateStreet(street) {
    if (!street.trim())
        return "Please enter street and house number.";
    if (!/^[\p{L}\p{N}\s,.-\/]{5,100}$/u.test(street.trim()))
        return "Street must be 5-100 characters, valid characters only.";
    return "";
}

function validateWard(ward) {
    if (ward && !/^[\p{L}\p{N}\s-\/]{2,50}$/u.test(ward.trim()))
        return "Ward/commune must be 2-50 characters.";
    return "";
}

function validateDistrict(district) {
    if (district && !/^[\p{L}\p{N}\s-\/]{2,50}$/u.test(district.trim()))
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

document.addEventListener('DOMContentLoaded', function () {
    populateCitySelect('city');

    const addressForm = document.getElementById('addressForm');
    if (addressForm) {
        addressForm.addEventListener('submit', function (e) {
            e.preventDefault();
            const nameInput = document.getElementById('receiverName');
            const phoneInput = document.getElementById('receiverPhone');
            const streetInput = document.getElementById('street');
            const wardInput = document.getElementById('ward');
            const districtInput = document.getElementById('district');
            const citySelect = document.getElementById('city');

            let hasError = false;
            hasError |= validateInput(nameInput, validateName, 'nameError');
            hasError |= validateInput(phoneInput, validatePhone, 'phoneError');
            hasError |= validateInput(streetInput, validateStreet, 'streetError');
            hasError |= validateInput(wardInput, validateWard, 'wardError');
            hasError |= validateInput(districtInput, validateDistrict, 'districtError');
            hasError |= validateInput(citySelect, validateCity, 'cityError');

            if (!hasError)
                addressForm.submit();
        });
    }

    const phoneInput = document.getElementById('receiverPhone');
    if (phoneInput) {
        phoneInput.addEventListener('input', function () {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    }

    // Auto-open modal if session contains failure or edit
    const hasEditData = '<%= session.getAttribute("updateFail") != null || session.getAttribute("addFail") != null %>' === 'true';
    if (hasEditData) {
        const modal = new bootstrap.Modal(document.getElementById('addressModal'));
        modal.show();
    }
});