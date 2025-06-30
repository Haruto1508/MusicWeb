<%-- 
    Document   : address
    Created on : May 30, 2025, 15:015:39 AM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container">
    <div class="mx-auto">
        <!-- Header -->
        <div class="text-center mb-4">
            <h3 class="text-primary fw-bold">
                <i class="fas fa-map-marker-alt me-2"></i> Địa chỉ của tôi
            </h3>
        </div>

        <!-- Danh sách địa chỉ -->
        <div class="row g-4">
            <!-- Địa chỉ mẫu - lặp lại cho từng địa chỉ -->
            <c:choose>
                <c:when test="${not empty addresses}">
                    <c:forEach var="address" items="${addresses}">
                        <div class="col-12">
                            <div class="card shadow-sm border-0 rounded-4 p-3">
                                <div class="d-flex justify-content-between align-items-start">
                                    <!-- Thông tin người nhận -->
                                    <div>
                                        <h5 class="fw-semibold mb-1 text-dark">
                                            <i class="fas fa-user text-primary me-2"></i>
                                            ${address.user.fullName}
                                            <c:if test="${address.isDefault}">
                                                <span class="badge bg-success ms-2">Default</span>
                                            </c:if>
                                        </h5>
                                        <span class="badge bg-info text-dark">${address.type}</span>
                                    </div>

                                    <!-- Nút thao tác -->
                                    <div class="btn-group">
                                        <button class="btn btn-outline-primary btn-sm" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-outline-danger btn-sm" title="Xóa">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </div>

                                <!-- Chi tiết địa chỉ -->
                                <div class="row mt-3">
                                    <div class="col-md-6">
                                        <p class="mb-1"><i class="fas fa-phone text-success me-2"></i><strong>SĐT:</strong> ${address.user.phone}</p>
                                        <p class="mb-1"><i class="fas fa-map-marker-alt text-danger me-2"></i><strong>Địa chỉ:</strong> ${address.street}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <p class="mb-1 text-muted"><i class="fas fa-location-dot me-2"></i>${address.ward}, ${address.district}, ${address.city}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <!-- Trạng thái rỗng -->
                    <div class="card shadow text-center mt-5 py-5">
                        <i class="fas fa-map-marker-alt fa-3x text-muted mb-3"></i>
                        <h5 class="text-muted">Chưa có địa chỉ nào</h5>
                        <p class="text-muted">Bạn chưa thêm địa chỉ nào.</p>
                    </div>
                </c:otherwise>
            </c:choose>

             
        </div>
        
        <div class="row g-4">
            <button type="button" class="btn btn-primary ms-4" data-bs-toggle="modal" data-bs-target="#editModal"> Thêm địa chỉ </button>
        </div>
    </div>
</div>

<!-- Modal chỉnh sửa Address -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="post" action="Crud">
                <input type="hidden" name="action" value="edit">

                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Địa chỉ</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="editId" class="form-label">Đường</label>
                        <input type="text" class="form-control" id="editId" name="id" readonly> 
                    </div>
                    <div class="mb-3">
                        <label for="editName" class="form-label">Phường</label>
                        <input type="text" class="form-control" id="editName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="editName" class="form-label">Quận</label>
                        <input type="text" class="form-control" id="editName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="editName" class="form-label">Thành phố</label>
                        <input type="text" class="form-control" id="editName" name="name" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Bỏ</button>
                    <button type="submit" class="btn btn-primary">Lưu địa chỉ</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function editArtist(id, name) {
        // Đặt giá trị vào input trong modal
        document.getElementById('editId').value = id;
        document.getElementById('editName').value = name;
    }

    function confirmDelete(id) {
        if (confirm("Are you sure you want to delete this artist?")) {
            window.location.href = '${pageContext.request.contextPath}/Crud?action=delete&id=' + id;
        }
    }
</script>