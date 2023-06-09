<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%> <!-- java. 생략 가능  -->
<%
	// 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// y, m, d 값이 null or "" -> redirection scheduleList.jsp
	if (request.getParameter("y") == null
	|| request.getParameter("m") == null
	|| request.getParameter("d") == null
	|| request.getParameter("y").equals("")
	|| request.getParameter("m").equals("")
	|| request.getParameter("d").equals("")) {
		response.sendRedirect("./scheduleList.jsp");
		return; // 실행 종료
	}
	
	// Date(날짜)값 슬라이스
	int y = Integer.parseInt(request.getParameter("y"));
	// 자바 API -> 12월(11로 표기) / MariaDB -> 12월(12로 표기)
	int m = Integer.parseInt(request.getParameter("m")) + 1; 
	int d = Integer.parseInt(request.getParameter("d"));
	
	System.out.println(y + " <-- y(listByDate)");
	System.out.println(m + " <-- m(listByDate)");
	System.out.println(d + " <-- d(listByDate)");
	
	String strM = m + ""; // int 형에 공백 붙여주면 String으로 자동 형변환
	if (m < 10) {
		strM = "0" + strM;
	}
	String strD = d + "";
	if (d < 10) {
		strD = "0" + strD;
	}
	
	// 일별 스케줄 리스트
	
	// 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공(listByDate)");
	
	// MariaDB 로그인 후 접속정보 반환
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	System.out.println("DB 접속 성공(listByDate) : " + conn);
	
	// 쿼리 생성
	String sql = "select schedule_no, schedule_date, schedule_time, schedule_memo, schedule_color, createdate, updatedate from schedule where schedule_date=? order by schedule_time asc";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, y + "-" + strM + "-" + strD);
	System.out.println(stmt + " <-- stmt(listByDate)");
	
	// 쿼리 실행
	ResultSet rs = stmt.executeQuery();
	System.out.println(rs + " <-- rs(listByDate)");
	
	// 자료구조 ResultSet 타입을 일반적인 자료구조 타입으로 변환
	// ResultSet -> ArrayList<Notice>
	ArrayList<Schedule> scheduleList = new ArrayList<Schedule>(); // Notice 클래스 사용
	while (rs.next()) { // 커서가 내려가는 동안 밖에서 만들어진 scheduleList에 값 저장
		Schedule s = new Schedule();
		s.scheduleNo = rs.getInt("schedule_no");
		s.scheduleDate = rs.getString("schedule_date");
		s.scheduleTime= rs.getString("schedule_time");
		s.scheduleMemo = rs.getString("schedule_memo");
		s.scheduleColor = rs.getString("schedule_color");
		s.createdate = rs.getString("createdate");
		s.updatedate = rs.getString("updatedate");
		scheduleList.add(s);
	}
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>scheduleListByDate</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div><!-- 메인메뉴 -->
			<a href="./scheduleList.jsp" class="btn btn-outline-dark">뒤로 가기</a>
		</div>
		<div class="container mt-3 d-flex justify-content-center">
		<h1>일정 입력</h1>
		</div>
		<form action="./insertScheduleAction.jsp" method="post"> 
			<table class="table table-bordered"> <!-- 나중에 css 수정  -->
				<tr>
					<th class="text-bg-dark text-center">schedule_date</th>														
					<td>
						<input type="date" name="scheduleDate" value="<%=y%>-<%=strM%>-<%=strD%>" readonly="readonly"> 	
					</td>
				</tr>
				<tr>
					<th class="text-bg-dark text-center">schedule_time</th>														
					<td>
						<input type="time" name="scheduleTime">
					</td>
				</tr>
				<tr>
					<th class="text-bg-dark text-center">schedule_color</th>														
					<td>
						<input type="color" name="scheduleColor" value="#000000">
					</td>
				</tr>
				<tr>
					<th class="text-bg-dark text-center">schedule_memo</th>														
					<td>
						<textarea cols="80" rows="3" name="scheduleMemo"></textarea>
					</td>
				</tr>
				<tr>
					<th class="text-bg-dark text-center">schedule_pw</th>
					<td>
						<input type="password" name="schedulePw">
					</td>
				</tr>
				
			</table>
			<button type="submit">입력</button>
		</form>
		<div class="container mt-3 d-flex justify-content-center">
			<h1><%=y%>년 <%=m%>월 <%=d%>일 일정 목록</h1>
		</div>
		<table class="table table-bordered"> <!-- css 수정 -->
			<tr>
				<th class="text-bg-dark text-center">schedule_time</th>
				<th class="text-bg-dark text-center">schedule_memo</th>
				<th class="text-bg-dark text-center">createdate</th>
				<th class="text-bg-dark text-center">updatedate</th>
				<th class="text-bg-dark text-center">수정</th>
				<th class="text-bg-dark text-center">삭제</th>
			</tr>
	<%
		for (Schedule s : scheduleList) { // scheduleList 만큼 반복
		// while (rs.next()) {
	%>
			<tr>
				<td><%=s.scheduleTime%></td>
				<td><%=s.scheduleMemo%></td>
				<td><%=s.createdate%></td>
				<td><%=s.updatedate%></td>
				<td>
					<a href="./updateScheduleForm.jsp?scheduleNo=<%=s.scheduleNo%>">수정</a>
				</td>
				<td>
					<a href="./deleteScheduleForm.jsp?scheduleNo=<%=s.scheduleNo%>">삭제</a>
				</td>
			</tr>
	<%
		}
	%>
		</table>
	</body>
</html>