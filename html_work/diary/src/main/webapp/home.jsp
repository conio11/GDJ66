<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%-- <%@ page import="java.sql.Connection" %> --%>
<%-- <%@ page import="java.sql.DriverManager" %> --%>
<%-- <%@ page import="java.sql.PreparedStatement"%> --%>
<%-- <%@ page import="java.sql.ResultSet" %> --%>
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
			<a href="./diaryList.jsp">일정 리스트</a>
		</div>
		
		<!-- 날짜순 최근 공지 5개  -->
		<%
			// select notice_title, createdate from notice 
			// order by createdate desc
			// limit 0, 5
			
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
			PreparedStatement stmt = conn.prepareStatement("select notice_no, notice_title, createdate from notice order by createdate desc limit 0, 5");
			System.out.println(stmt + " <-- stmt"); // parameters:[] 비어있으면 초기 페이지, noticeNo 출력
			ResultSet rs = stmt.executeQuery();
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
				<td><%=rs.getString("createdate").substring(0, 10)%></td> <!-- .substring(0, 9): index 0부터 9까지 출력 -->
			</tr>
		<%
				}
		%>
		</table>
	</body>
</html>