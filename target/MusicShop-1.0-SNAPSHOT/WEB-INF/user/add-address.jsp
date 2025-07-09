<%-- 
    Document   : add-address
    Created on : Jul 7, 2025, 5:24:28 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Thêm địa chỉ mới - MusicShop</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/choices.js/public/assets/styles/choices.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(135deg, #ede9fe 0%, #f5f5f5 100%);
                min-height: 100vh;
                font-family: 'Segoe UI', 'Roboto', Arial, sans-serif;
            }
            .musicshop-address-container {
                max-width: 500px;
                margin: 48px auto;
                background: #fff;
                border-radius: 22px;
                box-shadow: 0 8px 32px rgba(139,92,246,0.13);
                padding: 2.5rem 2rem 2rem 2rem;
            }
            .musicshop-header {
                background: linear-gradient(90deg, #8b5cf6 0%, #7c3aed 100%);
                color: #fff;
                padding: 1.2rem 2rem;
                font-size: 1.3rem;
                font-weight: bold;
                letter-spacing: 1px;
                display: flex;
                align-items: center;
                gap: 12px;
                border-radius: 16px;
                margin-bottom: 2rem;
                box-shadow: 0 2px 12px rgba(139,92,246,0.08);
            }
            .musicshop-section-title {
                font-size: 1.13rem;
                font-weight: 700;
                color: #7c3aed;
                margin-bottom: 18px;
                letter-spacing: 0.5px;
            }
            .musicshop-btn-save {
                background: linear-gradient(90deg, #8b5cf6 0%, #7c3aed 100%);
                border: none;
                color: #fff;
                font-weight: 700;
                font-size: 1.08rem;
                letter-spacing: 1px;
                border-radius: 10px;
                padding: 0.7rem 0;
                width: 100%;
                margin-top: 1.5rem;
                transition: background 0.2s, box-shadow 0.2s;
                box-shadow: 0 2px 12px rgba(139,92,246,0.10);
            }
            .musicshop-btn-save:hover, .musicshop-btn-save:focus {
                background: linear-gradient(90deg, #7c3aed 0%, #8b5cf6 100%);
                color: #fff;
                box-shadow: 0 4px 18px rgba(139,92,246,0.13);
            }
            .form-label {
                color: #7c3aed;
                font-weight: 500;
            }
            .form-select:focus, .form-control:focus {
                border-color: #8b5cf6;
                box-shadow: 0 0 0 0.2rem rgba(139,92,246,.10);
            }
            @media (max-width: 600px) {
                .musicshop-address-container {
                    max-width: 100%;
                    border-radius: 0;
                    padding: 1rem;
                }
                .musicshop-header {
                    padding: 1rem;
                    font-size: 1.1rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="musicshop-address-container">
            <div class="musicshop-header">
                <i class="fa fa-map-marker-alt"></i> Thêm địa chỉ mới
            </div>
            <form id="addAddressForm" method="post" action="#">
                <div class="musicshop-section-title">Thông tin người nhận</div>
                <div class="row mb-3 align-items-center">
                    <label for="receiverName" class="col-sm-4 col-form-label text-end">Họ tên người nhận <span class="text-danger">*</span></label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="Nhập họ tên" required>
                        <div class="invalid-feedback" id="nameError"></div>
                    </div>
                </div>
                <div class="row mb-3 align-items-center">
                    <label for="receiverPhone" class="col-sm-4 col-form-label text-end">Số điện thoại <span class="text-danger">*</span></label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="Nhập số điện thoại" required>
                        <div class="invalid-feedback" id="phoneError"></div>
                    </div>
                </div>
                <div class="musicshop-section-title">Địa chỉ nhận hàng</div>
                <div class="row mb-3 align-items-center">
                    <label for="street" class="col-sm-4 col-form-label text-end">Số nhà, tên đường <span class="text-danger">*</span></label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="street" name="street" placeholder="VD: 123 Đường ABC" required>
                        <div class="invalid-feedback" id="streetError"></div>
                    </div>
                </div>
                <div class="row mb-3 align-items-center">
                    <label for="ward" class="col-sm-4 col-form-label text-end">Phường/Xã</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="ward" name="ward" placeholder="VD: Phường 1">
                        <div class="invalid-feedback" id="wardError"></div>
                    </div>
                </div>
                <div class="row mb-3 align-items-center">
                    <label for="district" class="col-sm-4 col-form-label text-end">Quận/Huyện</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="district" name="district" placeholder="VD: Quận 1">
                        <div class="invalid-feedback" id="districtError"></div>
                    </div>
                </div>
                <div class="row mb-3 align-items-center">
                    <label for="city" class="col-sm-4 col-form-label text-end">Tỉnh/Thành phố <span class="text-danger">*</span></label>
                    <div class="col-sm-8">
                        <select id="city" name="city" class="form-select" required>
                            <option value="" disabled selected>-- Chọn tỉnh/thành phố --</option>
                            <option value="Hồ Chí Minh">Hồ Chí Minh</option>
                            <option value="Hà Nội">Hà Nội</option>
                            <option value="Đà Nẵng">Đà Nẵng</option>
                            <option value="Cần Thơ">Cần Thơ</option>
                            <option value="Khác">Khác</option>
                        </select>
                        <div class="invalid-feedback" id="cityError"></div>
                    </div>
                </div>
                <button type="submit" class="musicshop-btn-save mt-3"><i class="fa fa-plus me-2"></i>Lưu địa chỉ</button>
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/choices.js/public/assets/scripts/choices.min.js"></script>
    </body>
</html>