<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%
	// Controller Layer - 요청값 처리 계층
	
	// 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// <input> 태그 내 동일한 이름을 가진 value 값 전체를 배열 형태로 가져오기
	System.out.println(request.getParameterValues("ckMonth") + " <-- ckMonth(lastEmpListNewprac)");
	String[] ckMonth  = request.getParameterValues("ckMonth"); // 넘어온 월 값을 String 타입 ckMonth 배열에 저장
	
	// int 타입 배열 선언 (ckMonth의 값을 int 타입으로 변환)
	int[] intCkMonth = null;
	if (ckMonth != null) {
		intCkMonth = new int[ckMonth.length]; // int[] 대신 ArrayList<Integer> 사용 가능 // ckMonth의 형태를 int type으로 바꾸기 위한 배열
		for (int i = 0; i < intCkMonth.length; i += 1) { // 배열 길이만큼 반복하며 intCkMonth[i]에 값 대입
			intCkMonth[i] = Integer.parseInt(ckMonth[i]);
		}
	}
		
	// null값은 반복문 실행 불가 --> null값 유무 확인 필요
	if (request.getParameterValues("ckMonth") != null) {
		for (String s : request.getParameterValues("ckMonth")) { // 선택된 월 모두 출력
			System.out.println(s + " <-- 선택된 월(lastEmpListNewprac)");
		}
	}
	
	int currentPage = 1; // 넘어온 값 없을 경우 기본 1페이지로 설정
	if (request.getParameter("currentPage") != null && request.getParameter("currentPage").equals("")) {
		currentPage = Integer.parseInt(request.getParameter("currentPage")); // null값이나 공백값 아니면 넘어온 값 사용
	}
	System.out.println(currentPage + " <-- currentPage(lastEmpListNewprac)");
	
	// 페이지 당 출력 행 수
	int rowPerPage = 10;
	
	// 시작 행 번호 - LIMIT (0, 10), (10, 10), (20, 10), ...
	int startRow = (currentPage - 1) * rowPerPage;
	System.out.println(startRow + " <-- startRow(lastEmpListNewprac)");
	
	// Model Layer
	// DB 관련 변수 생성 및 호출
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/employees";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(lastEmpListNewprac)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(lastEmpListNewprac)");
	
	// sql 변수 2개 동시에 초기화 후 값 설정
	String sql = "";
	String sql2 = ""; 
	PreparedStatement stmt = null;
	PreparedStatement stmt2 = null;
	if (intCkMonth != null) { // 선택된 월 값이 있을 경우
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate FROM employees WHERE MONTH(hire_date) IN (";
		sql2 = "SELECT COUNT(*) FROM employees WHERE MONTH(hire_date) IN (";
		
	
		
		
	} else { // 선택된 월 값이 없을 경우
		sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate FROM employees LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		sql2 = "SELECT COUNT(*) FROM empolyees";
		stmt2 = conn.prepareStatement(sql2);
	}
	
	
	
	
	
	System.out.println("====================");
%>


    
    
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>lastEmpListNewprac</title>
	</head>
	<body>
		<h1>사원 목록</h1>
		<form action="./lastEmpListNewprac.jsp" method="get">
		<%
			// 체크 확인용 boolean 배열
			boolean[] checked = {false, false, false, false, false, false, false, false, false, false, false, false}; 
			int[] months = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
			for (int m : months) { // 12회 반복 (1 ~ 12)
				if (intCkMonth != null) { // intCkMonth에 값이 있는 경우 (선택된 월이 있는 경우) 실헹
					for (int i : intCkMonth) { // 선택된 월 개수만큼 반복
						if (i == m) { // 선택된 월일 경우 true 처리
							ckecked[i - 1] = true; 
						}
					}
					
				}
			}
			if (checked[m - 1] == true) { // 
		%>
				<input type="checkbox" name="ckMonth" value="<%=m%>" checked="checked"><%=m%>월
		<%	
			} else {
		%>
				<input type="checkbox" name="ckMonth" value="<%=m%>"><%=m%>월
		<%
			}
		%>
			<button type="submit">조회</button>
		</form>
		<table>
			<tr>
				<th>empNo</tr>
				<th>birthDate</th>
				<th>firstName</th>
				<th>lastName</th>
				<th>gender</th>
				<th>hiredate</th>
			</tr>
			
		
		</table>
	</body>
</html>