<%-- 
    Document   : header
    Created on : May 21, 2025, 10:38:27 AM
    Author     : Nguyen Hoang Thai Vinh - CE190384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home"><i class="fa-solid fa-music"></i> MusicShop</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-lg-center">
                <li class="nav-item">
                    <a class="nav-link active fw-semibold" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle fw-semibold" href="#" id="productDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        Sản phẩm
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="productDropdown">
                        <li><a class="dropdown-item" href="#">Guitar</a></li>
                        <li><a class="dropdown-item" href="#">Piano & Keyboard</a></li>
                        <li><a class="dropdown-item" href="#">Violin</a></li>
                        <li><a class="dropdown-item" href="#">Micro & accessories</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item" href="#">Tất cả sản phẩm </a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="#">Giới thiệu</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="#contact">Liên lạc</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle fw-semibold" href="#" id="accountDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-user"></i> Tài khoản
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="accountDropdown">
                        <c:choose>
                            <c:when test="${not empty user}">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/account?view=info">Tài khoản</a></li>
                                <li><a class="dropdown-item" href="#">Lịch sử mua hàng</a></li>
                                <li><hr class="dropdown-divider"> </li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/path?page=login">Đăng nhập</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/path?page=register">Đăng kí</a></li>
                            </c:otherwise> 
                        </c:choose>
                    </ul>
                </li>
                <li class="nav-item mx-2">
                    <form class="d-flex" role="search">
                        <input class="form-control form-control-sm me-2 rounded-pill" type="search" placeholder="Tìm kiếm..." aria-label="Search">
                        <button class="btn btn-light btn-sm rounded-pill px-3" type="submit"><i class="fa fa-search text-primary"></i></button>
                    </form>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fa-solid fa-cart-shopping"></i> Giỏ hàng</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<script>
    let lastScrollTop = 0;
    const navbar = document.querySelector('.navbar');

    window.addEventListener('scroll', function () {
        const currentScroll = window.pageYOffset || document.documentElement.scrollTop;

        if (currentScroll > lastScrollTop) {
            // Scroll down
            navbar.style.top = "-100px";
        } else {
            // Scroll up
            navbar.style.top = "0";
        }

        lastScrollTop = currentScroll <= 0 ? 0 : currentScroll;
    });
</script>
