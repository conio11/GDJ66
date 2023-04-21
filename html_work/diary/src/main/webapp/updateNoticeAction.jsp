<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<!-- ResultSet 사용 X  -->

<%
	// post 방식 인코딩 처리
	request.setCharacterEncoding("UTF-8"); 

	// no, pw, title, content 가 null 또는 공백이면 updateNoticeForm.jsp로 리다이렉트
	// updateForm도 noticeNo == null일 때 리다이렉트 -> noticeList2.jsp로 이동
	if (request.getParameter("noticeNo") == null 
	|| request.getParameter("noticePw") == null 
	|| request.getParameter("noticeTitle") == null
	|| request.getParameter("noticeContent") == null
	|| request.getParameter("noticeNo").equals("")
	|| request.getParameter("noticePw").equals("")
	|| request.getParameter("noticeTitle").equals("")
	|| request.getParameter("noticeContent").equals("")){
		
		response.sendRedirect("./updateNoticeForm.jsp");
		return;
	}

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticePw = request.getParameter("noticePw");
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	// 데이터 번호, 비밀번호, 제목, 컨텐츠 확인하는 디버깅 코드
	System.out.println(noticeNo + " <-- updateAction noticeNo");
	System.out.println(noticePw + " <-- updateAction noticePw");
	System.out.println(noticeTitle + " <-- updateAction noticeTitle");
	System.out.println(noticeContent + " <-- updateAction noticeContent");

	// 수정된 값들을 DB 테이블에 입력
	// update notice set notice_title=?, notice_content=? where notice_no=? and notice_pw=?
	
	// 드라이버 설정
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("updateAction 드라이버 확인");
	
	// DB, 로그인 정보 입력
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	System.out.println(conn + " <-- updateAction DB 연결");
	
	// SQL 구문 작성 및 변환 
	String sql = "update notice set notice_title=?, notice_content=? where notice_no=? and notice_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	System.out.println(stmt + " <-- updateAction stmt1");
	
	// ? 4개 (1 ~ 4)
	stmt.setString(1, noticeTitle);   // 첫 번째 ? 에 들어갈 값: noticeTitle
	stmt.setString(2, noticeContent); // 두 번째 ? 에 들어갈 값 : noticeContent
	stmt.setInt(3, noticeNo);		  // 세 번째 ? 에 들어갈 값 : noticeNo
	stmt.setString(4, noticePw); 	  // 네 번째 ? 에 들어갈 값 : noticePw
	System.out.println(stmt + " <-- updateAction stmt2");
	
	int row = stmt.executeUpdate(); 	// 0이면 입력 실패, 1이면 입력 성공 
	System.out.println(row + " <-- row"); // row 값을 이용한 디버깅 코드
	
	if (row == 0) { // 수정 실패하면 입력폼 화면으로 이동
		response.sendRedirect("./updateNoticeForm.jsp?noticeNo=" + noticeNo);
	} else {
		response.sendRedirect("./noticeOne.jsp?noticeNo=" + noticeNo); // 수정 성공하면 리스트 화면으로 이동
	}
%>