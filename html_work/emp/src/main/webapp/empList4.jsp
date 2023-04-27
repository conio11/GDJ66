<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%
	// 페이징 기능 + 이름/성별 검색 기능
	// Controller Layer - 요청값 처리 계층
	// gender(null, "", "M/F"), searchWord(null, "", "검색 단어")
	
	// 디버깅 첫 줄, 마지막 줄 적용
	final String BG_GREEN = "\u001B[42m"; // 콘솔 폰트 배경색 설정
	final String RESET_ANSI = "\u001B[0m"; // 설정 초기화
	
	// String 타입 넘어오기 때문에 인코딩 설정 필요
	request.setCharacterEncoding("UTF-8");
	
	// 파라미터값 확인
	System.out.println(BG_GREEN + request.getParameter("currentPage") + " <-- currentPage_current param(empList4)" + RESET_ANSI);
	System.out.println(request.getParameter("gender") + " <-- gender_current param(empList4)");
	System.out.println(request.getParameter("searchWord") + " <-- searchWord_current param(empList4)");
	
	int currentPage = 1;
	if (request.getParameter("currentPage") != null && !request.getParameter("currentPage").equals("")) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String gender = ""; // null, 공백 모두 where 없음 -> 공백 처리
	if (request.getParameter("gender") != null) {
		gender = request.getParameter("gender") ; 
	}

	String searchWord = "";
	if (request.getParameter("searchWord") != null) {
		searchWord = request.getParameter("searchWord");
	}

	// 유효값 확인
	System.out.println(currentPage + " <-- currentPage(empList4)");
	System.out.println(gender + " <-- gender(empList4)");
	System.out.println(searchWord + " <-- searchWord(empList4)");
	// searchWord에 값이 있는 경우도 디버깅 -> 주소창에 ?currentPage=(int값)&gender=(String값)&searchWord=(String값) 추가
	
	// 페이징 설정 - rowPerPage, startRow
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * rowPerPage;
	System.out.println(startRow + " <-- startRow(empList4)");
	
	// DB 관련 변수 생성 및 호출
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/employees";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(empList4)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(empList4)");
	
	// Model Layer
	// 쿼리 분기 
	// 1) 둘 다 공백 2) searchWord 공백 3) gender 공백 4) 둘 다 유효값
	// if, else if, else if, else
	// 1) select * from employees
	// 2) select * from employees where gender=?
	// 3) select * from employees where searchWord like ?
	// 4) select * from employees where gender=? and searchWord like ?
			
	String sql = null; // 쿼리문 블록에서 분기
	PreparedStatement stmt = null; // 분기된 쿼리값에 따라 변경
	if (gender.equals("") && searchWord.equals("")) {
		sql = "select emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate from employees limit ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
	} else if (!gender.equals("") && searchWord.equals("")) {
		sql = "select emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate from employees where gender=? limit ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, gender);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
	} else if (gender.equals("") && !searchWord.equals("")) {
		sql = "select emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate from employees where concat(first_name, ' ', last_name) like ? limit ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + searchWord + "%");
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
	} else { // 둘 다 유효값을 가지는 경우
		sql = "select emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate from employees where gender=? and concat(first_name, ' ', last_name) like ? limit ?, ?";	
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, gender);
		stmt.setString(2, "%" + searchWord + "%");
		stmt.setInt(3, startRow);
		stmt.setInt(4, rowPerPage);
	}
	
	System.out.println(stmt + " <-- stmt(empList4)");
	
	// ResultSet -> ArrayList<> 구조로 변경
	ResultSet rs = stmt.executeQuery();
	ArrayList<Employees> empList = new ArrayList<Employees>();
	while (rs.next()) { // rs의 커서가 내려가는 동안 반복
		Employees e = new Employees();
		e.empNo = rs.getInt("empNo");
		e.birthDate = rs.getString("birthDate");
		e.firstName = rs.getString("firstName");
		e.lastName = rs.getString("lastName");
		e.gender = rs.getString("gender");
		e.hireDate = rs.getString("hireDate");
		empList.add(e); // 한 행의 데이터 블록 밖 ArraList에 추가 + while문에 따라 반복
	}
	
	/*
	// 모델값 디버깅
	System.out.println(empList.size() + " <-- empList.size(empList4)");	
	for (Employees e : empList) {
		System.out.println(e.firstName + " " + e.lastName);
	}
	*/
	// 두 번째 모델값: 마지막 페이지
	// select count(*) from employees
	// stmt2, rs2 변수 생성
	String sql2 = "select count(*) from employees";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	ResultSet rs2 = stmt2.executeQuery();
	int totalRow = 0;
	if (rs2.next()) { // rs2의 커서가 내려가는 동안 반복
		totalRow = rs2.getInt("count(*)");
	}
	System.out.println(totalRow + " <-- totalRow(empList4)");
	
	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	System.out.println(lastPage + " <-- lastPage(empList4)");

	System.out.println(BG_GREEN + "=======================================" + RESET_ANSI);
			
			
	// select * from employees where year(hire_date) between 1988 and 1990
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>empList4</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div class="container mt-3 d-flex justify-content-center">
			<h1>사원 목록</h1>
		</div>
		<table class="table table-bordered text-center">
			<thead>
				<tr class="table-success">
					<th>emp_no</th>
					<th>birth_date</th>
					<th>first_name</th>
					<th>last_name</th>
					<th>gender</th>
					<th>hire_date</th>
				</tr>
			</thead>
	<%
			for (Employees e : empList) {
	%>
			<tbody>
				<!-- 모델 자료구조 순환 출력  -->
				<tr>
					<td><%=e.empNo%></td>
					<td><%=e.birthDate%></td>
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
			</tbody>

	<%
			}
	%>
		</table>
		<!-- 요청 폼 -->
		<div>
			<form action="./empList4.jsp" method="get">
			<label>성별 : </label>
				<select name="gender">
				
				<%
					if (gender.equals("")) { 
				%>
					<option value="" selected="selected">선택</option>
					<option value="M">남</option>
					<option value="F">여</option>
				<%
					} else if (gender.equals("M")) {
				%>
					<option value="">선택</option>
					<option value="M" selected="selected">남</option>
					<option value="F">여</option>
				<%
				
					} else {
				%>
					<option value="">선택</option>
					<option value="M">남</option>
					<option value="F" selected="selected">여</option>
				<%
					}
				%>
				
				</select>
				<label>이름 검색 : </label>
				<input type="text" name="searchWord" value="<%=searchWord%>">
				<!-- 
				<label>입사년도 : </label>
				<input type="number" name="beginYear"> ~ <input type="number" name="endYear">
				 -->
				<button type="submit">조회</button>
			</form>
		</div>
		<div class="text-center">
		<%
			if (currentPage > 1) { // 2페이지부터 이전 버튼 생성
		%>		
				<a href="./empList4.jsp?currentPage=<%=currentPage - 1%>&gender=<%=gender%>&searchWord=<%=searchWord%>" class="btn btn-success">이전</a>
		<%	
			}
		%>
			<%=currentPage%>페이지
		<%
			if (currentPage < lastPage) { // 마지막 페이지 - 1 페이지까지만 다음 버튼 생성
		%>
				<a href="./empList4.jsp?currentPage=<%=currentPage + 1%>&gender=<%=gender%>&searchWord=<%=searchWord%>" class="btn btn-success">다음</a>
		<%
			}
		%>	
		</div>
	</body>
</html>