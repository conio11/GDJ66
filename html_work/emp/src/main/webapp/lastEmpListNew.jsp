<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%
	// Controller Layer - 요청값 처리 계층
	
	// 디버깅 첫 줄, 마지막 줄 적용
	final String GREEN = "\u001B[42m"; // 콘솔창 폰트 배경색 설정
	final String RESET_ANSI = "\u001B[0m"; // 색상 설정 초기화
	
	// 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// <input> 태그 내 동일한 이름을 가진 value값 전체 배열 형태로 가져오기
	System.out.println(GREEN + request.getParameterValues("ckMonth") + " <-- ckMonth(lastEmpListNew)" + RESET_ANSI); 
	String[] ckMonth = request.getParameterValues("ckMonth"); // 넘어온 월 값을 String 타입 ckMonth 배열에 저장
	
	// int 배열 선언 (ckMonth의 값을 int 타입으로 저장)
	int[] intCkMonth = null; // int[] 대신 ArrayList<Integer> 사용 가능 // ckMonth의 형태를 int type으로 바꾸기 위한 배열
	if (ckMonth != null) { // ckMonth가 null 이면 intCkMonth도 null
		intCkMonth = new int[ckMonth.length]; // intCkMonth 배열의 길이는 chMonth 배열의 길이와 같음
		for (int i = 0; i < intCkMonth.length; i += 1) { // 배열 길이만큼 돌면서 intCkMonth에 값 대입
			intCkMonth[i] = Integer.parseInt(ckMonth[i]);
		}
	}
	
	// null값은 반복문 실행 불가하므로 null값 유무 확인 필요
	if (request.getParameterValues("ckMonth") != null) {
		for (String s : request.getParameterValues("ckMonth")) { // 선택된 월 모두 출력
			System.out.println(s + " <-- 선택된 월(lastEmpListNew)"); 
		}
	}

	int currentPage = 1; // 넘어온 값 없을 경우 기본 1페이지 설정
	if (request.getParameter("currentPage") != null && !request.getParameter("currentPage").equals("")) {
		currentPage = Integer.parseInt(request.getParameter("currentPage")); // null값이나 공백값 아니면 넘어온 값 사용
	}
	System.out.println(currentPage + " <-- currentPage(lastEmpListNew)");
	
	// 페이지 당 출력 행 수 
	int rowPerPage = 10;
	// 시작 행 번호
	int startRow = (currentPage - 1) * rowPerPage;
	System.out.println(startRow + " <-- startRow(lastEmpListNew)");
	
	// Model Layer
	// DB 관련 변수 생성 및 호출
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/employees";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(lastEmpListNew)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(lastEmpListNew)");
	
	String sql = "";
	String sql2 = "";
	PreparedStatement stmt = null;
	PreparedStatement stmt2 = null;
	if (intCkMonth != null) { // intCkMonth이 null이 아닐 경우 -> 선택된 월 값이 있을 경우
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate FROM employees WHERE MONTH(hire_date) IN (";
		sql2 = "SELECT COUNT(*) FROM employees WHERE MONTH(hire_date) IN (";
		
		// 배열 길이만큼 쿼리문에 ? 추가
		for (int i = 0; i < intCkMonth.length; i += 1) { 
			if (i == intCkMonth.length - 1) { // 마지막 ?에는 (,) 들어가지 않음
				sql +=  "?";
				sql2 += "?";
			} else {
				sql += "?, "; // 반복되는 동안에는 "?, " 추가
				sql2 += "?, ";
			}
		}
		sql += ") LIMIT ?, ?"; // ex) 2번 반복 종료 후 sq1 = "SELECT * FROM employees MONTH(hire_date) IN(?, ?)"
		sql2 += ")"; // ex) 2번 반복 종료 후 sql2 = "SELECT COUNT(*) FROM employees WHERE";
		stmt = conn.prepareStatement(sql);
		stmt2 = conn.prepareStatement(sql2);
		
		// ?에 값 대입
		for (int i = 0; i < intCkMonth.length; i += 1) {
			stmt.setInt(i + 1, intCkMonth[i]);
			stmt2.setInt(i + 1, intCkMonth[i]);
		}
		stmt.setInt(intCkMonth.length + 1, startRow);
		stmt.setInt(intCkMonth.length + 2, rowPerPage);
	} else {
		// 쿼리 전송
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate FROM employees LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		sql2 = "SELECT COUNT(*) FROM employees";
		stmt2 = conn.prepareStatement(sql2);
	}
		
	// 쿼리문 디버깅
	System.out.println(stmt + " <-- stmt(lastEmpListNew)");
	System.out.println(stmt2 + " <-- stmt2(lastEmpListNew)");
	
	// 쿼리 실행 결과값
	ResultSet rs = stmt.executeQuery();
	ResultSet rs2 = stmt2.executeQuery();

	ArrayList<Employees> empList = new ArrayList<Employees>(); // 자바 1.7 이후에서는 ArrayList<>(); 로 사용 가능
	while (rs.next()) {
		Employees e = new Employees();
		e.empNo = rs.getInt("empNo"); // 숫자로 사용 가능 - 맨 앞 컬럼 내용 사용
		e.birthDate = rs.getString("birthDate");
		e.firstName = rs.getString("firstName");
		e.lastName = rs.getString("lastName");
		e.gender = rs.getString("gender");
		e.hireDate = rs.getString("hireDate");
		empList.add(e);	
	}
	
	// 마지막 페이지
	// SELECT COUNT(*) FROM employees

	int totalRow = 0;
	if (rs2.next()) {
		totalRow = rs2.getInt("count(*)");
	}
	System.out.println(totalRow + " <-- totalRow(lastEmpListNew)");
	
	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	System.out.println(lastPage + " <-- lastpage(lastEmpListNew)");
	
	// 페이지 이동 시 선택된 월 값을 넘기는 문자열
	String check = "";
	if (intCkMonth != null) { // intCkMonth가 null이 아니면 -> 선택된 월이 있으면
		for (int i = 0; i < intCkMonth.length; i += 1) {
			// check += "&ckMonth=" + intCkMonth[i];
			check = check + "&ckMonth=" + intCkMonth[i];
		}
	}
	System.out.println(check + " <-- check(lastEmpListNew)");
	System.out.println(GREEN + "=============================" + RESET_ANSI);
%>

<!-- View Layer -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>lastEmpListNew</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div class="container mt-3 d-flex justify-content-center">
			<h1>사원 목록</h1>
		</div>
		
		<form action="./lastEmpListNew.jsp?" method="get">
			
		<% 
			// 체크 확인용 boolean 배열
			boolean[] checked = {false, false, false, false, false, false, false, false, false, false, false, false};
			int[] months = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
			for (int m : months) {
				if (intCkMonth != null) { // 선택된 월일 경우 true 처리
					for (int i: intCkMonth) {
						if (i == m) {
							checked[i - 1] = true;
						}
					}
				}
				if (checked[m - 1] == true) {
		%>
					<input type="checkbox" name="ckMonth" value="<%=m%>" checked="checked"><%=m%>월
		<%
				} else {
		%>
				 	<input type="checkbox" name="ckMonth" value="<%=m%>"><%=m%>월 <!-- 1월부터 12월까지 체크박스 생성  -->
		<% 		
				}
			}
		%>
			<button type="submit">검색</button>
		</form><br>
		<table class="table table-bordered text-center">
			<tr class="table-success">
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
		

		<div class="text-center">
		<%
			if (currentPage > 1) { // 2페이지부터 이전 버튼 생성
		%>
				<a href="./lastEmpListNew.jsp?currentPage=<%=currentPage - 1%><%=check%>" class="btn btn-success">이전</a>
		<%	
			}
		%>
				<%=currentPage%>페이지
		<%
			if (currentPage < lastPage) { // 마지막 페이지 - 1 페이지까지만 다음 버튼 생성
		%>
				<a href="./lastEmpListNew.jsp?currentPage=<%=currentPage + 1%><%=check%>" class="btn btn-success">다음</a>
		<%
			}
		%>
		</div>
	</body>
</html>