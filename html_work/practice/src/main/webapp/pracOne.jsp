<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<%
	// practice 테이블 상세 페이지 출력 코드
	
	// 해당 파일 실행 시 요청값 없으므로 홈 화면 출력
	if (request.getParameter("pracNo") == null) {
		response.sendRedirect("./pracHome.jsp"); // 요청값 없을 시 해당 페이지로 이동 (재요청)
		return; // 실행 종료
	}

	int pracNo = Integer.parseInt(request.getParameter("pracNo"));
	
	// 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공(상세)");
	
	// MariaDB 로그인 후 접속정보 반환
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419", "root", "java1234");
	System.out.println("DB 접속 성공(상세) : " + conn);
	
	// 쿼리 생성 후 실행
	String sql = "select prac_no, prac_title, prac_content, prac_writer, createdate, updatedate from practice where prac_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, pracNo); // 첫 번째 ? 에 pracNo
	System.out.println(stmt + " <-- stmt(상세)");
	ResultSet rs = stmt.executeQuery();
	System.out.println("쿼리 실행 성공(상세) " + rs);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>pracOne</title>
	</head>
	<body>
		<div>
			<a href="./pracHome.jsp">홈 화면으로</a>
			<a href="./pracList.jsp">데이터 리스트</a>
			<a href="">임시 링크</a>
		</div>
		<%
			if (rs.next()) { // 커서가 내려가는 동안
		%>
		<table border="1">
			<tr>
				<th>prac_no</th>
				<td><%=rs.getInt("prac_no")%></td>
			</tr>
			<tr>
				<th>prac_title</th>
				<td><%=rs.getString("prac_title")%></td>
			</tr>
			<tr>
				<th>prac_content</th>
				<td><%=rs.getString("prac_content")%></td>
			</tr>
			<tr>
				<th>prac_writer</th>
				<td><%=rs.getString("prac_writer")%></td>
			</tr>
						<tr>
				<th>createdate</th>
				<td><%=rs.getString("createdate").substring(0, 10)%></td>
			</tr>
			<tr>
				<th>updatedate</th>
				<td><%=rs.getString("updatedate").substring(0, 10)%></td>
			</tr>
		</table>
		<%
			}
		%>
		<div>
			<a href="updatePracForm.jsp?pracNo=<%=pracNo%>">수정</a>
			<a href="deletePracForm.jsp?pracNo=<%=pracNo%>">삭제</a>
		</div>
	</body>
</html>