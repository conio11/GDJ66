<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>gugu3</title>
		<style>
			table, td {
				border-collapse: collapse;'
			}
		
		</style>
	</head>
	<body>
		<h1>구구단 (가로)</h1>
		<table border="1">
			<tr>
				<!-- <td>&nbsp;</td> -->
	<%
		for (int dan = 2; dan < 10; dan = dan + 1) {
			for (int i = 0; i < 10; i = i + 1) {
				if (i == 0) {
					
				
	%>				<td><%=(dan + "단")%></td>
	
	<%
				} else {
	%>
	
				<td><%=(dan + " * " + i + " = " + (dan * i))%></td>	
	<% 			}
			}
			%>
		</tr>
	<%	
		}
	%>		
		</table>
	</body>
</html>