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
                <div class="mb-3">
                    <label class="info-label">Full Name:</label>
                    <p class="info-value">${user.fullName}</p>
                </div>
                <div class="mb-3">
                    <label class="info-label">Email:</label>
                    <p class="info-value">${user.email}</p>
                </div>
                <div class="mb-3">
                    <label class="info-label">Phone:</label>
                    <p class="info-value">${user.phone}</p>
                </div>
                <div class="mb-3">
                    <label class="info-label">Address:</label>
                    <p class="info-value">${user.address}</p>
                </div>
                <div class="mb-3">
                    <label class="info-label">Created date:</label>
                    <p class="info-value">${user.createDateTime}</p>
                </div>
                <hr>
                <div class="text-center">
                    <button class="btn btn-primary"><i class="fas fa-edit"></i> Edit</button>
                    <button class="btn btn-danger"><i class="fas fa-sign-out-alt"></i> Logout</button>
                </div>
            </div>
        </div>
    </div>
</div>

