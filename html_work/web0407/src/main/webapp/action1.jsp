<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String x = request.getParameter("fname");
	String y = request.getParameter("lname");
%>
	<div>
		<%
			out.print(x);
		%> 
	
	</div>
	
	<div>
		<%
			out.print(y);
		%>
	
	</div>
</body>
</html>