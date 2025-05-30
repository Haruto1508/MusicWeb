/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.JDBCUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.OrderDetail;
import model.Product;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class OrderDetailDAO {

    // Create new OrderDetail and return generated ID
    public int createOrderDetail(OrderDetail orderDetail) {
        String sql = "INSERT INTO order_details (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";

        try ( Connection connection = JDBCUtil.getConnection();  PreparedStatement statement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            statement.setInt(1, orderDetail.getOrderId());
            statement.setInt(2, orderDetail.getProductId());
            statement.setInt(3, orderDetail.getQuantity());
            statement.setBigDecimal(4, orderDetail.getPrice());

            int affectedRows = statement.executeUpdate();

            if (affectedRows == 0) {
                return -1;
            }

            try ( ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
            return -1;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    // Get OrderDetail by ID
    public OrderDetail getOrderDetailById(int orderDetailId) {
        String sql = "SELECT * FROM order_details WHERE order_detail_id = ?";

        try ( Connection connection = JDBCUtil.getConnection();  PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderDetailId);

            try ( ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrderDetailId(resultSet.getInt("order_detail_id"));
                    orderDetail.setOrderId(resultSet.getInt("order_id"));
                    orderDetail.setProductId(resultSet.getInt("product_id"));
                    orderDetail.setQuantity(resultSet.getInt("quantity"));
                    orderDetail.setPrice(resultSet.getBigDecimal("price"));
                    return orderDetail;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all OrderDetails for an order
    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT od.*, p.product_id, p.name, p.image_url, p.description, p.price AS product_price "
                + "FROM order_details od "
                + "JOIN products p ON od.product_id = p.product_id "
                + "WHERE od.order_id = ?";

        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Tạo Product
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setImageUrl(rs.getString("image_url"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("product_price"));

                // Tạo OrderDetail
                OrderDetail od = new OrderDetail();
                od.setOrderDetailId(rs.getInt("order_detail_id"));
                od.setOrderId(rs.getInt("order_id"));
                od.setProductId(rs.getInt("product_id"));
                od.setQuantity(rs.getInt("quantity"));
                od.setPrice(rs.getBigDecimal("price"));
                od.setProduct(product);  // Gán product vào

                list.add(od);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Update existing OrderDetail
    public boolean updateOrderDetail(OrderDetail orderDetail) {
        String sql = "UPDATE order_details SET order_id = ?, product_id = ?, quantity = ?, price = ? WHERE order_detail_id = ?";

        try ( Connection connection = JDBCUtil.getConnection();  PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderDetail.getOrderId());
            statement.setInt(2, orderDetail.getProductId());
            statement.setInt(3, orderDetail.getQuantity());
            statement.setBigDecimal(4, orderDetail.getPrice());
            statement.setInt(5, orderDetail.getOrderDetailId());

            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete OrderDetail by ID
    public boolean deleteOrderDetail(int orderDetailId) {
        String sql = "DELETE FROM order_details WHERE order_detail_id = ?";

        try ( Connection connection = JDBCUtil.getConnection();  PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderDetailId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Count all OrderDetails
    public int countAllOrderDetails() {
        String sql = "SELECT COUNT(*) FROM order_details";

        try ( Connection connection = JDBCUtil.getConnection();  PreparedStatement statement = connection.prepareStatement(sql);  ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get all OrderDetails
    public List<OrderDetail> getAllOrderDetails() {
        String sql = "SELECT * FROM order_details";
        List<OrderDetail> orderDetails = new ArrayList<>();

        try ( Connection connection = JDBCUtil.getConnection();  PreparedStatement statement = connection.prepareStatement(sql);  ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setOrderDetailId(resultSet.getInt("order_detail_id"));
                orderDetail.setOrderId(resultSet.getInt("order_id"));
                orderDetail.setProductId(resultSet.getInt("product_id"));
                orderDetail.setQuantity(resultSet.getInt("quantity"));
                orderDetail.setPrice(resultSet.getBigDecimal("price"));
                orderDetails.add(orderDetail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }

    public List<OrderDetail> getOrderDetailsByUserId(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT od.*, p.name FROM OrderDetails od JOIN Products p ON od.product_id = p.product_id WHERE od.order_id = ?";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail od = new OrderDetail();
                od.setOrderId(orderId);
                od.setOrderId(rs.getInt("order_id"));
                od.setProductId(rs.getInt("product_id"));
                od.setQuantity(rs.getInt("quantity"));
                od.setPrice(rs.getBigDecimal("price"));
                list.add(od);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
