<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
    
<%
	// 유효성 코드 추가 -> 분기 -> response.sendRedirect(); return;
	
	// 해당 파일 실행 시 요청값 없으므로 전체 리스트 출력
	if (request.getParameter("noticeNo") == null) {
		response.sendRedirect("./noticeList2.jsp"); // 요청값 없을 시 전체 리스트 페이지로 이동(재요청)
		return; // 코드 진행 종료 
	} 
		
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo + " <-- updateForm noticeNo");
	
	// 드라이버 연결 확인
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("updateForm 드라이버 연결");
	
	// DB 연결 확인
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	System.out.println(conn + " <-- updateForm DB 연결");
	
	// SQL 구문 작성 및 변환
	String sql = "select notice_no, notice_title, notice_content, notice_writer, createdate, updatedate from notice where notice_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, noticeNo); // stmt의 첫 번째 ? -> noticeNo로 바뀜 // notice_no가 int 타입이므로 setInt() 사용
	System.out.println(stmt + " <-- updateForm stmt");
	
	// stmt를 ResultSet 타입으로 변환
	ResultSet rs = stmt.executeQuery();
	System.out.println(rs + " <-- updateForm rs");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>updateNoticeForm</title>
</head>
<body>
	<div class="container mt-3 d-flex justify-content-center">
	<h1>수정폼</h1>
	</div>
	<div>
		<%
			if (request.getParameter("msg") != null) {
		%>	
				<!-- action 페이지로 잘못된 접근이거나 null, 공백 넘어감 -->
				<%=request.getParameter("msg")%>
		<%
			}
		%>
	</div>
	<form action="./updateNoticeAction2.jsp" method="post"> <!-- post: 주소창에 입력값 숨김 
								-> get 방식 사용하기에 많은 컨텐츠, 비밀번호 등 정보 숨기기 위한 목적 등 -->
	<%
		if (rs.next()) {
	%>
		<table class="table table-bordered">
			<tr>
				<td class="text-bg-dark text-center">
					notice_no
				</td>
				<td>
					<input type="number" name="noticeNo" value="<%=rs.getInt("notice_no")%>" readonly="readonly"> <!-- 입력값 숫자, 넘어갈 때는 문자열  -->
				</td>
			</tr>
			<tr>
				<td class="text-bg-dark text-center">
					notice_pw
				</td>
				<td>
					<input type="password" name="noticePw"> 
				</td>
			</tr>
			<tr>
				<td class="text-bg-dark text-center">
					notice_title
				</td>
				<td>
					<input type="text" name="noticeTitle" value="<%=rs.getString("notice_title")%>"> 
				</td>
			</tr>
			<tr>
				<td class="text-bg-dark text-center">
					notice_content
				</td>
				<td>
					<textarea rows="5" cols="80" name="noticeContent"><%=rs.getString("notice_content")%></textarea>
				</td>
			</tr>
			<tr>
				<td class="text-bg-dark text-center">
					notice_writer
				</td>
				<td>
					<%=rs.getString("notice_writer")%> <!-- 넘길 값 없으므로 값만 출력해도 됨 -->
				</td>
			</tr>
			<tr>
				<td class="text-bg-dark text-center">
					createdate
				</td>
				<td>
					<%=rs.getString("createdate")%> <!-- 넘길 값 없으므로 값만 출력해도 됨, form 요소 아니므로 넘어가지 않음 -->
				</td>
			</tr>
			<tr>
				<td class="text-bg-dark text-center">
					updatedate
				</td>
				<td>
					<%=rs.getString("updatedate")%> <!-- 넘길 값 없으므로 값만 출력해도 됨 -->
				</td>
			</tr>
		</table>
	<%
		}	
	%>	
		<div>
			<button type="submit">수정</button>	
		</div>									
	</form>
</body>
</html>