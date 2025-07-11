/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
import dao.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.Product;
import model.User;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

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
        String action = request.getParameter("action");
        CartDAO cartDAO = new CartDAO();
        HttpSession session = request.getSession(false);
        switch (action) {
            case "add":
                System.out.println("add");
                addCart(request, response, cartDAO, session);
                break;
            case "delete":
                deleteCart(request, response, cartDAO, session);
                break;
            default:
                throw new AssertionError();
        }
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

    }

    private void deleteCart(HttpServletRequest request, HttpServletResponse response, CartDAO dao, HttpSession session) throws ServletException, IOException {
        String cartIdStr = request.getParameter("cartId");

        int cartId = 0;
        try {
            cartId = Integer.parseInt(cartIdStr);
        } catch (Exception e) {
            session.setAttribute("deleteFail", "Cart deletion failed!");
            response.sendRedirect(request.getContextPath() + "/account?view=cart");
            return;
        }

        boolean isDelete = dao.deleteCartById(cartId);

        if (isDelete) {
            session.setAttribute("deleteSuccess", "Cart deleted successfully!");
            response.sendRedirect(request.getContextPath() + "/account?view=cart");
        } else {
            session.setAttribute("deleteFail", "Cart deletion failed!");
            response.sendRedirect(request.getContextPath() + "/account?view=cart");
        }
    }

    private void addCart(HttpServletRequest request, HttpServletResponse response, CartDAO dao, HttpSession session) throws ServletException, IOException {
        // check user
        System.out.println("srtart delete");
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // check params
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");
        if (productIdStr == null || productIdStr.trim().isEmpty() || quantityStr == null || quantityStr.trim().isEmpty()) {
            System.out.println("error params");
            session.setAttribute("addFail", "Invalid product information or quantity!");
            response.sendRedirect(request.getContextPath() + "/product?id=" + productIdStr);
            return;
        }

        // check product id
        int productId;
        try {
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            System.out.println("error prodc id");
            session.setAttribute("addFail", "Invalid product ID!");
            response.sendRedirect(request.getContextPath() + "/product?id=" + productIdStr);
            return;
        }

        // check product
        Product product = new ProductDAO().getProductById(productId);
        if (product == null) {
            System.out.println("get ptoduct fail");
            session.setAttribute("addFail", "Product does not exist!");
            response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
            return;
        }

        // check quantity
        int quantity = 1;
        try {
            quantity = Integer.parseInt(quantityStr);
            if (quantity < 1 || quantity > product.getStockQuantity()) {
                quantity = 1;
            }
        } catch (NumberFormatException e) {
            System.out.println("error quianty");
            session.setAttribute("addFail", "Invalid quantity!");
            response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
            return;
        }
        
        System.out.println(user.getUserId());
        System.out.println(productId);
        System.out.println(quantity);

        // add to cart
        Cart existingCart = dao.getCartByUserAndProduct(user.getUserId(), productId);
        if (existingCart != null) {
            // Sản phẩm đã có trong giỏ hàng, cập nhật số lượng
            int newQuantity = existingCart.getQuantity() + quantity;
            if (newQuantity > product.getStockQuantity()) {
                System.out.println("error out of quantyu");
                session.setAttribute("addFail", "The quantity in the cart exceeds the quantity in stock.!");
                response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
                return;
            }
            boolean isUpdated = dao.updateCartQuantity(existingCart.getCartId(), newQuantity);
            if (isUpdated) {
                System.out.println("upd ate sc");
                session.setAttribute("addSuccess", "Updated quantity of products in cart successfully!");
                response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
            } else {
                System.out.println("update dail");
                session.setAttribute("addFail", "Cart update failed!");
                response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
            }
        } else {
            // Sản phẩm chưa có trong giỏ hàng, thêm mới
            Cart cart = new Cart(user, product, quantity, null);
            boolean isInsertCart = dao.insertCart(cart);
            if (isInsertCart) {
                System.out.println("thanh cong");
                session.setAttribute("addSuccess", "Add to cart successfully!");
                response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
            } else {
                System.out.println("that bai");
                session.setAttribute("addFail", "Add to cart failed!");
                response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
            }
        }
    }
}
