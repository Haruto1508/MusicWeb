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
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.Map;
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
        System.out.println("bat dau update user servlet");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String fullName = request.getParameter("fullName").trim();
        String account = request.getParameter("account").trim();
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone").trim();
        String gender = request.getParameter("gender").trim();
        String day = request.getParameter("birth_day");
        String month = request.getParameter("birth_month");
        String year = request.getParameter("birth_year");

        System.out.println(fullName);
        System.out.println("Received: birth_day=" + day + ", birth_month=" + month + ", birth_year=" + year);

        UserDAO userDAO = new UserDAO();
        int userId = user.getUserId();

        // Check for duplicates
        if (isDuplicateUserInfo(request, userDAO, account, email, phone, userId, session)) {
            setTempAttributes(fullName, account, email, phone, gender, day, month, year, session);
            response.sendRedirect(request.getContextPath() + "/account?view=info");
            return;
        }

        // Check for valid update info
        if (!isValidUpdateInfo(request, user, account, fullName, email, phone, day, month, year, gender, session)) {
            setTempAttributes(fullName, account, email, phone, gender, day, month, year, session);
            response.sendRedirect(request.getContextPath() + "/account?view=info");
            return;
        }

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAccount(account);

        boolean isUpdateSuccess = userDAO.update(user);
        if (isUpdateSuccess) {
            session.setAttribute("user", user);
            session.setAttribute("updateSuccess", "Cập nhật thông tin thành công!");
            clearSession(session);
            response.sendRedirect(request.getContextPath() + "/account?view=info");
        } else {
            session.setAttribute("updateFail", "Update information failed!");
            setTempAttributes(fullName, account, email, phone, gender, day, month, year, session);
            response.sendRedirect(request.getContextPath() + "/account?view=info");
        }
    }

    private void setTempAttributes(String fullName, String account, String email, String phone, String gender, String day, String month, String year, HttpSession session) {
        session.setAttribute("tempFullName", fullName != null ? fullName : "");
        session.setAttribute("tempAccount", account != null ? account : "");
        session.setAttribute("tempEmail", email != null ? email : "");
        session.setAttribute("tempPhone", phone != null ? phone : "");
        session.setAttribute("tempGender", gender != null ? gender : "");
        session.setAttribute("birth_day", day != null ? day : "");
        session.setAttribute("birth_month", month != null ? month : "");
        session.setAttribute("birth_year", year != null ? year : "");
    }

    private boolean isDuplicateUserInfo(HttpServletRequest request, UserDAO userDAO, String account, String email, String phone, int userId, HttpSession session) {
        Map<String, Boolean> duplicates = userDAO.checkDuplicateInfo(account, email, phone, userId);
        boolean hasError = false;
        if (duplicates.get("account")) {
            session.setAttribute("accountError", "Account name already exists");
            hasError = true;
        }
        if (duplicates.get("email")) {
            session.setAttribute("emailError", "Email has been registered");
            hasError = true;
        }
        if (duplicates.get("phone")) {
            session.setAttribute("phoneError", "Phone number already in use");
            hasError = true;
        }
        if (hasError) {
            session.setAttribute("updateFail", "Update information failed!");
        }
        return hasError;
    }

    private boolean isValidUpdateInfo(HttpServletRequest request, User user, String account, String fullName, String email, String phone, String day, String month, String year, String gender, HttpSession session) {
        boolean isValid = true;

        if (account == null || account.trim().isEmpty()) {
            session.setAttribute("accountError", "Account cannot be blank");
            isValid = false;
        }

        if (fullName == null || fullName.trim().isEmpty()) {
            session.setAttribute("fullNameError", "Full name cannot be left blank");
            isValid = false;
        }

        if (email == null || !email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            session.setAttribute("emailError", "Invalid email");
            isValid = false;
        }

        if (phone != null && !phone.matches("^\\d{10,11}$")) {
            session.setAttribute("phoneError", "Phone number must be 10 to 11 digits");
            isValid = false;
        }

        if (day != null && month != null && year != null && !day.isEmpty() && !month.isEmpty() && !year.isEmpty()) {
            try {
                int d = Integer.parseInt(day);
                int m = Integer.parseInt(month);
                int y = Integer.parseInt(year);
                if (y < 1900 || y > LocalDate.now().getYear()) {
                    session.setAttribute("birthdateError", "Year must be between 1900 and " + LocalDate.now().getYear());
                    isValid = false;
                } else if (m < 1 || m > 12) {
                    session.setAttribute("birthdateError", "Month must be between 1 and 12");
                    isValid = false;
                } else if (d < 1 || d > 31) {
                    session.setAttribute("birthdateError", "Day must be between 1 and 31");
                    isValid = false;
                } else {
                    try {
                        LocalDate birthdate = LocalDate.of(y, m, d);
                        if (birthdate.getDayOfMonth() != d || birthdate.getMonthValue() != m || birthdate.getYear() != y) {
                            session.setAttribute("birthdateError", "Invalid date (e.g., 31/04 or 29/02 in non-leap year)");
                            isValid = false;
                        } else {
                            user.setBirthdate(birthdate);
                        }
                    } catch (DateTimeParseException e) {
                        session.setAttribute("birthdateError", "Invalid date (e.g., 31/04 or 29/02 in non-leap year)");
                        isValid = false;
                    }
                }
            } catch (NumberFormatException e) {
                session.setAttribute("birthdateError", "Invalid date format (day, month, year must be numbers)");
                isValid = false;
            }
        } else if (day != null || month != null || year != null) {
            session.setAttribute("birthdateError", "Please select complete birthdate (day, month, year)");
            isValid = false;
        }

        try {
            int genderValue = Integer.parseInt(gender);
            if (genderValue < 0 || genderValue > 3) {
                session.setAttribute("genderError", "Invalid gender selection");
                isValid = false;
            } else {
                user.setGender(Gender.fromGender(genderValue));
            }
        } catch (NumberFormatException e) {
            session.setAttribute("genderError", "Invalid gender selection");
            isValid = false;
        }

        if (!isValid) {
            session.setAttribute("updateFail", "Update information failed!");
        }

        return isValid;
    }

    private void clearSession(HttpSession session) {
        String[] attributes = {"tempFullName", "tempAccount", "tempEmail", "tempPhone", "tempGender",
            "birth_day", "birth_month", "birth_year", "accountError", "fullNameError",
            "emailError", "phoneError", "birthdateError", "genderError"};
        for (String attr : attributes) {
            session.removeAttribute(attr);
        }
    }

    // Giả định phương thức checkDuplicateInfo trong UserDAO
    private Map<String, Boolean> checkDuplicateInfo(String account, String email, String phone, int userId) {
        Map<String, Boolean> result = new HashMap<>();
        result.put("account", false);
        result.put("email", false);
        result.put("phone", false);
        // Thêm logic truy vấn cơ sở dữ liệu tại đây
        return result;
    }
}
