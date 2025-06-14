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
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpServletResponse httpServletResponse = (HttpServletResponse) response;
        HttpSession session = httpServletRequest.getSession(false);
        String contextPath = httpServletRequest.getContextPath();
        String requestURI = httpServletRequest.getRequestURI();

        // Bỏ qua login và các tài nguyên tĩnh
        if (requestURI.contains("/login") || requestURI.contains("/css") || requestURI.contains("/js") || requestURI.contains("/img")) {
            chain.doFilter(request, response);
            return;
        }
        
        // check for login
        if (session == null || session.getAttribute("user") == null) {
            httpServletResponse.sendRedirect(contextPath + "/login");
            return;
        }

        // check role
        User user = (User) session.getAttribute("user");
        int roleId = user.getRole().getId();
        String role;
        if (roleId == 2) { // roleId 2 for admin
            role = "admin";
        } else { // roleId 1 for user
            role = "user";
        }
        
        // access admin page but not an admin
        if (requestURI.startsWith(contextPath + "/admin") && !"admin".equals(role)) {
            httpServletResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }

        // access user page but not an user
        if (requestURI.startsWith(contextPath + "/user") && !("user".equals(role) || "admin".equals(role))) {
            httpServletResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }
        
        // access if valid 
        chain.doFilter(request, response);
    }
}
