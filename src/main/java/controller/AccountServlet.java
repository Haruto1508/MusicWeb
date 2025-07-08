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

        System.out.println(user.toString());
        System.out.println(user.getBirthdate());
        // Xử lý theo view
        switch (view) {
            case "info":
                // Định dạng ngày sinh
                int currentYear = LocalDate.now().getYear();
                DateTimeFormatter textFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
                DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

                String birthdateInputValue = user.getBirthdate() != null
                        ? user.getBirthdate().format(inputFormatter)
                        : "";
                String birthdateTextValue = user.getBirthdate() != null
                        ? user.getBirthdate().format(textFormatter)
                        : "";

                // Gán thông tin dùng chung
                session.setAttribute("user", user);
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
                // Nếu có view khác, xử lý tại đây
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
        // Thông báo
        Object deleteSuccess = session.getAttribute("deleteSuccess");
        Object deleteFail = session.getAttribute("deleteFail");
        Object addSuccess = session.getAttribute("addSuccess");
        Object addFail = session.getAttribute("addFail");
        Object updateSuccess = session.getAttribute("updateSuccess");
        Object updateFail = session.getAttribute("updateFail");

        if (deleteSuccess != null) {
            request.setAttribute("deleteSuccess", deleteSuccess);
            session.removeAttribute("deleteSuccess");
        }
        if (deleteFail != null) {
            request.setAttribute("deleteFail", deleteFail);
            session.removeAttribute("deleteFail");
        }
        if (addSuccess != null) {
            request.setAttribute("addSuccess", addSuccess);
            session.removeAttribute("addSuccess");
        }
        if (addFail != null) {
            request.setAttribute("addFail", addFail);
            session.removeAttribute("addFail");
        }
        if (updateSuccess != null) {
            request.setAttribute("updateSuccess", updateSuccess);
            session.removeAttribute("updateSuccess");
        }
        if (updateFail != null) {
            request.setAttribute("updateFail", updateFail);
            session.removeAttribute("updateFail");
        }

        // Dữ liệu nhập lại
        String[] fields = {"receiverName", "receiverPhone", "street", "ward", "district", "city",
            "nameError", "phoneError", "streetError", "cityError"};

        for (String field : fields) {
            Object val = session.getAttribute(field);
            if (val != null) {
                request.setAttribute(field, val);
                session.removeAttribute(field);
            }
        }
    }
}
