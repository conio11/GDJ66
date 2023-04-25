<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	// 인코딩 처리
	request.setCharacterEncoding("UTF-8");
	
	// 유효성 검사
	// no, pw, date, time, color, memo 에 null값 또는 공백이면 초기 화면으로 리다이렉트
	if (request.getParameter("scheduleNo") == null
	|| request.getParameter("schedulePw") == null
	|| request.getParameter("scheduleDate") == null
	|| request.getParameter("scheduleTime") == null
	|| request.getParameter("scheduleColor") == null
	|| request.getParameter("scheduleMemo") == null
	|| request.getParameter("scheduleNo").equals("")
	|| request.getParameter("schedulePw").equals("")
	|| request.getParameter("scheduleDate").equals("")
	|| request.getParameter("scheduleTime").equals("")
	|| request.getParameter("scheduleColor").equals("")
	|| request.getParameter("scheduleMemo").equals("")) {
		response.sendRedirect("./scheduleListByDate.jsp");
		return; // 실행 종료
	}
							
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	String schedulePw = request.getParameter("schedulePw");
	String scheduleDate = request.getParameter("scheduleDate");
	String scheduleTime = request.getParameter("scheduleTime");
	String scheduleColor = request.getParameter("scheduleColor");
	String scheduleMemo = request.getParameter("scheduleMemo");
	
	// sehedule 테이블의 열 번호, 비밀번호, 날짜, 시간, 색, 메모 확인하는 디버깅 코드
	System.out.println(scheduleNo + " <-- scheduleNo(updateScheduleAction)");
	System.out.println(schedulePw + " <-- schedulePw(updateScheduleAction)");
	System.out.println(scheduleDate + " <-- scheduleDate(updateScheduleAction)");
	System.out.println(scheduleTime + " <-- scheduleTime(updateScheduleAction)");
	System.out.println(scheduleColor + " <-- scheduleColor(updateScheduleAction)");
	System.out.println(scheduleMemo + " <-- scheduleMemo(updateScheduleAction)");
	
	// 수정된 값들을 DB에 반영
	// update schedule set schedule_date=?, schedule_time=?, schedule_color=?, schedule_memo=? where schedule_no=? and schedule_pw=?

	// 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공(updateScheduleAction)");
	
	// MariaDB 로그인 후 접속정보 반환
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	System.out.println("DB 접속 성공(updateScheduleAction) : " + conn);
	
	// 쿼리 생성
	String sql = "update schedule set schedule_date=?, schedule_time=?, schedule_color=?, schedule_memo=? where schedule_no=? and schedule_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	// ? 6개 (1, 6)
	stmt.setString(1, scheduleDate);
	stmt.setString(2, scheduleTime);
	stmt.setString(3, scheduleColor);
	stmt.setString(4, scheduleMemo);
	stmt.setInt(5, scheduleNo);
	stmt.setString(6, schedulePw);
	System.out.println(stmt + " <-- stmt(updateScheduleAction)");
	
	int row = stmt.executeUpdate(); // 0이면 입력 실패, 1이면 입력 성공
	System.out.println(row + " <-- row(updateScheduleAction)");
	
	// 수정 성공 후 확인 페이지로 가기 위해 Date(날짜) 값 슬라이스
	String y = scheduleDate.substring(0,4);
	int m = Integer.parseInt(scheduleDate.substring(5,7)) - 1 ;
	String d = scheduleDate.substring(8);
	
	System.out.println(y + " <-- y(updateScheduleAction)");
	System.out.println(m + " <-- m(updateScheduleAction)");
	System.out.println(d + " <-- d(updateScheduleAction)");	
	

	if (row == 1) {
		// 수정 성공 시 상세 화면으로 이동
		System.out.println("수정 완료");
		response.sendRedirect("./scheduleListByDate.jsp?y=" + y + "&m=" + m + "&d=" + d);
		
	} else {
		// 수정 실패 시 다시 입력폼
		System.out.println("수정 실패");
		response.sendRedirect("./updateScheduleForm.jsp?scheduleNo=" + scheduleNo);
	}
%>