<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>HomeServlet</title>
	</head>
	<body>
		<h1>HomeServlet</h1>
		<%=request.getParameter("id")%><br>
		<%=request.getAttribute("name")%>
	</body>
</html>