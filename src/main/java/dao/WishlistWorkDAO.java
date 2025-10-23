package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import model.WishlistWork;

public class WishlistWorkDAO {

	// 観たい作品を取得
    public List<WishlistWork> findAll() {
        List<WishlistWork> list = new ArrayList<>();
        String sql = """
            SELECT w.id, w.title, w.memo,
                   GROUP_CONCAT(g.name ORDER BY g.name SEPARATOR ', ') AS genres
            FROM wishlist_works w
            LEFT JOIN wishlist_work_genres wg ON w.id = wg.wishlist_work_id
            LEFT JOIN genres g ON wg.genre_id = g.id
            GROUP BY w.id, w.title, w.memo
            ORDER BY w.id ASC
        """;

        try (Connection conn = DBManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                WishlistWork work = new WishlistWork();
                work.setId(rs.getInt("id"));
                work.setTitle(rs.getString("title"));
                work.setMemo(rs.getString("memo"));

                String genreString = rs.getString("genres");
                if (genreString != null && !genreString.isEmpty()) {
                    work.setGenres(Arrays.asList(genreString.split(",\\s*")));
                } else {
                    work.setGenres(new ArrayList<>());
                }

                list.add(work);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public int insertAndGetId(WishlistWork work) {
        String sql = "INSERT INTO wishlist_works (title, memo) VALUES (?, ?)";
        try (Connection conn = DBManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, work.getTitle());
            pstmt.setString(2, work.getMemo());
            pstmt.executeUpdate();

            try (ResultSet rs = pstmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    public void insertGenreMapping(int workId, int genreId) {
        String sql = "INSERT INTO wishlist_work_genres (wishlist_work_id, genre_id) VALUES (?, ?)";
        try (Connection conn = DBManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, workId);
            pstmt.setInt(2, genreId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    //更新
    public void update(WishlistWork work) {
        String sql = "UPDATE wishlist_works SET title=?, memo=? WHERE id=?";
        try (Connection conn = DBManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, work.getTitle());
            pstmt.setString(2, work.getMemo());
            pstmt.setInt(3, work.getId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
 // 既存のジャンルを削除
    public void updateGenreMapping(int workId, String[] genreIds) {
        deleteGenreMapping(workId);
        if (genreIds != null) {
            for (String gid : genreIds) {
                insertGenreMapping(workId, Integer.parseInt(gid));
            }
        }
    }
    
    
    //削除
    public void delete(int id) {
        try (Connection conn = DBManager.getConnection()) {
            conn.setAutoCommit(false); // トランザクション開始

            // ① 中間テーブルからジャンルの紐付けを削除
            try (PreparedStatement stmt1 = conn.prepareStatement("DELETE FROM wishlist_work_genres WHERE wishlist_work_id = ?")) {
                stmt1.setInt(1, id);
                stmt1.executeUpdate();
            }

            // ② 本体テーブルから作品を削除
            try (PreparedStatement stmt2 = conn.prepareStatement("DELETE FROM wishlist_works WHERE id = ?")) {
                stmt2.setInt(1, id);
                stmt2.executeUpdate();
            }

            conn.commit(); // トランザクション完了
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteGenreMapping(int workId) {
        String sql = "DELETE FROM wishlist_work_genres WHERE wishlist_work_id=?";
        try (Connection conn = DBManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, workId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public WishlistWork findById(int id) {
        String sql = """
            SELECT w.id, w.title, w.memo,
                   GROUP_CONCAT(g.name ORDER BY g.name SEPARATOR ', ') AS genres
            FROM wishlist_works w
            LEFT JOIN wishlist_work_genres wg ON w.id = wg.wishlist_work_id
            LEFT JOIN genres g ON wg.genre_id = g.id
            WHERE w.id = ?
            GROUP BY w.id, w.title, w.memo
        """;

        try (Connection conn = DBManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    WishlistWork work = new WishlistWork();
                    work.setId(rs.getInt("id"));
                    work.setTitle(rs.getString("title"));
                    work.setMemo(rs.getString("memo"));

                    String genreString = rs.getString("genres");
                    if (genreString != null && !genreString.isEmpty()) {
                        work.setGenres(Arrays.asList(genreString.split(",\\s*")));
                    } else {
                        work.setGenres(new ArrayList<>());
                    }

                    return work;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Integer> findGenreIdsByWorkId(int workId) {
        List<Integer> genreIds = new ArrayList<>();
        String sql = "SELECT genre_id FROM wishlist_work_genres WHERE wishlist_work_id=?";
        try (Connection conn = DBManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, workId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    genreIds.add(rs.getInt("genre_id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return genreIds;
    }
}
