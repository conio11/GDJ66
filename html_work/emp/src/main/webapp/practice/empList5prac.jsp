<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*" %>

<%
	// 페이징 기능 + 이름/성별/입사년도 검색 기능
	// Controller Layer - 요청값 처리 계층
	// gender(null, "", "M/F"), searchWord(null, "", "검색 단어")
	
	// 인코딩 설정 -> 넘어오는 String 값 받기 위해
	request.setCharacterEncoding("UTF-8");

	// 초기 파라미터값 확인
	System.out.println(request.getParameter("currentPage") + " <-- currentPage_current param(empList5prac)");
	System.out.println(request.getParameter("gender") + " <-- gender_current param(empList5prac)");
	System.out.println(request.getParameter("searchWord") + " <-- searchWord_current param(empList5prac)");
	System.out.println(request.getParameter("beginYear") + " <-- beginYear_current param(empList5prac)");
	System.out.println(request.getParameter("endYear") + " <-- endYear_current param(empList5prac)");
	
	int currentPage = 1; // 최초 실행 시 받아오는 값 없으므로 1로 설정, 이후 이전/다음 링크 클릭 시 페이지값 변동
	if (request.getParameter("currentPage") != null // 현재 페이지값이 null 값이나 공백값이 아니면
	&& !request.getParameter("currentPage").equals("")) {	
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + " <-- currentPage(empList5prac)");
	
	// 페이지 당 출력 행 수 
	int rowPerPage = 10;
	
	// 시작 행 번호
	int startRow = (currentPage - 1) * rowPerPage;
	
	String gender="";
	if (request.getParameter("gender") != null) {
		gender = request.getParameter("gender");
	}
	
	String searchWord = "";
	if (request.getParameter("searchWord") != null) {
		searchWord = request.getParameter("searchWord");
	}

	// beginYear, endYear 중 하나라도 null값이거나 공백값이면 둘 다 0 처리 -> 쿼리문에서 between 사용 불가
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
	
	// 유효값 디버깅
	System.out.println(currentPage + " <-- currentPage(empList5prac)");
	System.out.println(gender + " <-- gender(empList5prac)");
	System.out.println(searchWord + " <-- searchWord(empList5prac)");
	System.out.println(beginYear + " <-- beginYear(empList5prac)");
	System.out.println(endYear + " <-- endYear(empList5prac)");
			
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/employees";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(epmList5prac)");
	
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(empList5prac)");
	
	// Model Layer
	// 쿼리 분기
	// 1-1) gender: 공백 searchWord: 공백 year(2): 0
	// 1-2) gender: 공백 searchWord: 공백 year(2): 유효값
	// 2-1) gender: 유효값 searchWord: 공백 year(2): 0
	// 2-2) gender: 유효값 searchWord: 공백 year(2): 유효값
	// 3-1) gender: 공백 searchWord: 유효값 year(2): 0
	// 3-2) gender: 공백 searchWord: 유효값 year(2): 유효값
	// 4-1) gender: 유효값 searchWord: 유효값 year(2): 0
 	// 4-2) gender: 유효값 searchWord: 유효값 year(2): 유효값

	// 1-1) SELECT * FROM employees
	// 1-2) SELECT * FROM employees WHERE year(hire_date) BETWEEN ? AND ?
	// 2-1) SELECT * FROM employees WHERE gender=?
	// 2-2) SELECT * FROM employees WHERE gender=? AND year(hire_date) BETWEEN ? AND ?
	// 3-1) SELECT * FROM employees WHERE searchWord LIKE ?
	// 3-2) SELECT * FROM employees WHERE searchWord LIKE ? AND year(hire_date) BETWEEN ? AND ?
	// 4-1) SELECT * FROM employees WHERE gender=? AND searchWord LIKE ?
	// 4-2) SELECT * FROM employees WHERE gender=? AND searchWord LIKE ? SELECT * FROM employees WHERE gender=? AND searchWord LIKE ?
	
	String sql = null;
	PreparedStatement stmt = null;
	
	if (gender.equals("") && searchWord.equals("")
	&& beginYear == 0 && endYear == 0) { // 유효값 없음
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender, hire_date hireDate FROM employees LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
	} else if (gender.equals("") && searchWord.equals("")
	&& beginYear != 0 && endYear != 0) { // year 값만 유효
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender, hire_date hireDate FROM employees WHERE YEAR(hire_date) BETWEEN ? AND ? LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginYear);
		stmt.setInt(2, endYear);
		stmt.setInt(3, startRow);
		stmt.setInt(4, rowPerPage);
	} else if (!gender.equals("") && searchWord.equals("")
	&& beginYear == 0 && endYear == 0) { // gender 유효값, searchWord 공백, year 둘 다 0 
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender, hire_date hireDate FROM employees WHERE gender=? LIMIT ?, ?";
		stmt = conn.prepareStatement(sql); 
		stmt.setString(1, gender);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
	} else if (!gender.equals("") && searchWord.equals("")
	&& beginYear != 0 && endYear != 0) { // gender 유효값, searchWord 공백, year 둘 다 유효값 
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender, hire_date hireDate FROM employees WHERE gender=? AND YEAR(hire_date) BETWEEN ? AND ? LIMIT ?, ?";
		stmt = conn.prepareStatement(sql); 
		stmt.setString(1, gender);
		stmt.setInt(2, beginYear);
		stmt.setInt(3, endYear);
		stmt.setInt(4, startRow);
		stmt.setInt(5, rowPerPage);
	} else if (gender.equals("") && !searchWord.equals("")
	&& beginYear == 0 && endYear == 0) { // gender 공백, searchWord 유효값, year 둘 다 0
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender, hire_date hireDate FROM employees WHERE CONCAT(first_name, ' ', last_name) LIKE ? LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);	
		stmt.setString(1, gender);
		stmt.setString(2, "%" + searchWord + "%");
		stmt.setInt(3, startRow);
		stmt.setInt(4, rowPerPage);
	} else if (gender.equals("") && !searchWord.equals("")
	&& beginYear != 0 && endYear != 0) { // gender 공백, searchWord 유효값, year 둘 다 유효값
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender, hire_date hireDate FROM employees WHERE CONCAT(first_name, ' ', last_name) LIKE ? AND YEAR(hire_date) BETWEEN ? AND ? LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);	
		stmt.setString(1, "%" + searchWord + "%");
		stmt.setInt(2, beginYear);
		stmt.setInt(3, endYear);
		stmt.setInt(4, startRow);
		stmt.setInt(5, rowPerPage);
	} else if (!gender.equals("") && !searchWord.equals("")  // gender, searchWord 둘 다 유효값, year 둘 다 0
	&& beginYear == 0 && endYear == 0) {
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender, hire_date hireDate FROM employees WHERE gender=? AND CONCAT(first_name, ' ', last_name) LIKE ? LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);	
		stmt.setString(1, gender);
		stmt.setString(2, "%" + searchWord + "%");
		stmt.setInt(3, startRow);
		stmt.setInt(4, rowPerPage);
	} else { // gender, searchWord 둘 다 유효값, year 둘 다 유효값
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender, hire_date hireDate FROM employees WHERE gender=? AND CONCAT(first_name, ' ', last_name) LIKE ? AND YEAR(hire_date) BETWEEN ? AND ? LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);	
		stmt.setString(1, gender);
		stmt.setString(2, "%" + searchWord + "%");
		stmt.setInt(3, beginYear);
		stmt.setInt(4, endYear);
		stmt.setInt(5, startRow);
		stmt.setInt(6, rowPerPage);
	}

	System.out.println(stmt + " <-- stmt(empList5prac)");
	
	ResultSet rs = stmt.executeQuery();
	System.out.println(rs + " <-- rs(empList5prac)");
	
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
	System.out.println(totalRow + " <-- totalRow(empList5prac)");

	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	System.out.println(lastPage + " <-- lastPage(empList5prac)");

	System.out.println("===============================");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>empList5prac</title>
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
		
		<form action="./empList5prac.jsp" method="get">
	 	<label>성별: </label>
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
			<label>입사년도: </label>
			<input type="number" name="beginYear" value="<%=beginYear%>"> ~ <input type="number" name="endYear" value="<%=endYear%>">
			<button type="submit">조회</button>
		</form>
		<br>
		<div class="text-center">
		<% 
			if (currentPage > 1) { 
		%>
		 	<a href="./empList5prac.jsp?currentPage=<%=currentPage - 1%>&gender=<%=gender%>&searchWord=<%=searchWord%>&beginYear=<%=beginYear%>&endYear=<%=endYear%>" class="btn btn-primary">이전</a>
		<% 
			}
		%>
			<%=currentPage%>페이지
		<%
			if (currentPage < lastPage) {
		%>
			<a href="./empList5prac.jsp?currentPage=<%=currentPage + 1%>&gender=<%=gender%>&searchWord=<%=searchWord%>&beginYear=<%=beginYear%>&endYear=<%=endYear%>" class="btn btn-primary">다음</a>
		<%
			}
		%>
		</div>
	</body>
</html>