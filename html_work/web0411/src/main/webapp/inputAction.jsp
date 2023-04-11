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
	// 요청값 (parameter value) 처리
	String x = request.getParameter("x");
	String y = request.getParameter("y");
	String z = x + y;
	
	int a = Integer.parseInt(x);
	int b = Integer.parseInt(y);
	int c = a + b;
%>

<%-- <div>
		<% out.println(z); %>
	</div> --%>

	<div>
		z : <%=z%>
	</div>
		
	<div>
		c : <%=c%>
	</div>

</body>
</html>