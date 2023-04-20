<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
    
<%
	// 입력폼 화면은 deleteNoticeForm
	
	// 번호, 비밀번호 중 null값이나 공백이 있을 경우 초기 화면으로 리다이렉트
	if (request.getParameter("noticeNo") == null
	|| request.getParameter("noticePw") == null
	|| request.getParameter("noticeNo").equals("")
	|| request.getParameter("noticePw").equals("")) {
		response.sendRedirect("./noticeList2.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticePw = request.getParameter("noticePw");
	
	System.out.println(noticeNo + " <-- deleteNoticeAction param noticeNo");
	System.out.println(noticePw + " <-- deleteNoticeAction param noticePw");
	
	
	// 쿼리문
	// delete from notice where notice_no=? and notice_pw=?
			
	// 드라이버 설정
	Class.forName("org.mariadb.jdbc.Driver");
	// db, 로그인 정보 입력
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	// 긴 쿼리문은 sql 변수로 설정
	String sql = "delete from notice where notice_no=? and notice_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	// ? 2개 (1, 2)
	stmt.setInt(1, noticeNo);
	stmt.setString(2, noticePw);
	System.out.println(stmt + " <-- deleteNoticeAction sql"); // 쿼리 출력
	
	int row = stmt.executeUpdate(); // 완료된 행 수 ?
	System.out.println(row + " <-- row");
	
	if (row == 0) { // 비밀번호 틀려서 삭제행 0 // 삭제 실패 -> 이전 폼으로 리다이렉트
		response.sendRedirect("./deleteNoticeForm.jsp?noticeNo=" + noticeNo);
	} else {
		response.sendRedirect("./noticeList2.jsp");
	}
%>