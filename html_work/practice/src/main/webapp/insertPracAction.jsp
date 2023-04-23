<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<!-- 이 페이지에서 출력할 값 없으므로 ResultSet 시용하지 않음 -->

<%
	// post 방식 인코딩 처리
	request.setCharacterEncoding("UTF-8");

	// 입력 폼에서 한 개의 값이라도 공백이거나 null이면 넘어가지 않고 insertPracForm.jsp 다시 실행
	if (request.getParameter("pracTitle") == null
	|| request.getParameter("pracContent") == null
	|| request.getParameter("pracWriter") == null
	|| request.getParameter("pracPw") == null
	|| request.getParameter("pracTitle").equals("")
	|| request.getParameter("pracContent").equals("")
	|| request.getParameter("pracWriter").equals("")
	|| request.getParameter("pracPw").equals("")) {
		response.sendRedirect("./insertPracForm.jsp");
		return; // 실행 종료
	}
	
	String pracTitle = request.getParameter("pracTitle");
	String pracContent = request.getParameter("pracContent");
	String pracWriter = request.getParameter("pracWriter");
	String pracPw = request.getParameter("pracPw");
	
	// 디버깅 코드
	System.out.println(pracTitle + " <-- pracTitle(insert)");
	System.out.println(pracContent + " <-- pracContent(insert)");
	System.out.println(pracWriter + " <-- pracWriter(insert)");
	System.out.println(pracPw + " <-- pracPw(insert)");
	
	// 입력폼에서 넘어온 값들을 DB 테이블에 입력
	// insert into practice(prac_title, prac_content, prac_writer, prac_pw, createdate, updatedate)
	// values(?, ?, ?, ?, now(), now) // ? -> values 에 대해서만 사용 가능 // now() : SQL에서 현재 시간
	
	// 드라이버 설정
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공(insert)");
	
	// MariaDB 로그인 후 접속정보 반환
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419", "root", "java1234");
	System.out.println("DB 접속 성공(insert) : " + conn);
	
	// 쿼리 생성 및 실행
	String sql = "insert into practice(prac_title, prac_content, prac_writer, prac_pw, createdate, updatedate) values(?, ?, ?, ?, now(), now())";
	PreparedStatement stmt = conn.prepareStatement(sql);
	// ? 4개 (1 ~ 4)	
	stmt.setString(1, pracTitle);
	stmt.setString(2, pracContent);
	stmt.setString(3, pracWriter);
	stmt.setString(4, pracPw);
	System.out.println(stmt + " <-- stmt(insert)");
	
	int row = stmt.executeUpdate(); // 0이면 입력된 행 X, 1이면 입력 성공
	System.out.println(row + " <-- row(insert)");
	
	conn.setAutoCommit(true); // 디폴트값 true -> executeUpdate(); 후 자동 커밋
	// conn.commit(); // 생략 가능
	
	response.sendRedirect("./pracList.jsp"); // 데이터 입력 후 pracList.jsp에서 확인
%>