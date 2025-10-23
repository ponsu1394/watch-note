package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Genre;

public class GenreDAO {
    public List<Genre> findAll() {
        List<Genre> list = new ArrayList<>();
        String sql = "SELECT id, name FROM genres ORDER BY id";

        try (Connection conn = DBManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Genre genre = new Genre();
                genre.setId(rs.getInt("id"));
                genre.setName(rs.getString("name"));
                list.add(genre);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
