/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import enums.Gender;
import java.io.IOException;
import jakarta.servlet.ServletException;
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
public class UpdateUserServlet extends HttpServlet {

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

        String fullName = request.getParameter("fullName").trim();
        String account = request.getParameter("account").trim();
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone").trim();
        String gender = request.getParameter("gender").trim();
        String day = request.getParameter("birth_day");
        String month = request.getParameter("birth_month");
        String year = request.getParameter("birth_year");

        System.out.println(year + " " + month + " " + day);
        UserDAO userDAO = new UserDAO();

        // Check for duplicates separately
        int userId = user.getUserId();

        // check for get id
        try {
            String id = String.valueOf(userId);
            System.out.println("Get id " + id + " success");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // check for duplicate user info
        if (isDuplicateUserInfo(request, userDAO, account, email, phone, userId)) {
            setBirthdateAttributes(user, request);
            setTempAttributes(request, fullName, account, email, phone, gender, day, month, year);
            request.getRequestDispatcher("WEB-INF/user/profile.jsp").forward(request, response);
            return;
        }

        // check for valid update info
        if (!isValidUpdateInfo(request, user, account, fullName, email, phone, day, month, year)) {
            setBirthdateAttributes(user, request);
            setTempAttributes(request, fullName, account, email, phone, gender, day, month, year);
            request.getRequestDispatcher("WEB-INF/user/profile.jsp").forward(request, response);
            return;
        }

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setGender(Gender.fromGender(Integer.parseInt(gender)));
        user.setAccount(account);

        boolean isUpdateSuccess = userDAO.update(user);
        System.out.println(user.toString());
        if (isUpdateSuccess) {
            session.setAttribute("user", user);
            System.out.println("cap nhat thanh cong");
            request.setAttribute("updateSuccess", "Cập nhật thông tin thành công!");
            setBirthdateAttributes(user, request);
            
            request.getRequestDispatcher("WEB-INF/user/profile.jsp").forward(request, response);
        } else {
            System.out.println("cap nhat that bai");
            setCommonFailAttributes(request);
            setBirthdateAttributes(user, request);
            
            request.getRequestDispatcher("WEB-INF/user/profile.jsp").forward(request, response);
        }
    }

    private void setBirthdateAttributes(User user, HttpServletRequest request) {
        int currentYear = LocalDate.now().getYear();
        DateTimeFormatter textFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String birthdateInputValue = user.getBirthdate() != null
                ? user.getBirthdate().format(inputFormatter)
                : "";
        String birthdateTextValue = user.getBirthdate() != null
                ? user.getBirthdate().format(textFormatter)
                : "";
        request.setAttribute("currentYear", currentYear);
        request.setAttribute("birthdateInputValue", birthdateInputValue);
        request.setAttribute("birthdateTextValue", birthdateTextValue);
    }

    private void setTempAttributes(HttpServletRequest request, String fullName, String account, String email, String phone, String gender, String day, String month, String year) {
        request.setAttribute("tempFullName", fullName);
        request.setAttribute("tempAccount", account);
        request.setAttribute("tempEmail", email);
        request.setAttribute("tempPhone", phone);
        request.setAttribute("tempGender", gender);
        request.setAttribute("birth_day", day);
        request.setAttribute("birth_month", month);
        request.setAttribute("birth_year", year);
    }

    private boolean isDuplicateUserInfo(HttpServletRequest request, UserDAO userDAO, String account, String email, String phone, int userId) {
        boolean hasError = false;
        if (userDAO.isAccountTaken(account, userId)) {
            request.setAttribute("accountError", "Account name already exists");
            setCommonFailAttributes(request);
            hasError = true;
        }

        if (userDAO.isEmailTaken(email, userId)) {
            request.setAttribute("emailError", "Email has been registered");
            setCommonFailAttributes(request);
            hasError = true;
        }

        if (userDAO.isPhoneTaken(phone, userId)) {
            request.setAttribute("phoneError", "Phone number already in use");
            setCommonFailAttributes(request);
            hasError = true;
        }

        return hasError;
    }

    private boolean isValidUpdateInfo(HttpServletRequest request, User user, String account, String fullName, String email, String phone, String day, String month, String year) {
        boolean isValid = true;

        if (account == null || account.trim().isEmpty()) {
            request.setAttribute("accountError", "Account không được để trống");
            setCommonFailAttributes(request);
            isValid = false;
        }
        
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("fullNameError", "Họ tên không được để trống");
            setCommonFailAttributes(request);
            isValid = false;
        }

        if (email == null || !email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            request.setAttribute("emailError", "Email không hợp lệ");
            setCommonFailAttributes(request);
            isValid = false;
        }

        if (phone != null && !phone.matches("^\\d{10,11}$")) {
            request.setAttribute("phoneError", "Số điện thoại phải từ 10 đến 11 chữ số");
            setCommonFailAttributes(request);
            isValid = false;
        }

        if (day != null && month != null && year != null) {
            try {
                LocalDate birthdate = LocalDate.of(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day));
                user.setBirthdate(birthdate);
            } catch (DateTimeParseException | NumberFormatException e) {
                isValid = false;
                setCommonFailAttributes(request);
                e.printStackTrace();
            }
        }

        return isValid;
    }

    private void setCommonFailAttributes(HttpServletRequest request) {
        request.setAttribute("updateFail", "Update informatio fail!");
        request.setAttribute("view", "info");
    }
}
