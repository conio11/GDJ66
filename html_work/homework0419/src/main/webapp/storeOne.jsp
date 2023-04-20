<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	// 상세 페이지 출력 코드
	
	if (request.getParameter("storeNo") == null) {
		response.sendRedirect("./storeHome.jsp"); // 요청값 없을 시 홈 페이지로 리다이렉트
		return; // 리다이렉트 후 이 페이지의 코드 실행하지 않음
	}

	int storeNo = Integer.parseInt(request.getParameter("storeNo"));
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419", "root", "java1234");
	String sql = "select store_no, store_name, store_category, store_address, store_emp_cnt, store_begin, createdate, updatedate from store where store_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, storeNo); // stmt의 첫 번째 ? -> storeNo로 바뀜 // store_no가 int 타입이므로 setInt() 사용
	System.out.println(stmt + " <-- stmt");
	ResultSet rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>storeOne</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div><!-- 메인메뉴 -->
			<a href="./storeHome.jsp">메인화면으로</a>
			<a href="./storeList.jsp">전체 리스트</a>
		</div>
		<div class="container mt-3 d-flex justify-content-center">
		<h1>맛집 상세</h1>
		</div>
		<%
			if (rs.next()) { // 행에 값이 있으면 테이블 생성
				
		%>
			<table class="table table-bordered text-center">
			<tr>
				<td class="text-bg-dark">store_no</td>
				<td><%=rs.getInt("store_no")%></td>
			</tr>
			<tr>
				<td class="text-bg-dark">store_name</td>
				<td><%=rs.getString("store_name")%></td>
			</tr>
			<tr>
				<td class="text-bg-dark">store_category</td>
				<td><%=rs.getString("store_category")%></td>
			</tr>
			<tr>
				<td class="text-bg-dark">store_address</td>
				<td><%=rs.getString("store_address")%></td>
			</tr>
			<tr>
				<td class="text-bg-dark">store_emp_cnt</td>
				<td><%=rs.getInt("store_emp_cnt")%></td>
			</tr>
			<tr>
				<td class="text-bg-dark">store_begin</td>
				<td><%=rs.getString("store_begin")%></td>
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
			<a href="./updateStoreForm.jsp?storeNo=<%=storeNo%>">수정</a>
			<a href="./deleteStoreForm.jsp?storeNo=<%=storeNo%>">삭제</a>
		</div>
	
	</body>
</html>