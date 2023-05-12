<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*" %>

<%
	// Oracle DB 연결
	String driver = "oracle.jdbc.driver.OracleDriver";
	String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbUser = "hr";
	String dbPw = "1234";
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println(conn + " <-- conn(employeesList)");

	// 리스트 출력 쿼리문 작성
	// SELECT employee_id employeeID, first_name firstName, last_name lastName, email, phone_number phoneNumber, hire_date hireDate, job_id jobID, salary, commission_pct commissionPct, manager_id managerID, department_id departmentID
	// FROM employees 
	String selectSql = "SELECT employee_id employeeID, first_name firstName, last_name lastName, email, phone_number phoneNumber, hire_date hireDate, job_id jobID, salary, commission_pct commissionPct, manager_id managerID, department_id departmentID FROM employees";
	PreparedStatement selectStmt = conn.prepareStatement(selectSql);
	ResultSet selectRs = selectStmt.executeQuery();
	
	ArrayList<Employees> empList = new ArrayList<Employees>();
	while (selectRs.next()) { 
		Employees e = new Employees();
	}
	
	
%>
    
    
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>employeesLIst</title>
	</head>
	<body>
		
	</body>
</html>