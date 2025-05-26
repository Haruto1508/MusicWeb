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
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import model.Order;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class OrderDAO {

    public void addOrder(Order order) {
        String sql = "INSERT INTO Orders (user_id, order_date, status, total_amount, shipping_address, discount_id, discount_amount) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, order.getUserId());
            stmt.setTimestamp(2, Timestamp.valueOf(order.getOrderDate()));
            stmt.setString(3, order.getStatus());
            stmt.setBigDecimal(4, order.getTotalAmount());
            stmt.setString(5, order.getShippingAddress());
            if (order.getDiscountId() != null) {
                stmt.setInt(6, order.getDiscountId());
            } else {
                stmt.setNull(6, Types.INTEGER);
            }
            stmt.setBigDecimal(7, order.getDiscountAmount());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM Orders WHERE order_id = ?";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            try ( ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Order(
                            rs.getInt("order_id"),
                            rs.getInt("user_id"),
                            rs.getTimestamp("order_date").toLocalDateTime(),
                            rs.getString("status"),
                            rs.getBigDecimal("total_amount"),
                            rs.getString("shipping_address"),
                            rs.getObject("discount_id") != null ? rs.getInt("discount_id") : null,
                            rs.getBigDecimal("discount_amount")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE user_id = ?";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try ( ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    orders.add(
                            new Order(
                                    rs.getInt("order_id"),
                                    rs.getInt("user_id"),
                                    rs.getTimestamp("order_date").toLocalDateTime(),
                                    rs.getString("status"),
                                    rs.getBigDecimal("total_amount"),
                                    rs.getString("shipping_address"),
                                    rs.getObject("discount_id") != null ? rs.getInt("discount_id") : null,
                                    rs.getBigDecimal("discount_amount")
                            )
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders;";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql);  ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                orders.add(
                        new Order(
                                rs.getInt("order_id"),
                                rs.getInt("user_id"),
                                rs.getTimestamp("order_date").toLocalDateTime(),
                                rs.getString("status"),
                                rs.getBigDecimal("total_amount"),
                                rs.getString("shipping_address"),
                                rs.getObject("discount_id") != null ? rs.getInt("discount_id") : null,
                                rs.getBigDecimal("discount_amount")
                        )
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
}
