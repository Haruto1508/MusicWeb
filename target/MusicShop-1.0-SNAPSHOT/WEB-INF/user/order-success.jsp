<%-- 
    Document   : order-success
    Created on : Jul 8, 2025, 3:17:22 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Success - MusicShop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/order-success.css"/>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="success-container">
        <div class="success-bg"></div>
        <!-- Canva/illustration style image (replace with your own if needed) -->
        <img class="success-img" src="https://cdni.iconscout.com/illustration/premium/thumb/order-confirmed-4268412-3551741.png?f=webp" alt="Order Success Illustration">
        <div class="success-icon">
            <i class="fa fa-check-circle"></i>
        </div>
        <div class="success-title">Order Placed Successfully!</div>
        <div class="success-message">
            Thank you for your purchase.<br>
            Your order has been received and is being processed.<br>
            We will contact you soon for delivery details.
        </div>
        <div class="order-info" id="orderInfo">
            Order Code: <strong>${orderId}</strong>
        </div>
            <a href="${pageContext.request.contextPath}/path?page=home" class="btn btn-home mt-2"><i class="fa fa-home me-2"></i>Back to Home</a>
        <canvas class="confetti"></canvas>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/js/all.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/order-success-effect.js"></script>
</body>
</html>