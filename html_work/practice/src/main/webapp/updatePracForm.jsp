<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	// 수정 코드 (비밀번호 입력하면 제목, 내용 수정 가능)
	// 유효성 코드 추가 -> 분기 -> response.sendRedirect(); return;
	// 해당 파일 실행 시 요청값 없으므로 전체 리스트 출력
	 if (request.getParameter("pracNo") == null) {
		 response.sendRedirect("./pracList.jsp"); // 요청값 없을 시 전체 데이터 리스트 페이지로 이동
		 return; // 코드 진행 종료
	 }
	
	 int pracNo = Integer.parseInt(request.getParameter("pracNo"));
	 System.out.println(pracNo + " <-- pracNo(update)");
	 
	 // 드라이버 로딩
	 Class.forName("org.mariadb.jdbc.Driver");
	 System.out.println("드라이버 로딩 성공(update)");
	 
	 // MariaDB 로그인 후 접속정보 반환
	 Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419", "root", "java1234");
	 System.out.println("DB 접속 성공(update) : " + conn);
	 
	// 쿼리 생성 
	String sql = "select prac_no, prac_title, prac_content, prac_writer, createdate, updatedate from practice where prac_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);	
	stmt.setInt(1, pracNo); // stmt의 ? 에 pracNo 대입
	System.out.println(stmt + " <-- stmt(update)");
	
	// stmt를 ResultSet 타입으로 변환
	ResultSet rs = stmt.executeQuery();
	System.out.println(rs + " <-- rs(update)");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updatePracForm</title>
	</head>
	<body>
		<h1>수정폼</h1>
		<form action="./updatePracAction.jsp" method="post">
		
		<% 
			if (rs.next()) { // 커서가 내려가는 동안
		
		%>
			<table border="1">
				<tr>
					<td>prac_no</td>
					<td>
						<input type="text" name="pracNo" value="<%=rs.getInt("prac_no")%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>prac_pw</td>
					<td>
						<input type="password" name="pracPw">
					</td>
				</tr>
				<tr>
					<td>prac_title</td>
					<td>
						<input type="text" name="pracTitle" value="<%=rs.getString("prac_title")%>">
					</td>
				</tr>
				<tr>
					<td>prac_content</td>
					<td>
						<textarea rows="5" cols="50" name="pracContent"><%=rs.getString("prac_content")%></textarea>
					</td>
				</tr>
				<tr>
					<td>prac_writer</td>
					<td>
						<%=rs.getString("prac_writer")%> <!-- prac_writer 부터는 넘길 값 없으므로 값만 출력 가능 -->
					</td>
				</tr>
				<tr>
					<td>createdate</td>
					<td>
						<%=rs.getString("createdate").substring(0, 10)%>
					</td>
				</tr>
				<tr>
					<td>updatedate</td>
					<td>
						<%=rs.getString("updatedate").substring(0, 10)%>
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