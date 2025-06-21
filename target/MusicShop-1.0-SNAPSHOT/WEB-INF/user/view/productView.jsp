<%-- 
    Document   : productView
    Created on : Jun 17, 2025, 5:41:46 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết sản phẩm - MusicShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.getContextPath}/assets/css/product.view.css">
</head>
<body>
    <div class="container">
        <div class="product-detail">
            <div class="row">
                <div class="col-md-6 product-images">
                    <span class="badge">Yêu thích</span>
                    <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=600&q=80" alt="Guitar Acoustic" class="product-main-image">
                    <div class="product-thumbnail-images">
                        <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=600&q=80" alt="Guitar Acoustic">
                        <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=600&q=80" alt="Guitar Acoustic">
                        <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=600&q=80" alt="Guitar Acoustic">
                    </div>
                </div>
                <div class="col-md-6 product-info">
                    <h1>Guitar Acoustic Yamaha F310</h1>
                    <div class="rating">
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star-half"></i>
                        (150 đánh giá)
                    </div>
                    <div class="price">2.500.000đ</div>
                    <div class="options">
                        <label>Màu sắc:</label>
                        <select class="form-select">
                            <option>Tự nhiên</option>
                            <option>Đen</option>
                            <option>Nâu</option>
                        </select>
                    </div>
                    <div class="quantity">
                        <label>Số lượng:</label>
                        <input type="number" class="form-control" value="1">
                    </div>
                    <div class="actions">
                        <button class="btn btn-danger add-to-cart" data-product-id="123">
                          <i class="fa fa-cart-plus"></i> Thêm vào giỏ hàng
                        </button>
                        <button class="btn btn-primary buy-now" data-bs-toggle="modal" data-bs-target="#orderModal">
                          <i class="fa fa-shopping-cart"></i> Mua ngay
                        </button>
                        <button class="btn btn-outline-secondary add-to-wishlist" data-product-id="123">
                          <i class="fa fa-heart"></i> Yêu thích
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="product-description">
            <h2>Mô tả sản phẩm</h2>
            <p>Âm thanh ấm áp, phù hợp cho người mới bắt đầu và biểu diễn chuyên nghiệp. Thiết kế tinh tế, chất liệu gỗ cao cấp, độ bền cao.</p>
            <ul>
                <li>Thương hiệu: Yamaha</li>
                <li>Loại: Acoustic</li>
                <li>Mặt đàn: Gỗ vân sam</li>
                <li>Lưng & hông: Gỗ Meranti</li>
                <li>Bảo hành: 12 tháng</li>
            </ul>
        </div>
        <div class="product-reviews">
            <h2>Đánh giá sản phẩm</h2>
            <!-- Thêm các đánh giá sản phẩm ở đây -->
        </div>
        <div class="product-related">
            <h2>Sản phẩm liên quan</h2>
            <div class="row">
                <div class="col-md-3">
                    <div class="card">
                        <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=200&q=80" class="card-img-top" alt="Guitar">
                        <div class="card-body">
                            <h5 class="card-title">Guitar Yamaha F310</h5>
                            <p class="card-text">2.500.000đ</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card">
                        <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=200&q=80" class="card-img-top" alt="Guitar">
                        <div class="card-body">
                            <h5 class="card-title">Guitar Yamaha F310</h5>
                            <p class="card-text">2.500.000đ</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card">
                        <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=200&q=80" class="card-img-top" alt="Guitar">
                        <div class="card-body">
                            <h5 class="card-title">Guitar Yamaha F310</h5>
                            <p class="card-text">2.500.000đ</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Order Modal -->
    <div class="modal fade" id="orderModal" tabindex="-1" aria-labelledby="orderModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="orderModalLabel">Thông tin khách hàng</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <form>
              <div class="mb-3">
                <label for="name" class="form-label">Họ và tên</label>
                <input type="text" class="form-control" id="name" placeholder="Nhập họ và tên" required>
              </div>
              <div class="mb-3">
                <label for="phone" class="form-label">Số điện thoại</label>
                <input type="tel" class="form-control" id="phone" placeholder="Nhập số điện thoại" required>
              </div>
              <div class="mb-3">
                <label for="address" class="form-label">Địa chỉ</label>
                <input type="text" class="form-control" id="address" placeholder="Nhập địa chỉ" required>
              </div>
              <div class="mb-3">
                <label for="payment" class="form-label">Phương thức thanh toán</label>
                <select class="form-select" id="payment">
                  <option>Thanh toán khi nhận hàng</option>
                  <option>Thẻ tín dụng</option>
                  <option>Ví điện tử</option>
                </select>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            <button type="button" class="btn btn-primary">Đặt hàng</button>
          </div>
        </div>
      </div>
    </div>

    <script>
      document.querySelectorAll('.add-to-cart').forEach(button => {
        button.addEventListener('click', function() {
          const productId = this.dataset.productId;
          alert(`Đã thêm sản phẩm ${productId} vào giỏ hàng (chưa xử lý logic)`);
        });
      });

      document.querySelectorAll('.add-to-wishlist').forEach(button => {
        button.addEventListener('click', function() {
          const productId = this.dataset.productId;
          alert(`Đã thêm sản phẩm ${productId} vào danh sách yêu thích (chưa xử lý logic)`);
        });
      });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>