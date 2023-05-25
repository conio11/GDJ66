<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>countSelectTest</title>
	</head>
	<body>
	<%
		EmployeeDao dao = new EmployeeDao();
		int totalRow = dao.selectEmployeeCount();
	%>
		<div><%=totalRow%>명</div>
	</body>
</html>