/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AddressDAO;
import dao.CartDAO;
import dao.OrderDAO;
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
            out.println("<title>Servlet AccountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AccountServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession(false);
        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String view = request.getParameter("view");
        if (view == null) {
            view = "info";
        }

        switch (view) {
            case "info":
                int currentYear = LocalDate.now().getYear();
                DateTimeFormatter textFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
                DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                String birthdateInputValue = user.getBirthdate() != null ? user.getBirthdate().format(inputFormatter) : "";
                String birthdateTextValue = user.getBirthdate() != null ? user.getBirthdate().format(textFormatter) : "";
                request.setAttribute("birthdateInputValue", birthdateInputValue);
                request.setAttribute("birthdateTextValue", birthdateTextValue);
                request.setAttribute("currentYear", currentYear);
                request.setAttribute("user", user);
                break;
            case "address":
                AddressDAO addressDAO = new AddressDAO();
                List<Address> addresses = addressDAO.getAddressesByUserId(user.getUserId());
                if (addresses == null) {
                    request.setAttribute("error", "Cannot load addresses");
                    addresses = new ArrayList<>();
                }
                request.setAttribute("addresses", addresses);
                break;
            case "cart":
                CartDAO cartDAO = new CartDAO();
                List<Cart> carts = cartDAO.getCartByUserId(user.getUserId());
                if (carts == null) {
                    request.setAttribute("error", "Cannot load cart");
                    carts = new ArrayList<>();
                }
                request.setAttribute("carts", carts);
                break;
            case "order":
                OrderDAO orderDAO = new OrderDAO();
                List<Order> orders = orderDAO.getOrderByUserId(user.getUserId());
                if (orders == null) {
                    request.setAttribute("error", "Cannot load orders");
                    orders = new ArrayList<>();
                }
                request.setAttribute("orders", orders);
                break;
            case "setting":
                break;
            case "password":
                break;
            default:
                view = "info";
                request.setAttribute("error", "Invalid view parameter");
                break;
        }

        request.setAttribute("view", view);
        request.getRequestDispatcher("WEB-INF/user/profile.jsp").forward(request, response);
    }
}
