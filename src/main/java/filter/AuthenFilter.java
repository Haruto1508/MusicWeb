 /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
@WebFilter(filterName="AuthenFilter", urlPatterns = {
    "/account", "/order", "/updateUser", "/order-confirm", "/address", "/cart",
    "/avatar"
}) 
public class AuthenFilter implements  Filter{

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        System.out.println("Start Auth Filter");
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        HttpSession session = req.getSession();
        
        if (session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
//            res.sendRedirect(req.getContextPath() + "/error-page/404page.jsp");
            return;
        }
        
        System.out.println("End AuthFilter");
        chain.doFilter(request, response);
    }
}
