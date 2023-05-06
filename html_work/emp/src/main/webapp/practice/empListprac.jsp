<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*" %>

<%
	// 페이징 기능 + 컬럼별 오늘차순/내림차순 데이터 정렬 기능
	
	// 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	int currentPage = 1; // 최초 실행 시 받아오는 값 없으므로 1로 설정, 이후 이전/다음 링크 클릭 시 페이지값 변동
	if (request.getParameter("currentPage") != null // 현재 페이지값이 null 값이나 공백값이 아니면
	&& !request.getParameter("currentPage").equals("")) {	
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + " <-- currentPage(empListprac)");
	
	// 페이지 당 출력 행 수 
	int rowPerPage = 10;
	
	// 시작 행 번호
	int startRow = (currentPage - 1) * rowPerPage;
	
	// SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender, hire_date hireDate FROM employees order by emp_no asc LIMIT ?, ?
			
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공(epmListprac)");
	
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees", "root", "java1234");
	System.out.println("DB 접속 성공(empListprac)");
	
	// col, ascDesc 값에 따라 쿼리문 변경
	String col = "emp_no";
	String ascDesc = "ASC";
	
	// col과 ascDesc 값이 모두 null이 아닌 경우
	// ex) col -> "birth_date", order -> "ASC"; ==> "birth_date ASC";
	if (request.getParameter("col") != null
	&& request.getParameter("ascDesc") != null) {
		col = request.getParameter("col");
		ascDesc = request.getParameter("ascDesc");
	}
	
	String sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender, hire_date hireDate FROM employees ORDER BY " + col + " " + ascDesc + " limit ?, ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, startRow);
	stmt.setInt(2, rowPerPage);
	
	System.out.println(stmt + " <-- stmt(empListprac)");
	ResultSet rs = stmt.executeQuery();
	
	// ResultSet -> ArrayList<Employees>로 변경
	ArrayList<Employees> employeesList = new ArrayList<Employees>();
	while (rs.next()) {
		Employees e = new Employees();
		e.empNo = rs.getInt("empNo");
		e.birthDate = rs.getString("birthDate");
		e.firstName = rs.getString("firstName");
		e.lastName = rs.getString("lastName");
		e.gender = rs.getString("gender");
		e.hireDate = rs.getString("hireDate");
		employeesList.add(e); // ArrayList에 데이터 추가
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
	System.out.println(totalRow + " <-- totalRow(empListprac)");

	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	System.out.println(lastPage + " <-- lastPage(empListprac)");
	
	// 나이 계산
	Calendar today = Calendar.getInstance(); // today 변수: 오늘 날짜 정보 포함
	int todayYear = today.get(Calendar.YEAR);
	System.out.println(todayYear + " <-- todayYear(empListprac)");
	int todayMonth = today.get(Calendar.MONTH);
	System.out.println((todayMonth + 1) + " <-- todayMonth(empListprac)");
	int todayDate = today.get(Calendar.DATE);
	System.out.println(todayDate + " <-- todatDate(empListprac)");
	
	System.out.println("===============================");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>empListprac</title>
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
				<th>
					<a href="./empListprac.jsp?col=emp_no&ascDesc=ASC">[ASC]</a>
					emp_no
					<a href="./empListprac.jsp?col=emp_no&ascDesc=DESC">[DESC]</a>
				</th>
				<th>
					<a href="./empListprac.jsp?col=birth_date&ascDesc=ASC">[ASC]</a>
					age
					<a href="./empListprac.jsp?col=birth_date&ascDesc=DESC">[DESC]</a>
				</th>
				<th>
					<a href="./empListprac.jsp?col=first_name&ascDesc=ASC">[ASC]</a>
					first_name
					<a href="./empListprac.jsp?col=first_name&ascDesc=DESC">[DESC]</a>
				</th>
				<th>
					<a href="./empListprac.jsp?col=last_name&ascDesc=ASC">[ASC]</a>
					last_name
					<a href="./empListprac.jsp?col=last_name&ascDesc=DESC">[DESC]</a>
				</th>
				<th>
					<a href="./empListprac.jsp?col=gender&ascDesc=ASC">[ASC]</a>
					gender
					<a href="./empListprac.jsp?col=gender&ascDesc=DESC">[DESC]</a>
				</th>
				<th>
					<a href="./empListprac.jsp?col=hire_date&ascDesc=ASC">[ASC]</a>
					hire_date
					<a href="./empListprac.jsp?col=hire_date&ascDesc=DESC">[DESC]</a>
				</th>
			</tr>
		<% 
			for (Employees e : employeesList) {
		%>
			<tr>
				<td><%=e.empNo%></td>
				<td>
					<%
						int empYear = Integer.parseInt(e.birthDate.substring(0, 4));
						int empMonth = Integer.parseInt(e.birthDate.substring(5, 7));
						int empDate = Integer.parseInt(e.birthDate.substring(8));
						
						int age = todayYear - empYear;
						if (empMonth > (todayMonth + 1)) {
							age = age - 1; // 생일 지나지 않은 경우
						} else if (empMonth == (todayMonth + 1) && empDate > todayDate) {
							age = age - 1;
						}
					%>
					<%=age%>
				</td>
				<td><%=e.firstName%></td>
				<td><%=e.lastName%></td>
				<td>
					<%	
						if (e.gender.equals("M")) {	
					%>
						<img src="<%= request.getContextPath()%>/img/manNew.jpg" width="50" height="50">
					<%
						} else {
					%>		
						<img src="<%= request.getContextPath()%>/img/womanNew.jpg" width="50" height="50">
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
		<div class="text-center">
		<% 
			if (currentPage > 1) { 
		%>
		 	<a href="./empListprac.jsp?currentPage=<%=currentPage - 1%>&col=<%=col%>&ascDesc=<%=ascDesc%>" class="btn btn-primary">이전</a>
		<% 
			}
		%>
			<%=currentPage%>페이지
		<%
			if (currentPage < lastPage) {
		%>
			<a href="./empListprac.jsp?currentPage=<%=currentPage + 1%>&col=<%=col%>&ascDesc=<%=ascDesc%>" class="btn btn-primary">다음</a>
		<%
			}
		%>
		</div>
	</body>
</html>