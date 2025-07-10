/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.CategoryType;
import model.PageSize;
import model.Product;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
@WebServlet(name = "GuitarServlet", urlPatterns = {"/guitar"})
public class GuitarServlet extends HttpServlet {

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
            out.println("<title>Servlet GuitarServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GuitarServlet at " + request.getContextPath() + "</h1>");
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
        int page = 1;
        int pageSize = PageSize.PAGE_SIZE;
        int categoryId = CategoryType.CATEGORY_GUITAR;

        // Lấy tham số page
        String pageParam = request.getParameter("page");
        try {
            page = Integer.parseInt(pageParam);
        } catch (Exception e) {
            page = 1;
        }

        ProductDAO dao = new ProductDAO();

        // Lấy tham số lọc và tìm kiếm
        String[] types = request.getParameterValues("type");
        String priceStr = request.getParameter("price");
        boolean sale = "true".equals(request.getParameter("sale"));
        boolean bestSeller = "true".equals(request.getParameter("bestSeller"));
        String searchQuery = request.getParameter("search");

        List<Product> products;
        int totalProducts;

        // Áp dụng lọc và tìm kiếm nếu có tham số
        if (types != null || priceStr != null || sale || bestSeller || (searchQuery != null && !searchQuery.trim().isEmpty())) {
            totalProducts = dao.countFilteredProducts(categoryId, types, priceStr, sale, bestSeller, searchQuery);
            products = dao.filterProductsByPage(categoryId, types, priceStr, sale, bestSeller, searchQuery, (page - 1) * pageSize, pageSize);
        } else {
            totalProducts = dao.countProductsByCategory(categoryId);
            products = dao.getProductsByCategoryAndPage(categoryId, (page - 1) * pageSize, pageSize);
        }

        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        if (totalPages == 0) {
            totalPages = 1;
        }
        if (page < 1) {
            page = 1;
        }
        if (page > totalPages) {
            page = totalPages;
        }

        // Gửi dữ liệu tới JSP
        request.setAttribute("guitars", products);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("categoryId", categoryId);
        request.setAttribute("selectedTypes", types);
        request.setAttribute("selectedPrice", priceStr);
        request.setAttribute("isSale", sale);
        request.setAttribute("isBestSeller", bestSeller);
        request.setAttribute("searchQuery", searchQuery);

        request.getRequestDispatcher("/WEB-INF/collections/guitar.jsp").forward(request, response);
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
        processRequest(request, response);
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
