<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	// 수정, 삭제 후 해당 페이지로 돌아오기
	
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
	
	// 여기부터 기존 코드
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
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>scheduleListByDate</title>
	</head>
	<body>
		<h1>일정 입력</h1>
		<form action="./insertScheduleAction.jsp" method="post"> 
			<table border="1"> <!-- 나중에 css 수정  -->
				<tr>
					<th>schedule_date</th>														
					<td>
						<input type="date" name="scheduleDate" value="<%=y%>-<%=strM%>-<%=strD%>" readonly="readonly"> 	
					</td>
				</tr>
				<tr>
					<th>schedule_time</th>														
					<td>
						<input type="time" name="scheduleTime">
					</td>
				</tr>
				<tr>
					<th>schedule_color</th>														
					<td>
						<input type="color" name="scheduleColor" value="#000000">
					</td>
				</tr>
				<tr>
					<th>schedule_memo</th>														
					<td>
						<textarea cols="80" rows="3" name="scheduleMemo"></textarea>
					</td>
				</tr>
				<tr>
					<th>schedule_pw</th>
					<td>
						<input type="password" name="schedulePw">
					</td>
				</tr>
				
			</table>
			<button type="submit">입력</button>
		</form>
		<h1><%=y%>년 <%=m%>월 <%=d%>일 일정 목록</h1>
		<table border="1"> <!-- css 수정 -->
			<tr>
				<th>schedule_time</th>
				<th>schedule_memo</th>
				<th>createdate</th>
				<th>updatedate</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
	<%
		while (rs.next()) {
	%>
			<tr>
				<td><%=rs.getString("schedule_time")%></td>
				<td><%=rs.getString("schedule_memo")%></td>
				<td><%=rs.getString("createdate")%></td>
				<td><%=rs.getString("updatedate")%></td>
				<td>
					<a href="./updateScheduleForm.jsp?scheduleNo=<%=rs.getString("schedule_no")%>">수정</a>
				</td>
				<td>
					<a href="./deleteScheduleForm.jsp?scheduleNo=<%=rs.getString("schedule_no")%>">삭제</a>
				</td>
			</tr>
	<%
		}
	%>
		</table>
	</body>
</html>