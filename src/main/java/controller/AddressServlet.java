/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AddressDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Address;
import model.User;
import java.io.IOException;
import model.AddressStyle;

@WebServlet(name = "AddressServlet", urlPatterns = {"/address"})
public class AddressServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        AddressDAO addressDAO = new AddressDAO();

        try {
            switch (action) {
                case "add":
                    addAddress(request, response, user, addressDAO, session);
                    break;
                case "update":
                    updateAddress(request, response, user, addressDAO, session);
                    break;
                case "delete":
                    deleteAddress(request, response, user, addressDAO, session);
                    break;
                case "updateDefaultAddress":
                    updateDefaultAddress(request, response, user, addressDAO);
                    break;
                case "getAddress":
                    getAddressByAddressId(request, response, user, addressDAO);
                default:
                    session.setAttribute("error", "Invalid action");
                    response.sendRedirect(request.getContextPath() + "/account?view=address");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "An error occurred");
            response.sendRedirect(request.getContextPath() + "/account?view=address");
        }
    }

    private void getAddressByAddressId(HttpServletRequest request, HttpServletResponse response, User user, AddressDAO addressDAO, HttpSession session) {
        String addressIdStr = request.getParameter("addressId");
        
        int addressId;
        try {
            addressId = Integer.parseInt(addressIdStr);
        } catch (NumberFormatException e) {
            session.setAttribute("updateFail", "Invalid address ID");
            response.sendRedirect(request.getContextPath() + "/account?view=address");
            return;
        }
        
        Address address = addressDAO.getAddressById(addressId, user.getUserId());
        
        if (address != null) {
            request.setAttribute("recieverName", address.getReceiverName());
            request.setAttribute("recieverName", address.getReceiverPhone());
            request.setAttribute("recieverName", address.getStreet());
            request.setAttribute("recieverName", address.getWard());
            request.setAttribute("recieverName", address.getCity());
            request.setAttribute("recieverName", address.getDistrict());
        }
    }
    
    private void addAddress(HttpServletRequest request, HttpServletResponse response, User user, AddressDAO addressDAO, HttpSession session)
            throws ServletException, IOException {
        // Lấy tham số từ form
        String receiverName = request.getParameter("receiverName");
        String receiverPhone = request.getParameter("receiverPhone");
        String street = request.getParameter("street");
        String ward = request.getParameter("ward");
        String district = request.getParameter("district");
        String city = request.getParameter("city");
        String isSetDefault = request.getParameter("isDefault");

        // Xác thực tham số
        if (receiverName == null || receiverPhone == null || street == null || city == null) {
            session.setAttribute("addFail", "Add address fail! All required fields must be filled.");
            session.setAttribute("receiverName", receiverName);
            session.setAttribute("receiverPhone", receiverPhone);
            session.setAttribute("street", street);
            session.setAttribute("ward", ward);
            session.setAttribute("district", district);
            session.setAttribute("city", city);
            session.setAttribute("isDefault", "true".equals(isSetDefault));
            response.sendRedirect(request.getContextPath() + "/account?view=address");
            return;
        }

        boolean hasError = false;
        if (!receiverName.matches("^[\\p{L} .'-]+$")) {
            session.setAttribute("nameError", "Full name is invalid.");
            hasError = true;
        }
        if (!receiverPhone.matches("^(0[2-9][0-9]{8,9})$")) {
            session.setAttribute("phoneError", "Phone number must be 10-11 digits and start with 0.");
            hasError = true;
        }
        if (!street.matches("^.{5,100}$")) {
            session.setAttribute("streetError", "Street must be 5-100 characters.");
            hasError = true;
        }
        if (city.trim().isEmpty()) {
            session.setAttribute("cityError", "City/Province is required.");
            hasError = true;
        }

        if (hasError) {
            session.setAttribute("addFail", "Add address fail!");
            session.setAttribute("receiverName", receiverName);
            session.setAttribute("receiverPhone", receiverPhone);
            session.setAttribute("street", street);
            session.setAttribute("ward", ward);
            session.setAttribute("district", district);
            session.setAttribute("city", city);
            session.setAttribute("isDefault", "true".equals(isSetDefault));
            response.sendRedirect(request.getContextPath() + "/account?view=address");
            return;
        }

        // Tạo đối tượng Address
        Address address = new Address();
        address.setUser(user);
        address.setReceiverName(receiverName);
        address.setReceiverPhone(receiverPhone);
        address.setStreet(street);
        address.setWard(ward != null ? ward : null);
        address.setDistrict(district != null ? district : null);
        address.setCity(city);
        address.setType(AddressStyle.ADDRESS_HOME_STYLE);
        address.setIsDefault("true".equals(isSetDefault));

        // Thêm địa chỉ
        boolean isInsert = addressDAO.insertAddress(address);
        if (!isInsert) {
            session.setAttribute("addFail", "Add address failed!");
            response.sendRedirect(request.getContextPath() + "/account?view=address");
            return;
        }

        // Thành công
        session.setAttribute("addSuccess", "Add address success!");
        response.sendRedirect(request.getContextPath() + "/account?view=address");
    }

    private void updateAddress(HttpServletRequest request, HttpServletResponse response, User user, AddressDAO addressDAO, HttpSession session)
            throws ServletException, IOException {
        // Lấy tham số
        String addressIdStr = request.getParameter("addressId");
        String receiverName = request.getParameter("receiverName");
        String receiverPhone = request.getParameter("receiverPhone");
        String street = request.getParameter("street");
        String ward = request.getParameter("ward");
        String district = request.getParameter("district");
        String city = request.getParameter("city");
        String isSetDefault = request.getParameter("isDefault");

        // Xác thực addressId
        int addressId;
        try {
            addressId = Integer.parseInt(addressIdStr);
        } catch (NumberFormatException e) {
            session.setAttribute("updateFail", "Invalid address ID");
            response.sendRedirect(request.getContextPath() + "/account?view=address");
            return;
        }

        // Xác thực tham số
        boolean hasError = false;
        if (receiverName == null || !receiverName.matches("^[\\p{L} .'-]+$")) {
            session.setAttribute("nameError", "Full name is invalid.");
            hasError = true;
        }
        if (receiverPhone == null || !receiverPhone.matches("^(0[2-9][0-9]{8,9})$")) {
            session.setAttribute("phoneError", "Phone number must be 10-11 digits and start with 0.");
            hasError = true;
        }
        if (street == null || !street.matches("^.{5,100}$")) {
            session.setAttribute("streetError", "Street must be 5-100 characters.");
            hasError = true;
        }
        if (city == null || city.trim().isEmpty()) {
            session.setAttribute("cityError", "City/Province is required.");
            hasError = true;
        }

        if (hasError) {
            session.setAttribute("updateFail", "Update address failed!");
            session.setAttribute("receiverName", receiverName);
            session.setAttribute("receiverPhone", receiverPhone);
            session.setAttribute("street", street);
            session.setAttribute("ward", ward);
            session.setAttribute("district", district);
            session.setAttribute("city", city);
            session.setAttribute("editAddressId", addressIdStr);
            session.setAttribute("isDefault", "true".equals(isSetDefault));
            response.sendRedirect(request.getContextPath() + "/account?view=address");
            return;
        }

        // Tạo đối tượng Address
        Address address = new Address();
        address.setAddressId(addressId);
        address.setUser(user);
        address.setReceiverName(receiverName);
        address.setReceiverPhone(receiverPhone);
        address.setStreet(street);
        address.setWard(ward != null ? ward : null);
        address.setDistrict(district != null ? district : null);
        address.setCity(city);
        address.setType(AddressStyle.ADDRESS_HOME_STYLE);
        address.setIsDefault("true".equals(isSetDefault));

        // Cập nhật địa chỉ
        if (!addressDAO.update(address)) {
            session.setAttribute("updateFail", "Update address failed!");
            response.sendRedirect(request.getContextPath() + "/account?view=address");
            return;
        }

        // Thành công
        session.setAttribute("updateSuccess", "Update address success!");
        response.sendRedirect(request.getContextPath() + "/account?view=address");
    }

    private void deleteAddress(HttpServletRequest request, HttpServletResponse response, User user, AddressDAO addressDAO, HttpSession session)
            throws ServletException, IOException {
        // Lấy addressId
        String addressIdStr = request.getParameter("addressId");
        int addressId;
        try {
            addressId = Integer.parseInt(addressIdStr);
        } catch (NumberFormatException e) {
            session.setAttribute("deleteFail", "Invalid address ID");
            response.sendRedirect(request.getContextPath() + "/account?view=address");
            return;
        }

        // Xóa địa chỉ
        if (!addressDAO.deleteAddress(addressId, user.getUserId())) {
            session.setAttribute("deleteFail", "Delete address fail! This address is used in existing orders and cannot be deleted.");
            response.sendRedirect(request.getContextPath() + "/account?view=address");
            return;
        }

        // Thành công
        session.setAttribute("deleteSuccess", "Delete address success!");
        response.sendRedirect(request.getContextPath() + "/account?view=address");
    }

    private void updateDefaultAddress(HttpServletRequest request, HttpServletResponse response, User user, AddressDAO addressDAO)
            throws ServletException, IOException {
        String page = request.getParameter("page");
        String productId = request.getParameter("productId");
        String quantity = request.getParameter("quantity");
        String voucherId = request.getParameter("voucherId");
        String paymentMethod = request.getParameter("paymentMethod");

        // Lấy addressId
        String addressIdStr = request.getParameter("addressId");
        int addressId;
        try {
            addressId = Integer.parseInt(addressIdStr);
        } catch (NumberFormatException e) {
            setErrorAndForward(request, response, "Invalid address ID", page, productId, quantity, voucherId, paymentMethod);
            return;
        }

        // Cập nhật địa chỉ mặc định
        if (!addressDAO.setDefaultAddress(user.getUserId(), addressId)) {
            setErrorAndForward(request, response, "Failed to update default address", page, productId, quantity, voucherId, paymentMethod);
            return;
        }

        // Chuyển hướng
        response.sendRedirect(buildRedirectUrl(request, page, productId, quantity, voucherId, paymentMethod));
    }
    
    private void setErrorAndForward(HttpServletRequest request, HttpServletResponse response, String errorMessage,
            String page, String productId, String quantity, String voucherId, String paymentMethod)
            throws ServletException, IOException {
        request.setAttribute("inputError", errorMessage);
        if ("orderConfirm".equals(page)) {
            request.setAttribute("productId", productId);
            request.setAttribute("quantity", quantity);
            request.setAttribute("voucherId", voucherId);
            request.setAttribute("paymentMethod", paymentMethod);
            request.getRequestDispatcher("/WEB-INF/user/order-confirmation.jsp").forward(request, response);
        } else {
            // Giả định trang quản lý địa chỉ
            request.getRequestDispatcher("/WEB-INF/user/address-management.jsp").forward(request, response);
        }
    }

    private String buildRedirectUrl(HttpServletRequest request, String page, String productId, String quantity,
            String voucherId, String paymentMethod) {
        if ("orderConfirm".equals(page)) {
            String redirectUrl = request.getContextPath() + "/order-confirm?productId=" + productId + "&quantity=" + quantity;
            if (voucherId != null && !voucherId.isEmpty() && !voucherId.equals("not")) {
                redirectUrl += "&voucherId=" + voucherId;
            }
            redirectUrl += "&paymentMethod=" + (paymentMethod != null ? paymentMethod : "1");
            return redirectUrl;
        } else {
            return request.getContextPath() + "/address-management";
        }
    }
}