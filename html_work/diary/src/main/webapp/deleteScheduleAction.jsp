<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	// 삭제 폼: deleteSheduleForm.jsp
	
	// 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// 번호, 비밀번호 중 null값 or 공백값 있을 경우 초기 화면으로 리다이렉트
	if (request.getParameter("scheduleNo") == null
	|| request.getParameter("schedulePw") == null
	|| request.getParameter("scheduleNo").equals("")
	|| request.getParameter("schedulePw").equals("")) {
		response.sendRedirect("./scheduleListByDate.jsp");
		return; // 실행 종료
	}
	
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	String schedulePw = request.getParameter("schedulePw");
	
	System.out.println(scheduleNo + " <-- scheduleNo(deleteAction)");
	System.out.println(schedulePw + " <-- schedulePw(deleteAction)");
	
	// 쿼리문
	// delete from schedule where schedule_no=? and schedule_pw=?
			
	// 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공(deleteScheduleAction)");
	
	// MariaDB 로그인 후 접속정보 반환
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	System.out.println("DB 접속 성공(deleteScheduleAction) : " + conn);
	
	// 쿼리 생성
	String sql = "delete from schedule where schedule_no=? and schedule_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	// ? 2개 (1 ~ 2)
	stmt.setInt(1, scheduleNo);
	stmt.setString(2, schedulePw);
	
	System.out.println(stmt + " <-- stmt(deleteScheduleAction)");
	
	int row = stmt.executeUpdate(); // 0이면 입력 실패, 1이면 입력 성공
	System.out.println(row + " <-- row(deleteScheduleAction)");
	
	/*
	// 날짜 불러오는 sql 구문 
	String sql2 = "select schedule_date from schedule where schedule_no=?";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, scheduleNo);
	ResultSet rs = stmt2.executeQuery();
	// rs.next();
	
	// 변수에 날짜 넣기
	String scheduleDate = rs.getString("schedule_date");
	// System.out.println("stmt2-deleteSchedulAction.jsp-->" + scheduleDate+ stmt2);
	
	// 삭제 성공 후 확인 페이지로 가기 위해 Date(날짜) 값 슬라이스
	String y = scheduleDate.substring(0,4);
	int m = Integer.parseInt(scheduleDate.substring(5,7)) - 1;
	String d = scheduleDate.substring(8);
	
	System.out.println(y + " <-- y(deleteScheduleAction)");
	System.out.println(m + " <-- m(deleteScheduleAction)");
	System.out.println(d + " <-- d(deleteScheduleAction)");	
	 */
	
	if (row == 1) {
		System.out.println("삭제 완료");
	} else {
		System.out.println("삭제 실패");
	}
	
	response.sendRedirect("./scheduleListByDate.jsp"); // 삭제 작업 후 해당 페이지로 리다이렉트
%>