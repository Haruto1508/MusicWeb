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
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.Product;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class CartDAO {

    public void insert(Cart cart) {
        String sql = "INSERT INTO Carts (userID, productID, quantity, addDate) VALUES (?, ?, ?, ?)";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cart.getUserID());
            stmt.setInt(2, cart.getProductID());
            stmt.setInt(3, cart.getQuantity());
            stmt.setTimestamp(4, Timestamp.valueOf(cart.getAddDate()));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Cart cart) {
        String sql = "UPDATE Carts SET userID=?, productID=?, quantity=?, addDate=? WHERE cartID=?";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cart.getUserID());
            stmt.setInt(2, cart.getProductID());
            stmt.setInt(3, cart.getQuantity());
            stmt.setTimestamp(4, Timestamp.valueOf(cart.getAddDate()));
            stmt.setInt(5, cart.getCartID());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int cartID) {
        String sql = "DELETE FROM Carts WHERE cartID=?";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Cart getCartByID(int cartID) {
        String sql = "SELECT * FROM Carts WHERE cartID=?";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Cart(
                        rs.getInt("cartID"),
                        rs.getInt("userID"),
                        rs.getInt("productID"),
                        rs.getInt("quantity"),
                        rs.getTimestamp("addDate").toLocalDateTime()
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Cart> getCartByUserId(int userId) {
        List<Cart> cartItems = new ArrayList<>();
        String sql = "SELECT c.cart_id, c.user_id, c.product_id, c.quantity, c.added_at, "
                + "p.name AS product_name, p.price, p.image_url "
                + "FROM Carts c "
                + "JOIN Products p ON c.product_id = p.product_id "
                + "WHERE c.user_id = ?";

        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try ( ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Tạo Product
                    Product product = new Product();
                    product.setProductId(rs.getInt("product_id"));
                    product.setName(rs.getString("product_name"));
                    product.setPrice(rs.getBigDecimal("price"));
                    product.setImageUrl(rs.getString("image_url"));

                    // Tạo Cart và gán Product
                    Cart cart = new Cart(
                            rs.getInt("cart_id"),
                            rs.getInt("user_id"),
                            rs.getInt("product_id"),
                            rs.getInt("quantity"),
                            rs.getTimestamp("added_at").toLocalDateTime()
                    );
                    cart.setProduct(product);

                    cartItems.add(cart);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }
    
    public static void main(String[] args) {
        CartDAO c = new CartDAO();
        
        List<Cart> cl = c.getCartByUserId(1);
        
        for(Cart cs : cl) {
            System.out.println(c.toString());
        }
    }
}
