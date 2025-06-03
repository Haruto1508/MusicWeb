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
import model.Product;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
@WebServlet(name = "DispatcherServlet", urlPatterns = {"/path"})
public class DispatcherServlet extends HttpServlet {

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
            out.println("<title>Servlet DispatcherServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DispatcherServlet at " + request.getContextPath() + "</h1>");
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
        String page = request.getParameter("page");

        switch (page) {
            case "login":
                forwardLogin(request, response);
                break;
            case "register":
                forwardRegister(request, response);
                break;
            case "home":
                forwardHome(request, response);
                break;
            case "profile":
                forwardProfile(request, response);
                break;
            case "guitar":
                forwardGuitarPage(request, response);
                break;
            case "piano":
                forwardPianoPage(request, response);
                break;
            case "violin":
                forwardViolinPage(request, response);
                break;
            case "accessory":
                forwardAccessoryPage(request, response);
                break;
            case "info":
                forwardUserInfo(request, response);
            default:
                throw new AssertionError();
        }

    }

    protected void forwardLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
    }

    protected void forwardRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/register.jsp").forward(request, response);
    }

    protected void forwardHome(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/home.jsp").forward(request, response);
    }

    protected void forwardProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/user/profile.jsp").forward(request, response);
    }

    protected void forwardGuitarPage(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        ProductDAO productDAO = new ProductDAO();

        List<Product> guitars = productDAO.getProductsByCategory(1);

        request.setAttribute("guitars", guitars);
        request.getRequestDispatcher("/WEB-INF/collections/guitar.jsp").forward(request, response);
    }

    protected void forwardPianoPage(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        ProductDAO productDAO = new ProductDAO();

        List<Product> pianos = productDAO.getProductsByCategory(3);

        request.setAttribute("pianos", pianos);
        request.getRequestDispatcher("/WEB-INF/collections/piano.jsp").forward(request, response);
    }

    protected void forwardViolinPage(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        ProductDAO productDAO = new ProductDAO();

        List<Product> violins = productDAO.getProductsByCategory(2);

        request.setAttribute("violins", violins);
        request.getRequestDispatcher("/WEB-INF/collections/violin.jsp").forward(request, response);
    }

    protected void forwardAccessoryPage(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        ProductDAO productDAO = new ProductDAO();

        List<Product> accessories = productDAO.getProductsByCategory(4);

        request.setAttribute("accessories", accessories);
        request.getRequestDispatcher("WEB-INF/collections/accessory.jsp").forward(request, response);
    }
    
    protected void forwardUserInfo(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/WEB-INF/collections/violin.jsp").forward(request, response);
    }
}
