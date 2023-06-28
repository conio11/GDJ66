package dao;

import java.util.*;
import java.sql.*;
import vo.Sample;

public class SampleDao {
	// ArrayList 대신 List(인터페이스) 반환 -> 확장성 고려 (List 안에 ArrayList 포함 -> 다형성)
	public List<Sample> selectSampleAll() {
		List<Sample> list = new ArrayList<>();
		Connection conn = null; // 다른 블록 안에서 사용하기 위해 try문 밖에 선언(초기화)
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String driver = "org.mariadb.jdbc.Driver";
		String url = "jdbc:mariadb://127.0.0.1:3306/servicetest";
		String dbid = "root";
		String dbpw = "java1234";
		String sql = "SELECT x, y FROM sample";
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, dbid, dbpw);
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				// Sample s = new Sample(rs.getInt("x"), rs.getInt("y"));
				Sample s = new Sample();
				s.setX(rs.getInt("x"));
				s.setY(rs.getInt("y"));
				// 디버깅
				// toString() 메소드가 오버라이딩 되어 있지 않다면 아래와 같이 사용
				// System.out.println("s.x: " + s.getX());
				// System.out.println("s.y: " + s.getY());
				
				// toString() 메소드 오버라이딩
				System.out.println(s); 
				list.add(s);	
			}
			
		} catch (Exception e) { // Exception: 모든 예외를 받을 수 있음
			// conn.close();
			e.printStackTrace(); // 콘솔에만 출력 -> 사용자가 볼 수 없음
		} finally { // 예외 발생 여부에 상관없이 항상 실행되는 코드
			try {
				rs.close(); 
				stmt.close();
				conn.close(); // rs, stmt 이후 실행
			} catch (SQLException e){
				e.printStackTrace();
			}
			
		}
		// rs 사용하지 않음(ArrayList 등 사용) -> 일반적인 데이터 타입이 아님, DB자원을 반환해야 함 
		// conn.close(); // 위에서 예외 발생하면 실행되지 않을 수 있음
		
		return list;
	}
}