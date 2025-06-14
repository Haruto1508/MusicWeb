<%-- 
    Document   : manager
    Created on : Jun 12, 2025, 11:12:40 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .product-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
        }
        .action-btns {
            white-space: nowrap;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active text-white" href="#">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="#">
                                <i class="fas fa-boxes me-2"></i>Quản lý sản phẩm
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="#">
                                <i class="fas fa-users me-2"></i>Quản lý khách hàng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="#">
                                <i class="fas fa-receipt me-2"></i>Đơn hàng
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2"><i class="fas fa-boxes me-2"></i>Quản lý sản phẩm</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
                            <i class="fas fa-plus me-1"></i> Thêm sản phẩm
                        </button>
                    </div>
                </div>

                <!-- Search and filter -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Tìm kiếm sản phẩm...">
                            <button class="btn btn-outline-secondary" type="button">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select">
                            <option selected>Danh mục</option>
                            <option>Điện thoại</option>
                            <option>Laptop</option>
                            <option>Phụ kiện</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select">
                            <option selected>Trạng thái</option>
                            <option>Còn hàng</option>
                            <option>Hết hàng</option>
                        </select>
                    </div>
                </div>

                <!-- Product table -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th width="5%">ID</th>
                                <th width="10%">Hình ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th width="10%">Danh mục</th>
                                <th width="10%">Giá</th>
                                <th width="10%">Số lượng</th>
                                <th width="10%">Trạng thái</th>
                                <th width="15%">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Sample data - replace with JSTL/EL -->
                            <tr>
                                <td>1</td>
                                <td><img src="https://via.placeholder.com/80" class="product-img rounded" alt="Product"></td>
                                <td>iPhone 14 Pro Max</td>
                                <td>Điện thoại</td>
                                <td>25.990.000₫</td>
                                <td>15</td>
                                <td><span class="badge bg-success">Còn hàng</span></td>
                                <td class="action-btns">
                                    <button class="btn btn-sm btn-warning me-1">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td><img src="https://via.placeholder.com/80" class="product-img rounded" alt="Product"></td>
                                <td>MacBook Pro M2 2023</td>
                                <td>Laptop</td>
                                <td>42.990.000₫</td>
                                <td>8</td>
                                <td><span class="badge bg-success">Còn hàng</span></td>
                                <td class="action-btns">
                                    <button class="btn btn-sm btn-warning me-1">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td><img src="https://via.placeholder.com/80" class="product-img rounded" alt="Product"></td>
                                <td>AirPods Pro 2</td>
                                <td>Phụ kiện</td>
                                <td>5.990.000₫</td>
                                <td>0</td>
                                <td><span class="badge bg-danger">Hết hàng</span></td>
                                <td class="action-btns">
                                    <button class="btn btn-sm btn-warning me-1">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">Trước</a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">Sau</a>
                        </li>
                    </ul>
                </nav>
            </main>
        </div>
    </div>

    <!-- Add Product Modal -->
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="addProductModalLabel"><i class="fas fa-plus me-1"></i> Thêm sản phẩm mới</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="productName" class="form-label">Tên sản phẩm</label>
                                <input type="text" class="form-control" id="productName" required>
                            </div>
                            <div class="col-md-6">
                                <label for="productCategory" class="form-label">Danh mục</label>
                                <select class="form-select" id="productCategory" required>
                                    <option value="">Chọn danh mục</option>
                                    <option value="phone">Điện thoại</option>
                                    <option value="laptop">Laptop</option>
                                    <option value="accessory">Phụ kiện</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="productPrice" class="form-label">Giá bán</label>
                                <div class="input-group">
                                    <input type="number" class="form-control" id="productPrice" required>
                                    <span class="input-group-text">₫</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="productQuantity" class="form-label">Số lượng</label>
                                <input type="number" class="form-control" id="productQuantity" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="productImage" class="form-label">Hình ảnh sản phẩm</label>
                            <input class="form-control" type="file" id="productImage">
                        </div>
                        <div class="mb-3">
                            <label for="productDescription" class="form-label">Mô tả sản phẩm</label>
                            <textarea class="form-control" id="productDescription" rows="3"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-primary">Lưu sản phẩm</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Xử lý sự kiện JavaScript tại đây
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Trang quản lý sản phẩm đã sẵn sàng');
        });
    </script>
</body>
</html>