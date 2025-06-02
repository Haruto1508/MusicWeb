<%-- 
    Document   : info
    Created on : May 24, 2025, 2:50:06 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row">
    <div class="col-md-8">
        <div class="card">
            <h1 class="text-center fw-bold py-4">Information</h1>
            <div class="card-body">
                <form id="userInfoForm" action="updateUser" method="POST">
                    <div class="mb-3">
                        <label class="info-label">Full Name:</label>
                        <p class="info-value" id="fullNameView">${user.fullName}</p>
                        <input type="text" class="form-control info-edit" id="fullNameEdit" name="fullName" value="${user.fullName}" style="display: none;">
                    </div>
                    <div class="mb-3">
                        <label class="info-label">Email:</label>
                        <p class="info-value" id="emailView">${user.email}</p>
                        <input type="email" class="form-control info-edit" id="emailEdit" name="email" value="${user.email}" style="display: none;" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="info-label">Phone:</label>
                        <p class="info-value" id="phoneView">${user.phone}</p>
                        <input type="tel" class="form-control info-edit" id="phoneEdit" name="phone" value="${user.phone}" style="display: none;">
                    </div>
                    <div class="mb-3">
                        <label class="info-label">Address:</label>
                        <p class="info-value" id="addressView">${user.address}</p>
                        <input type="text" class="form-control info-edit" id="addressEdit" name="address" value="${user.address}" style="display: none;">
                    </div>
                    <div class="mb-3">
                        <label class="info-label">Created date:</label>
                        <p class="info-value">${user.createDateTime}</p>
                    </div>
                    <hr>
                    <div class="text-center">
                        <button type="button" id="editBtn" class="btn btn-primary"><i class="fas fa-edit"></i> Edit</button>
                        <button type="submit" id="saveBtn" class="btn btn-success" style="display: none;"><i class="fas fa-save"></i> Save</button>
                        <button type="button" id="cancelBtn" class="btn btn-secondary" style="display: none;"><i class="fas fa-times"></i> Cancel</button>
                        <button type="button" id="logoutBtn" class="btn btn-danger"><i class="fas fa-sign-out-alt"></i> Logout</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Chuyển đổi giữa chế độ xem và chỉnh sửa
        $('#editBtn').click(function() {
            $('.info-value').hide();
            $('.info-edit').show();
            $('#editBtn').hide();
            $('#saveBtn').show();
            $('#cancelBtn').show();
        });
        
        // Hủy bỏ chỉnh sửa
        $('#cancelBtn').click(function() {
            $('.info-edit').hide();
            $('.info-value').show();
            $('#saveBtn').hide();
            $('#cancelBtn').hide();
            $('#editBtn').show();
            
            // Reset giá trị về ban đầu
            $('#fullNameEdit').val($('#fullNameView').text());
            $('#phoneEdit').val($('#phoneView').text());
            $('#addressEdit').val($('#addressView').text());
        });
        
        // Xử lý logout
        $('#logoutBtn').click(function() {
            window.location.href = 'logout';
        });
        
        // Xử lý submit form
        $('#userInfoForm').submit(function(e) {
            e.preventDefault();
            
            // Validate dữ liệu
            if(!validateForm()) {
                return false;
            }
            
            // Gửi dữ liệu bằng AJAX
            $.ajax({
                url: 'updateUser',
                type: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    if(response.success) {
                        // Cập nhật giá trị hiển thị
                        $('#fullNameView').text($('#fullNameEdit').val());
                        $('#phoneView').text($('#phoneEdit').val());
                        $('#addressView').text($('#addressEdit').val());
                        
                        // Quay về chế độ xem
                        $('.info-edit').hide();
                        $('.info-value').show();
                        $('#saveBtn').hide();
                        $('#cancelBtn').hide();
                        $('#editBtn').show();
                        
                        // Hiển thị thông báo thành công
                        alert('Information updated successfully!');
                    } else {
                        alert('Update failed: ' + response.message);
                    }
                },
                error: function() {
                    alert('An error occurred while updating information.');
                }
            });
        });
        
        // Hàm validate form
        function validateForm() {
            const phone = $('#phoneEdit').val();
            const fullName = $('#fullNameEdit').val();
            
            // Validate tên không rỗng
            if(!fullName || fullName.trim() === '') {
                alert('Full name cannot be empty');
                return false;
            }
            
            // Validate số điện thoại (nếu cần)
            if(phone && !/^\d+$/.test(phone)) {
                alert('Phone number must contain only digits');
                return false;
            }
            
            return true;
        }
    });
</script>