/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.JDBCUtil;
import enums.DiscountType;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Brand;
import model.Category;
import model.Discount;
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
        String sql = "SELECT * \n"
                + "  FROM Products p  \n"
                + "  LEFT JOIN Categories c ON c.category_id = p.category_id \n"
                + "  LEFT JOIN Brands b ON b.brand_id = p.brand_id\n"
                + "  LEFT JOIN Discounts d ON d.discount_id = p.discount_id\n"
                + "  WHERE p.product_id = ?";
        Object[] params = {productId};

        try {
            ResultSet rs = execSelectQuery(sql, params);

            if (rs.next()) {

                Category category = new Category(rs.getInt("category_id"), rs.getString("description"), rs.getString("name"));
                Brand brand = new Brand(rs.getInt("brand_id"), rs.getString("brand_name"));
                Discount discount = new Discount(
                        rs.getInt("discount_id"), rs.getString("code"),
                        rs.getString("description"), null,
                        rs.getBigDecimal("discount_value"), rs.getDate("start_date").toLocalDate(),
                        rs.getDate("end_date").toLocalDate(),
                        rs.getBigDecimal("minimum_order_value"), rs.getInt("usage_limit"),
                        rs.getInt("used_count"),
                        rs.getBoolean("is_active"));

                return new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getInt("stock_quantity"),
                        category,
                        rs.getString("image_url"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        brand,
                        discount
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Product> getAll() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * \n"
                + "  FROM Products p  \n"
                + "  LEFT JOIN Categories c ON c.category_id = p.category_id \n"
                + "  LEFT JOIN Brands b ON b.brand_id = p.brand_id\n"
                + "  LEFT JOIN Discounts d ON d.discount_id = p.discount_id";

        try {
            ResultSet rs = execSelectQuery(sql);

            while (rs.next()) {
                Category category = new Category(rs.getInt("category_id"), rs.getString("description"), rs.getString("name"));
                Brand brand = new Brand(rs.getInt("brand_id"), rs.getString("brand_name"));
                Discount discount = new Discount(
                        rs.getInt("discount_id"), rs.getString("code"),
                        rs.getString("description"), null,
                        rs.getBigDecimal("discount_value"), rs.getDate("start_date").toLocalDate(),
                        rs.getDate("end_date").toLocalDate(),
                        rs.getBigDecimal("minimum_order_value"), rs.getInt("usage_limit"),
                        rs.getInt("used_count"),
                        rs.getBoolean("is_active"));

                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getInt("stock_quantity"),
                        category,
                        rs.getString("image_url"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        brand,
                        discount
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

        String sql = "SELECT * \n"
                + "  FROM Products p  \n"
                + "  LEFT JOIN Categories c ON c.category_id = p.category_id \n"
                + "  LEFT JOIN Brands b ON b.brand_id = p.brand_id\n"
                + "  LEFT JOIN Discounts d ON d.discount_id = p.discount_id\n"
                + "  WHERE p.category_id = ?";

        try {
            ResultSet rs = execSelectQuery(sql, params);
            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("category_id"),
                        rs.getString("description"),
                        rs.getString("name")
                );
                Brand brand = new Brand(
                        rs.getInt("brand_id"),
                        rs.getString("brand_name")
                );

                Discount discount = null;
                int discountId = rs.getInt("discount_id");
                if (!rs.wasNull() && discountId != 0) {
                    int discountType = rs.getInt("discount_type");
                    DiscountType type = DiscountType.fromType(discountType);

                    discount = new Discount(
                            rs.getInt("discount_id"),
                            rs.getString("code"),
                            rs.getString("description"),
                            type,
                            rs.getBigDecimal("discount_value"),
                            rs.getDate("start_date") != null ? rs.getDate("start_date").toLocalDate() : null,
                            rs.getDate("end_date") != null ? rs.getDate("end_date").toLocalDate() : null,
                            rs.getBigDecimal("minimum_order_value"),
                            rs.getInt("usage_limit"),
                            rs.getInt("used_count"),
                            rs.getBoolean("is_active")
                    );
                }

                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getInt("stock_quantity"),
                        category,
                        rs.getString("image_url"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        brand,
                        discount
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
                product.setProductId(rs.getInt("product_id"));
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

    public List<Product> getRelatedProducts(int productId, int limit) {
        List<Product> list = new ArrayList<>();

        String sql = "SELECT TOP " + limit + " * "
                + "FROM Products "
                + "WHERE product_id <> ? AND is_active = 1 "
                + "AND (category_id = (SELECT category_id FROM Products WHERE product_id = ?) "
                + "OR brand_id = (SELECT brand_id FROM Products WHERE product_id = ?)) "
                + "ORDER BY NEWID()";

        Object[] params = {limit, productId, productId};

        try ( ResultSet rs = execSelectQuery(sql, params)) {
            while (rs.next()) {
                Product product = new Product();
                product.setName(rs.getString("name"));
                product.setProductId(rs.getInt("product_id"));
                product.setImageUrl(rs.getString("image_url"));
                product.setPrice(rs.getBigDecimal("price"));

                list.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public static void main(String[] args) {
        Product product = new ProductDAO().getProductById(3);

        System.out.println(product.toString());
    }
}
