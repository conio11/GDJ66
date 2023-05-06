<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*" %>

<%
	// 페이징 기능 + 이름 검색기능
	// Controller Layer - 요청값 처리 계층
	// searchWord(null, "", "검색 단어")
	
	// 인코딩 설정 -> 넘어오는 String 값 받기 위해
	request.setCharacterEncoding("UTF-8");

	// 초기 파라미터값 확인
	System.out.println(request.getParameter("currentPage") + " <-- currentPage_current param(empListBySearchprac)");
	System.out.println(request.getParameter("searchWord") + " <-- searchWord_current param(empListBySearchprac)");
	
	int currentPage = 1; // 최초 실행 시 받아오는 값 없으므로 1로 설정, 이후 이전/다음 링크 클릭 시 페이지값 변동
	if (request.getParameter("currentPage") != null // 현재 페이지값이 null 값이나 공백값이 아니면
	&& !request.getParameter("currentPage").equals("")) {	
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + " <-- currentPage(empListBySearchprac)");
	
	// 페이지 당 출력 행 수 
	int rowPerPage = 10;
	
	// 시작 행 번호
	int startRow = (currentPage - 1) * rowPerPage;
	
	String searchWord = "";
	if (request.getParameter("searchWord") != null) {
		searchWord = request.getParameter("searchWord");
	}

	// 유효값 디버깅
	System.out.println(currentPage + " <-- currentPage(empListBySearchprac)");
	System.out.println(searchWord + " <-- searchWord(empListBySearchprac)");
	
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/employees";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(empListBySearchprac)");
	
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(empListBySearchprac)");
	
	// Model Layer
	// 쿼리 분기

	String sql = null;
	PreparedStatement stmt = null;
	if (searchWord.equals("")) { // searchWord 공백이면
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender, hire_date hireDate FROM employees LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
	} else {
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender, hire_date hireDate FROM employees WHERE CONCAT(first_name, ' ', last_name) LIKE ? LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + searchWord + "%");
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
	}

	System.out.println(stmt + " <-- stmt(empListBySearchprac)");
	
	ResultSet rs = stmt.executeQuery();
	System.out.println(rs + " <-- rs(empListBySearchprac)");
	
	// ResultSet -> ArrayList<Employees>로 변경
	ArrayList<Employees> empList = new ArrayList<Employees>();
	while (rs.next()) {
		Employees e = new Employees();
		e.empNo = rs.getInt("empNo");
		e.birthDate = rs.getString("birthDate");
		e.firstName = rs.getString("firstName");
		e.lastName = rs.getString("lastName");
		e.gender = rs.getString("gender");
		e.hireDate = rs.getString("hireDate");
		empList.add(e); // ArrayList에 데이터 추가
	}
	
	// 마지막 페이지
	// sql2 = "SELECT COUNT(*) FROM employees"
	String sql2 = "SELECT COUNT(*) FROM employees";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	ResultSet rs2 = stmt2.executeQuery();
	int totalRow = 0;
	while (rs2.next()) { // rs2의 커서가 내려가는 동안 실행
		totalRow = rs2.getInt("count(*)");
	}
	System.out.println(totalRow + " <-- totalRow(empListBySearchprac)");

	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	System.out.println(lastPage + " <-- lastPage(empListBySearchprac)");

	System.out.println("===============================");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>empListBySearchprac</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div class="container mt-3 d-flex justify-content-center">
			<h1>사원 리스트</h1>
		</div>
		<table class="table table-bordered text-center">
			<tr class="table-primary">
				<th>emp_no</th>
				<th>birth_date</th>
				<th>first_name</th>
				<th>last_name</th>
				<th>gender</th>
				<th>hire_date</th>
			</tr>
		<% 
			for (Employees e : empList) {
		%>
			<tr>
				<td><%=e.empNo%></td>
				<td><%=e.birthDate%></td>
				<td><%=e.firstName%></td>
				<td><%=e.lastName%></td>
				<td>
					<%	
						if (e.gender.equals("M")) {	
					%>
						<img src="<%=request.getContextPath()%>/img/manNew.jpg" width="50" height="50">
					<%
						} else {
					%>		
						<img src="<%=request.getContextPath()%>/img/womanNew.jpg" width="50" height="50">
					<%
						}	
					%>				
				</td>
				<td><%=e.hireDate%></td>
			</tr>
		<%
			}
		%>
		</table>
		
		<form action="./empListBySearchprac.jsp" method="get">
			<label>이름 검색 : </label>
			<input type="text" name="searchWord" value="<%=searchWord%>">
			<button type="submit">검색</button>
		</form>
		<br>
		<div class="text-center">
		<% 
			if (currentPage > 1) { 
		%>
		 	<a href="./empListBySearchprac.jsp?currentPage=<%=currentPage - 1%>&searchWord=<%=searchWord%>" class="btn btn-primary">이전</a>
		<% 
			}
		%>
			<%=currentPage%>페이지
		<%
			if (currentPage < lastPage) {
		%>
			<a href="./empListBySearchprac.jsp?currentPage=<%=currentPage + 1%>&searchWord=<%=searchWord%>" class="btn btn-primary">다음</a>
		<%
			}
		%>
		</div>
	</body>
</html>