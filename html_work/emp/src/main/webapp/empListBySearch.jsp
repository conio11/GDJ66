<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
    
<%
	// 디버깅 첫 줄, 마지막 줄 적용
	final String BG_GREEN = "\u001B[42m"; // 콘솔 폰트 배경색 설정
	final String RESET_ANSI = "\u001B[0m"; // 설정 초기화
    
	// MVC 패턴
	// Controller Layer: 요청값 처리 계층 
	// 가장 먼저 필요한 내용: 받아올 값 정의(파라미터값) - 현재 페이지(String -> Integer -> int), 검색 단어(String) 
	// String 타입 넘어오기 때문에 인코딩 설정 필요
	request.setCharacterEncoding("UTF-8");
	
	// 파라미터값 확인
	System.out.println(BG_GREEN + request.getParameter("currentPage") + " <- currentPage_current param(empListBySearch)" + RESET_ANSI);
	System.out.println(request.getParameter("searchWord") + " <- searchWord_current param(empListBySearch)");
	System.out.println(request.getParameter("rowPerPage") + " <- rowPerPage_current param(empListBySearch)");
	
	// 파라미터값 null 유효성 검사
	// request.getParameter("currentPage") -> null 일 경우 진행 불가
	// request.getParameter("searchWord") -> null이어도 진행 가능 
	
	/*
	int currentPage = 0; // 블록 밖에서 선언해야 외부에서도 사용 가능, 최초 선언 시 초기화
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	} else {
		currentPage = 1; // 값이 넘어오지 않을 경우 currentPage = 1로 기본 설정 -> else 대신 블록 밖에서 초기값을 1로 설정
	}
	*/
	
	int currentPage = 1;
	if (request.getParameter("currentPage") != null && !request.getParameter("currentPage").equals("")) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String searchWord = ""; // String 타입 공백으로 초기화 // null 일 경우 공백 처리
	if (request.getParameter("searchWord") != null) {
		searchWord = request.getParameter("searchWord");
	}
	
	int rowPerPage = 10; // null값 넘어왔을 경우 기본 10행씩 출력
	if (request.getParameter("rowPerPage") != null) { // 받아온 rowPerPage 값이 null이 아니면 해당 값 사용
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));	
	}
	
	// 유효값 확인
	System.out.println(currentPage + " <-- currentPage(empListBySearch)");
	System.out.println(searchWord + " <-- searchWord(empListBySearch)");
	System.out.println(rowPerPage + " <-- rowPerPage(empListBySearch)");
	// searchWord에 값이 있는 경우도 디버깅 -> 주소창에 ?currentPage=(int값)&searchWord=(String값)&rowPerPage=(int값) 추가
	
	// Model Layer: 모델값 생성하기 까지
	// Controller layer의 결과 변수 (currentPage, searchWord)의 모델 생성을 위한 변수 추가
	// controller layer의 결과 변수 가공

	int startRow = (currentPage - 1) * rowPerPage;
	// currentPage = 1 -> startRow = 0
	System.out.println(startRow + " <-- startRow(empListBySearch)");
	
	// DB 호출에 필요한 변수 생성
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/employees";
	String dbUser  = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(empListBySearch)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(empListBySearch) : " + conn);
	
	// Model Layer
	// 동적 쿼리 
	String sql = null;
	PreparedStatement stmt = null;
	if (searchWord.equals("") == true) { // serachWord 공백이면 // if (searchWord.equals("")) {}
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender, hire_date hireDate FROM employees ORDER BY emp_no ASC LIMIT ?, ?"; 
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		
	} else {
		/* 
		select * from employees where concat(first_name, ' ', last_name) LIKE ?
		ORDER BY emp_no ASC 
		LIMIT ?, ?
		
		*/
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender, hire_date hireDate FROM employees WHERE CONCAT(first_name, ' ', last_name) LIKE ? ORDER BY emp_no ASC LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + searchWord + "%");
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
	}
	
	System.out.println(stmt + " <-- stmt(empListBySearch)");
	
	// ResultSet -> ArrayList<> 구조로 변경
	ResultSet rs = stmt.executeQuery();
	ArrayList<Employees> empList = new ArrayList<Employees>();
	while (rs.next()) { // rs 커서가 내려가는 동안 반복
		Employees e = new Employees();
		e.empNo = rs.getInt("empNo");
		e.birthDate = rs.getString("birthDate");
		e.firstName = rs.getString("firstName");
		e.lastName = rs.getString("lastName");
		e.gender = rs.getString("gender");
		e.hireDate = rs.getString("hireDate");
		empList.add(e); // 한 행의 데이터 ArrayList에 추가 
	}
	
	// 모델값 디버깅
	System.out.println(empList.size() + " <-- empList.size(empListBySearch)");
	for (Employees e : empList) { // .jsp 뒤에 별도 값 입력하지 않고 실행할 경우 1페이지에 10개 데이터 행 출력
		System.out.println(e.firstName + " " + e.lastName);
	}
	
	// 두 번째 모델값: 마지막 페이지
	// SELECT COUNT(*) FROM employees
	// stmt2, rs2 변수 생성
	PreparedStatement stmt2 = conn.prepareStatement("select count(*) from employees");
	ResultSet rs2 = stmt2.executeQuery();
	int totalRow = 0;
	if (rs2.next()) { // r2의 커서가 내려가는 동안
		totalRow = rs2.getInt("count(*)");
	}
	System.out.println(totalRow + " <-- totalRow(empListBySearch)");
	
	int lastPage = totalRow / rowPerPage; // 모델값
	if (totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	System.out.println(lastPage + " <-- lastPage(empListBySearch)");
	
	System.out.println(BG_GREEN + "==============================================" + RESET_ANSI);
	
	// View Layer 
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>empListBySearch</title>
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
				<td><%=e.gender%></td>
				<td><%=e.hireDate%></td>
			</tr>
		<% 
			}
		%>
		</table>
		<form action="./empListBySearch.jsp" method="get">
			<input type="text" name="searchWord">
			<button type="submit">이름 검색</button>
		</form>
		
		<div class="text-center">
		<%
			if (currentPage > 1) { // 2페이지부터 이전 버튼 생성
		%>	
			<a href="./empListBySearch.jsp?currentPage=<%=currentPage - 1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>" class="btn btn-success">이전</a>
		<%
			}
		
		%>
			<%=currentPage%>페이지
		<%
			if (currentPage < lastPage) { // 마지막 페이지 - 1 페이지까지만 다음 버튼 생성
		%>
			<a href="./empListBySearch.jsp?currentPage=<%=currentPage + 1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>" class="btn btn-success">다음</a>
		<%		
			}
		%>
		</div>
	</body>
</html>