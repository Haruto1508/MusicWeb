<%-- 
    Document   : address
    Created on : May 30, 2025, 15:015:39 AM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container py-5" style="min-height: 85vh;">
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
    </div>
</div>