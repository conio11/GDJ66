<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	// 유효성 코드 추가
	
	// 드라이버 로딩
	 Class.forName("org.mariadb.jdbc.Driver");
	 System.out.println("드라이버 로딩 성공(updateScheduleForm)");
	 
	// MariaDB 로그인 후 접속정보 반환
	 Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	 System.out.println("DB 접속 성공(updateScheduleForm) : " + conn);
	 
	// 쿼리 생성 
	
	
	// select schedule_no, schedule_date, schedule_time, schedule_
	String sql = "select prac_no, prac_title, prac_content, prac_writer, createdate, updatedate from practice where prac_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);	
	// stmt.setInt(1, pracNo); // stmt의 ? 에 pracNo 대입
	// System.out.println(stmt + " <-- stmt(update)");
	
	// stmt를 ResultSet 타입으로 변환
	ResultSet rs = stmt.executeQuery();
	System.out.println(rs + " <-- rs(updateScheduleForm)");

%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateScheduleForm</title>
	</head>
	<body>
		<h1>일정 수정</h1>
		<form action="./deleteScheduleAction.jsp" method="post">
			<table border="1"> <!-- css 추후 수정  -->
				<tr>
					<td>schedule_no</td>
					<td>
						<input type="text" name="scheduleNo" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>schedule_pw</td>
					<td>
						<input type="password" name="schedulePw">
					</td>	
				</tr>
				<tr>
					<td>schedule_date</td>
					<td>
						<input type="date" name="scheduleDate">
					</td>
				</tr>
				<tr>
					<td>schedule_time</td>
					<td>
						<input type="time" name="scheduleTime">
					</td>
				</tr>
				<tr>
					<td>schedule_memo</td>
					<td>
						<textarea cols="60" rows="5" name="scheduleMemo"></textarea>
					</td>
				</tr>
				<tr>
					<td>createdate</td>
					<td>
					
					</td>
				</tr>
				<tr>
					<td>updatedate</td>
					<td>
					
					</td>
				</tr>
			</table>
			<div>
				<button type="submit">삭제</button>
			</div>
		
		
		</form>
		
	
	</body>
</html>