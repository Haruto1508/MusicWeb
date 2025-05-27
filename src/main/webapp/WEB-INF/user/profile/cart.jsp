<%-- 
    Document   : cart
    Created on : May 28, 2025, 12:08:39 AM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            margin-top: 30px;
        }

        .cart-item {
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            display: flex;
            align-items: center;
        }

        .cart-item img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 15px;
        }

        .cart-item-details {
            flex-grow: 1;
        }

        .cart-item-quantity {
            display: flex;
            align-items: center;
        }

        .cart-item-quantity button {
            width: 30px;
            height: 30px;
            border: none;
            background-color: #f0f0f0;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 5px;
        }

        .cart-item-quantity input {
            width: 40px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 5px;
        }

        .cart-total {
            margin-top: 20px;
            text-align: right;
        }

        .remove-item {
            color: red;
            cursor: pointer;
            margin-left: 10px;
        }

        .cart-buttons {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }
    </style>
</head>

<body>
    <div class="container">
        <h1>Giỏ hàng của bạn</h1>
        <div class="cart-item">
            <img src="https://via.placeholder.com/100" alt="Sản phẩm 1">
            <div class="cart-item-details">
                <h5>Sản phẩm 1</h5>
                <p>Giá: 200.000 VNĐ</p>
                <div class="cart-buttons">
                    <button class="btn btn-sm btn-outline-primary">Xem chi tiết</button>
                    <button class="btn btn-sm btn-success">Mua ngay</button>
                </div>
            </div>
            <div class="cart-item-quantity">
                <button><i class="fas fa-minus"></i></button>
                <input type="number" value="1">
                <button><i class="fas fa-plus"></i></button>
            </div>
            <div class="remove-item">
                <i class="fas fa-trash-alt"></i>
            </div>
        </div>
        <div class="cart-item">
            <img src="https://via.placeholder.com/100" alt="Sản phẩm 2">
            <div class="cart-item-details">
                <h5>Sản phẩm 2</h5>
                <p>Giá: 300.000 VNĐ</p>
                <div class="cart-buttons">
                    <button class="btn btn-sm btn-outline-primary">Xem chi tiết</button>
                    <button class="btn btn-sm btn-success">Mua ngay</button>
                </div>
            </div>
            <div class="cart-item-quantity">
                <button><i class="fas fa-minus"></i></button>
                <input type="number" value="2">
                <button><i class="fas fa-plus"></i></button>
            </div>
            <div class="remove-item">
                <i class="fas fa-trash-alt"></i>
            </div>
        </div>
        <div class="cart-total">
            <h4>Tổng cộng: 800.000 VNĐ</h4>
            <button class="btn btn-primary">Thanh toán</button>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>