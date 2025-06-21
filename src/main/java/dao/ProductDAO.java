/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.JDBCUtil;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.Product;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class ProductDAO extends JDBCUtil {

    public boolean insert(Product product) {
        String sql = "INSERT INTO Products(name, description, price, stock_quantity, category_id, image_url) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            Object[] params = {
                product.getName(), product.getDescription(), product.getPrice(), product.getStockQuantity(), product.getCategory().getCategoryId(), product.getImageUrl()
            };

            return execQuery(sql, params) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(Product product) {
        String sql = "UPDATE Products SET name=?, description=?, price=?, stock_quantity=?, category_id=?, image_url=?, discount_type=? WHERE product_id=?";
        
        try {
            Object[] params = {
                product.getDescription(), product.getPrice(), product.getStockQuantity(), product.getCategory().getCategoryId(), product.getImageUrl(), product.getName()
            };
            return execQuery(sql, params) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int productId) {
        String sql = "DELETE FROM Products WHERE product_id=?";
        Object[] params = {productId};

        try {
            return execQuery(sql, params) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Product getProductById(int productId) {
        String sql = "SELECT * ,\n"
                + "	c.category_id,\n"
                + "	c.description,\n"
                + "	c.name\n"
                + "FROM Products p\n"
                + "JOIN Categories c ON c.category_id = p.category_id\n"
                + "WHERE p.product_id = ?;";
        Object[] params = {productId};

        try {
            ResultSet rs = execSelectQuery(sql, params);

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

                Category category = new Category(rs.getInt("category_id"), rs.getString("description"), rs.getString("name"));

                return new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getInt("stock_quantity"),
                        category,
                        rs.getString("image_url"),
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
        String sql = "SELECT * ,\n"
                + "	c.category_id,\n"
                + "	c.description,\n"
                + "	c.name\n"
                + "FROM Products p\n"
                + "JOIN Categories c ON c.category_id = p.category_id\n"
                + "WHERE p.product_id = ?;";
        try {
            ResultSet rs = execSelectQuery(sql);

            while (rs.next()) {
                Category category = new Category(rs.getInt("category_id"), rs.getString("description"), rs.getString("name"));

                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getInt("stock_quantity"),
                        category,
                        rs.getString("image_url"),
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
        Object[] params = {categoryId};
        String sql = "SELECT * ,\n"
                + "	c.category_id,\n"
                + "	c.description,\n"
                + "	c.name\n"
                + "FROM Products p\n"
                + "JOIN Categories c ON c.category_id = p.category_id\n"
                + "WHERE c.category_id = ?;";

        try {
            ResultSet rs = execSelectQuery(sql, params);

            while (rs.next()) {
                Category category = new Category(rs.getInt("category_id"), rs.getString("description"), rs.getString("name"));

                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getInt("stock_quantity"),
                        category,
                        rs.getString("image_url"),
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
        Object[] params = {categoryId, limit};
        String sql = "SELECT * FROM products WHERE category_id = ? LIMIT ?";

        try {
            ResultSet rs = execSelectQuery(sql, params);

            while (rs.next()) {
                Category category = new Category(rs.getInt("category_id"), rs.getString("description"), rs.getString("name"));

                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getInt("stock_quantity"),
                        category,
                        rs.getString("image_url"),
                     
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
        Object[] params = {userID};

        String sql = "SELECT DISTINCT p.product_id, p.name, p.description, p.price, p.image_url "
                + "FROM Orders o "
                + "JOIN OrderDetails od ON o.order_id = od.order_id "
                + "JOIN Products p ON od.product_id = p.product_id "
                + "WHERE o.user_id = ?";

        try {
            ResultSet rs = execSelectQuery(sql, params);
            
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setImageUrl(rs.getString("image_url"));
                productList.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }
    
//    public Product getDetailByProductId(int id) {
//    }
}
