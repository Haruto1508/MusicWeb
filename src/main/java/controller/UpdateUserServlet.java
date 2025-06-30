/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import model.User;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
@WebServlet(name = "UpdateUserServlet", urlPatterns = {"/updateUser"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UpdateUserServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateUserServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateUserServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login"); // Hoặc trang báo lỗi
            return;
        }
        setBirthdateAttributes(user, request);

        System.out.println(user.toString());

        String fullName = request.getParameter("fullName").trim();
        String account = request.getParameter("account").trim();
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone").trim();
        String gender = request.getParameter("gender").trim();
        String day = request.getParameter("birth_day");
        String month = request.getParameter("birth_month");
        String year = request.getParameter("birth_year");

        UserDAO userDAO = new UserDAO();
        boolean hasError = false;

        // Check for duplicates separately
        int userId = user.getUserId();
        System.out.println(userId);

        if (userDAO.isAccountTaken(account, userId)) {
            request.removeAttribute("accountError");
            request.setAttribute("accountError", "Account name already exists");
            request.setAttribute("updateFail", "Cập nhật thông tin không thành công!");
            request.setAttribute("view", "info");
            System.out.println("account fail");
            request.getRequestDispatcher("WEB-INF/user/profile.jsp").forward(request, response);
            hasError = true;
        }

        if (userDAO.isEmailTaken(email, userId)) {
            request.removeAttribute("emailError");
            request.setAttribute("emailError", "Email has been registered");
            request.setAttribute("updateFail", "Cập nhật thông tin không thành công!");
            request.setAttribute("view", "info");
            System.out.println("email fail");
            request.getRequestDispatcher("WEB-INF/user/profile.jsp").forward(request, response);
            hasError = true;
        }

        if (userDAO.isPhoneTaken(phone, userId)) {
            request.removeAttribute("phoneError");
            request.setAttribute("phoneError", "Phone number already in use");
            request.setAttribute("updateFail", "Cập nhật thông tin không thành công!");
            request.setAttribute("view", "info");
            System.out.println("phone fail");
            request.getRequestDispatcher("WEB-INF/user/profile.jsp").forward(request, response);
            hasError = true;
        }

        if (hasError) {
            return;
        }

        if (fullName == null || fullName.trim().isEmpty()) {
            request.removeAttribute("fullNameError");
            request.setAttribute("fullNameError", "Họ tên không được để trống");
            request.setAttribute("updateFail", "Cập nhật thông tin không thành công!");
            request.setAttribute("view", "info");
            System.out.println("name fail");
            request.getRequestDispatcher("WEB-INF/user/profile.jsp").forward(request, response);
            return;
        }

        if (email == null || !email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            request.removeAttribute("emailError");
            request.setAttribute("emailError", "Email không hợp lệ");
            request.setAttribute("updateFail", "Cập nhật thông tin không thành công!");
            request.setAttribute("view", "info");
            System.out.println("email fail 2");
            request.getRequestDispatcher("WEB-INF/user/profile.jsp").forward(request, response);
            return;
        }

        if (phone != null && !phone.matches("^\\d{10,11}$")) {
            request.removeAttribute("phoneError");
            request.setAttribute("phoneError", "Số điện thoại phải từ 10 đến 11 chữ số");
            request.setAttribute("updateFail", "Cập nhật thông tin không thành công!");
            request.setAttribute("view", "info");
            System.out.println("phone fail 2");
            request.getRequestDispatcher("WEB-INF/user/profile.jsp").forward(request, response);
            return;
        }

        if (day != null && month != null && year != null) {
            try {
                LocalDate birthdate = LocalDate.of(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day));
                user.setBirthdate(birthdate);
            } catch (DateTimeParseException | NumberFormatException e) {
                e.printStackTrace();
            }
        }

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setGender(gender);
        user.setAccount(account);

        boolean isUpdateSuccess = userDAO.update(user);
        System.out.println(user.toString());
        if (isUpdateSuccess) {
            session.setAttribute("user", user);
            System.out.println("cap nhat thanh cong");
            request.setAttribute("updateSuccess", "Cập nhật thông tin thành công!");
            request.setAttribute("view", "info");
            request.getRequestDispatcher("WEB-INF/user/profile.jsp").forward(request, response);
        } else {
            System.out.println("cap nhat that bai");
            request.setAttribute("updateFail", "Cập nhật thông tin không thành công!");
            request.setAttribute("view", "info");
            request.getRequestDispatcher("WEB-INF/user/profile.jsp").forward(request, response);
        }
    }
  
    private void setBirthdateAttributes(User user, HttpServletRequest request) {
        if (user.getBirthdate() != null) {
            DateTimeFormatter inputFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            DateTimeFormatter displayFmt = DateTimeFormatter.ofPattern("dd-MM-yyyy");
            request.setAttribute("birthdateInputValue", user.getBirthdate().format(inputFmt));
            request.setAttribute("birthdateTextValue", user.getBirthdate().format(displayFmt));
        } else {
            request.setAttribute("birthdateInputValue", "");
            request.setAttribute("birthdateTextValue", "");
        }
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
