<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*" %>
    
<% 
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + " <-- currentPage(emloyeeList)");
	
	int rowPerPage = 10;
	if (request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	System.out.println(rowPerPage + " <-- rowPerPage(emloyeeList)");
	
	// LIMIT(beginRow, endRow)
	int beginRow = (currentPage - 1) * rowPerPage + 1; // 
	int endRow = beginRow + (rowPerPage - 1);
	
	int totalCnt = 0;
	
	/* 
	-- rowPerPage = 10;
	currentPage	 beginRow	 endRow
		1	        1     		10
		2			11			20
		3			21			30	
	*/
	
	// Oracle DB 연결
	String driver = "oracle.jdbc.driver.OracleDriver";
	String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbUser = "hr";
	String dbPw = "1234";
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println(conn + " <-- conn(employeesList)");
	
	// 1) 마지막 행 번호(전체 행)를 구하는 쿼리
	String totalCntSql = "SELECT COUNT(*) FROM employees"; // 모든 행의 개수 반환
	PreparedStatement totalCntStmt = conn.prepareStatement(totalCntSql);
	ResultSet totalCntRs = totalCntStmt.executeQuery();
	if (totalCntRs.next()) {
		totalCnt = totalCntRs.getInt(1); // SELECT 반환 컬럼이 하나일 경우 index 사용 권장
	}
	System.out.println(totalCnt + " <-- totalCnt(employeeList)");
	
	
	if (endRow > totalCnt) {
		endRow = totalCnt;
	}
	System.out.println(endRow + " <-- endRow(employeeList)");
	
	int lastPage = totalCnt / rowPerPage;
	if (totalCnt % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}

	System.out.println(lastPage + " <-- lastPage(employeeList)");
	
	// 2) 페이지 리스트
	/*
	select e3.*
	from
	    (select rownum rnum, e2.*
	    from
	        (select 
	            rownum,
	            e1.*
	        from employees e1
	        order by e1.hire_date desc) e2) e3
	where e3.rnum between 11 and 20
	*/

	String employeeListSql = "select e3.* from (select rownum rnum, e2.* from (select rownum, e1.* from employees e1 order by e1.hire_date desc) e2) e3 where e3.rnum between ? and ?";
	PreparedStatement employeeListStmt = conn.prepareStatement(employeeListSql);
	employeeListStmt.setInt(1, beginRow);
	employeeListStmt.setInt(2, endRow);
	ResultSet employeeListRs = employeeListStmt.executeQuery();
	
	ArrayList<Employee> empList = new ArrayList<Employee>();
	while (employeeListRs.next()) {
		Employee e = new Employee();
		e.setEmployeeID(employeeListRs.getInt("employee_id"));
		e.setFirstName(employeeListRs.getString("first_name"));
		e.setLastName(employeeListRs.getString("last_name"));
		e.setEmail(employeeListRs.getString("email"));
		e.setPhoneNumber(employeeListRs.getString("phone_number"));
		e.setHireDate(employeeListRs.getString("hire_date"));
		e.setJobID(employeeListRs.getString("job_id"));
		e.setSalary(employeeListRs.getDouble("salary"));
		e.setCommissionPct(employeeListRs.getDouble("commission_pct"));
		e.setManagerID(employeeListRs.getInt("manager_id"));
		e.setDepartmentID(employeeListRs.getInt("department_id"));
		empList.add(e);
	}
	
	System.out.println("==================================");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>employeeList</title>
	  	<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div class="text-center">
			<h1>employees List</h1>
		</div>
		<br>
		<table class="table table-hover">
			<tr>
				<th>employeeID</th>
				<th>firstName</th>
				<th>lastName</th>
				<th>email</th>
				<th>phoneNumber</th>
				<th>hireDate</th>
				<th>jobID</th>
				<th>salary</th>
				<th>commissionPct</th>
				<th>managerID</th>
				<th>departmentID</th>
			</tr>
		<%
			for (Employee e : empList) {	
		%>
			<tr>
				<td><%=e.getEmployeeID()%></td>
				<td><%=e.getFirstName()%></td>
				<td><%=e.getLastName()%></td>
				<td><%=e.getEmail()%></td>
				<td><%=e.getPhoneNumber()%></td>
				<td><%=e.getHireDate()%></td>
				<td><%=e.getJobID()%></td>
				<td><%=e.getSalary()%></td>
				<td><%=e.getCommissionPct()%></td>
				<td><%=e.getManagerID()%></td>
				<td><%=e.getDepartmentID()%></td>
			</tr>	
		<%
			}
		%>
		</table>
		<div class="text-center">
		<%
			if (currentPage > 1) {
		%>
				<a href="./employeeList.jsp?currentPage=<%=currentPage - 1%>">이전</a>
		<%
			}
		%>
				<%=currentPage%>페이지
		<%
			if (currentPage < lastPage) {
		%>
				<a href="./employeeList.jsp?currentPage=<%=currentPage + 1%>">다음</a>
		<%
			}
		%>
		</div>
		<div>
			<a href="<%=request.getContextPath()%>/employee/addEmployee.jsp" class="btn btn-outline-secondary">새 직원 정보 입력</a>
		</div>
		<!-- 로그인 상태인 경우에만 새 직원 정보 입력 가능 -->
		<!-- 로그인 어케하는지 몰라서 일단 나중에 수정 (if문 안쪽으로 버튼 옮기기)  -->
		<%
			if (session.getAttribute("loginEmployee") != null) {
		%>
				
		<%
			}
		%>
	</body>
</html>