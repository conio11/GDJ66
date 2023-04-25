<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%> <!-- java. 생략 가능  -->
 
<%
	// 상세 페이지 출력 코드
	
	// 해당 파일 실행 시 요청값 없으므로 홈 화면 출력
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

	/*
	
	// 자료구조 ResultSet 타입을 일반적인 자료구조 타입으로 변환
	// ResultSet -> ArrayList<Notice>
	ArrayList<Notice> noticeList = new ArrayList<Notice>();
	while (rs.next()) { // 커서가 내려가는 동안 밖에서 만들어진 noticeList에 값 저장
		Notice n = new Notice();
		n.noticeNo = rs.getInt("notice_no");
		n.noticeTitle = rs.getString("notice_title");
		n.noticeContent = rs.getString("notice_content");
		n.noticeWriter = rs.getString("notice_writer");
		n.createdate = rs.getString("createdate");
		n.updatedate = rs.getString("updatedate");
		noticeList.add(n); // ArrayList에 클래스 객체 추가
	}
	*/
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
			<a href="./home.jsp" class="btn btn-outline-dark">홈으로</a>
			<a href="./noticeList2.jsp" class="btn btn-outline-dark">공지 리스트</a>
			<a href="./scheduleList.jsp" class="btn btn-outline-dark">일정 리스트</a>
		</div>
		<div class="container mt-3 d-flex justify-content-center">
		<h1>공지 상세</h1>
		</div>
		<%
			
			// 모델 데이터
			// rs를 사용하는 것은 모델 데이터 생성까지
			// Notice notice = new Notice(); // 사용 가능하나 초기값 설정되기 때문에 오류검사와 맞지 않을 가능성
			Notice notice = null;
			if (rs.next()) { // rs 내부에서 필요한 타입을 결정 // rs가 항상 ArrayList 타입으로 바뀌어야 하는 것은 아님
				notice = new Notice();
				notice.noticeNo = rs.getInt("notice_no");
				notice.noticeTitle = rs.getString("notice_title");
				notice.noticeContent = rs.getString("notice_content");
				notice.noticeWriter = rs.getString("notice_writer");
				notice.createdate = rs.getString("createdate");
				notice.updatedate = rs.getString("updatedate");
		
			// for (Notice n : noticeList) {
			// if (rs.next()) { // 행에 값이 있으면 테이블 생성
		%>		
			<table class="table table-bordered text-center">
			<tr>
				<td class="text-bg-dark">notice_no</td>
				<td><%=notice.noticeNo%></td>
			</tr>
			<tr>
				<td class="text-bg-dark">notice_title</td>
				<td><%=notice.noticeTitle%></td>
			</tr>
			<tr>
				<td class="text-bg-dark">notice_content</td>
				<td><%=notice.noticeContent%></td>
			</tr>
			<tr>
				<td class="text-bg-dark">notice_writer</td>
				<td><%=notice.noticeWriter%></td>
			</tr>
			<tr>
				<td class="text-bg-dark">createdate</td>
				<td><%=notice.createdate%></td>
			</tr>
			<tr>
				<td class="text-bg-dark">updatedate</td>
				<td><%=notice.updatedate%></td>
			</tr>
		</table>
		<% 
			}
		%>
		
		<div>
			<a href="./updateNoticeForm.jsp?noticeNo=<%=noticeNo%>" class="btn btn-dark">수정</a>
			<a href="./deleteNoticeForm.jsp?noticeNo=<%=noticeNo%>" class="btn btn-dark">삭제</a>
		</div>
	</body>
</html>