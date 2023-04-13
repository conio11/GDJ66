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
	// swap
	int x = 1;
	int y = 2;
	int temp = 0;
	
	temp = y;
	y = x;
	x = temp;
%>
	<div>x: <%=x%></div>
	<div>y: <%=y%></div>
</body>
</html>