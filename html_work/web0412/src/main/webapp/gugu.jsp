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
	// out.print(2 + " * " + 1); // out.print("2" + " * " + "1");
	out.print(2 + " * " + 1 + " = " + (2 * 1) + " ");
	out.print(2 + " * " + 2 + " = " + (2 * 2) + " ");
	out.print(2 + " * " + 3 + " = " + (2 * 3) + " ");
	out.print(2 + " * " + 4 + " = " + (2 * 4) + " ");
	out.print(2 + " * " + 5 + " = " + (2 * 5) + " ");
	out.print(2 + " * " + 6 + " = " + (2 * 6) + " ");
	out.print(2 + " * " + 7 + " = " + (2 * 7) + " ");
	out.print(2 + " * " + 8 + " = " + (2 * 8) + " ");
	out.print(2 + " * " + 9 + " = " + (2 * 9) + " ");
%>
	<br>
	<h1>구구단 (가로)</h1>
<%
	for (int dan = 2; dan < 10; dan = dan + 1) {
		for (int i = 1; i < 10; i = i + 1) {
			out.print(dan + " * " + i + " = " + (dan * i) + " ");
		}
%>
	<br>
<%	
	}
%>
	<h1>구구단 (세로)</h1>
<%
	for (int i = 1; i < 10; i = i + 1) {
		for (int dan = 2; dan < 10; dan = dan + 1) {
			out.print(dan + " * " + i + " = " + (dan * i) + " ");
		}
%>	
	<br>
<%
	}
%>

</body>
</html>