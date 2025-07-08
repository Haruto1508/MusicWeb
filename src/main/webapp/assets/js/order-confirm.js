document.addEventListener("DOMContentLoaded", function () {
    console.log('order-confirm.js loaded');
    const voucherSelect = document.getElementById("voucherSelect");
    const paymentMethodSelect = document.getElementById("paymentMethodSelect");
    const paymentMethodInput = document.getElementById("paymentMethodInput");
    const voucherForm = document.getElementById("voucherForm");

    if (paymentMethodSelect && paymentMethodInput) {
        paymentMethodSelect.addEventListener("change", function () {
            paymentMethodInput.value = paymentMethodSelect.value;
            const addressForm = document.querySelector("#addressListSection form");
            if (addressForm) {
                let paymentInput = addressForm.querySelector("input[name='paymentMethod']");
                if (paymentInput) {
                    paymentInput.value = paymentMethodSelect.value;
                }
            }
            if (voucherForm) {
                let voucherPaymentInput = voucherForm.querySelector("#voucherPaymentMethod");
                if (voucherPaymentInput) {
                    voucherPaymentInput.value = paymentMethodSelect.value;
                }
            }
            console.log('Payment method updated:', paymentMethodSelect.value);
        });
    } else {
        console.warn('Warning: #paymentMethodSelect or #paymentMethodInput not found');
    }

    if (voucherSelect) {
        voucherSelect.addEventListener("change", function () {
            const selectedVoucherId = voucherSelect.value;
            const addressForm = document.querySelector("#addressListSection form");
            if (addressForm) {
                let voucherInput = addressForm.querySelector("input[name='voucherId']");
                if (voucherInput) {
                    voucherInput.value = selectedVoucherId;
                }
            }
            const orderForm = document.getElementById("orderForm");
            if (orderForm) {
                let voucherInput = orderForm.querySelector("input[name='voucherId']");
                if (voucherInput) {
                    voucherInput.value = selectedVoucherId;
                }
            }
            console.log('Voucher ID updated:', selectedVoucherId);
        });
    } else {
        console.warn('Warning: #voucherSelect not found');
    }
});