/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.JDBCUtil;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.Review;
import model.User;

/**
 *
 * @author Nguyen Hoang Thai Vinh - CE190384
 */
public class ReviewDAO extends JDBCUtil {

    public Review getReviewById(int id) {
        return new Review();
    }
    
    public boolean createReview(int productId, int userId, int rating, String comment) {
        String sql = "INSERT Reviews (product_id, user_id, rating, comment) VALUES (?, ?, ?, ?)";
        Object[] params = {
            productId,
            userId,
            rating,
            comment
        };

        try {
            return execQuery(sql, params) > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Review> getReviewsByUserAndProduct(int userId, int productId) {
        String sql = "SELECT  \n"
                + "r.* , p.name, u.account \n"
                + "FROM  \n"
                + "Reviews r  \n"
                + "LEFT JOIN Products p ON p.product_id = r.product_id  \n" 
                + "LEFT JOIN Users u ON u.user_id = r.user_id \n"
                + "WHERE r.user_id = ? AND r.product_id = ?";
        Object[] params = {userId, productId};
        List<Review> reviewList = new ArrayList<>();

        try ( ResultSet rs = execSelectQuery(sql, params)) {
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));

                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setAccount(rs.getString("account"));
                
                Review r = new Review();
                r.setReviewId(rs.getInt("review_id"));
                r.setProduct(p);
                r.setComment(rs.getString("comment"));
                r.setRating(rs.getInt("rating"));

                // Lấy created_at
                Timestamp ts = rs.getTimestamp("created_at");
                if (ts != null) {
                    r.setCommentDate(ts.toLocalDateTime());
                }

                reviewList.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return reviewList;
    }

    public boolean deleteReview(int reviewId) {
        String sql = "DELETE FROM Reviews WHERE review_id = ?";
        Object[] params = {reviewId};

        try {
            return execQuery(sql, params) > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateReview(Review review) {
        String sql = "UPDATE Reviews SET rating = ?, comment = ? WHERE review_id = ?";
        Object[] params = {
            review.getRating(),
            review.getComment(),
            review.getReviewId()
        };

        try {
            return execQuery(sql, params) > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

}
