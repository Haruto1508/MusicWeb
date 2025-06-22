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
import model.Role;
import model.User;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class UserDAO extends JDBCUtil {

    public boolean insert(User user) {
        String sql = "INSERT INTO Users(full_name, email, password, phone, gender, birthdate, account) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Object[] params = {
            user.getFullName(),
            user.getEmail(),
            user.getPassword(),
            user.getPhone(),
            user.getGender(),
            user.getBirthdate() != null ? java.sql.Date.valueOf(user.getBirthdate()) : null,
            user.getAccount()
        };

        try {
            ResultSet rs = execInsertWithGeneratedKeys(sql, params);
            if (rs.next()) {
                int generatedId = rs.getInt(1);
                user.setUserId(generatedId);
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(User user) {
        String sql = "UPDATE Users SET full_name=?, email=?, phone=?, gender=?, birthdate=? WHERE user_id=?";
        Object[] params = {
            user.getFullName(), user.getEmail(), user.getPhone(), user.getGender(), user.getBirthdate(), user.getUserId()
        };

        try {
            return execQuery(sql, params) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int userId) {
        String sql = "DELETE FROM Users WHERE user_id=?";
        Object[] params = {userId};

        try {
            return execQuery(sql, params) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserById(int userId) {
        String sql = "select *,\n"
                + "	r.name,\n"
                + "	r.description\n"
                + "FROM Users u \n"
                + "LEFT JOIN Roles r ON r.role_id = u.role_id\n"
                + "WHERE u.user_id = ?";
        Object[] params = {userId};

        try {
            ResultSet rs = execSelectQuery(sql, params);

            if (rs.next()) {
                Role role = new Role(rs.getInt("role_id"), rs.getString("name"), rs.getString("description"));

                User user = new User();
                user.setAccount(rs.getString("account"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setCreateDateTime(rs.getTimestamp("created_at").toLocalDateTime());
                user.setImageUrl(rs.getString("image_url"));
                user.setGender(rs.getString("gender"));
                user.setRole(role);
                user.setUserId(rs.getInt("user_id"));
                user.setBirthdate(rs.getDate("birthdate") != null ? rs.getDate("birthdate").toLocalDate() : null);

                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> getAll() {
        List<User> list = new ArrayList<>();
        String sql = "select *,\n"
                + "	r.name,\n"
                + "	r.description\n"
                + "FROM Users u \n"
                + "LEFT JOIN Roles r ON r.role_id = u.role_id\n"
                + "WHERE u.user_id = ?";
        try {
            ResultSet rs = execSelectQuery(sql);

            while (rs.next()) {
                Role role = new Role(rs.getInt("role_id"), rs.getString("name"), rs.getString("description"));
                User user = new User();
                user.setAccount(rs.getString("account"));
                user.setPassword("password");
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setCreateDateTime(rs.getTimestamp("created_at").toLocalDateTime());
                user.setImageUrl(rs.getString("image_url"));
                user.setGender(rs.getString("gender"));
                user.setRole(role);
                user.setUserId(rs.getInt("user_id"));
                user.setBirthdate(rs.getDate("birthdate") != null ? rs.getDate("birthdate").toLocalDate() : null);

                list.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public User getUserLogin(String login, String password) {
        String sql = "select *,\n"
                + "	r.name,\n"
                + "	r.description\n"
                + "FROM Users u \n"
                + "LEFT JOIN Roles r ON r.role_id = u.role_id\n"
                + "WHERE (email = ? OR account = ?) AND password = ?";
        Object[] params = {login, login, password};
        User user = null;

        try {
            ResultSet rs = execSelectQuery(sql, params);

            if (rs.next()) {
                Role role = new Role(rs.getInt("role_id"), rs.getString("name"), rs.getString("description"));
                user = new User();

                user.setAccount(rs.getString("account"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setCreateDateTime(rs.getTimestamp("created_at").toLocalDateTime());
                user.setImageUrl(rs.getString("image_url"));
                user.setGender(rs.getString("gender"));
                user.setRole(role);
                user.setUserId(rs.getInt("user_id"));
                user.setBirthdate(rs.getDate("birthdate") != null ? rs.getDate("birthdate").toLocalDate() : null);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public User isUserTaken(String account, String phone, String email) {
        String sql = "SELECT * FROM Users WHERE account = ? OR phone = ? OR email = ?";
        Object[] params = {account, phone, email};
        User user = null;
        try {
            ResultSet rs = execSelectQuery(sql, params);

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setAccount(rs.getString("account"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    public boolean updateUserInfo(User user) {
        String sql = "UPDATE Users"
                + "SET full_name = ?, account = ?, gender = ?, phone = ?, birthdate = ?, email = ?"
                + "WHERE user_id = ?";
        Object[] params = {user.getFullName(), user.getAccount(), user.getGender(), user.getPhone(), user.getBirthdate(), user.getEmail(), user.getUserId()};

        try {
            return execQuery(sql, params) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public User checkDuplicateAccountInfo(String account, String phone, String email, int id) {
        String sql = "SELECT * FROM Users WHERE (account = ? OR phone = ? OR email = ?) AND user_id != ?";
        Object[] params = {account, phone, email, id};
        User user = null;
        try {
            ResultSet rs = execSelectQuery(sql, params);
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setAccount(rs.getString("account"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public boolean updatePasswordByUserId(String password, int id) {
        String sql = "UPDATE Users\n"
                + "SET password = ?\n"
                + "WHERE user_id = ?";
        
        Object[] params = {password, id};
        
        try {
            return execQuery(sql, params) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }

    public static void main(String[] args) {
        UserDAO u = new UserDAO();

        User uss = u.getUserLogin("ramcute", "ed218e06b885297d0750b65be5e4041e");

        System.out.println(uss.toString());
        System.out.println(uss.getPassword());
    }

}
