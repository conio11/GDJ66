<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<%
	// practice의 전체 데이터를 7개씩 출력 (최초 50개 데이터)
	// 번호, 제목, 작성자 출력
	// select prac_no, prac_title, prac_writer from practice order by prac_no limit ?, ?
	
	// 현재 페이지
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 현재 페이지 확인용 디버깅 코드
	System.out.println(currentPage + " <-- currentPage");
	
	// 페이지 당 출력할 행의 수 
	int rowPerPage = 7;
	
	// 시작 행 번호
	/*
	currentPage / startRow
	1 / 0
	2 / 7
	3 / 14
	4 / 21
	5 / 28
	startRow = (currentPage - 1) * 7
	*/
	int startRow = (currentPage - 1) * 7;
	
	// 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공(pracList)");
	
	// MariaDB 로그인 후 접속정보 반환
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419", "root", "java1234");
	System.out.println("DB 접속 성공(pracList) : " + conn);
	
	// 쿼리 생성 
	String sql = "select prac_no, prac_title, prac_writer from practice order by prac_no limit ?, ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	System.out.println(stmt + " <-- stmt(pracList)");
	// ?, ?에 들어갈 데이터 설정
	stmt.setInt(1, startRow); // 첫 번째 ? -> startRow
	stmt.setInt(2, rowPerPage); // 두 번째 ? -> rowPerPage
	
	// 쿼리 실행
	ResultSet rs = stmt.executeQuery();
	System.out.println("쿼리 실행 성공(pracList) : " + rs);
	
	// 마지막 페이지
	// select count(*) from practice
	// 다른 쿼리문 사용하기 위해 stmt2 변수 생성
	String sql2 = "select count(*) from practice";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	System.out.println(stmt2 + " <-- stmt2(pracList)");
	ResultSet rs2 = stmt2.executeQuery();
	System.out.println("쿼리 실행 성공(pracList) : " + rs2);
	
	int totalRow = 0; // select count(*) from practice
	if (rs2.next()) { // 커서가 내려가는 동안
		totalRow = rs2.getInt("count(*)");
	}
	int lastPage = totalRow / rowPerPage; 
	if (totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>pracList</title>
	</head>
	<body>
		<div>
			<a href="./pracHome.jsp">홈 화면으로</a>
			<a href="./pracList.jsp">데이터 리스트</a>
			<a href="">임시 링크</a>
		</div>
		<h1>연습용 데이터 리스트</h1>
		<a href="./insertPracForm.jsp">데이터 입력</a>
		<table border="1">
			<tr>
				<th>prac_no</th>
				<th>prac_title</th>
				<th>prac_writer</th>
			</tr>
		<%
			while (rs.next()) {
		%>	
			<tr>
				<td><%=rs.getInt("prac_no")%></td>
				<td><a href="./pracOne.jsp?pracNo=<%=rs.getInt("prac_no")%>"><%=rs.getString("prac_title")%></a></td>
				<td><%=rs.getString("prac_writer")%></td>
			</tr>
		<%
			}
		%>	
		</table>
		<%
			if (currentPage > 1) { // 2페이지부터 이전 버튼 생성
		%>
			<a href="./pracList.jsp?currentPage=<%=currentPage - 1%>">이전</a>
		<%
			}
		%>
			<%=currentPage%>페이지
		<%
			if (currentPage < lastPage) { // 마지막 페이지에는 다음 버튼 생성 X // (마지막 - 1) 페이지까지 다음 버튼 생성
		%>
			<a href="./pracList.jsp?currentPage=<%=currentPage + 1%>">다음</a>
		<%
			}
		%>
	</body>
</html>