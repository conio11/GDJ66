package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ParentDao {
	public int insert(Connection conn, String info1) throws SQLException {
		int pid = 0;
		
		// Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "INSERT INTO parent(info1) VALUES(?)";
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			// conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/m1", "root", "java1234");
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // auto-increment 값을 구하기 위함
			stmt.setString(1, info1);
			int row = stmt.executeUpdate();
			if (row == 1) {
				rs = stmt.getGeneratedKeys();
				if (rs.next()) {
					pid = rs.getInt(1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				stmt.close();
				// conn.close(); 
			}
			
			catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return pid;
	}
}
