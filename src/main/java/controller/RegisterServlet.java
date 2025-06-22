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
        request.getRequestDispatcher("/WEB-INF/register.jsp").forward(request, response);
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
            request.getRequestDispatcher("/WEB-INF/register.jsp").forward(request, response);
            return;
        }

        // Gán lại để giữ giá trị nếu có lỗi
        request.setAttribute("full_name", name);
        request.setAttribute("account", account);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("gender", gender);

        boolean hasError = false;

        // Regex kiểm tra
        if (name == null || !name.matches("^[a-zA-Z\\s]{3,}$")) {
            request.setAttribute("fullnameError", "Họ tên phải từ 3 ký tự trở lên, chỉ chứa chữ cái và khoảng trắng.");
            hasError = true;
        }

        if (account == null || !account.matches("^[a-zA-Z0-9_]{3,20}$")) {
            request.setAttribute("accountError", "Tên đăng nhập phải từ 3-20 ký tự, chỉ chứa chữ cái, số và dấu gạch dưới.");
            hasError = true;
        }

        if (email == null || !email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            request.setAttribute("emailError", "Email không đúng định dạng.");
            hasError = true;
        }

        if (phone == null || !phone.matches("^0[0-9]{9,10}$")) {
            request.setAttribute("phoneError", "Số điện thoại phải bắt đầu bằng 0 và có 10-11 chữ số.");
            hasError = true;
        }

        if (password == null || !password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{8,}$")) {
            request.setAttribute("passwordError", "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.");
            hasError = true;
        }

        if (hasError) {
            request.getRequestDispatcher("WEB-INF/register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra trùng dữ liệu
        UserDAO dao = new UserDAO();
        User existUser = dao.isUserTaken(account, phone, email);

        if (existUser != null) {
            if (existUser.getAccount().equals(account)) {
                request.setAttribute("accountError", "Tài khoản đã tồn tại.");
            }
            if (existUser.getEmail().equals(email)) {
                request.setAttribute("emailError", "Email đã được sử dụng.");
            }
            if (existUser.getPhone().equals(phone)) {
                request.setAttribute("phoneError", "Số điện thoại đã được đăng ký.");
            }
            request.getRequestDispatcher("WEB-INF/register.jsp").forward(request, response);
            return;
        }

        // Nếu hợp lệ thì tạo user
        User user = new User();
        user.setFullName(name);
        user.setAccount(account);
        user.setEmail(email);
        user.setPhone(phone);
        user.setGender(gender);
        user.setPassword(MD5PasswordHasher.hashPassword(password));

        if (dao.insert(user)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("registerError", "Đăng ký thất bại. Vui lòng thử lại!");
            request.getRequestDispatcher("WEB-INF/register.jsp").forward(request, response);
        }
    }
}
