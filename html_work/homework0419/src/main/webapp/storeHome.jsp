<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	// 홈 페이지 (맛집 10개만 출력)
%>

<%
 	// 개업일 내림차순 처음 10개
 	// 쿼리: select store_no, store_name, store_category, store_address, store_emp_cnt,store_begin, createdate, updatedate  
 	// from store order by store_begin desc
 	// limit 0, 10
 	
 	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419", "root", "java1234");
	String sql = "select store_no, store_name, store_category, store_address, store_emp_cnt, store_begin, createdate, updatedate from store order by store_begin desc limit 0, 10";
	PreparedStatement stmt = conn.prepareStatement(sql);
	// 디버깅 코드
	System.out.println(stmt + " <-- stmt (실행 SQL)");
	ResultSet rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>storeHome</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
 		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div>
			<a href="./storeHome.jsp">메인화면으로</a>
			<a href="./storeList.jsp">전체 리스트</a>
		</div>
		<div class="container mt-3 d-flex justify-content-center">
		<h1>맛집</h1>
		</div>
		<table class="table table-bordered text-center">
			<tr>
				<th class="text-bg-dark">store_no</th>
				<th class="text-bg-dark">store_em_cnt</th>
			</tr>
			
		<% 
			while (rs.next()) {
		%>	
			<tr>
				<td>
					<a href="./storeOne.jsp?storeNo=<%=rs.getInt("store_no")%>">
						<%=rs.getInt("store_no")%>
					</a>
				</td>
				<td><%=rs.getInt("store_emp_cnt")%></td>
			</tr>
		<% 	
			}
		%>
		</table>
	</body>
</html>