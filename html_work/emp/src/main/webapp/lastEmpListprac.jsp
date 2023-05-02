<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import="java.sql.*" %>  
<%@ page import="vo.*" %>    

<%
	// lastEmpList.jsp, lastEmpListNew 복습용 파일
	// MVC 모델
	// Controller Layer - 요청값 처리 계층
	
	// 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// <input> 태그 내 동일한 이름을 가진 value 값 전체 배열 형태로 가져오기
	System.out.println(request.getParameterValues("ckMonth") + "<-- ckMonth(lastEmpListprac)");
	String[] ckMonth = request.getParameterValues("ckMonth"); // 체크박스 선택된 월 값을 String 타입 ckMonth 배열로 저장
	
	// int 배열 선언 (ckMonth -> int 타입으로 변환)
	int[] intCkMonth = null; // int[] 대신 ArrayList<Integer> 사용 가능 
	if (ckMonth != null) { // 체크박스 선택된 월 값이 있으면 실행 (ckMonth에 값이 있으면 실행)
		intCkMonth = new int[ckMonth.length]; // ckMonth 배열의 길이만큼 크기 설정
		for (int i = 0; i < intCkMonth.length; i += 1) { // ckMonth 배열 길이만큼 반복 실행
			intCkMonth[i] = Integer.parseInt(ckMonth[i]);
		}
		
		for (int i = 0; i < intCkMonth.length; i++) {
			System.out.println(intCkMonth[i] + "월 선택");
		}
	}
	
	// null 값은 반복문 실행 불가 -> null값 유무 확인 필요
	if (request.getParameter("ckMonth") != null) {
		for (String s : request.getParameterValues("ckMonth")) {
			System.out.println(s + " <-- 선택된 월(lastEmpListprac)");
		}
	}
		
	int currentPage = 1; // 넘어온 값 없을 경우 기본 페이지: 1
	if (request.getParameter("currentPage") != null && !request.getParameter("currentPage").equals("")) {
		currentPage = Integer.parseInt(request.getParameter("currentPage")); // null값, 공백값이 아니면 넘어온 값 사용
	}
	
	// currentPage 확인
	System.out.println(currentPage + " <-- currentPage(lastEmpListprac)");
	
	// 페이지 당 출력 행 수 
	int rowPerPage = 10;
	
	// 시작 행 번호 - LIMIT (0, 10), (10, 10), (20, 10)...
	int startRow = (currentPage - 1) * rowPerPage;
	System.out.println(startRow + " <-- startRow(lastEmpListprac)");
	
	// Model Layer
	// DB 관련 변수 생성 및 호출
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/employees";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(lastEmpListprac)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(lastEmpListprac)");
	
	// sql 분기: 월 선택값이 있는 경우, 없는 경우
	String sql = null;
	PreparedStatement stmt = null;
	if (intCkMonth == null) {
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate FROM employees LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
	} else { // 월 선택값 있는 경우 - 경우에 따라 ? 개수 지정 후 ?에 값 설정
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate FROM employees WHERE MONTH(hire_date) IN (?";
		// 쿼리 내 ? 개수 설정
		for (int i = 1; i < intCkMonth.length; i += 1) { // (월 선택 개수 - 1)만큼 ? 추가 // 1개만 선택한 경우 ? 추가되지 않음
				sql += ", ?";
		}
		sql += ") LIMIT ?, ?";
		
		stmt = conn.prepareStatement(sql);
		
		// 쿼리에 ?값 설정
		for (int i = 0; i < intCkMonth.length; i += 1) { // 선택된 월 개수만큼 반복 실행
			stmt.setInt(i + 1, intCkMonth[i]); 
		}
		stmt.setInt(intCkMonth.length + 1, startRow);
		stmt.setInt(intCkMonth.length + 2, rowPerPage);
	}
	
	ResultSet rs = stmt.executeQuery();
	ArrayList<Employees> empList = new ArrayList<Employees>(); // 자바 1.7 이후에서는 ArrayList<>(); 로 사용 가능
	while (rs.next()) {
		Employees e = new Employees();
		e.empNo = rs.getInt("empNo");
		e.birthDate = rs.getString("birthDate");
		e.firstName = rs.getString("firstName");
		e.lastName = rs.getString("lastName");
		e.gender = rs.getString("gender");
		e.hireDate = rs.getString("hireDate");
		empList.add(e);
	}
	
	// 마지막 페이지
	// SELECT COUNT(*) FROM employees
	// sql2, stmt2, rs2
	String sql2 = "SELECT COUNT(*) FROM employees";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	ResultSet rs2 = stmt2.executeQuery();
	int totalRow = 0;
	if (rs2.next()) {
		totalRow = rs2.getInt("count(*)");
	}
	System.out.println(totalRow + " <-- totalRow(lastEmpListprac)");
	
	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	System.out.println(lastPage + " <-- lastPage(lastEmpListprac)");
	
	System.out.println("=================");
%>

<!-- View Layer  -->
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>lastEmpListprac</title>
	</head>
	<body>
		<h1>사원 목록</h1>
		<form action="./lastEmpListprac.jsp" method="get">
		<%
			int[] months = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
			for (int m : months) {	
		%>
				<input type="checkbox" name="ckMonth" value="<%=m%>"><%=m%>월
		<%
			}
		%>		
			<button type="submit">조회</button> <!-- 값 선택하고 버튼 클릭 시 lastEmpListprac.jsp?ckMonth=와 같이 주소창 변경 -->
		</form>
		<table border="1">
			<tr>
				<th>empNo</th>
				<th>birthDate</th>
				<th>firstName</th>
				<th>lastName</th>
				<th>gender</th>
				<th>hireDate</th>
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
		<%
			if (currentPage > 1) { // 2페이지부터 이전 버튼 생성
		%>
				<a href="./lastEmpListprac.jsp?currentPage=<%=currentPage - 1%>">이전</a>
		<%
			}
		%> 
			<%=currentPage%> 페이지
		<%
			if (currentPage < lastPage) { // (마지막 페이지 - 1) 페이지까지만 다음 버튼 생성
		%>
				<a href="./lastEmpListprac.jsp?currentPage=<%=currentPage + 1%>">다음</a>
		<%
			}
		%>
	
	</body>
</html>