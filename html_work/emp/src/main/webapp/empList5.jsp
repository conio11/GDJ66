<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%
	// 페이징 기능 + 이름/성별/입사년도 검색 기능
	// Controller Layer - 요청값 처리 계층
	// gender(null, "", "M/F"), searchWord(null, "", "검색 단어")
	
	// 디버깅 첫 줄, 마지막 줄 적용
	final String BG_GREEN = "\u001B[42m"; // 콘솔 폰트 배경색 설정
	final String RESET_ANSI = "\u001B[0m"; // 설정 초기화
	
	// String 타입 넘어오기 때문에 인코딩 설정 필요
	request.setCharacterEncoding("UTF-8");
	
	// 파라미터값 확인
	System.out.println(BG_GREEN + request.getParameter("currentPage") + " <-- currentPage_current param(empList5)" + RESET_ANSI);
	System.out.println(request.getParameter("gender") + " <-- gender_current param(empList5)");
	System.out.println(request.getParameter("searchWord") + " <-- searchWord_current param(empList5)");
	System.out.println(request.getParameter("beginYear") + " <-- beginYear_current param(empList5)");
	System.out.println(request.getParameter("endYear") + " <-- endYear_current param(empList5)");
	
	int currentPage = 1; // 공백값 또는 null이면 1로 초기화
	if (request.getParameter("currentPage") != null && !request.getParameter("currentPage").equals("")) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String gender = ""; // null, 공백 모두 where 없음 -> 공백 처리
	if (request.getParameter("gender") != null) {
		gender = request.getParameter("gender") ; 
	}

	String searchWord = ""; // null, 공백 모두 where 없음 -> 공백 처리
	if (request.getParameter("searchWord") != null) {
		searchWord = request.getParameter("searchWord");
	}
	
	// beginYear, endYear 중 하나라도 null값이거나 공백값이면 둘 다 0 처리 -> between 사용 불가
	int beginYear = 0;
	int endYear = 0;
	if (request.getParameter("beginYear") == null 
	|| request.getParameter("endYear") == null
	|| request.getParameter("beginYear").equals("")
	|| request.getParameter("endYear").equals("")) {
		beginYear = 0;
		endYear = 0;
	} else {
		beginYear = Integer.parseInt(request.getParameter("beginYear"));
		endYear = Integer.parseInt(request.getParameter("endYear"));
	}

	// 유효값 확인
	System.out.println(currentPage + " <-- currentPage(empList5)");
	System.out.println(gender + " <-- gender(empList5)");
	System.out.println(searchWord + " <-- searchWord(empList5)");
	System.out.println(beginYear + " <-- beginYear(empList5)");
	System.out.println(endYear + " <-- endYear(empList5)");
	// 값이 넘어오지 않는 경우는 주소창으로 직접 디버깅 -> 주소창에 ?&gender=(String값)&searchWord=(String값)&beginYear=(int값)&endYear=(int값) 추가
	
	// 페이징 설정 - rowPerPage, startRow
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * rowPerPage;
	System.out.println(startRow + " <-- startRow(empList5)");
	
	// DB 관련 변수 생성 및 호출
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/employees";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(empList5)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(empList5)");
	
	// Model Layer
	// 쿼리 분기 
	// 1-1) gender, searchWord 둘 다 공백, year 둘 다 0
	// 1-2) gender, searchWord 둘 다 공백, year 둘 다 유효값
	// 2-1) gender 유효값, searchWord 공백, year 둘 다 0 
	// 2-2) gender 유효값, searchWord 공백, year 둘 다 유효값 
	// 3-1) gender 공백, searchWord 유효값, year 둘 다 0
	// 3-2) gender 공백, searchWord 유효값, year 둘 다 유효값
	// 4-1) gender, searchWord 둘 다 유효값, year 둘 다 0
	// 4-2) gender, searchWord 둘 다 유효값, year 둘 다 유효값

	// if, else if, else if, else
	// 1-1) select * from employees
	// 1-2) select * from employees where year(hire_date) between ? and ?
	// 2-1) select * from employees where gender=?
 	// 2-2) select * from employees where gender=? and year(hire_date) between ? and ?
	// 3-1) select * from employees where searchWord like ? 
	// 3-2) select * from employees where searchWord like ? and year(hire_date) between ? and ?
	// 4-1) select * from employees where gender=? and searchWord like ?
	// 4-2) select * from employees where gender=? and searchWord like ? year(hire_date) between ? and ?

	String sql = null; // 쿼리문 블록에서 분기
	PreparedStatement stmt = null; // 분기된 쿼리값에 따라 변경
	if (gender.equals("") && searchWord.equals("")
	&& beginYear == 0 && endYear == 0) { // 유효값 없음
		sql = "select emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate from employees limit ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
	} else if (gender.equals("") && searchWord.equals("")
	&& beginYear != 0 && endYear != 0) { // year 값만 유효
		sql = "select emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate from employees where year(hire_date) between ? and ? limit ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginYear);
		stmt.setInt(2, endYear);
		stmt.setInt(3, startRow);
		stmt.setInt(4, rowPerPage);
	} else if (!gender.equals("") && searchWord.equals("")
	&& beginYear == 0 && endYear == 0) { // gender 유효값, searchWord 공백, year 둘 다 0 
		sql = "select emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate from employees where gender=? limit ?, ?";
		stmt = conn.prepareStatement(sql); 
		stmt.setString(1, gender);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage); 
	} else if (!gender.equals("") && searchWord.equals("")
	&& beginYear != 0 && endYear != 0) { // gender 유효값, searchWord 공백, year 둘 다 유효값 
		sql = "select emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate from employees where gender=? and year(hire_date) between ? and ? limit ?, ?";
		stmt = conn.prepareStatement(sql); 
		stmt.setString(1, gender);
		stmt.setInt(2, beginYear);
		stmt.setInt(3, endYear);
		stmt.setInt(4, startRow);
		stmt.setInt(5, rowPerPage);
	} else if (gender.equals("") && !searchWord.equals("")
	&& beginYear == 0 && endYear == 0) { // gender 공백, searchWord 유효값, year 둘 다 0
		sql = "select emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate from employees where concat(first_name, ' ', last_name) like ? limit ?, ?";
		stmt = conn.prepareStatement(sql);	
		stmt.setString(1, "%" + searchWord + "%");
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
	} else if (gender.equals("") && !searchWord.equals("")
	&& beginYear != 0 && endYear != 0) { // gender 공백, searchWord 유효값, year 둘 다 유효값
		sql = "select emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate from employees where concat(first_name, ' ', last_name) like ? and year(hire_date) between ? and ? limit ?, ?";
		stmt = conn.prepareStatement(sql);	
		stmt.setString(1, "%" + searchWord + "%");
		stmt.setInt(2, beginYear);
		stmt.setInt(3, endYear);
		stmt.setInt(4, startRow);
		stmt.setInt(5, rowPerPage);	
	} else if (!gender.equals("") && !searchWord.equals("")
	&& beginYear == 0 && endYear == 0) { // gender, searchWord 둘 다 유효값, year 둘 다 0
		sql = "select emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate from employees where gender=? and concat(first_name, ' ', last_name) like ? limit ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, gender);
		stmt.setString(2, "%" + searchWord + "%");
		stmt.setInt(3, startRow);
		stmt.setInt(4, rowPerPage);	
	} else { // gender, searchWord 둘 다 유효값, year 둘 다 유효값
		sql = "select emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate from employees where gender=? and concat(first_name, ' ', last_name) like ? and year(hire_date) between ? and ? limit ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, gender);
		stmt.setString(2, "%" + searchWord + "%");
		stmt.setInt(3, beginYear);
		stmt.setInt(4, endYear);
		stmt.setInt(5, startRow);
		stmt.setInt(6, rowPerPage);	
	}
	
	System.out.println(stmt + " <-- stmt(empList5)");
	
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
	System.out.println(totalRow + " <-- totalRow(empList5)");
	
	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	System.out.println(lastPage + " <-- lastPage(empList5)");

	System.out.println(BG_GREEN + "=======================================" + RESET_ANSI);
%>

<!-- View Layer -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>empList5</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div class="container mt-3 d-flex justify-content-center">
			<h1>사원 목록</h1>
		</div>
		<br>
		<div>
		 	<!-- 요청 폼 -->
			<form action="./empList5.jsp" method="get">
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
				<input type="text" name="searchWord"> <!-- value="<%=searchWord%> 없어도 정상 실행? -->
				<label>입사년도 : </label> <!-- div 요소와 달리 행 전체 차지하지 않음  -->
				<input type="number" name="beginYear"> ~ <input type="number" name="endYear">
				<button type="submit">조회</button>
			</form>
		</div>
		<br> 
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
		<div class="text-center">
		<%
			if (currentPage > 1) { // 2페이지부터 이전 버튼 생성
		%>		
				<a href="./empList5.jsp?currentPage=<%=currentPage - 1%>&gender=<%=gender%>&searchWord=<%=searchWord%>&beginYear=<%=beginYear%>&endYear=<%=endYear%>" class="btn btn-success">이전</a>
		<%	
			}
		%>
			<%=currentPage%>페이지
		<%
			if (currentPage < lastPage) { // 마지막 페이지 - 1 페이지까지만 다음 버튼 생성
		%>
				<a href="./empList5.jsp?currentPage=<%=currentPage + 1%>&gender=<%=gender%>&searchWord=<%=searchWord%>&beginYear=<%=beginYear%>&endYear=<%=endYear%>" class="btn btn-success">다음</a>
		<%
			}
		%>	
		</div>
	</body>
</html>