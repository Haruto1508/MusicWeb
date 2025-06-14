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
import model.User;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class AddressDAO extends JDBCUtil {

    public boolean insert(Address address) {
        String sql = "INSERT INTO Address (user_id, street, ward, district, city, type, is_default) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Object[] params = {
            address.getUser().getUserId(), address.getStreet(), address.getWard(), address.getDistrict(), address.getCity(), address.getType(), address.isIsDefault()
        };
        try {
            return execQuery(sql, params) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Address> getAddressesByUserId(int userId) {
        List<Address> list = new ArrayList<>();
        String sql = "SELECT *, \n"
                + "	u.user_id,\n"
                + "	u.full_name,\n"
                + "	u.phone\n"
                + "FROM Address a\n"
                + "LEFT JOIN Users u ON u.user_id = a.user_id\n"
                + "WHERE a.address_id = ?";
        try {
            Object[] params = {userId};

            ResultSet rs = execSelectQuery(sql, params);
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));

                Address address = new Address(
                        rs.getInt("address_id"),
                        user,
                        rs.getString("street"),
                        rs.getString("ward"),
                        rs.getString("district"),
                        rs.getString("city"),
                        rs.getString("type"),
                        rs.getBoolean("is_default")
                );
                list.add(address);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean update(Address address) {
        String sql = "UPDATE Address SET street = ?, ward = ?, district = ?, city = ?, type = ?, is_default = ? WHERE address_id = ?";
        Object[] params = {
            address.getStreet(), address.getWard(), address.getDistrict(), address.getCity(), address.getType(), address.isIsDefault(), address.getUser().getUserId()
        };
        
        try {
            return execQuery(sql, params) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }

    public boolean delete(int addressId) {
        String sql = "DELETE FROM Address WHERE address_id = ?";
        Object[] params = {addressId};
        
        try {
           return execQuery(sql, params) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }

    public Address getDefaultAddress(int userId) {
        String sql = "SELECT *, \n"
                + "	u.user_id,\n"
                + "	u.full_name,\n"
                + "	u.phone\n"
                + "FROM Address a\n"
                + "LEFT JOIN Users u ON u.user_id = a.user_id\n"
                + "WHERE a.address_id = ? AND a.is_default = 1";
        Object[] params = {userId};
        
        try {
            ResultSet rs = execSelectQuery(sql, params);
            
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));

                return new Address(
                        rs.getInt("address_id"),
                        user,
                        rs.getString("street"),
                        rs.getString("ward"),
                        rs.getString("district"),
                        rs.getString("city"),
                        rs.getString("type"),
                        rs.getBoolean("is_default")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public static void main(String[] args) {
        AddressDAO addressDAO = new AddressDAO();
        
        List<Address> a = addressDAO.getAddressesByUserId(1);
        
        for(Address ar : a){
            System.out.println(ar.toString());
        }
    }
}


