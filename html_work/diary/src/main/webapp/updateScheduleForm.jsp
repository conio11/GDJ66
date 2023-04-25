<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%> <!-- java. 생략 가능  -->
 
<%
	// 유효성 코드 추가
	// 해당 파일 실행 시 요청값 없으므로 scheduleList.jsp로 이동
	if (request.getParameter("scheduleNo") == null
	|| request.getParameter("scheduleNo").equals("")) {
		response.sendRedirect("./scheduleList.jsp");
		return; // 코드 진행 종료
	}
		
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	System.out.println(scheduleNo + " <--scheduleNo(updateScheduleForm)");
	
	// 드라이버 로딩
	 Class.forName("org.mariadb.jdbc.Driver");
	 System.out.println("드라이버 로딩 성공(updateScheduleForm)");
	 
	// MariaDB 로그인 후 접속정보 반환
	 Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	 System.out.println("DB 접속 성공(updateScheduleForm) : " + conn);
	 
	// 쿼리 생성 
	String sql = "select schedule_no, schedule_date, schedule_time, schedule_memo, schedule_color, createdate, updatedate from schedule where schedule_no=?" ;
	PreparedStatement stmt = conn.prepareStatement(sql);	
	stmt.setInt(1, scheduleNo); // stmt의 ? 에 pracNo 대입
	System.out.println(stmt + " <-- stmt(updateScheduleForm)");
	
	// stmt를 ResultSet 타입으로 변환
	ResultSet rs = stmt.executeQuery();
	System.out.println(rs + " <-- rs(updateScheduleForm)");
	
	// 자료구조 ResultSet 타입을 일반적인 자료구조 타입으로 변환
	// ResultSet -> ArrayList<Schedule>
	ArrayList<Schedule> scheduleList = new ArrayList<Schedule>();
	while (rs.next()) { // 커서가 내려가는 동안 밖에서 만들어진 scheduleList에 값 저장
		Schedule s = new Schedule();
		s.scheduleNo = rs.getInt("schedule_no"); 
		s.scheduleDate = rs.getString("schedule_date"); 
		s.scheduleTime = rs.getString("schedule_time"); 
		s.scheduleMemo = rs.getString("schedule_memo"); 
		s.scheduleColor = rs.getString("schedule_color"); 
		s.createdate = rs.getString("createdate");
		s.updatedate = rs.getString("updatedate");	
		scheduleList.add(s); // ArrayList에 데이터 추가
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateScheduleForm</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div><!-- 메인메뉴 -->
			<a href="./scheduleList.jsp" class="btn btn-outline-dark">일정 리스트</a>
		</div>
		<div class="container mt-3 d-flex justify-content-center">
			<h1>일정 수정</h1>
		</div>
		<form action="./updateScheduleAction.jsp" method="post">
		<%
		 	for (Schedule s : scheduleList) {
			// if (rs.next()) { // 커서가 내려가는 동안
		%>
			<table class="table table-bordered">
				<tr>
					<td class="text-bg-dark text-center">schedule_no</td>
					<td>
						<input type="text" name="scheduleNo" value="<%=s.scheduleNo%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="text-bg-dark text-center">schedule_pw</td>
					<td>
						<input type="password" name="schedulePw">
					</td>	
				</tr>
				<tr>
					<td class="text-bg-dark text-center">schedule_date</td>
					<td>
						<input type="date" name="scheduleDate" value="<%=s.scheduleDate%>">
					</td>
				</tr>
				<tr>
					<td class="text-bg-dark text-center">schedule_time</td>
					<td>
						<input type="time" name="scheduleTime" value="<%=s.scheduleTime%>">
					</td>
				</tr>
				<tr>
					<td class="text-bg-dark text-center">schedule_color</td>														
					<td>
						<input type="color" name="scheduleColor" value="<%=s.scheduleColor%>">
					</td>
				</tr>
				<tr>
					<td class="text-bg-dark text-center">schedule_memo</td>
					<td>
						<textarea cols="60" rows="5" name="scheduleMemo"><%=s.scheduleMemo%></textarea>
					</td>
				</tr>
				<tr>
					<td class="text-bg-dark text-center">createdate</td>
					<td>
						<%=s.createdate.substring(0, 10)%> <!-- DB 내 데이터 그대로 출력, 넘길 값 X -->
					</td>
				</tr>
				<tr>
					<td class="text-bg-dark text-center">updatedate</td>
					<td>
						<%=s.updatedate.substring(0, 10)%> <!-- DB 내 데이터 그대로 출력, 넘길 값 X -->
					</td>
				</tr>
			</table>
		<%
			}
		%>
			<div>
				<button type="submit">수정</button>
			</div>
		</form>
	</body>
</html>