<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>     
<%
	/* 
	// rank, ntile
	SELECT 번호, 이름, 연봉, 순위, 등급 
		FROM (SELECT rownum 번호, 이름, 연봉, 순위, 등급
			FROM (SELECT first_name 이름, salary 연봉, rank() over(order by salary desc) 순위, ntile(10) over (order by salary desc) 등급
				from employees))
	WHERE 번호 BETWEEN ? and ?
	*/
	
	// 페이징
	int currentPage = 1; // 기본 1페이지
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + " <-- currentPage(rank_ntile)");
	
	// DB 연결
	String driver = "oracle.jdbc.driver.OracleDriver";
	String dbUser = "hr";
	String dbPw = "1234";
	String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(rank_ntile)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(rank_ntile)");

%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>rank_ntile_list</title>
	</head>
	<body>
		<h1>rank_ntile_list</h1>
		<table border="1">
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>연봉</th>
				<th>순위</th>
				<th>등급</th>
			</tr>
		<%
		
		%>

		<%
		
		%>
		</table>
	
	</body>
</html>