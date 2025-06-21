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
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
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
        String action = request.getParameter("action");

        switch (action) {
            case "updateInfo":
                doUpdateInfo(request, response, user, session);
                break;
            case "updateAvatar":
                doUpdateAvatar(request, response, user, session);
                break;
            default:
                request.setAttribute("error", "Thao tác không hợp lệ");
        }

        setBirthdateAttributes(user, request);
        request.setAttribute("user", user);
        request.setAttribute("view", "info");
        request.getRequestDispatcher("WEB-INF/user/profile.jsp").forward(request, response);
    }

    protected void doUpdateInfo(HttpServletRequest request, HttpServletResponse response, User user, HttpSession session) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String account = request.getParameter("account");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String day = request.getParameter("birth_day");
        String month = request.getParameter("birth_month");
        String year = request.getParameter("birth_year");

        UserDAO userDAO = new UserDAO();
        User existUser = userDAO.checkDuplicateAccountInfo(account, phone, email, user.getUserId());
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
            return;
        }

        if (fullName == null || fullName.trim().isEmpty()) {
            request.removeAttribute("fullNameError");
            request.setAttribute("fullNameError", "Họ tên không được để trống");
            return;
        }

        if (email == null || !email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            request.removeAttribute("emailError");
            request.setAttribute("emailError", "Email không hợp lệ");
            return;
        }

        if (phone != null && !phone.matches("^\\d{10,11}$")) {
            request.removeAttribute("phoneError");
            request.setAttribute("phoneError", "Số điện thoại phải từ 10 đến 11 chữ số");
            return;
        }

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setGender(gender);
        user.setAccount(account);

        if (day != null && month != null && year != null) {
            try {
                LocalDate birthdate = LocalDate.of(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day));
                user.setBirthdate(birthdate);
            } catch (DateTimeParseException | NumberFormatException e) {
                request.setAttribute("birthdateError", "Ngày sinh không hợp lệ");
                return;
            }
        }

        boolean isUpdateSuccess = new UserDAO().update(user);
        if (isUpdateSuccess) {
            session.setAttribute("user", user);
            request.setAttribute("message", "true");
        } else {
            request.setAttribute("message", "false");

        }
    }

    protected void doUpdateAvatar(HttpServletRequest request, HttpServletResponse response, User user, HttpSession session) throws ServletException, IOException {
        Part filePart = request.getPart("avatarFile");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadsDir = getServletContext().getRealPath("/uploads");
            File uploadDir = new File(uploadsDir);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String filePath = uploadsDir + File.separator + fileName;
            filePart.write(filePath);

            user.setImageUrl("/uploads/" + fileName);
            try {
                new UserDAO().update(user);
                session.setAttribute("user", user);
                request.setAttribute("message", "Cập nhật ảnh đại diện thành công");
            } catch (Exception e) {
                request.setAttribute("error", "Lỗi khi cập nhật ảnh đại diện");
            }
        } else {
            request.setAttribute("error", "Vui lòng chọn file ảnh");
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
