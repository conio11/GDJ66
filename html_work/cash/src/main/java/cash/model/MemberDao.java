package cash.model;

import java.sql.*;

import cash.vo.Member;

public class MemberDao {
	// 회원정보(비밀번호) 수정 메소드
	public int modifyMember(String id, String pw, String newPw) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ? AND member_pw = PASSWORD(?)";
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/cash", "root", "java1234");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, newPw);
			stmt.setString(2, id);
			stmt.setString(3, pw);
			row = stmt.executeUpdate();
		} catch (Exception e1) {
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
	
	// 회원 탈퇴 메소드
	public int deleteMember(String id, String pw) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		// ResultSet rs = null;
		String sql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/cash", "root", "java1234");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setString(2, pw);
			row = stmt.executeUpdate();
		} catch (Exception e1) {
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
	
	// 회원 상세정보
	public Member selectMemberOne(String memberId) {
		Member member = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT member_id memberId, member_pw memberPw, createdate, updatedate FROM member WHERE member_id = ?";
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/cash", "root", "java1234");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			if (rs.next()) {
				member = new Member();
				member.setMemberId(memberId);
				member.setMemberPw(rs.getString("memberPw"));
				member.setCreatedate(rs.getString("createdate"));
				member.setUpdatedate(rs.getString("updatedate"));
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		} finally {
			try {
				stmt.close();
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return member;
	}
	
	// 회원가입 메소드
	public int insertMember(Member member) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		// ResultSet rs = null;
		String sql = "INSERT INTO member (member_id, member_pw, createdate, updatedate) VALUES(?, PASSWORD(?), NOW(), NOW())";
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/cash", "root", "java1234");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, member.getMemberId());
			stmt.setString(2, member.getMemberPw());
			row = stmt.executeUpdate();
		} catch (Exception e1) {
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
	
	// 회원가입 시 아이디 중복체크 메소드
	public int checkId(String id) {
		int check = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM member WHERE member_id = ?";
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/cash", "root", "java1234");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			rs = stmt.executeQuery();
			if (rs.next()) {
				check = rs.getInt(1);
			}
		} catch (Exception e1) {
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
		
		return check;
	}
	
	// 로그인 메소드
	public Member selectMemberById(Member paramMember) { // 로그인 성공 시 Member 객체 반환
		Member returnMember = null;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT member_id memberId FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/cash", "root", "java1234");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			rs = stmt.executeQuery();
			if (rs.next()) {
				returnMember = new Member();
				returnMember.setMemberId(rs.getString("memberId"));
			}
			
		} catch(Exception e1) {
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
		
		return returnMember;
	}
}