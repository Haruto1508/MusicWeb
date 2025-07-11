/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 5, // 5MB
        maxRequestSize = 1024 * 1024 * 10 // 10MB
)
@WebServlet(name = "AvatarServlet", urlPatterns = {"/avatar"})
public class AvatarServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AvatarServlet.class.getName());
    private static final String UPLOAD_DIR = "uploads/avatars";
    private static final String[] ALLOWED_EXTENSIONS = {".jpg", ".jpeg", ".png", ".gif"};

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
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        Part filePart = request.getPart("avatar");
        String updateFail = null;

        if (filePart == null || filePart.getSize() == 0) {
            updateFail = "Please select an image file.";
            session.setAttribute("updateFail", updateFail);
            session.setAttribute("avatarUpdateFail", true);
            response.sendRedirect(request.getContextPath() + "/account?view=info");
            return;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String fileExt = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();

        // Validate file extension
        boolean validExtension = false;
        for (String ext : ALLOWED_EXTENSIONS) {
            if (fileExt.equals(ext)) {
                validExtension = true;
                break;
            }
        }

        if (!validExtension) {
            updateFail = "Invalid image format. Only JPG, JPEG, PNG, GIF allowed.";
            session.setAttribute("updateFail", updateFail);
            session.setAttribute("avatarUpdateFail", true);
            response.sendRedirect(request.getContextPath() + "/account?view=info");
            return;
        }

        // Generate unique filename
        String newFileName = UUID.randomUUID().toString() + fileExt;
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);

        // Create upload directory if it doesn't exist
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String filePath = uploadPath + File.separator + newFileName;
        String avatarUrl = request.getContextPath() + "/" + UPLOAD_DIR + "/" + newFileName;

        try {
            // Save the new avatar file
            filePart.write(filePath);

            // Delete old avatar if it exists and is not the default
            if (user.getImageUrl() != null && !user.getImageUrl().contains("default")) {
                String oldPath = getServletContext().getRealPath("")
                        + File.separator
                        + user.getImageUrl().substring(request.getContextPath().length() + 1);
                Files.deleteIfExists(Paths.get(oldPath));
            }

            // Update avatar URL in the database
            UserDAO dao = new UserDAO();
            boolean updateSuccess = dao.uploadAvatar(avatarUrl, user.getUserId());
            if (!updateSuccess) {
                updateFail = "Failed to update avatar in the database.";
                session.setAttribute("updateFail", updateFail);
                session.setAttribute("avatarUpdateFail", true);
                // Delete the uploaded file if database update fails
                Files.deleteIfExists(Paths.get(filePath));
                response.sendRedirect(request.getContextPath() + "/account?view=info");
                return;
            }

            // Update user object with new avatar URL
            user.setImageUrl(avatarUrl);
            session.setAttribute("user", user);
            session.setAttribute("updateSuccess", "Avatar uploaded successfully!");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing avatar upload", e);
            updateFail = "Failed to upload avatar. Please try again.";
            session.setAttribute("updateFail", updateFail);
            session.setAttribute("avatarUpdateFail", true);
            // Delete the uploaded file if an error occurs
            Files.deleteIfExists(Paths.get(filePath));
        }

        response.sendRedirect(request.getContextPath() + "/account?view=info");
    }
}

