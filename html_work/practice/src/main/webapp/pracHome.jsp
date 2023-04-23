<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<%
	// 홈 화면에 5개 데이터만 출력(번호, 제목, 작성자), prac_no 오름차순
	// select prac_no, prac_title, prac_writer from practice order by prac_no limit 0, 5
	
	// 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공(home)");
	
	// MariaDB 로그인 후 접속정보 반환
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419", "root", "java1234");
	System.out.println("DB 접속 성공(home) :" + conn);
	
	// 쿼리 생성 후 실행
	String sql = "select prac_no, prac_title, prac_writer from practice order by prac_no limit 0, 5";
	PreparedStatement stmt = conn.prepareStatement(sql);
	System.out.println(stmt + " <-- stmt(home)");
	ResultSet rs = stmt.executeQuery();
	System.out.println("쿼리 실행 성공(home) " + rs);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>prac_home</title>
	</head>
	<body>	
		<div> <!-- 메인 메뉴 -->
			<a href="./pracHome.jsp">홈 화면으로</a>
			<a href="./pracList.jsp">데이터 리스트</a>
			<a href="">임시 링크</a>
		</div>
		<h1>연습용 데이터(홈)</h1>
		<table border="1">
			<tr>
				<th>prac_no</th>
				<th>prac_title</th>
				<th>prac_writer</th>
			</tr>
		<%
			while (rs.next()) { // 마지막 커서까지
		%>
			<tr>
				<td>
					<a href="./pracOne.jsp?pracNo=<%=rs.getInt("prac_no")%>">
						<%=rs.getInt("prac_no")%>
					</a>
				</td>
				<td><%=rs.getString("prac_title")%></td>
				<td><%=rs.getString("prac_writer")%></td>
			</tr>
		<%
			}
		%>
		</table>
	</body>
</html>