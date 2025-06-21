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
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

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
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
        // Clear existing session
        HttpSession currentSession = request.getSession(false);
        if (currentSession != null) {
            currentSession.invalidate();
        }

        // Get parameters with null checks
        String name = request.getParameter("full_name");
        String account = request.getParameter("account");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String password = request.getParameter("password");

        // Validate required fields
        if (name == null || account == null || email == null || phone == null || password == null) {
            request.setAttribute("error", "Please fill in all information!");
            request.getRequestDispatcher("WEB-INF/register.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User existUser = userDAO.isUserTaken(account, phone, email);
        boolean hasError = false;

        // Check for duplicates separately
        if (existUser != null) {
            if (existUser.getAccount().equals(account)) {
                request.removeAttribute("accountError");
                request.setAttribute("accountError", "Account name already exists");
                hasError = true;
            }

            if (existUser.getEmail().equals(email)) {
                request.removeAttribute("emailError");
                request.setAttribute("emailError", "Email has been registered");
                hasError = true;
            }

            if (existUser.getPhone().equals(phone)) {
                request.removeAttribute("phoneError");
                request.setAttribute("phoneError", "Phone number already in use");
                hasError = true;
            }
        
        }

        if (hasError) {
            // Preserve input values
            request.setAttribute("full_name", name);
            request.setAttribute("account", account);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("gender", gender);

            request.getRequestDispatcher("WEB-INF/register.jsp").forward(request, response);
            return;
        }

        // Create new user
        User user = new User();
        user.setFullName(name);
        user.setAccount(account);
        user.setPhone(phone);
        user.setEmail(email);
        user.setGender(gender);

        // Hash password before saving (using BCrypt for example)
        String hashedPassword = MD5PasswordHasher.hashPassword(password);
        user.setPassword(hashedPassword);

        if (userDAO.insert(user)) {
            // Optionally auto-login after registration
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("registerError", "Đăng ký thất bại. Vui lòng thử lại!");
            request.getRequestDispatcher("WEB-INF/register.jsp").forward(request, response);
        }
    }
}
