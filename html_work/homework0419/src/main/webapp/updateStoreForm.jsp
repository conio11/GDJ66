<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<%	
	// 수정: 이름, 카테고리, 주소, 직원 수 
	// 유효성 확인 코드
	if (request.getParameter("storeNo") == null) {
		response.sendRedirect("storeList.jsp"); // 요청값 없을 시 전체 리스트 페이지로 이동
		return;
	}

	int storeNo = Integer.parseInt(request.getParameter("storeNo"));
	System.out.println(storeNo + " <-- updateForm storeNo");
	
	// 드라이버 연결 확인
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("updateForm 드라이버 연결");
	
	// DB 연결 확인/
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419", "root", "java1234");
	System.out.println(conn + " <-- updateForm DB 연결");
	
	// SQL 구문 작성 및 변환
	String sql = "select store_no, store_name, store_address, store_emp_cnt, store_begin, createdate, updatedate, store_pw from store where store_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, storeNo); // stmt의 첫 번째 ? -> storeNo
	System.out.println(stmt + " <-- updateForm stmt");
	
	// stmt를 ResultSet 타입으로 변환
	ResultSet rs = stmt.executeQuery(); // 쿼리 실행
	System.out.println(rs + " <-- updateForm rs");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>updateStoreForm</title>
</head>
<body>
	<div class="container mt-3 d-flex justify-content-center">
		<h1>맛집 수정폼</h1>
	</div>
	<form action="./updateStoreAction.jsp" method="post">
	<%
		if (rs.next()) {
	%>
		<table class="table table-bordered">
			<tr>
				<td class="text-bg-dark text-center">store_no</td>
				<td>	
					<input type="text" name="storeNo" value="<%=rs.getInt("store_no") %>" readonly="readonly">
				</td>
			</tr>
				<tr>
				<td class="text-bg-dark text-center">store_pw</td>
				<td>
					<input type="password" name="storePw">
				</td>
			</tr>
			<tr>
				<td class="text-bg-dark text-center">store_name</td>
				<td>
					<input type="text" name="storeName" value="<%=rs.getString("store_name")%>">
				</td>
			</tr>
			<tr>
				<td class="text-bg-dark text-center">store_category</td>
				<td>
					<input type="radio" name="storeCategory" value="한식">한식
					<input type="radio" name="storeCategory" value="중식">중식
					<input type="radio" name="storeCategory" value="일식">일식
				</td>
			</tr>
			<tr>
				<td class="text-bg-dark text-center">store_address</td>
				<td>
					<textarea rows="5" cols="80" name="storeAddress"><%=rs.getString("store_address")%></textarea>
				</td>
			</tr>
			<tr>
				<td class="text-bg-dark text-center">store_emp_cnt</td>
				<td>
					<input type="text" name="storeEmpCnt" value="<%=rs.getInt("store_emp_cnt")%>">
				</td>
			</tr>
			<tr>
				<td class="text-bg-dark text-center">store_begin</td>
				<td><%=rs.getString("store_begin")%></td>
			</tr>
			<tr>
				<td class="text-bg-dark text-center">createdate</td>
				<td><%=rs.getString("createdate")%></td>
			</tr>
			<tr>
				<td class="text-bg-dark text-center">updatedate</td>
				<td><%=rs.getString("updatedate")%></td>
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