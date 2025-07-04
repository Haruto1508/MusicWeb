<%-- 
    Document   : order-confirmation
    Created on : Jul 1, 2025, 4:46:51 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="musicshop-buy-container">
            <div class="musicshop-header">
                <i class="fa fa-shopping-bag"></i> Xác nhận đơn hàng
            </div>
            <!-- Địa chỉ nhận hàng -->
            <div class="musicshop-section">
                <div class="musicshop-section-title"><i class="fa fa-map-marker-alt me-2"></i>Địa chỉ nhận hàng</div>
                <div class="musicshop-address d-flex justify-content-between align-items-center flex-wrap">
                    <div>
                        <strong id="receiverName">Nguyễn Văn A</strong> | 
                        <span id="receiverPhone">0123456789</span><br>
                        <span id="receiverAddress">123 Đường ABC, Quận 1, TP.HCM</span>
                    </div>
                    <div class="mt-2 mt-md-0">
                        <button type="button" class="btn btn-outline-primary btn-sm me-2" onclick="chooseAddress()">
                            <i class="fa fa-map-pin"></i> Chọn địa chỉ khác
                        </button>
                        <button type="button" class="btn btn-outline-secondary btn-sm" onclick="choosePhone()">
                            <i class="fa fa-phone"></i> Chọn số điện thoại khác
                        </button>
                    </div>
                </div>
                <!-- Nếu chưa có địa chỉ, hiển thị nút tạo địa chỉ -->
                <div id="noAddress" class="text-center mt-2" style="display:none;">
                    <button type="button" class="btn btn-warning btn-sm" onclick="createAddress()">
                        <i class="fa fa-plus"></i> Tạo địa chỉ mới
                    </button>
                </div>
            </div>
            <!-- Sản phẩm -->
            <div class="musicshop-section">
                <div class="musicshop-section-title">Sản phẩm</div>
                <div class="musicshop-product-row">
                    <img src="./img/ram.jpg" alt="Guitar Acoustic">
                    <div class="musicshop-product-info">
                        <div class="musicshop-product-name">Guitar Acoustic Yamaha F310</div>
                        <div class="musicshop-product-attr">Màu sắc: <span class="badge bg-light text-dark">Tự nhiên</span></div>
                        <div class="musicshop-product-attr">Số lượng: <span id="quantity">1</span></div>
                    </div>
                    <div class="musicshop-product-price">2.500.000đ</div>
                </div>
            </div>
            <!-- Chọn voucher -->
            <div class="musicshop-section">
                <div class="musicshop-section-title"><i class="fa fa-ticket-alt me-2"></i>Chọn voucher</div>
                <div class="d-flex align-items-center">
                    <select class="form-select w-auto me-2" id="voucherSelect" style="min-width:180px;">
                        <option value="">-- Không áp dụng --</option>
                        <option value="10">Giảm 10.000đ</option>
                        <option value="20">Giảm 20.000đ</option>
                    </select>
                    <button type="button" class="btn btn-outline-success btn-sm" onclick="applyVoucher()">
                        Áp dụng
                    </button>
                </div>
                <div id="voucherInfo" class="form-text text-success mt-1" style="display:none;"></div>
            </div>
            <!-- Thanh toán -->
            <div class="musicshop-section">
                <div class="musicshop-section-title">Phương thức thanh toán</div>
                <div class="d-flex align-items-center justify-content-between flex-wrap">
                    <div>
                        <i class="fa fa-money-bill-wave me-2"></i>
                        <span id="paymentMethodText">Thanh toán khi nhận hàng (COD)</span>
                    </div>
                    <button type="button" class="btn btn-outline-primary btn-sm mt-2 mt-md-0" onclick="choosePayment()">
                        <i class="fa fa-credit-card"></i> Chọn phương thức khác
                    </button>
                </div>
            </div>
            <!-- Tổng kết -->
            <div class="musicshop-section">
                <div class="musicshop-section-title">Tổng kết đơn hàng</div>
                <div class="musicshop-summary-row">
                    <span>Tổng tiền sản phẩm</span>
                    <span>2.500.000đ</span>
                </div>
                <div class="musicshop-summary-row">
                    <span>Phí vận chuyển</span>
                    <span>30.000đ</span>
                </div>
                <div class="musicshop-summary-row total">
                    <span>Tổng thanh toán</span>
                    <span>2.530.000đ</span>
                </div>
            </div>
            <!-- Nút đặt hàng -->
            <form id="orderForm">
                <button type="submit" class="musicshop-btn-order w-100 mt-3"><i class="fa fa-check me-2"></i>Đặt hàng</button>
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Demo chọn địa chỉ khác
            function chooseAddress() {
                alert('Chức năng chọn địa chỉ khác (mở modal hoặc chuyển trang address.html)');
            }
            function createAddress() {
                alert('Chức năng tạo địa chỉ mới (mở modal hoặc chuyển trang address.html)');
            }
            function choosePhone() {
                alert('Chức năng chọn số điện thoại khác');
            }
            function choosePayment() {
                alert('Chức năng chọn phương thức thanh toán khác');
            }

            // Demo voucher
            function applyVoucher() {
                var voucher = document.getElementById('voucherSelect').value;
                var info = document.getElementById('voucherInfo');
                if (voucher === "10") {
                    info.style.display = "block";
                    info.textContent = "Đã áp dụng voucher giảm 10.000đ!";
                } else if (voucher === "20") {
                    info.style.display = "block";
                    info.textContent = "Đã áp dụng voucher giảm 20.000đ!";
                } else {
                    info.style.display = "none";
                    info.textContent = "";
                }
            }
            // Demo xác nhận đặt hàng
            document.getElementById('orderForm').addEventListener('submit', function (e) {
                e.preventDefault();
                alert('Đặt hàng thành công!\nCảm ơn bạn đã mua hàng tại MusicShop.');
            });
        </script>
    </body>
</html>