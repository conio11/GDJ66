<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>

<%
	// post 방식 인코딩 처리
	request.setCharacterEncoding("UTF-8");

	// prac_no, prac_pw, prac_title, prac_content 가 null 또는 공백값이면 updatePracForm.jsp로 리다이렉트
	if (request.getParameter("pracNo") == null
	|| request.getParameter("pracPw") == null
	|| request.getParameter("pracTitle") == null
	|| request.getParameter("pracContent") == null
	|| request.getParameter("pracNo").equals("")
	|| request.getParameter("pracPw").equals("")
	|| request.getParameter("pracTitle").equals("")
	|| request.getParameter("pracContent").equals("")) {
		response.sendRedirect("./updatePracForm.jsp"); // updateForm도 pracNo == null일 때 리다이렉트 -> pracList.jsp로 이동
 		return; // 실행 종료
	}
	
	int pracNo = Integer.parseInt(request.getParameter("pracNo"));
	String pracPw = request.getParameter("pracPw");
	String pracTitle = request.getParameter("pracTitle");
	String pracContent = request.getParameter("pracContent");
	
	System.out.println(pracNo + " <-- pracNo(update)");
	System.out.println(pracPw + " <-- pracPw(update)");
	System.out.println(pracTitle + " <-- pracTitle(update)");
	System.out.println(pracContent + " <-- pracContent(update)");
	
	// 수정된(입력된) 값들을 DB 테이블에 입력
	// update practice set prac_title=?, prac_content=? where prac_no=? and prac_pw=?
			
	// 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공(update)");
	
	// MariaDB 로그인 후 접속정보 반환
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419", "root", "java1234");
	System.out.println("DB 접속 성공(update) : " + conn);
	
	// 쿼리 생성
	String sql = "update practice set prac_title=?, prac_content=? where prac_no=? and prac_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	// ? 4개 (1 ~ 4)
	stmt.setString(1, pracTitle);
	stmt.setString(2, pracContent);
	stmt.setInt(3, pracNo);
	stmt.setString(4, pracPw);
	System.out.println(stmt + " <-- stmt(update)");
	
	int row = stmt.executeUpdate(); // 0이면 입력 실패, 1이면 입력 성공
	System.out.println(row + " <-- row(update)");
	
	if (row == 0) { // 수정 실패 시 수정폼 화면으로 이동
		response.sendRedirect("./updatePracForm.jsp?pracNo=" + pracNo);
	} else { // 수정 성공 시 상세 리스트 화면으로 이동
		response.sendRedirect("./pracOne.jsp?pracNo=" + pracNo);
	}
	
	
%>