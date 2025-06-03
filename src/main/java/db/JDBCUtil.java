/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class JDBCUtil {
    private Connection conn;
    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=MusicShop;encrypt=true;trustServerCertificate=true";
    private static final String USER = "sa";
    private static final String PASSWORD = "15082005";

    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    public static Connection getConnection() throws SQLException {
            return DriverManager.getConnection(DB_URL, USER, PASSWORD);
    }
    
    public static void closeConnection(Connection connect) {
        if (connect != null) {
            try {
                if (!connect.isClosed()) {
                    connect.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public ResultSet execSelecQuery(String query, Object[] params) throws  SQLException {
        PreparedStatement ps = conn.prepareStatement(query);
        
        if (params != null) {
            for(int i=0; i<params.length; i++) {
                ps.setObject(i+1, params[i]);
            }
        }
        
        return ps.executeQuery();
    }
    
    public ResultSet execSelecQuery(String query) throws  SQLException {
        return this.execSelecQuery(query, null);
    }
    
    public int execQuery(String query, Object[] params) throws  SQLException {
        PreparedStatement ps = conn.prepareStatement(query);
        
        if (params != null) {
            for(int i=0; i<params.length; i++) {
                ps.setObject(i+1, params[i]);
            }
        }
        
        return ps.executeUpdate();
    }

}
