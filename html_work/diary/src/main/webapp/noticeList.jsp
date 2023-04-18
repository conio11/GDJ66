<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<%
	// select 쿼리를 MariaDB에 전송 -> 결과셋을 받아서 출력하는 페이지
	// select title_no, notice_title from notice order by notice_no desc;
	
	// 1) MariaDB 프로그램 사용 가능하도록 장치 드라이버를 로딩
	Class.forName("org.mariadb.jdbc.Driver"); 
	System.out.println("드라이버 로딩 성공");
	
	// 2) MariaDB에 로그인 후 접속정보 반환 
	Connection conn = null; // 접속정보 타입
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234"); 
	System.out.println("접속성공 " + conn);
	
	// 3) 쿼리 생성 후 실행
	String sql = "select notice_no, notice_title from notice order by notice_no desc";
	PreparedStatement stmt = conn.prepareStatement(sql); // prepareStatement: 문자열을 conn 내부에 쿼리로 변경 
	ResultSet rs = stmt.executeQuery(); // ResultSet: 배열의 한 종류(크기 알 수 없음) 부모타입으로 결과값 반환
	System.out.println("쿼리 실행 성공 " + rs);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeList.jsp</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>notice_no</th>
			<th>notice_title</th>
		</tr>
		
		<%
			while (rs.next()) { // 배열(rs)의 크기를 알 수 없으므로 커서가 0이 될 때까지 반복
		%>
		
		<tr>
			<td><%=rs.getInt("notice_no")%></td>
			<td><a href=""><%=rs.getString("notice_title")%></a>></td>
		</tr>
		
		<%
			}
		%>
	</table>
</body>
</html>