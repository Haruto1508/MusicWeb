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
import model.Address;
import model.Discount;
import model.Order;
import model.User;
import model.Product;
import model.Brand;
import model.Category;
import java.sql.Timestamp;

public class OrderDAO extends JDBCUtil {

    public boolean addOrder(Order order) {
        String sql = "INSERT INTO Orders (user_id, status, total_amount, discount_id, discount_amount, order_phone, receiver_name, address_id) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        Object[] params = {
            order.getUser().getUserId(),
            order.getStatus(),
            order.getTotalAmount(),
            order.getDiscount() != null ? order.getDiscount().getDiscountId() : null,
            order.getDiscountAmount(),
            order.getOrderPhone(),
            order.getReceiverName(),
            order.getAddress() != null ? order.getAddress().getAddressId() : null
        };

        try {
            return execQuery(sql, params) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT o.*, a.street, a.city, a.district, a.ward, a.type, a.is_default "
                   + "FROM Orders o "
                   + "LEFT JOIN Address a ON o.address_id = a.address_id "
                   + "WHERE o.order_id = ?";

        Object[] params = {orderId};

        try (ResultSet rs = execSelectQuery(sql, params)) {
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));

                Discount discount = null;
                int discountId = rs.getInt("discount_id");
                if (!rs.wasNull()) {
                    discount = new Discount();
                    discount.setDiscountId(discountId);
                }

                Address address = null;
                int addressId = rs.getInt("address_id");
                if (!rs.wasNull()) {
                    address = new Address();
                    address.setAddressId(addressId);
                    address.setStreet(rs.getString("street"));
                    address.setCity(rs.getString("city"));
                    address.setDistrict(rs.getString("district"));
                    address.setWard(rs.getString("ward"));
                    address.setType(rs.getString("type"));
                    address.setIsDefault(rs.getBoolean("is_default"));
                    address.setUser(user);
                }

                return new Order(
                        rs.getInt("order_id"),
                        user,
                        rs.getTimestamp("order_date").toLocalDateTime(),
                        rs.getString("status"),
                        rs.getBigDecimal("total_amount"),
                        discount,
                        rs.getBigDecimal("discount_amount"),
                        rs.getString("order_phone"),
                        rs.getString("receiver_name"),
                        address
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Order> getOrderByUserId(int userId) {
        List<Order> list = new ArrayList<>();

        String sql = "SELECT o.*, d.discount_id "
                   + "FROM Orders o "
                   + "LEFT JOIN Discounts d ON d.discount_id = o.discount_id "
                   + "WHERE o.user_id = ?";

        Object[] params = {userId};

        try (ResultSet rs = execSelectQuery(sql, params)) {
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));

                Discount discount = null;
                int discountId = rs.getInt("discount_id");
                if (!rs.wasNull()) {
                    discount = new Discount();
                    discount.setDiscountId(discountId);
                }

                Order order = new Order(
                        rs.getInt("order_id"),
                        user,
                        rs.getTimestamp("order_date").toLocalDateTime(),
                        rs.getString("status"),
                        rs.getBigDecimal("total_amount"),
                        discount,
                        rs.getBigDecimal("discount_amount"),
                        rs.getString("order_phone"),
                        rs.getString("receiver_name"),
                        null // Không join Address ở đây để tối ưu
                );

                list.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders";

        try (ResultSet rs = execSelectQuery(sql)) {
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));

                Discount discount = null;
                int discountId = rs.getInt("discount_id");
                if (!rs.wasNull()) {
                    discount = new Discount();
                    discount.setDiscountId(discountId);
                }

                Order order = new Order(
                        rs.getInt("order_id"),
                        user,
                        rs.getTimestamp("order_date").toLocalDateTime(),
                        rs.getString("status"),
                        rs.getBigDecimal("total_amount"),
                        discount,
                        rs.getBigDecimal("discount_amount"),
                        rs.getString("order_phone"),
                        rs.getString("receiver_name"),
                        null // Không join Address ở đây
                );

                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public Product getProductByOrderId(int orderId) {
        String sql = "SELECT  \n"
                + "    p.name AS product_name, \n"
                + "    p.description AS product_description, \n"
                + "    p.image_url, \n"
                + "    p.category_id, \n"
                + "    p.brand_id, \n"
                + "    p.price,\n"
                + "    p.stock_quantity,\n"
                + "    p.discount_id, \n"
                + "    p.product_id, \n"
                + "    b.brand_id AS brand_id, \n"
                + "    b.brand_name AS brand_name,\n"
                + "    c.category_id AS category_id,\n"
                + "    c.name AS category_name,\n"
                + "    c.description AS category_description\n"
                + "FROM OrderDetails od \n"
                + "LEFT JOIN Products p ON p.product_id = od.product_id \n"
                + "LEFT JOIN Orders o ON o.order_id = od.order_id \n"
                + "LEFT JOIN Brands b ON b.brand_id = p.brand_id \n"
                + "LEFT JOIN Categories c ON c.category_id = p.category_id\n"
                + "WHERE o.order_id = ?";

        Object[] params = {orderId};

        try (ResultSet rs = execSelectQuery(sql, params)) {
            if (rs.next()) {
                Product product = new Product();

                Brand brand = new Brand(
                        rs.getInt("brand_id"),
                        rs.getString("brand_name")
                );

                Category category = new Category(
                        rs.getInt("category_id"),
                        rs.getString("category_name"),
                        rs.getString("category_description")
                );

                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("product_name"));
                product.setDescription(rs.getString("product_description"));
                product.setImageUrl(rs.getString("image_url"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setBrand(brand);
                product.setCategory(category);

                return product;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public static void main(String[] args) {
        Product product = new OrderDAO().getProductByOrderId(3);
        System.out.println(product);
    }
}