<%-- 
   Document   : order-history
   Created on : Jul 18, 2025, 11:20:18 AM
   Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container my-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="text-center">Order History</h3>
        <c:if test="${not empty histories}">
            <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal" data-action="deleteAll">
                Clear All History
            </button>
        </c:if>
    </div>

    <c:choose>
        <c:when test="${not empty histories}">
            <div class="row d-flex flex-column">
                <c:forEach var="order" items="${histories}">
                    <div class="col">
                        <div class="card border-0 shadow-sm p-3">
                            <div class="d-flex align-items-center">
                                <img src="${order.orderDetail.product.imageUrl}" alt="${order.orderDetail.product.name}" class="me-3" style="width: 80px; height: 80px; object-fit: cover;">
                                <div class="flex-grow-1">
                                    <strong>#${order.orderId}</strong><br>
                                    <small>${order.orderDetail.product.name}</small><br>
                                    <small class="text-muted">
                                        <c:choose>
                                            <c:when test="${not empty order.shippedDate}">
                                                <fmt:formatDate value="${order.shippedDate}" pattern="dd/MM/yyyy"/>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatDate value="${order.estimatedDelivery}" pattern="dd/MM/yyyy"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </small>
                                </div>
                                <div class="text-end d-flex">
                                    <a href="${pageContext.request.contextPath}/product?id=${order.orderDetail.product.productId}" class="btn btn-outline-primary btn-sm">See Details</a>
                                    <button class="btn btn-outline-danger btn-sm me-3" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal" data-action="delete" data-order-id="${order.orderId}">
                                        Delete
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center mt-4 p-4 bg-light rounded">
                <h5 class="text-muted">No Order History</h5>
                <p class="text-muted">You haven't placed any orders yet.</p>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-sm">Shop Now</a>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Modal xác nhận xóa -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmDeleteModalLabel">Confirm Delete</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Are you sure you want to <span id="deleteActionText"></span>?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form id="deleteForm" action="${pageContext.request.contextPath}/order" method="post">
                        <input type="hidden" name="action" id="deleteAction">
                        <input type="hidden" name="orderId" id="deleteOrderId">
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Xử lý sự kiện khi modal được hiển thị
    const confirmDeleteModal = document.getElementById('confirmDeleteModal');
    confirmDeleteModal.addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget; // Nút kích hoạt modal
        const action = button.getAttribute('data-action');
        const orderId = button.getAttribute('data-order-id') || '';

        // Cập nhật nội dung modal
        const actionText = document.getElementById('deleteActionText');
        const deleteActionInput = document.getElementById('deleteAction');
        const deleteOrderIdInput = document.getElementById('deleteOrderId');

        if (action === 'deleteAll') {
            actionText.textContent = 'delete all order history';
        } else {
            actionText.textContent = 'delete this order';
        }

        deleteActionInput.value = action;
        deleteOrderIdInput.value = orderId;
    });
</script>
