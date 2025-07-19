<%-- 
    Document   : productView
    Created on : Jun 17, 2025, 5:41:46 PM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Product View - MusicShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product.view.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
</head>
<body>
    <%@ include file="/WEB-INF/include/header.jsp" %>
    <div class="container py-5">
        <c:choose>
            <c:when test="${not empty product}">
                <div class="product-detail">
                    <div class="row">
                        <div class="col-md-6 product-images">
                            <span class="badge">Favourite</span>
                            <img src="${pageContext.request.contextPath}/${product.imageUrl}" alt="${product.name}" class="product-main-image">
                            <div class="product-thumbnail-images">
                                <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=600&q=80" alt="Guitar Acoustic">
                                <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=600&q=80" alt="Guitar Acoustic">
                                <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=600&q=80" alt="Guitar Acoustic">
                            </div>
                        </div>
                        <div class="col-md-6 product-info">
                            <h1>${product.name}</h1>
                            <div class="rating">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star-half"></i>
                                (150 Rate)
                            </div>
                            <div class="price">
                                Price: <strong><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>đ</strong>
                            </div>
                            <p class="text-muted">Quantity in stock: ${product.stockQuantity}</p>
                            <p>
                                Brand: <strong>${product.brand.name}</strong><br>
                                Category: <strong>${not empty product.category.name ? product.category.name : 'Unknown'}</strong><br>
                                Material: <strong>${not empty product.material ? product.material : 'Unknown'}</strong><br>
                                Year of manufacture: <strong>${product.yearOfManufacture != 0 ? product.yearOfManufacture : 'Unknown'}</strong><br>
                                Made in: <strong>${not empty product.madeIn ? product.madeIn : 'Unknown'}</strong>
                            </p>
                            <div class="quantity d-flex align-items-center">
                                <label for="userQuantityInput">Quantity: </label>
                                <button type="button" class="btn btn-outline-secondary" onclick="changeQuantity(-1)">−</button>
                                <input type="number" id="userQuantityInput" name="quantity" class="form-control text-center mx-2"
                                       value="1" min="1" max="${product.stockQuantity}" style="width: 60px;">
                                <button type="button" class="btn btn-outline-secondary" onclick="changeQuantity(1)">+</button>
                            </div>
                            <div class="actions mt-3">
                                <div class="d-flex">
                                    <c:choose>
                                        <c:when test="${product.stockQuantity > 0}">
                                            <form action="${pageContext.request.contextPath}/cart" method="get">
                                                <input type="hidden" name="productId" value="${product.productId}">
                                                <input type="hidden" name="quantity" id="addToCartQuantity" value="1">
                                                <input type="hidden" name="action" value="add">
                                                <button type="submit" class="btn btn-danger add-to-cart">
                                                    <i class="fa fa-cart-plus"></i> Add to cart
                                                </button>
                                            </form>
                                            <form id="buyNowForm" action="${pageContext.request.contextPath}/order-confirm" method="post" class="d-inline">
                                                <input type="hidden" name="productId" value="${product.productId}">
                                                <input type="hidden" name="quantity" id="buyNowQuantity" value="1">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fa fa-shopping-cart"></i> Buy now
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn btn-danger add-to-cart" disabled>
                                                <i class="fa fa-cart-plus"></i> Sold out
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="product-description mt-5">
                        <h2>Product Description</h2>
                        <p>${product.description}</p>
                    </div>

                    <div class="product-reviews mt-5">
                        <h2>Product Reviews</h2>
                        <c:if test="${not empty sessionScope.user}">
                            <form action="${pageContext.request.contextPath}/product" method="post" class="comment-form mb-4">
                                <input type="hidden" name="action" value="addReview">
                                <input type="hidden" name="productId" value="${product.productId}">
                                <div class="mb-3">
                                    <label for="rating" class="form-label">Rating:</label>
                                    <select class="form-select" name="rating" id="rating" required>
                                        <option value="1">1 Star</option>
                                        <option value="2">2 Stars</option>
                                        <option value="3">3 Stars</option>
                                        <option value="4">4 Stars</option>
                                        <option value="5">5 Stars</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <textarea class="form-control" name="comment" rows="4" placeholder="Write your review..." required></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary comment-btn"><i class="fa-solid fa-comment"></i> Post Review</button>
                            </form>
                        </c:if>
                        <c:if test="${empty sessionScope.user}">
                            <p class="text-muted">Please <a href="${pageContext.request.contextPath}/login">log in</a> to post a review.</p>
                        </c:if>

                        <div class="comment-list" id="commentList">
                            <c:choose>
                                <c:when test="${not empty reviews}">
                                    <c:forEach var="review" items="${reviews}">
                                        <div class="comment-item" data-review-id="${review.reviewId}">
                                            <div class="comment-header">
                                                <span class="comment-username">${review.user.account}</span>
                                                <span class="comment-date">
                                                    <fmt:formatDate value="${review.commentDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                </span>
                                            </div>
                                            <div class="comment-rating">
                                                <c:forEach begin="1" end="${review.rating}">
                                                    <i class="fa fa-star text-warning"></i>
                                                </c:forEach>
                                                <c:forEach begin="${review.rating + 1}" end="5">
                                                    <i class="fa fa-star text-muted"></i>
                                                </c:forEach>
                                            </div>
                                            <div class="comment-content">${review.comment}</div>
                                            <c:if test="${sessionScope.user != null && (sessionScope.user.userId == review.user.userId || sessionScope.user.isAdmin)}">
                                                <div class="comment-actions">
                                                    <button class="btn btn-sm btn-outline-primary edit-comment-btn" onclick="editReview(${review.reviewId}, this)">
                                                        <i class="fa-solid fa-edit"></i> Edit
                                                    </button>
                                                    <form action="${pageContext.request.contextPath}/product" method="post" style="display:inline;">
                                                        <input type="hidden" name="action" value="deleteReview">
                                                        <input type="hidden" name="reviewId" value="${review.reviewId}">
                                                        <button type="submit" class="btn btn-sm btn-outline-danger delete-comment-btn">
                                                            <i class="fa-solid fa-trash"></i> Delete
                                                        </button>
                                                    </form>
                                                </div>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted">No reviews yet. Be the first to review!</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <button class="btn btn-primary scroll-to-top-comment" id="scrollToTopComment" style="display: none;">
                            <i class="fa-solid fa-arrow-up"></i> Back to Top
                        </button>
                    </div>

                    <div class="product-related mt-5">
                        <h2>Related Products</h2>
                        <div class="row">
                            <c:forEach var="relatedProduct" items="${relatedList}">
                                <div class="col-md-3">
                                    <div class="card">
                                        <img src="${pageContext.request.contextPath}/${relatedProduct.imageUrl}" class="card-img-top" alt="${relatedProduct.name}">
                                        <div class="card-body">
                                            <h5 class="card-title">${relatedProduct.name}</h5>
                                            <p class="card-text"><fmt:formatNumber value="${relatedProduct.price}" type="number" groupingUsed="true"/>đ</p>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/product?id=${relatedProduct.productId}" class="text-decoration-none text-center text-dark">View detail</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div>
                        <h3>Product does not exist!</h3>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <%@include file="/WEB-INF/include/toast.jsp" %>
        <%@ include file="/WEB-INF/include/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Helper function to escape special characters
            function escapeHtml(text) {
                const div = document.createElement('div');
                div.textContent = text;
                return div.innerHTML;
            }

            // Update quantity for forms
            function updateQuantityForms() {
                const quantityInput = document.getElementById('userQuantityInput');
                const buyNowQuantity = document.getElementById('buyNowQuantity');
                const addToCartQuantity = document.getElementById('addToCartQuantity');
                if (quantityInput && buyNowQuantity && addToCartQuantity) {
                    buyNowQuantity.value = quantityInput.value;
                    addToCartQuantity.value = quantityInput.value;
                }
            }

            // Handle quantity change
            function changeQuantity(delta) {
                const input = document.getElementById('userQuantityInput');
                if (input) {
                    let value = parseInt(input.value);
                    const min = parseInt(input.min);
                    const max = parseInt(input.max);
                    value = Math.min(max, Math.max(min, value + delta));
                    input.value = value;
                    updateQuantityForms();
                }
            }

            // Initialize quantity
            updateQuantityForms();
            const quantityInput = document.getElementById('userQuantityInput');
            if (quantityInput) {
                quantityInput.addEventListener('input', updateQuantityForms);
            }

            // Scroll to Top Button for Comment Section
            const commentList = document.getElementById('commentList');
            const scrollToTopComment = document.getElementById('scrollToTopComment');
            if (commentList && scrollToTopComment) {
                commentList.addEventListener('scroll', () => {
                    scrollToTopComment.style.display = commentList.scrollTop > 100 ? 'block' : 'none';
                });
                scrollToTopComment.addEventListener('click', () => {
                    commentList.scrollTo({ top: 0, behavior: 'smooth' });
                });
            }

            // Edit Review Function
            function editReview(reviewId, button) {
                const reviewItem = button.closest('.comment-item');
                const reviewContent = reviewItem.querySelector('.comment-content');
                const reviewActions = reviewItem.querySelector('.comment-actions');
                const content = reviewContent.textContent; // Get raw content
                const rating = Array.from(reviewItem.querySelectorAll('.comment-rating .fa-star.text-warning')).length;

                // Create form dynamically
                const form = document.createElement('form');
                form.action = '${pageContext.request.contextPath}/product';
                form.method = 'post';
                form.className = 'edit-comment-form';

                // Create select element for rating
                const select = document.createElement('select');
                select.className = 'form-select';
                select.name = 'rating';
                select.id = 'rating-' + reviewId;
                select.required = true;
                for (let i = 1; i <= 5; i++) {
                    const option = document.createElement('option');
                    option.value = i;
                    option.textContent = i + (i === 1 ? ' Star' : ' Stars');
                    if (i === rating) {
                        option.selected = true;
                    }
                    select.appendChild(option);
                }

                // Create textarea element
                const textarea = document.createElement('textarea');
                textarea.className = 'form-control mb-2';
                textarea.name = 'comment';
                textarea.rows = 3;
                textarea.required = true;
                textarea.value = content; // Set unescaped content directly

                form.innerHTML = `
                    <input type="hidden" name="action" value="editReview">
                    <input type="hidden" name="reviewId" value="${reviewId}">
                    <div class="mb-3">
                        <label for="rating-${reviewId}" class="form-label">Rating:</label>
                    </div>
                    <button type="submit" class="btn btn-sm btn-primary"><i class="fa-solid fa-save"></i> Save</button>
                    <button type="button" class="btn btn-sm btn-secondary" onclick="cancelEdit(${reviewId}, this)">Cancel</button>
                `;
                // Append select and textarea
                const labelDiv = form.querySelector('.mb-3');
                labelDiv.appendChild(select);
                form.insertBefore(textarea, form.querySelector('button[type="submit"]'));

                reviewContent.innerHTML = '';
                reviewContent.appendChild(form);
                reviewActions.style.display = 'none';
            }

            // Cancel Edit Function
            function cancelEdit(reviewId, button) {
                const reviewItem = button.closest('.comment-item');
                const reviewContent = reviewItem.querySelector('.comment-content');
                const reviewActions = reviewItem.querySelector('.comment-actions');
                const originalContent = reviewContent.querySelector('textarea').value; // Get from textarea
                reviewContent.innerHTML = escapeHtml(originalContent);
                reviewActions.style.display = 'flex';
            }
        </script>
    </body>
</html>