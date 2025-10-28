package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import model.ViewedWork;

public class ViewedWorkDAO {
	
	// 観た作品を取得
    public List<ViewedWork> findAll() {
        List<ViewedWork> list = new ArrayList<>();
        String sql =
                "SELECT vw.id, vw.title, vw.updated_at, vw.star_id, s.label AS star_label, vw.review, " +
                "GROUP_CONCAT(DISTINCT g.name ORDER BY g.name SEPARATOR ', ') AS genres " +
                "FROM viewed_works vw " +
                "LEFT JOIN stars s ON vw.star_id = s.id " +
                "LEFT JOIN viewed_work_genres vwg ON vw.id = vwg.viewed_work_id " +
                "LEFT JOIN genres g ON vwg.genre_id = g.id " +
                "GROUP BY vw.id, vw.title, vw.updated_at, vw.star_id, s.label, vw.review "+
                "ORDER BY vw.star_id DESC";

        try (Connection conn = DBManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                ViewedWork work = new ViewedWork();
                work.setId(rs.getInt("id"));
                work.setTitle(rs.getString("title"));
                work.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                work.setStarId(rs.getInt("star_id"));
                work.setStarLabel(rs.getString("star_label"));
                work.setReview(rs.getString("review"));

                String genreString = rs.getString("genres");
                if (genreString != null && !genreString.isEmpty()) {
                    String[] genreArray = genreString.split(",\\s*");
                    work.setGenres(Arrays.asList(genreArray));
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
	
    // viewed_worksテーブルに作品情報を登録し、登録された作品のIDを返す
	public int insertAndGetId(ViewedWork work) {
	    String sql = "INSERT INTO viewed_works (title, updated_at, star_id, review) VALUES (?, ?, ?, ?)";
	    try (Connection conn = DBManager.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

	        pstmt.setString(1, work.getTitle());
	        pstmt.setTimestamp(2, Timestamp.valueOf(work.getUpdatedAt()));
	        pstmt.setInt(3, work.getStarId());
	        pstmt.setString(4, work.getReview());
	        pstmt.executeUpdate();

	        try (ResultSet rs = pstmt.getGeneratedKeys()) {
	            if (rs.next()) {
	                return rs.getInt(1); // 自動生成されたIDを返す
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return -1;
	}
	
	//viewed_work_genresテーブルに作品IDとジャンルIDの組み合わせを登録する
	public void insertGenreMapping(int workId, int genreId) {
	    String sql = "INSERT INTO viewed_work_genres (viewed_work_id, genre_id) VALUES (?, ?)";
	    try (Connection conn = DBManager.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, workId);
	        pstmt.setInt(2, genreId);
	        pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

    

    // 更新
    public void update(ViewedWork viewedWork) {
        String sql = "UPDATE viewed_works SET title=?, updated_at=?, star_id=?, review=? WHERE id=?";
        try (Connection conn = DBManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, viewedWork.getTitle());
            pstmt.setTimestamp(2, Timestamp.valueOf(viewedWork.getUpdatedAt()));
            pstmt.setInt(3, viewedWork.getStarId());
            pstmt.setString(4, viewedWork.getReview());
            pstmt.setInt(5, viewedWork.getId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // 既存のジャンルを削除
    public void updateGenreMapping(int workId, String[] genreIds) {
        String deleteSql = "DELETE FROM viewed_work_genres WHERE viewed_work_id = ?";
        try (Connection conn = DBManager.getConnection();
             PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
            deleteStmt.setInt(1, workId);
            deleteStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // 新しいジャンルを挿入
        if (genreIds != null) {
            for (String genreIdStr : genreIds) {
                int genreId = Integer.parseInt(genreIdStr);
                insertGenreMapping(workId, genreId);
            }
        }
    }
    
    //作品IDで1件取得する
    public ViewedWork findById(int id) {
        String sql = "SELECT vw.id, vw.title, vw.updated_at, vw.star_id, vw.review, s.label AS star_label, " +
                     "GROUP_CONCAT(DISTINCT g.name ORDER BY g.name SEPARATOR ', ') AS genres " +
                     "FROM viewed_works vw " +
                     "LEFT JOIN stars s ON vw.star_id = s.id " +
                     "LEFT JOIN viewed_work_genres vwg ON vw.id = vwg.viewed_work_id " +
                     "LEFT JOIN genres g ON vwg.genre_id = g.id " +
                     "WHERE vw.id = ? " +
                     "GROUP BY vw.id, vw.title, vw.updated_at, vw.star_id, s.label, vw.review";

        try (Connection conn = DBManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    ViewedWork work = new ViewedWork();
                    work.setId(rs.getInt("id"));
                    work.setTitle(rs.getString("title"));
                    work.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                    work.setStarId(rs.getInt("star_id"));
                    work.setStarLabel(rs.getString("star_label"));
                    work.setReview(rs.getString("review"));

                    String genreString = rs.getString("genres");
                    if (genreString != null && !genreString.isEmpty()) {
                        String[] genreArray = genreString.split(",\\s*");
                        work.setGenres(Arrays.asList(genreArray));
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
        String sql = "SELECT genre_id FROM viewed_work_genres WHERE viewed_work_id = ?";
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

    // 削除
    public void delete(int id) {
        String sql = "DELETE FROM viewed_works WHERE id=?";
        try (Connection conn = DBManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
 // viewed_work_genres テーブルからジャンル関連を削除
    public void deleteGenreMapping(int workId) {
        String sql = "DELETE FROM viewed_work_genres WHERE viewed_work_id = ?";
        try (Connection conn = DBManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, workId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}