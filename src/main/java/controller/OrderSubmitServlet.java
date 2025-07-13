/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AddressDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDate;
import model.Address;
import model.Discount;
import model.User;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
@WebServlet(name = "OrderSubmitServlet", urlPatterns = {"/order-submit"})
public class OrderSubmitServlet extends HttpServlet {

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
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        // Lấy tham số từ form
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");
        String addressIdStr = request.getParameter("addressId");
        String voucherIdStr = request.getParameter("voucherId");
        String paymentMethodStr = request.getParameter("paymentMethod");
        String shippingMethodStr = request.getParameter("shippingMethod");

        System.out.println("productIdStr = " + productIdStr);
        System.out.println("quantityStr = " + quantityStr);
        System.out.println("addressIdStr = " + addressIdStr);
        System.out.println("voucherIdStr = " + voucherIdStr);
        System.out.println("paymentMethodStr = " + paymentMethodStr);
        System.out.println("shippingMethodStr = " + shippingMethodStr);

        // Lưu lại để hiển thị lại khi có lỗi
        request.setAttribute("productId", productIdStr);
        request.setAttribute("quantity", quantityStr);
        request.setAttribute("addressId", addressIdStr);
        request.setAttribute("voucherId", voucherIdStr);
        request.setAttribute("paymentMethod", paymentMethodStr);
        request.setAttribute("shippingMethod", shippingMethodStr);

        int addressId, productId, quantity, paymentMethod, shippingMethod;
        Integer voucherId = null;

        try {
            addressId = Integer.parseInt(addressIdStr);
            productId = Integer.parseInt(productIdStr);
            quantity = Integer.parseInt(quantityStr);
            paymentMethod = Integer.parseInt(paymentMethodStr);
            shippingMethod = Integer.parseInt(shippingMethodStr);

            if (quantity <= 0) {
                throw new NumberFormatException("Quantity must be positive");
            }
            if (paymentMethod != 1 && paymentMethod != 2) {
                throw new NumberFormatException("Invalid payment method");
            }
            if (shippingMethod <= 0 || shippingMethod > 3) {
                throw new NumberFormatException("Invalid shipping method");
            }
            if (voucherIdStr != null && !voucherIdStr.equals("not")) {
                voucherId = Integer.parseInt(voucherIdStr);
            }
        } catch (NumberFormatException e) {
            String error;
            switch (e.getMessage()) {
                case "Quantity must be positive":
                    error = "Quantity must be positive";
                    break;
                case "Invalid payment method":
                    error = "Invalid payment method";
                    break;
                case "Invalid shipping method":
                    error = "Invalid shipping method";
                    break;
                default:
                    error = "Invalid input data";
            }
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/order-confirmation.jsp").forward(request, response);
            return;
        }

        // Kiểm tra địa chỉ
        AddressDAO addressDAO = new AddressDAO();
        Address address = addressDAO.getAddressById(addressId, user.getUserId());
        if (address == null) {
            request.setAttribute("error", "Invalid address");
            request.getRequestDispatcher("/WEB-INF/order-confirmation.jsp").forward(request, response);
            return;
        }

        // Kiểm tra sản phẩm
        ProductDAO productDAO = new ProductDAO();
        if (productDAO.getProductById(productId) == null) {
            request.setAttribute("error", "Product not found");
            request.getRequestDispatcher("/WEB-INF/order-confirmation.jsp").forward(request, response);
            return;
        }

        // Gọi OrderDAO
        OrderDAO orderDAO = new OrderDAO();
        try {
            int orderId = orderDAO.createOrder(
                    user.getUserId(),
                    addressId,
                    productId,
                    quantity,
                    voucherId,
                    paymentMethod,
                    shippingMethod
            );

            request.setAttribute("orderId", orderId);
            request.getRequestDispatcher("/WEB-INF/order-success.jsp").forward(request, response);
        } catch (SQLException e) {
            String errorMessage = e.getMessage();
            if (errorMessage.contains("Invalid address")) {
                request.setAttribute("error", "Invalid address");
            } else if (errorMessage.contains("Product not found")) {
                request.setAttribute("error", "Product not found or inactive");
            } else if (errorMessage.contains("Insufficient stock")) {
                request.setAttribute("error", "Insufficient stock");
            } else if (errorMessage.contains("Invalid or expired discount")) {
                request.setAttribute("error", "Invalid or expired discount");
            } else if (errorMessage.contains("Order value does not meet")) {
                request.setAttribute("error", "Order value does not meet discount requirements");
            } else if (errorMessage.contains("Invalid shipping method")) {
                request.setAttribute("error", "Invalid shipping method");
            } else {
                request.setAttribute("error", "Failed to create order");
            }

            // Giữ lại các giá trị người dùng đã chọn
            request.setAttribute("productId", productIdStr);
            request.setAttribute("quantity", quantityStr);
            request.setAttribute("paymentMethod", paymentMethodStr);
            request.setAttribute("shippingMethod", shippingMethodStr);
            request.setAttribute("voucherId", voucherIdStr);
            request.setAttribute("addressId", addressIdStr);

            request.getRequestDispatcher("/WEB-INF/order-confirmation.jsp").forward(request, response);
        }
    }

    private boolean isDiscountValid(Discount discount) {
        if (discount == null) {
            return false;
        }
        LocalDate today = LocalDate.now();
        boolean inDateRange = !today.isBefore(discount.getStartDate()) && !today.isAfter(discount.getEndDate());
        boolean underUsageLimit = discount.getUsageLimit() <= 0 || discount.getUsedCount() < discount.getUsageLimit();
        return discount.isIsActive() && inDateRange && underUsageLimit;
    }

}
