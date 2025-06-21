/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
@WebFilter(filterName = "AdminAuthFilter", urlPatterns = {"/*"})
public class AdminAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        String uri = req.getRequestURI();
        String context = req.getContextPath();

        // Bỏ qua login và tài nguyên tĩnh
        if (uri.contains("/login") || uri.contains("/logout")
                || uri.contains("/css") || uri.contains("/js") || uri.contains("/img")) {
            chain.doFilter(request, response);
            return;
        }

        // Kiểm tra đăng nhập
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(context + "/login");
            return;
        }

        // Ngăn cache
//        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
//        res.setHeader("Pragma", "no-cache");
//        res.setDateHeader("Expires", 0);
//
//        // Phân quyền
//        User user = (User) session.getAttribute("user");
//        int roleId = user.getRole().getId();
//
//        if (uri.startsWith(context + "/admin") && roleId != 2) {
//            res.sendRedirect(context + "/403.jsp"); // hoặc sendError nếu thích
//            return;
//        }
//
//        if (uri.startsWith(context + "/user") && (roleId != 1 && roleId != 2)) {
//            res.sendRedirect(context + "/403.jsp");
//            return;
//        }

        chain.doFilter(request, response);
    }
}
