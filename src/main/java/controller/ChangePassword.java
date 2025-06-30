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
@WebServlet(name = "ChangePassword", urlPatterns = {"/change-password"})
public class ChangePassword extends HttpServlet {

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
            out.println("<title>Servlet ChangePassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePassword at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String oldPassword = request.getParameter("oldPw");
        String newPassword = request.getParameter("newPw");
        String confirmPassword = request.getParameter("confirmPw");

        System.out.println(oldPassword);
        System.out.println(newPassword);
        System.out.println(confirmPassword);
        System.out.println(user.getUserId() + " " + user.getPassword());

        // Kiểm tra mật khẩu cũ
        if (!MD5PasswordHasher.checkPassword(oldPassword, user.getPassword())) {
            System.out.println(MD5PasswordHasher.hashPassword(oldPassword));
            System.out.println(user.toString());
            System.out.println(user.getPassword());
            request.removeAttribute("oldPwError");
            request.setAttribute("oldPwError", "Mật khẩu cũ không chính xác!");
            request.setAttribute("updateFail", "Thay đổi mật khẩu thất bại!");
            request.setAttribute("view", "password");
            request.getRequestDispatcher("/WEB-INF/user/profile.jsp").forward(request, response);
            return;  // quan trọng: phải return sau forward
        }

        // Kiểm tra confirm password
        if (!newPassword.equals(confirmPassword)) {
            request.removeAttribute("confirmPwError");
            request.setAttribute("confirmPwError", "Mật khẩu nhập lại không chính xác!");
            request.setAttribute("updateFail", "Thay đổi mật khẩu thất bại!");
            request.setAttribute("view", "password");
            request.getRequestDispatcher("/WEB-INF/user/profile.jsp").forward(request, response);
            return;
        }

        if (!newPassword.matches("^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@#$%^&+=!]).{8,}$")) {
            request.removeAttribute("newPwError");
            request.setAttribute("newPwError", "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt!");
            request.setAttribute("updateFail", "Thay đổi mật khẩu thất bại!");
            request.setAttribute("view", "password");
            request.getRequestDispatcher("/WEB-INF/user/profile.jsp").forward(request, response);
            return;
        }

        String newHashPw = MD5PasswordHasher.hashPassword(newPassword);
        boolean isUpdatePw = new UserDAO().updatePasswordByUserId(newHashPw, user.getUserId());

        if (isUpdatePw) {
            user.setPassword(newHashPw);
            session.setAttribute("user", user);
            request.setAttribute("updateSuccess", "Thay đổi mật khẩu thành công!");
        } else {
            request.setAttribute("updateFail", "Thay đổi mật khẩu thất bại!");
        }

        request.setAttribute("view", "password");
        request.getRequestDispatcher("/WEB-INF/user/profile.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
