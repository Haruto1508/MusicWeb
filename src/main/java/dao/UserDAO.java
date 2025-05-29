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
import model.User;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class UserDAO {

    public boolean insert(User user) {
        String sql = "INSERT INTO Users(full_name, email, password, phone, address, role) VALUES (?, ?, ?, ?, ?, ?)";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getRole());
            ps.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean update(User user) {
        String sql = "UPDATE Users SET full_name=?, email=?, password=?, phone=?, address=?, role=? WHERE user_id=?";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getRole());
            ps.setInt(7, user.getUserId());
            ps.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int userId) {
        String sql = "DELETE FROM Users WHERE user_id=?";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getById(int userId) {
        String sql = "SELECT * FROM Users WHERE user_id=?";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("user_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("role_id"),
                        rs.getString("account"),
                        rs.getTimestamp("created_at").toLocalDateTime()
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> getAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User(
                        rs.getInt("user_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("role_id"),
                        rs.getString("account"),
                        rs.getTimestamp("created_at").toLocalDateTime()
                );
                
                list.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean isLogin(String login, String password) {
        String sql = "SELECT * FROM Users WHERE (email = ? OR account = ?) AND password = ?";
        User user = null;
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, login);
            ps.setString(2, login);
            ps.setString(3, password);

            try ( ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserLogin(String login, String password) {
        String sql = "SELECT * FROM Users WHERE (email = ? OR account = ?) AND password = ?";
        User user = null;

        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setString(1, login);
            ps.setString(2, login);
            ps.setString(3, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User(
                        rs.getInt("user_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("role_id"),
                        rs.getString("account"),
                        rs.getTimestamp("created_at").toLocalDateTime()
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean isUsernameTaken(String account, String phone) {
        String sql = "SELECT username FROM users WHERE account = ? or phone = ?";
        try ( Connection conn = JDBCUtil.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, account);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // Nếu có kết quả -> đã tồn tại
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    public static void main(String[] args) {
        UserDAO u = new UserDAO();
        
        List<User> user = u.getAll();
        
        for(User us : user) {
            System.out.println(us.toString());
        }
    }
}
