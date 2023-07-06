package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import model.ChildDao;
import model.ParentDao;

public class ParentService {
	// Controller에서 info1, info2 매개값으로
	public void add(String info1, String info2) {
		Connection conn = null; // Connection 객체 conn 초기화
		int row = 0;
		
		try {
			
			Class.forName("org.mariadb.jdbc.Driver"); // 드라이버 로딩
			conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/m1", "root", "java1234"); // DB 연결
			
			// ParentDao.insert() & ChildDao.insert() 호출 -> 하나의 트랜잭션
			
			conn.setAutoCommit(false); // 자동 커밋 비활성화
			
			
			ParentDao parentDao = new ParentDao();
			int pid = parentDao.insert(conn, info1);
			
			ChildDao childDao = new ChildDao(); 
			row = childDao.insert(conn, pid, info2);
			
			conn.commit(); // 트랜잭션 커밋 (예외가 발생하지 않을 경우)
		} catch (Exception e) { // 예외가 발생한 경우 예외처리
			e.printStackTrace();
			
			try {
				conn.rollback(); // 트랜잭션 롤백
				
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
		}  finally {
			try {
				conn.close(); // DB 연결 닫기
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}