<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%> 
<%
	/* 
	// 계층 쿼리
	select level, lpad('', level - 1)||first_name, manager_id, sys_connect_by_path(first_name, '-')
	from employees
	start with manager_id is null 
	connect by prior employee_id = manager_id;
	*/
	
	// 페이징
	int currentPage = 1; // 기본 1페이지
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// DB 연결
	String driver = "oracle.jdbc.driver.OracleDriver";
	String dbUser = "hr";
	String dbPw = "1234";
	String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(start_with)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(start_with)");
	
	// 출력할 전체 행 수 구하기
	int totalRow = 0;
	String totalRowSql = "SELECT COUNT(*) FROM employees";
	PreparedStatement totalRowStmt = conn.prepareStatement(totalRowSql);
	ResultSet totalRowRs = totalRowStmt.executeQuery();
	if (totalRowRs.next()) {
		totalRow = totalRowRs.getInt(1); // 구하는 행이 한 개이므로 인덱스 사용 가능
	}
	
	// 페이지 당 10개 행씩 출력
	int rowPerPage = 10;
	
	// BETWEEN beginRow AND endRow -> endRow가 전체 행 수(totalRow) 보다 클 수 없음
	// 1페이지: 1 ~ 10, 2페이지: 11 ~ 20, 3페이지: 21 ~ 30, ...
	int beginRow = (currentPage - 1) * rowPerPage + 1;
	int endRow = beginRow + (rowPerPage - 1);
	if (endRow > totalRow) { // 마지막 페이지의 마지막 행 번호가 전체 행 개수보다 클 수 없음
		endRow = totalRow;
	}
	
	// 마지막 페이지
	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	
	// [이전] [다음] 탭 사이 출력할 번호의 개수
	int pagePerPage = 10; 
	
	// minPage: [이전] [다음] 탭 사이 번호 중 최소값 -> 1, 11, 21, ...
	// maxPage: [이전] [다음] 탭 사이 번호 중 최대값 -> 10, 20, 30, ...
	int minPage = ((currentPage - 1) / pagePerPage) * pagePerPage + 1;
	int maxPage = minPage + (pagePerPage - 1);
	if (maxPage > lastPage) { // maxPage가 마지막 페이지보다 클 수 없음 
		maxPage = lastPage;
	}
	
	
	/*
	select 번호, 레벨, 이름, 매니저ID, 경로 from (select rownum 번호, level 레벨, lpad(' ', level-1) || first_name 이름, manager_id 매니저ID, sys_connect_by_path(first_name,'/') 경로 from employees start with manager_id is null connect by prior employee_id = manager_id) where 번호 between ? and ?
	*/
	String sql = "select level, lpad('', level - 1)||first_name, manager_id, sys_connect_by_path(first_name, '-') from employees start with manager_id is null connect by prior employee_id = manager_id;";
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>start_with_connect_by_prior</title>
	</head>
	<body>
		<h1>start with / connect by</h1>
		<table border="1">
			<tr>
				<th>LEVEL</th>
				<th>이름</th>
				<th>사원ID</th>
				<th>PATH</th>
			</tr>
		</table>
	</body>
</html>