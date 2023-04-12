<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style>
			table, td {
				border-collapse: collapse;
				text-align: center;
			}
		</style>
	</head>
	<body>
	<h1>구구단 (세로)</h1>
		<table border="1">
		<tr>
	<%
			for (int i = 0; i < 10; i = i + 1) { 
				// <tr> 위치 상관없음 
				for (int dan = 2; dan < 10; dan = dan + 1) {
					if (i == 0) {		
	%>
				<td>
					<%=(dan + "단")%>
				</td>
	<%
						} else {
	%>			
				<td>
					<%=dan + " * " + i + " = " + (dan * i)%>
				</td>			
	<% 
				}
			}		
	%>	
			</tr>
	<%
		}
				
	%>				
		</table>
	</body>
</html>
