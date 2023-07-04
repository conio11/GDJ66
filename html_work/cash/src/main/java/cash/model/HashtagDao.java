package cash.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cash.vo.Hashtag;

public class HashtagDao {
	public int insertHashtag(Hashtag hashtag) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/cash", "root", "java1234");
			String sql = "INSERT INTO hashtag(cashbook_no, word, updatedate, createdate) VALUES(?, ?, NOW(), NOW())";
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // insert 이후 자동 생성된 키 반환을 위해 사용
			stmt.setInt(1, hashtag.getCashbookNo());
			stmt.setString(2, hashtag.getWord());
	
			row = stmt.executeUpdate();
		
		}  catch (Exception e1) {
			e1.printStackTrace();
		} finally {
			try {
				stmt.close();
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return row;
	}
	
	public List<Map<String, Object>> selectWordCntByMonth(String id, int targetYear, int targetMonth) {
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
			
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/cash", "root", "java1234");
			String sql = "SELECT word, COUNT(*) cnt FROM hashtag h INNER JOIN cashbook c ON h.cashbook_no = c.cashbook_no WHERE c.member_id = ? AND YEAR(c.cashbook_date) = ? AND MONTH(c.cashbook_date) = ? GROUP BY word ORDER BY COUNT(*) DESC";
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // insert 이후 자동 생성된 키 반환을 위해 사용
			stmt.setString(1, id);
			stmt.setInt(2, targetYear);
			stmt.setInt(3, targetMonth);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("word", rs.getString("word"));
				m.put("cnt", rs.getString("cnt"));
				list.add(m);
			}
		
		}  catch (Exception e1) {
			e1.printStackTrace();
		} finally {
			try {
				rs.close();
				stmt.close();
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return list;
	}
}