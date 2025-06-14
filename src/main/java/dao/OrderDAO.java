/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.JDBCUtil;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Discount;
import model.Order;
import model.User;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class OrderDAO extends JDBCUtil {

    public boolean addOrder(Order order) {
        String sql = "INSERT INTO Orders (user_id, order_date, status, total_amount, shipping_address, discount_id, discount_amount) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        Object[] params = {order.getUser(), order.getOrderDate(), order.getStatus(),
            order.getTotalAmount(), order.getShippingAddress(), order.getDiscount(),
            order.getDiscountAmount()
        };

        try {
            return execQuery(sql, params) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT \n"
                + "	o.order_id,\n"
                + "	o.user_id,\n"
                + "	o.order_date,\n"
                + "	o.status,\n"
                + "	o.total_amount,\n"
                + "	o.shipping_address,\n"
                + "	o.discount_amount,\n"
                + "	o.discount_amount,\n"
                + "	d.discount_id\n"
                + "FROM Orders o \n"
                + "JOIN Users u ON u.user_id = o.user_id\n"
                + "JOIN Discounts d ON d.discount_id = o.discount_id\n"
                + "WHERE o.order_id = ?";

        Object[] params = {orderId};

        try ( ResultSet rs = execSelectQuery(sql, params)) {
            User user = new User();
            user.setUserId(rs.getInt("user_id"));

            Discount discount = new Discount();
            discount.setDiscountId(rs.getInt("discount_id"));

            if (rs.next()) {
                return new Order(
                        rs.getInt("order_id"),
                        user,
                        rs.getTimestamp("order_date").toLocalDateTime(),
                        rs.getString("status"),
                        rs.getBigDecimal("total_amount"),
                        rs.getString("shipping_address"),
                        discount,
                        rs.getBigDecimal("discount_amount")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Order> getOrderByUserId(int userId) {
        List<Order> list = new ArrayList<>();

        String sql = "SELECT \n"
                + " o.order_id,\n"
                + " o.user_id,\n"
                + " o.order_date,\n"
                + " o.status,\n"
                + " o.total_amount,\n"
                + " o.shipping_address,\n"
                + " o.discount_amount,\n"
                + " d.discount_id\n"
                + "FROM Orders o \n"
                + "JOIN Users u ON u.user_id = o.user_id\n"
                + "LEFT JOIN Discounts d ON d.discount_id = o.discount_id\n"
                + "WHERE u.user_id = ?";

        Object[] params = {userId};

        try ( ResultSet rs = execSelectQuery(sql, params)) {
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));

                Discount discount = new Discount();
                discount.setDiscountId(rs.getInt("discount_id"));

                list.add(new Order(
                        rs.getInt("order_id"),
                        user,
                        rs.getTimestamp("order_date").toLocalDateTime(),
                        rs.getString("status"),
                        rs.getBigDecimal("total_amount"),
                        rs.getString("shipping_address"),
                        discount,
                        rs.getBigDecimal("discount_amount")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();

        String sql = "SELECT * FROM Orders;";
        try {
            ResultSet rs = execSelectQuery(sql);

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));

                Discount discount = new Discount();
                discount.setDiscountId(rs.getInt("discount_id"));

                orders.add(
                        new Order(
                                rs.getInt("order_id"),
                                user,
                                rs.getTimestamp("order_date").toLocalDateTime(),
                                rs.getString("status"),
                                rs.getBigDecimal("total_amount"),
                                rs.getString("shipping_address"),
                                discount,
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
