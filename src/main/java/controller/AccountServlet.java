/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AddressDAO;
import dao.CartDAO;
import dao.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.Address;
import model.Cart;
import model.Order;
import model.User;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
@WebServlet(name = "AccountServlet", urlPatterns = {"/account"})

public class AccountServlet extends HttpServlet {

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
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        // Gọi clearSession để lấy các thông báo từ session sang request
        clearSession(request, response, session);

        String view = request.getParameter("view");
        if (view == null) {
            view = "info";
        }

        switch (view) {
            case "info":
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
                break;

            case "address":
                AddressDAO addressDAO = new AddressDAO();
                List<Address> addresses = addressDAO.getAddressesByUserId(user.getUserId());
                if (addresses == null) {
                    addresses = new ArrayList<>();
                    request.setAttribute("error", "Cannot load addresses");
                }
                request.setAttribute("addresses", addresses);
                break;

            case "cart":
                CartDAO cartDAO = new CartDAO();
                List<Cart> carts = cartDAO.getCartByUserId(user.getUserId());
                BigDecimal total = BigDecimal.ZERO;
                if (carts != null) {
                    for (Cart c : carts) {
                        total = total.add(c.getProduct().getPrice());
                    }
                } else {
                    carts = new ArrayList<>();
                    request.setAttribute("error", "Cannot load cart");
                }
                request.setAttribute("carts", carts);
                request.setAttribute("total", total);
                break;

            case "order":
                OrderDAO orderDAO = new OrderDAO();
                List<Order> orders = orderDAO.getOrdersByUserId(user.getUserId());
                if (orders == null) {
                    orders = new ArrayList<>();
                    request.setAttribute("error", "Cannot load orders");
                }
                request.setAttribute("orders", orders);
                break;

            case "setting":
            case "password":
                break;

            default:
                request.setAttribute("error", "Invalid view parameter");
                view = "info";
                break;
        }

        request.setAttribute("view", view);
        request.getRequestDispatcher("WEB-INF/user/profile.jsp").forward(request, response);
    }

    protected void clearSession(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        String[] attributes = {"deleteSuccess", "deleteFail", "addSuccess", "addFail", "updateSuccess", "updateFail",
            "receiverName", "receiverPhone", "street", "ward", "district", "city",
            "nameError", "phoneError", "streetError", "cityError",
            "tempFullName", "tempAccount", "tempEmail", "tempPhone", "tempGender",
            "birth_day", "birth_month", "birth_year", "accountError", "fullNameError",
            "emailError", "phoneError", "birthdateError", "genderError"};
        for (String attr : attributes) {
            Object val = session.getAttribute(attr);
            if (val != null) {
                request.setAttribute(attr, val);
                session.removeAttribute(attr);
            }
        }
    }
}
