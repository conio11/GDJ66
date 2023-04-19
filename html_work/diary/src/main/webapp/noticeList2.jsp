<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<%
	// 요청 분석(currentPage, ...)
	// 현재 페이지
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + " <-- currentPage");
	
	// 페이지 당 출력할 행의 수
	int rowPerPage = 10;
	
	// 시작 행 번호
	int startRow = (currentPage - 1) * rowPerPage; // 1page 일 때만 startRow = 0
	/*
	currentpage  startRow (rowPerPage = 10일 때)
	1  			 0 	<-- (currentPage - 1) * rowPerPage
	2 			 10	
	3 		 	 20
	4 			 30
	*/
	
	// DB 연결 설정
	// select notice_title, createdate from notice 
	// order by createdate desc
	// limit ?, ? // 쿼리에서 ? 표시 -> 값만 가능
			
	// 출력할 공지 데이터		
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	PreparedStatement stmt = conn.prepareStatement("select notice_no, notice_title, createdate from notice order by createdate desc limit ?, ?");
	
	stmt.setInt(1, startRow); // 첫 번째 ? 에 startRow
	stmt.setInt(2, rowPerPage); // 두 번째 ? 에 rowPerPage
	System.out.println(stmt + " <-- stmt");
	ResultSet rs = stmt.executeQuery();
	
	// 마지막 페이지
	// select count(*) from notice
	PreparedStatement stmt2 = conn.prepareStatement("select count(*) from notice");
	ResultSet rs2 = stmt2.executeQuery();
	int totalRow = 0; // select count(*) from notice;
	if (rs2.next()) {
		totalRow = rs2.getInt("count(*)");
	}
	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage !=0) {
		lastPage = lastPage + 1;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>noticeList2.jsp</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
 		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div><!-- 메인메뉴 -->
			<a href="./home.jsp">홈으로</a>
			<a href="./noticeList.jsp">공지 리스트</a>
			<a href="./diaryList.jsp">일정 리스트</a>
		</div>
		<div class="container mt-3 d-flex justify-content-center">
		<h1>공지사항 리스트</h1>
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
		<div class="text-center">
		<%
			if (currentPage > 1) {	
		%>
			<a href="./noticeList2.jsp?currentPage=<%=currentPage - 1%>" class="btn btn-dark">이전</a>
		<%
			} 
		%>
			<%=currentPage%>
		<%
			if (currentPage < lastPage) {
		%>	
			<a href="./noticeList2.jsp?currentPage=<%=currentPage + 1%>" class="btn btn-dark">다음</a>
		<%
			}
		%>
		</div>
	</body>
</html>