<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%-- <%@ page import="java.sql.Connection" %> --%>
<%-- <%@ page import="java.sql.DriverManager" %> --%>
<%-- <%@ page import="java.sql.PreparedStatement"%> --%>
<%-- <%@ page import="java.sql.ResultSet" %> --%>
<%
	// 홈 페이지 (공지사항 5개만 출력)
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>home.jsp</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
 		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div><!-- 메인메뉴 -->
			<a href="./home.jsp">홈으로</a>
			<a href="./noticeList2.jsp">공지 리스트</a>
			<a href="./scheduleList.jsp">일정 리스트</a>
		</div>
		
		<!-- 날짜순 최근 공지 5개 & 오늘 일정(모두) -->
		<%
			// select notice_title, createdate from notice 
			// order by createdate desc
			// limit 0, 5
			
			// 드라이버 로딩
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공");
			
			// MariaDB 로그인 후 접속정보 반환
			Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
			System.out.println("DB 접속 성공 :" + conn);
			
			// 최근 공지 5개
			PreparedStatement stmt = conn.prepareStatement("select notice_no, notice_title, createdate from notice order by createdate desc limit 0, 5");
			System.out.println(stmt + " <-- stmt(home)"); // parameters:[] 비어있으면 초기 페이지, noticeNo 출력
			ResultSet rs = stmt.executeQuery();
			
			// 오늘 일정
			/*
			SELECT schedule_date, schedule_time, substr(schedule_memo, 1, 10)
			FROM schedule
			WHERE schedule_date = CURDATE()
			ORDER BY schedule_time ASC; 
			*/
			String sql2 = "select schedule_no, schedule_date, schedule_time, substr(schedule_memo, 1, 10) memo from schedule where schedule_date = curdate() order by schedule_time asc";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			System.out.println(stmt + " <-- stmt2(home)");
			ResultSet rs2 = stmt2.executeQuery();
		%>	
		
		<div class="container mt-3 d-flex justify-content-center">
		<h1>공지사항</h1>
		</div>
		<table class="table table-bordered text-center">
			<tr>
				<th class="text-bg-dark">notice_title</th>
				<th class="text-bg-dark">createdate</th>
			</tr>

		<%
				while (rs.next()) {
		%>	
			<tr>
				<td>
					<a href="./noticeOne.jsp?noticeNo=<%=rs.getInt("notice_no")%>"> <!-- request.getParameter(); 키, 값 넘겨주기 -->
						<%=rs.getString("notice_title")%>
					</a>
				</td>
				<td><%=rs.getString("createdate").substring(0, 10)%></td> 
			</tr>
		<%
				}
		%>
		</table>
		
		<div class="container mt-3 d-flex justify-content-center">
		<h1>오늘 일정</h1>
		</div>
		<table class="table table-bordered text-center">
			<tr>
				<th class="text-bg-dark">schedule_date</th>
				<th class="text-bg-dark">schedule_time</th>
				<th class="text-bg-dark">schedule_memo</th>
			</tr>
		<%
				while (rs2.next()) {
		%>	
			<tr>
				<td><%=rs2.getString("schedule_date")%></td>
				<td><%=rs2.getString("schedule_time")%></td>  
				<td>
					<a href="./scheduleOne.jsp?scheduleNo=<%=rs2.getInt("schedule_no")%>"> <!-- request.getParameter(); 키, 값 넘겨주기 -->
						<%=rs2.getString("memo")%>
					</a>
				</td>
			</tr>
		<%		
				}
		%>
		</table>
	</body>
</html>