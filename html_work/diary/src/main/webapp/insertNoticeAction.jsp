<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<!-- ResultSet 사용 X  -->

<%
	// MVC 형태로 작성
	
	// validation (요청 파라미터값 유효성 검사)
	
	// post 방식 인코딩 처리
	request.setCharacterEncoding("UTF-8"); 
	
	// 한 개의 값이라도 공백이거나 null이면 페이지 넘어가지 않고 insertNoticeForm.jsp 다시 실행
	if (request.getParameter("noticeTitle") == null 
		|| request.getParameter("noticeContent") == null 
		|| request.getParameter("noticeWriter") == null 
		|| request.getParameter("noticePw") == null 
		|| request.getParameter("noticeTitle").equals("")
		|| request.getParameter("noticeContent").equals("")
		|| request.getParameter("noticeWriter").equals("")
		|| request.getParameter("noticePw").equals("")) {
		response.sendRedirect("./insertNoticeForm.jsp");
		return; // 종료
	}

	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	String noticeWriter = request.getParameter("noticeWriter");
	String noticePw = request.getParameter("noticePw");

	// 입력된 값들을 DB 테이블에 입력
	/*
	    insert into notice(notice_title, notice_content, notice_writer, notice_pw, createdate, updatedate)
	    values(?, ?, ?, ?, now(), now()) // ? 는 값(values)에 대해서만 사용 가능
	*/
	
	// 드라이버 설정
	Class.forName("org.mariadb.jdbc.Driver");
	// db, 로그인 정보 입력
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	// 긴 쿼리문은 sql 변수로 설정
	String sql = "insert into notice(notice_title, notice_content, notice_writer, notice_pw, createdate, updatedate) values(?, ?, ?, ?, now(), now())";
	PreparedStatement stmt = conn.prepareStatement(sql);
	// ? 4개 (1 ~ 4)
	stmt.setString(1, noticeTitle); // 첫 번째 ? 에 들어갈 값: noticeTitle
	stmt.setString(2, noticeContent); 
	stmt.setString(3, noticeWriter);
	stmt.setString(4, noticePw);
	int row = stmt.executeUpdate(); // 0이면 입력된 행 X, 1이면 1행 입력 성공, 2이면 2행 입력 성공 
	System.out.println(row + " <-- row"); // row 값을 이용한 디버깅 코드
	
	conn.setAutoCommit(true); // 디폴트 값이 true이므로 executeUpdate(); 후 커밋 자동실행 
	// conn.commit(); // 커밋 자동실행 설정되어 있으므로 생략 가능
	
	response.sendRedirect("./noticeList2.jsp"); // 데이터 입력 후 noticeList2.jsp 페이지로 리다이렉트(연결) // 마지막에 작성
%>