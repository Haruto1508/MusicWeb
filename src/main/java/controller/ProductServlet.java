/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductDAO;
import dao.ReviewDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Product;
import model.Review;
import model.User;
import util.RelatedProduct;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
@WebServlet(name = "ProductServlet", urlPatterns = {"/product"})
public class ProductServlet extends HttpServlet {

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
            out.println("<title>Servlet ProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductServlet at " + request.getContextPath() + "</h1>");
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
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        clearSession(request, response, session);

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        if (id == null || id.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        ReviewDAO reviewDAO = new ReviewDAO();

        Product product = productDAO.getProductById(Integer.parseInt(id));
        // Fetch all reviews for the product
        List<Review> reviews = reviewDAO.getReviewsByUserAndProduct(user.getUserId(), Integer.parseInt(id));
        List<Product> relatedList = productDAO.getRelatedProducts(product.getProductId(), RelatedProduct.RELATED_PRODUCT_LIMIT);

        request.setAttribute("product", product);
        request.setAttribute("reviews", reviews);
        request.setAttribute("relatedList", relatedList);
        request.getRequestDispatcher("/WEB-INF/product-view.jsp").forward(request, response);

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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        ReviewDAO reviewDAO = new ReviewDAO();

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        switch (action) {
            case "addReview":
                int productId = Integer.parseInt(request.getParameter("productId"));
                int rating = Integer.parseInt(request.getParameter("rating"));
                String comment = request.getParameter("comment");
                boolean added = reviewDAO.createReview(productId, user.getUserId(), rating, comment);
                if (added) {
                    session.setAttribute("addSuccess", "Review posted successfully!");
                } else {
                    session.setAttribute("addFail", "Failed to post review.");
                }
                break;
            case "editReview":
                int reviewId = Integer.parseInt(request.getParameter("reviewId"));
                Review review = reviewDAO.getReviewById(reviewId);
                if (review != null && (user.getUserId() == review.getUser().getUserId())) {
                    review.setRating(Integer.parseInt(request.getParameter("rating")));
                    review.setComment(request.getParameter("comment"));
                    boolean updated = reviewDAO.updateReview(review);
                    if (updated) {
                        session.setAttribute("addSuccess", "Review updated successfully!");
                    } else {
                        session.setAttribute("addFail", "Failed to update review.");
                    }
                }
                break;
            case "deleteReview":
                reviewId = Integer.parseInt(request.getParameter("reviewId"));
                review = reviewDAO.getReviewById(reviewId);
                if (review != null && (user.getUserId() == review.getUser().getUserId())) {
                    boolean deleted = reviewDAO.deleteReview(reviewId);
                    if (deleted) {
                        session.setAttribute("addSuccess", "Review deleted successfully!");
                    } else {
                        session.setAttribute("addFail", "Failed to delete review.");
                    }
                }
                break;
        }

        // Redirect to the same product page
        String productId = request.getParameter("productId");
        response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
    }

    protected void clearSession(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        String[] attributes = {"addFail", "addSuccess", "updateFail"};
        for (String attr : attributes) {
            Object val = session.getAttribute(attr);
            if (val != null) {
                request.setAttribute(attr, val);
                session.removeAttribute(attr);
            }
        }
    }
}
