package dao;

import java.sql.*;

public class EmployeeDao {
	// employees 테이블의 모든 행의 수(int)를 반환하는 메소드
	public int selectEmployeeCount() throws Exception {
		int totalRow = 0;
		String driver = "oracle.jdbc.driver.OracleDriver";
		Class.forName(driver);
		String dbUser = "hr";
		String dbPw = "1234";
		String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
		Class.forName(driver);
		System.out.println("드라이버 로딩 성공(EmployeeDao)");
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		System.out.println("DB 접속 성공(EmployeeDao)");
		
		PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM employees");
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			totalRow = rs.getInt(1); // 반환할 행이 1개 // rs.getInt(COUNT(*)
		}
		return totalRow;
	}
}
