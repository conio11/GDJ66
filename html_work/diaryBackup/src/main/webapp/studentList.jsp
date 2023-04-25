<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<%
	// 1) 장치 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공");
	
	// 2) MariaDB에 로그인 후 접속정보 반환
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234"); 
	System.out.println("접속성공 " + conn);
	
	// 3) 쿼리 생성 후 실행
	String sql = "select no, name, age from student";
	PreparedStatement stmt = conn.prepareStatement(sql); // prepareStatement: 문자열을 conn 내부에 쿼리로 변경 
	ResultSet rs = stmt.executeQuery(); // ResultSet: 배열의 한 종류(크기 알 수 없음) 부모타입으로 결과값 반환
	System.out.println("쿼리 실행 성공 " + rs);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>studentList.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
	<table class="table">
		<thead class="table-success">
		<tr>
			<th>no</th>
			<th>name</th>
			<th>age</th>
		</tr>
		</thead>
		
		<%
			while (rs.next()) {
				
			
		%>
			<tr>
				<td><%=rs.getInt("no")%></td>
				<td><%=rs.getString("name")%></td>
				<td><%=rs.getInt("age")%></td>
			</tr>
		<%
			}
		%>
		
	</table>
</body>
</html>