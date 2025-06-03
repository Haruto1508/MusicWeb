/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.JDBCUtil;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Product;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class ProductDAO {

    public boolean insert(Product product) {
        String sql = "INSERT INTO Products(name, description, price, stock_quantity, category_id, image_url, discount_type, discount_value, discount_start, discount_end) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setInt(4, product.getStockQuantity());
            ps.setInt(5, product.getCategoryId());
            ps.setString(6, product.getImageUrl());
            // Xử lý các trường discount có thể null
            if (product.getDiscountType() != null) {
                ps.setString(7, product.getDiscountType());
            } else {
                ps.setNull(7, Types.NVARCHAR);
            }
            ps.setBigDecimal(8, product.getDiscountValue());
            // Chuyển đổi LocalDate -> java.sql.Date
            if (product.getDiscountStart() != null) {
                ps.setDate(9, Date.valueOf(product.getDiscountStart()));
            } else {
                ps.setNull(9, Types.DATE);
            }

            if (product.getDiscountEnd() != null) {
                ps.setDate(10, Date.valueOf(product.getDiscountEnd()));
            } else {
                ps.setNull(10, Types.DATE);
            }
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(Product product) {
        String sql = "UPDATE Products SET name=?, description=?, price=?, stock_quantity=?, category_id=?, image_url=?, discount_type=?, discount_value=?, discount_start=?, discount_end=? WHERE product_id=?";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setInt(4, product.getStockQuantity());
            ps.setInt(5, product.getCategoryId());
            ps.setString(6, product.getImageUrl());
            if (product.getDiscountType() != null) {
                ps.setString(7, product.getDiscountType());
            } else {
                ps.setNull(7, Types.NVARCHAR);
            }
            ps.setBigDecimal(8, product.getDiscountValue());
            if (product.getDiscountStart() != null) {
                ps.setDate(9, Date.valueOf(product.getDiscountStart()));
            } else {
                ps.setNull(9, Types.DATE);
            }

            if (product.getDiscountEnd() != null) {
                ps.setDate(10, Date.valueOf(product.getDiscountEnd()));
            } else {
                ps.setNull(10, Types.DATE);
            }
            ps.setInt(11, product.getProductID());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void delete(int productId) {
        String sql = "DELETE FROM Products WHERE product_id=?";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Product getProductById(int productId) {
        String sql = "SELECT * FROM Products WHERE product_id=?";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Xử lý các trường date có thể null
                LocalDate discountStart = null;
                Date discountStartDate = rs.getDate("discount_start");
                if (discountStartDate != null) {
                    discountStart = discountStartDate.toLocalDate();
                }

                LocalDate discountEnd = null;
                Date discountEndDate = rs.getDate("discount_end");
                if (discountEndDate != null) {
                    discountEnd = discountEndDate.toLocalDate();
                }

                return new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getInt("stock_quantity"),
                        rs.getInt("category_id"),
                        rs.getString("image_url"),
                        rs.getString("discount_type"),
                        rs.getBigDecimal("discount_value"),
                        discountStart,
                        discountEnd,
                        rs.getTimestamp("created_at").toLocalDateTime()
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Product> getAll() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getInt("stock_quantity"),
                        rs.getInt("category_id"),
                        rs.getString("image_url"),
                        rs.getString("discount_type"),
                        rs.getBigDecimal("discount_value"),
                        rs.getDate("discount_start") != null ? rs.getDate("discount_start").toLocalDate() : null,
                        rs.getDate("discount_end") != null ? rs.getDate("discount_end").toLocalDate() : null,
                        rs.getTimestamp("created_at").toLocalDateTime()
                );
                list.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM Products WHERE category_id = ?";

        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getInt("stock_quantity"),
                        rs.getInt("category_id"),
                        rs.getString("image_url"),
                        rs.getString("discount_type"),
                        rs.getBigDecimal("discount_value"),
                        rs.getDate("discount_start") != null ? rs.getDate("discount_start").toLocalDate() : null,
                        rs.getDate("discount_end") != null ? rs.getDate("discount_end").toLocalDate() : null,
                        rs.getTimestamp("created_at").toLocalDateTime()
                );
                products.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getProductsDemo(int categoryId, int limit) {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM products WHERE category_id = ? LIMIT ?";

        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);
            stmt.setInt(2, limit);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getInt("stock_quantity"),
                        rs.getInt("category_id"),
                        rs.getString("image_url"),
                        rs.getString("discount_type"),
                        rs.getBigDecimal("discount_value"),
                        rs.getDate("discount_start") != null ? rs.getDate("discount_start").toLocalDate() : null,
                        rs.getDate("discount_end") != null ? rs.getDate("discount_end").toLocalDate() : null,
                        rs.getTimestamp("created_at").toLocalDateTime()
                );
                products.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getOrderHistoryByUserId(int userID) {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT DISTINCT p.product_id, p.name, p.description, p.price, p.image_url "
                + "FROM Orders o "
                + "JOIN OrderDetails od ON o.order_id = od.order_id "
                + "JOIN Products p ON od.product_id = p.product_id "
                + "WHERE o.user_id = ?";

        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            try ( ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductID(rs.getInt("product_id"));
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getBigDecimal("price"));
                    product.setImageUrl(rs.getString("image_url"));
                    productList.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }
}
