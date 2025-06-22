/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import hashpw.MD5PasswordHasher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userInfo = request.getParameter("info");
        String password = request.getParameter("password");
        String hashPasswod = MD5PasswordHasher.hashPassword(password);
        UserDAO userDAO = new UserDAO();

        User loginUser = userDAO.getUserLogin(userInfo, hashPasswod);

        if (loginUser != null) {
            HttpSession session = request.getSession();

            // check user role
            int roleId = loginUser.getRole().getId();

            if (roleId == 2) { // Admin
                request.getRequestDispatcher("/WEB-INF/admin/manager.jsp").forward(request, response);
            } else if (roleId == 1) { // User
                session.setAttribute("user", loginUser);
                session.setAttribute("message", "Welcome " + loginUser.getAccount());
                System.out.println("Login successful");        
                System.out.println(loginUser.getPassword());
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                // Nếu role không rõ ràng, logout
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/logout");
            }
        } else {
            request.setAttribute("info", userInfo);
            request.setAttribute("error", "User name or password is incorrect.");
            request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
            System.out.println("Login fail");//delete all files
        }
    }
}
