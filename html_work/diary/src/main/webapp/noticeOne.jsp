<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet" %>

<%
	// 상세 페이지 출력 코드
	
	if (request.getParameter("noticeNo") == null) {
		response.sendRedirect("./home.jsp"); // 요청값 없을 시 기존 페이지로 이동 (재요청)
		return; // 1) 코드 진행 종료 2) 반환값을 남길 때
	} 
		
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	String sql = "select notice_no, notice_title, notice_content, notice_writer, createdate, updatedate from notice where notice_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, noticeNo); // stmt의 첫 번째 ? -> noticeNo로 바뀜 // notice_no가 int 타입이므로 setInt() 사용
	System.out.println(stmt + " <-- stmt");
	ResultSet rs = stmt.executeQuery();
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<title>noticeOne.jsp</title>
	</head>
	<body>
		<div><!-- 메인메뉴 -->
			<a href="./home.jsp">홈으로</a>
			<a href="./noticeList2.jsp">공지 리스트</a>
			<a href="./diaryList.jsp">일정 리스트</a>
		</div>
		<div class="container mt-3 d-flex justify-content-center">
		<h1>공지 상세</h1>
		</div>
		<%
			if (rs.next()) { // 행에 값이 있으면 테이블 생성
		%>		
			<table class="table table-bordered text-center">
			<tr>
				<td class="text-bg-dark">notice_no</td>
				<td><%=rs.getInt("notice_no")%></td>
			</tr>
			<tr>
				<td class="text-bg-dark">notice_title</td>
				<td><%=rs.getString("notice_title")%></td>
			</tr>
			<tr>
				<td class="text-bg-dark">notice_content</td>
				<td><%=rs.getString("notice_content")%></td>
			</tr>
			<tr>
				<td class="text-bg-dark">notice_writer</td>
				<td><%=rs.getString("notice_writer")%></td>
			</tr>
			<tr>
				<td class="text-bg-dark">createdate</td>
				<td><%=rs.getString("createdate")%></td>
			</tr>
			<tr>
				<td class="text-bg-dark">updatedate</td>
				<td><%=rs.getString("updatedate")%></td>
			</tr>
		</table>
		<% 
			}
		%>
		
		<div>
			<a href="./updateNoticeForm.jsp?noticeNo=<%=noticeNo%>">수정</a>
			<a href="./deleteNoticeForm.jsp?noticeNo=<%=noticeNo%>">삭제</a>
		</div>
	</body>
</html>