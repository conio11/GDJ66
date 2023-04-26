<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*" %>
<%
	// 페이징 기능 + 컬럼별 오름차순/내림차순 데이터 정렬 기능
	
	// 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	int currentPage = 1; // 최초 실행 시 받아오는 값 없으므로 1로 설정, 이후 링크 클릭 시 페이지값 변동
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
		
	System.out.println(currentPage + " <-- currentPage(empList)");
	
	// 페이지 당 출력할 자료(행)의 수
	int rowPerPage = 10;
	
	// 시작 행 번호
	int startRow = (currentPage - 1) * rowPerPage;
	
	/*
	현재 페이지 / 시작 위치 (페이지당 10 데이터씩)
	1 / 0   <-- (currentPage - 1) * 10
	2 / 10
	3 / 20
	4 / 30	
	*/
	
	// 쿼리문
	// SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate FROM employees order by emp_no asc LIMIT ?, ?
	// birthDate 대신 만 나이 출력 - java에서 구하는 방법으로
	
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공(empList)");
	
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/employees", "root", "java1234");
	System.out.println("DB 접속 성공(empList) : " + conn);
	
	// col, ascDesc 값에 따라 쿼리문 변경
	String col = "emp_no"; 
	String ascDesc = "ASC";
	
	if (request.getParameter("col") != null
	&& request.getParameter("ascDesc") != null) {
		col = request.getParameter("col");
		ascDesc = request.getParameter("ascDesc");
	}
	// ex col -> "birth_date", order -> "ASC"; ===> "birth_date ASC"
	
	String sql = "select emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate from employees order by " + col + " " + ascDesc + " limit ?, ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	// ? 2개
	// limit (?, ?) -> ?번째 행부터 ?개 자료 출력
	stmt.setInt(1, startRow); // 1번째 ? 의 값
	stmt.setInt(2, rowPerPage); // 2번째 ? 의 값
			
	System.out.println(stmt + "stmt(empList)");
	ResultSet rs = stmt.executeQuery();
	System.out.println(rs + " <-- rs(empList)");
	
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
	System.out.println(rs2 + " <-- rs2(empList)");
	int totalRow = 0;
	if (rs2.next()) { // rs2의 커서가 내려가는 동안 실행
		totalRow = rs2.getInt("count(*)"); 
	}
	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	System.out.println(lastPage + " <-- lastpage(empList)");
	
	// 나이 계산
	Calendar today = Calendar.getInstance(); // today 변수: 오늘 날짜 정보 포함
	int todayYear = today.get(Calendar.YEAR);
	System.out.println(todayYear + " <-- todayYear(empList)");
	int todayMonth = today.get(Calendar.MONTH);
	System.out.println((todayMonth + 1) + " <--  todayMonth(empList)");
	int todayDate = today.get(Calendar.DATE);
	System.out.println(todayDate + " <-- todayDate(empList)");
	
	// 만 나이 계산 
	// 현재(2023-04-26) 기준
	// 생일이 현재 월 이상이면 -> .substring()
	// empYear: .substring(0, 4)
	// empMonth: .substring(5, 7)
	// empDate: .substring(8) // 8부터 끝까지
	// int 형으로 변환 (parseInt)
	// int age = 0
	// int age = todayYear - empYear
	
	// empMonth > todayMonth 이면  age = age - 1
	// empMonth < todayMonth 이면  age = age
	// empMonth = todayMonth 이면 분기
	//	empDate > todayDate 이면 age = age - 1
	// 	empDate =< todayDate 이면 age = age
	
	System.out.println("==============================================");
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>empList</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div>
			<!-- 링크 필요 시 추가 -->
		</div>
		<div class="container mt-3 d-flex justify-content-center">
			<h1>employees 리스트</h1>
		</div>
		<table class="table table-bordered text-center">
			<tr class="table-success">
				<th>
					<a href="./empList.jsp?col=emp_no&ascDesc=ASC" class="btn">[ASC]</a>
					emp_no
					<a href="./empList.jsp?col=emp_no&ascDesc=DESC" class="btn">[DESC]</a>
				</th>
				<th>
					<a href="./empList.jsp?col=birth_date&ascDesc=ASC" class="btn">[ASC]</a>
					age
					<a href="./empList.jsp?col=birth_date&ascDesc=DESC" class="btn">[DESC]</a>
				</th>
				<th>
					<a href="./empList.jsp?col=first_name&ascDesc=ASC" class="btn">[ASC]</a>
					first_name
					<a href="./empList.jsp?col=first_name&ascDesc=DESC" class="btn">[DESC]</a>
				</th>
				<th>
					<a href="./empList.jsp?col=last_name&ascDesc=ASC" class="btn">[ASC]</a>
					last_name
					<a href="./empList.jsp?col=last_name&ascDesc=DESC" class="btn">[DESC]</a>
				</th>
				<th>
					<a href="./empList.jsp?col=gender&ascDesc=ASC" class="btn">[ASC]</a>
					gender
					<a href="./empList.jsp?col=gender&ascDesc=DESC" class="btn">[DESC]</a>
				</th>
				<th>
					<a href="./empList.jsp?col=hire_date&ascDesc=ASC" class="btn">[ASC]</a>
					hire_date
					<a href="./empList.jsp?col=hire_date&ascDesc=DESC" class="btn">[DESC]</a>
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
						// System.out.println(empYear + " <-- empYear(empList)");
						int empMonth = Integer.parseInt(e.birthDate.substring(5, 7));
						// System.out.println(empMonth + " <-- empMonth(empList)");
						int empDate = Integer.parseInt(e.birthDate.substring(8));
						// System.out.println(empDate + " <-- empDate(empList)");
					
						// empMonth > (todayMonth + 1) 이면  age = age - 1
						//	empDate > todayDate 이면 age = age - 1
						
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
		<div class="text-center">
		<%
			if (currentPage > 1) { // 2페이지부터 이전 버튼 생성
		%>
				<a href="./empList.jsp?currentPage=<%=currentPage - 1%>&col=<%=col%>&ascDesc=<%=ascDesc%>" class="btn btn-success">이전</a>
		<%
			}
		%>
			<%=currentPage%>페이지
		<%
			if (currentPage < lastPage) { // 마지막 페이지 - 1 페이지까지만 다음 버튼 생성
		%>
				<a href="./empList.jsp?currentPage=<%=currentPage + 1%>&col=<%=col%>&ascDesc=<%=ascDesc%>" class="btn btn-success">다음</a>
		<%
			}
		%>
		</div>
	</body>
</html>