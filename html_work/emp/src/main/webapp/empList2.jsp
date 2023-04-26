<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*" %>
<%
	// where gender=? 조건 추가 
	// 페이징 기능 + 1페이지에서 gender 가 "F", "M" 인 자료만 조회 기능

	// 코드 작성 시 데이터부터 생성, 출력은 나중에 

	// 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// 요구사항(요구사항 간 우선순위 - 큰 의미 X) 
	// 받아오는 값에 대한 조건 : curentPage
	int currentPage = 1; // 최초 실행 시 받아오는 값 없으므로 1로 설정, 이후 링크 클릭 시 페이지값 변동
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	System.out.println(currentPage + "currentPage(empList2)");
	
	// 페이지 당 출력할 자료(행)의 수
	int rowPerPage = 10;
	
	// 시작 행 번호
	int startRow = (currentPage - 1) * rowPerPage;
	
	String gender = "";
	if (request.getParameter("gender") != null) { // 공백이 넘겨지면 gender = ""
		gender = request.getParameter("gender");
	}
	
	// 쿼리 미리 작성 및 테스트 후(HeidiSQL 등) DB에 접근 시작
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공(empList2)");
	
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees", "root", "java1234");
	System.out.println("DB 접속 성공(empList) : " + conn);
	
	// 쿼리 생성
	String sql = null;
	PreparedStatement stmt = null;
	if (gender.equals("")) { // gender 값이 들어오지 않았을 경우 
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate FROM employees LIMIT ?, ?";
		stmt = conn.prepareStatement(sql); // ? 2개
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		
	} else { // gender 값이 들어왔을 경우 
		sql = "select emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName,gender gender, hire_date hireDate from employees where gender = ? limit ?,?";
		stmt = conn.prepareStatement(sql); // ? 3개
		stmt.setString(1, gender);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
	}
	
	System.out.println(stmt + "stmt(empList2)");
	ResultSet rs = stmt.executeQuery();
	System.out.println(rs + " <-- rs(empList2)");

	// ResultSet -> ArrayList<Employees> 변경
	ArrayList<Employees> employeesList = new ArrayList<Employees>();
	while (rs.next()) {
		Employees e = new Employees();
		e.empNo = rs.getInt("empNo");
		e.birthDate = rs.getString("birthDate");
		e.firstName = rs.getString("firstName");
		e.lastName = rs.getString("lastName");
		e.gender = rs.getString("gender");
		e.hireDate = rs.getString("hireDate");
		employeesList.add(e); // 한 행의 데이터 ArrayList에 추가
	}
	
	// 마지막 페이지
	// select count (*) from employees
	// 새로운 쿼리문 사용 -> stmt2 변수
	PreparedStatement stmt2 = conn.prepareStatement("select count(*) from employees");
	ResultSet rs2 = stmt2.executeQuery();
	System.out.println(rs2 + " <-- rs2(empList2)");
	int totalRow = 0;
	if (rs2.next()) { // rs2의 커서가 내려가는 동안 실행
		totalRow = rs2.getInt("count(*)"); 
	}
	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	System.out.println(lastPage + " <-- lastpage(empList2)");
	
	// 나이 계산
	Calendar today = Calendar.getInstance(); // today 변수: 오늘 날짜 정보 포함
	int todayYear = today.get(Calendar.YEAR);
	System.out.println(todayYear + " <-- todayYear(empList2)");
	int todayMonth = today.get(Calendar.MONTH);
	System.out.println((todayMonth + 1) + " <--  todayMonth(empList2)");
	int todayDate = today.get(Calendar.DATE);
	System.out.println(todayDate + " <-- todayDate(empList2)");
	
	System.out.println("======================================");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>empList2</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		
	</head>
	<body>
		<div>
			<!-- 추후 링크 필요할 시 추가 -->
		</div>
		<div class="container mt-3 d-flex justify-content-center">
			<h1>employees 리스트</h1>
		</div>
		<table class="table table-bordered text-center">
			<tr class="table-success">
				<th>emp_no</th>
				<th>age</th>
				<th>first_name</th>
				<th>last_name</th>
				<th>gender</th>
				<th>hire_date</th>
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
						if (empMonth > (todayMonth + 1)) { // todayMonth 값: 0 ~ 11이므로 1 추가
							age = age - 1;
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
					<img src="./img/manNew.jpg" width="50" height="50">
				<% 
				
					} else {
				%>
					<img src="./img/womanNew.jpg" width="50" height="50">
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
	
		<form action="./empList2.jsp" method="get">
			<select name="gender">
				<option value="">성별 선택</option>
				<option value="M">남</option>
				<option value="F">여</option>
			</select>
			<button type="submit">성별 검색</button>
		</form>
		
		<div class="text-center">
		<%
			if (currentPage > 1) { // 2페이지부터 이전 버튼 생성
		%>
				<a href="./empList2.jsp?currentPage=<%=currentPage - 1%>" class="btn btn-success">이전</a>
		<%
			}
		%>
			<%=currentPage%>페이지
		<%
			if (currentPage < lastPage) { // 마지막 페이지 - 1 페이지까지만 다음 버튼 생성
		%>
				<a href="./empList2.jsp?currentPage=<%=currentPage + 1%>" class="btn btn-success">다음</a>
		<%
			}
		%>
		</div>
	</body>
</html>