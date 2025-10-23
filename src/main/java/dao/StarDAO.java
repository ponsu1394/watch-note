package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Star;

public class StarDAO {
    public List<Star> findAll() {
        List<Star> list = new ArrayList<>();
        String sql = "SELECT id, label FROM stars ORDER BY id";

        try (Connection conn = DBManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Star star = new Star();
                star.setId(rs.getInt("id"));
                star.setLabel(rs.getString("label"));
                list.add(star);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public Star findById(int id) {
        String sql = "SELECT id, label FROM stars WHERE id = ?";
        try (Connection conn = DBManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Star star = new Star();
                    star.setId(rs.getInt("id"));
                    star.setLabel(rs.getString("label"));
                    return star;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // 該当なしの場合
    }
}
