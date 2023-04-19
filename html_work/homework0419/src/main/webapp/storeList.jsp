<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%
    // 95개 rows, page당 10개 데이터
    
   	// 현재 페이지
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 현재 페이지 확인용 디버깅 코드
	System.out.println(currentPage + " <-- currentPage");
    
    // 페이지 당 출력할 행의 수
	int rowPerPage = 10;
    
    // 시작 행 번호
    int startRow = (currentPage - 1) * rowPerPage; // 
    
    // DB 연결 설정
    // (SQL 쿼리) select store_no, store_name, store_category, store_address, store_emp_cnt, store_begin, createdate, updatedate
    // from store order by store_begin desc limit ?, ?
    		
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419", "root", "java1234");
	String sql = " select store_no, store_name, store_category, store_address, store_emp_cnt, store_begin, createdate, updatedate from store order by store_begin desc limit ?, ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, startRow);
	stmt.setInt(2, rowPerPage);
	System.out.println(stmt + " <-- stmt");
	ResultSet rs = stmt.executeQuery();
	
	// 마지막 페이지
	// (SQL 쿼리) select count(*) from store 
	PreparedStatement stmt2 = conn.prepareStatement("select count(*) from store");
	ResultSet rs2 = stmt2.executeQuery();
	int totalRow = 0;
	if (rs2.next()) {
		totalRow = rs2.getInt("count(*)");
	}
	int lastPage = totalRow / rowPerPage; // 마지막 페이지는 전체 페이지를 행별 페이지 수로 나눈 몫
	if (totalRow % rowPerPage != 0) {	  // 행별 페이지 수로 나눈 몫이 0이 아니면(나누어 떨어지지 않으면)
		lastPage = lastPage + 1;	   	  // 마지막 페이지 (몫)에 1페이지 추가
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>storeList.jsp</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
 		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div class="container mt-3 d-flex justify-content-center">
		<h1>맛집 리스트</h1>
		</div>
		<table class="table table-bordered text-center">
			<tr>
				<th class="text-bg-dark">store_no</th>
				<th class="text-bg-dark">store_name</th>
				<th class="text-bg-dark">store_category</th>
				<th class="text-bg-dark">store_address</th>
				<th class="text-bg-dark">store_emp_cnt</th>
				<th class="text-bg-dark">store_begin</th>
				<th class="text-bg-dark">createdate</th>
				<th class="text-bg-dark">updatedate</th> 
			</tr>
			
			<%
				while (rs.next()) {	// 커서 마지막까지 (ResultSet 마지막까지)
			%>		
				<tr>
					<td><%=rs.getString("store_no")%></td> 
					<td><%=rs.getString("store_name")%></td>
					<td><%=rs.getString("store_category")%></td>
					<td><%=rs.getString("store_address")%></td>
					<td><%=rs.getInt("store_emp_cnt")%></td>
					<td><%=rs.getString("store_begin")%></td>
					<td><%=rs.getString("createdate").substring(0, 10)%></td>
					<td><%=rs.getString("updatedate").substring(0, 10)%></td> 
				</tr>
			<%	
				}
			%>
		</table>
		<div class="text-center">
		<%
			if (currentPage > 1) {	
		%>
				<a href="./storeList.jsp?currentPage=<%=currentPage - 1%>" class="btn btn-dark">이전</a>
		<%
			}
		%>
				<%=currentPage%>
		<%
			if (currentPage < lastPage) {
		%>	
				<a href="./storeList.jsp?currentPage=<%=currentPage + 1%>" class="btn btn-dark">다음</a>
		<%
			}
		%>
		</div>
	</body>
</html>