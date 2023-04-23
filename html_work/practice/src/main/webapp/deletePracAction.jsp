<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>

<%
	// 입력폼 화면 -> deletePracForm
	
	// 데이터 번호, 비밀번호 중 null 또는 공백값 있을 경우 초기 화면으로 리다이렉트
	if (request.getParameter("pracNo") == null
	|| request.getParameter("pracPw") == null
	|| request.getParameter("pracNo").equals("")
	|| request.getParameter("pracPw").equals("")) {
		response.sendRedirect("./pracList.jsp");
		return;
	}
	
	int pracNo = Integer.parseInt(request.getParameter("pracNo"));
	String pracPw = request.getParameter("pracPw");
	
	System.out.println(pracNo + " <-- pracNo(delete)");
	System.out.println(pracPw + " <-- pracPw(delete)");
	
	// 쿼리문
	// delete from practice where prac_no=? and prac_pw=?
			
	// 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공(delete)");
	
	// MariaDB 로그인 후 접속정보 반환
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419", "root", "java1234");
	System.out.println("DB 접속 성공(delete) : " + conn);
	
	// 쿼리 생성 
	String sql = "delete from practice where prac_no=? and prac_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	// ? 2개 (1, 2)
	stmt.setInt(1, pracNo);
	stmt.setString(2, pracPw);
	System.out.println(stmt + " <-- stmt(delete)");
	
	int row = stmt.executeUpdate(); // 완료된 행 수
	System.out.println(row + " row");
	
	if (row == 0) { // 비밀번호 틀릴 경우 삭제 완료 행 0 -> 삭제 실패 -> 이전 폼으로 리다이렉트
		response.sendRedirect("./deletePracForm.jsp?pracNo=" + pracNo);
	} else { // 삭제 성공
		response.sendRedirect("./pracList.jsp");
	}
%>