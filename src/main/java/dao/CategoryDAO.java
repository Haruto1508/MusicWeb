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
import model.Category;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class CategoryDAO {
    public boolean insert(Category category) {
        String sql = "INSERT INTO Categories(name, description) VALUES (?, ?)";
        try (Connection conn = JDBCUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.executeUpdate();
            
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(Category category) {
        String sql = "UPDATE Categories SET name=?, description=? WHERE category_id=?";
        try (Connection conn = JDBCUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setInt(3, category.getCategoryId());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void delete(int categoryId) {
        String sql = "DELETE FROM Categories WHERE category_id=?";
        try (Connection conn = JDBCUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Category getById(int categoryId) {
        String sql = "SELECT * FROM Categories WHERE category_id=?";
        try (Connection conn = JDBCUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Category(
                        rs.getInt("category_id"),
                        rs.getString("name"),
                        rs.getString("description")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Category> getAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Categories";
        try (Connection conn = JDBCUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("category_id"),
                        rs.getString("name"),
                        rs.getString("description")
                );
                list.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
