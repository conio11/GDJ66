package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ChildDao {
	public int insert(Connection conn, int pid, String info2) throws SQLException {
		int row = 0;
		
		// Connection conn = null;
		PreparedStatement stmt = null;

		
		String sql = "INSERT INTO child(pid, info2) VALUES(?, ?)";
		
		try {
			// Class.forName("org.mariadb.jdbc.Driver");
			// conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/m1", "root", "java1234");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, pid);
			stmt.setString(2, info2);
			row = stmt.executeUpdate();

		//} catch (Exception e) {
			// e.printStackTrace();
		} finally {
			try {
				stmt.close();
				// conn.close();
			}
			catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return row;
	}
}
