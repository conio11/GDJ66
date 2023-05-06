<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*" %>

<%
	// 페이징 기능 + 컬럼별 오늘차순/내림차순 데이터 정렬 기능
	// where gender=? 추가
	// 페이징 기능 + gender가 F, M인 자료만 조회 기능
	
	// 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 받아오는 값에 대한 조건
	int currentPage = 1; // 최초 실행 시 받아오는 값 없으므로 1로 설정, 이후 이전/다음 링크 클릭 시 페이지값 변동
	if (request.getParameter("currentPage") != null // 현재 페이지값이 null 값이나 공백값이 아니면
	&& !request.getParameter("currentPage").equals("")) {	
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + " <-- currentPage(empList2prac)");
	
	// 페이지 당 출력 행 수 
	int rowPerPage = 10;
	
	// 시작 행 번호
	int startRow = (currentPage - 1) * rowPerPage;
	
	String gender = "";
	if (request.getParameter("gender") != null) {
		gender = request.getParameter("gender");
	}
			
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/employees";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(epmList2prac)");
	
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(empList2prac)");
	
	String sql = null;
	PreparedStatement stmt = null;
	if (gender.equals("")) { // gender 값이 들어오지 않았을 경우
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender, hire_date hireDate FROM employees LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
	} else {
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender, hire_date hireDate FROM employees WHERE gender=? LIMIT ?, ?";
		stmt = conn.prepareStatement(sql); // ? 3개
		stmt.setString(1, gender);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
	}
	
	System.out.println(stmt + " <-- stmt(empList2prac)");
	ResultSet rs = stmt.executeQuery();
	System.out.println(rs + " <-- rs(empList2prac)");
	
	// ResultSet -> ArrayList<Employees> 변경
	ArrayList<Employees> empList = new ArrayList<Employees>();
	while (rs.next()) {
		Employees e = new Employees();
		e.empNo = rs.getInt("empNo");
		e.birthDate = rs.getString("birthDate");
		e.firstName = rs.getString("firstName");
		e.lastName = rs.getString("lastName");
		e.gender = rs.getString("gender");
		e.hireDate = rs.getString("hireDate");
		empList.add(e); // 한 행의 데이터 ArrayList에 추가
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
	System.out.println(lastPage + " <-- lastPage(empListparc)");
	
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
		<title>empList2prac</title>
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
				<th>age</th>
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
		<form action="./empList2prac.jsp" method="get">
			<select name="gender">
				<option value="">성별 선택</option>
				<option value="M">남</option>
				<option value="F">여</option>
			</select>
			<button type="submit">성별 검색</button>
		</form>
		<div class="text-center">
		<% 
			if (currentPage > 1) { 
		%>
		 	<a href="./empList2prac.jsp?currentPage=<%=currentPage - 1%>&gender=<%=gender%>" class="btn btn-primary">이전</a>
		<% 
			}
		%>
			<%=currentPage%>페이지
		<%
			if (currentPage < lastPage) {
		%>
			<a href="./empList2prac.jsp?currentPage=<%=currentPage + 1%>&gender=<%=gender%>" class="btn btn-primary">다음</a>
		<%
			}
		%>
		</div>
	</body>
</html>