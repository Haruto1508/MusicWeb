/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.OrderDetailDAO;
import dao.ProductDAO;
import dao.ReviewDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.OrderDetail;
import model.Product;
import model.User;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
@WebServlet(name = "ReviewServlet", urlPatterns = {"/review"})
public class ReviewServlet extends HttpServlet {

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
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String orderIdStr = request.getParameter("orderId");
        System.out.println(orderIdStr);
        int orderId;
        try {
            orderId = Integer.parseInt(orderIdStr);
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/error-page/404page.jsp");
            return;
        }

        OrderDetailDAO odDAO = new OrderDetailDAO();
        List<OrderDetail> odList = odDAO.getOrderDetailsByOrderId(orderId);

        if (odList == null) {
            session.setAttribute("updateFail", "Opp! There are some thing wrong.");
            response.sendRedirect(request.getContextPath() + "/account?view=info");
            return;
        }

        request.setAttribute("orderId", orderId);
        request.setAttribute("productId", odList.get(0).getProduct().getProductId());
        request.setAttribute("productName", odList.get(0).getProduct().getName());
        request.getRequestDispatcher("/WEB-INF/product-review.jsp").forward(request, response);
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
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User user = (User) session.getAttribute("user");

        String review = request.getParameter("reviewText");
        String orderIdStr = request.getParameter("orderId");
        String productIdStr = request.getParameter("productId");
        String rating = request.getParameter("rating");

        int orderId, productId;
        try {
            orderId = Integer.parseInt(orderIdStr);
            productId = Integer.parseInt(productIdStr);
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/error-page/404page.jsp");
            return;
        }

        // Validate dữ liệu
        if (review == null || review.trim().isEmpty() || rating == null || rating.isEmpty()) {
            setReviewErrorAndReturn(request, response, orderId, productId,
                    "Please provide both rating and review.");
            return;
        }

        int ratingValue;
        try {
            ratingValue = Integer.parseInt(rating);
        } catch (NumberFormatException e) {
            setReviewErrorAndReturn(request, response, orderId, productId,
                    "Invalid rating value.");
            return;
        }

        ReviewDAO dao = new ReviewDAO();
        boolean isCreate = dao.createReview(productId, user.getUserId(), ratingValue, review);

        if (isCreate) {
            session.setAttribute("updateSuccess", "You have successfully submitted your review.");
        } else {
            session.setAttribute("updateFail", "Failed to submit your review.");
        }
        response.sendRedirect(request.getContextPath() + "/account?view=order");
    }

    private void setReviewErrorAndReturn(HttpServletRequest request, HttpServletResponse response,
            int orderId, int productId, String message)
            throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        request.setAttribute("orderId", orderId);
        request.setAttribute("productId", productId);

        // Lấy lại tên sản phẩm
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);
        request.setAttribute("productName", product != null ? product.getName() : "Unknown Product");

        request.getRequestDispatcher("/WEB-INF/product-review.jsp").forward(request, response);
    }
}
