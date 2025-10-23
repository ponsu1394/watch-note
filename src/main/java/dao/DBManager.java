package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBManager {

	private final static String JDBC_URL="jdbc:mysql://localhost:3306/watchnote?useSSL=false&serverTimezone=UTC";
	private final static String DB_USER="root";
	private final static String DB_PASS="root";


    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");  // JDBC 8以降の正しいドライバークラス名
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
    	Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);

        // ★接続先のデータベース名を確認
        try {
            var rs = conn.createStatement().executeQuery("SELECT DATABASE()");
            if (rs.next()) {
                System.out.println("Javaが接続しているDB名: " + rs.getString(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return conn;

    }
}