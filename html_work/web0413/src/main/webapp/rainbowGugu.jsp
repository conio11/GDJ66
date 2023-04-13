<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<style>
			table, th, td {
			border: 1px solid #404040;
			}
			table {border-collapse: collapse;}
			.red {background-color: red;}
			.orange {background-color: orange;}
			.yellow {background-color: yellow;}
			.green {background-color: green;}
			.blue {background-color: blue;}
			.navy {background-color: navy;}
			.purple {background-color: purple;}
			.gray {background-color: gray;}
		</style>
		<title>무지개 구구단</title>
	</head>
	<body>
		<h1>구구단</h1>
		<table>
		<% 
			for (int i = 0; i < 10; i = i + 1) {		
		%>
			<tr>
				<%
					for (int dan = 2; dan < 10; dan = dan + 1) {
						String color = null;
						if (dan == 2) {
							color="red";
						} else if (dan == 3) {
							color="orange";
						} else if (dan == 4) {
							color="yellow";
						} else if (dan == 5) {
							color="green ";
						} else if (dan == 6) {
							color="blue";
						} else if (dan == 7) {
							color="navy";
						} else if (dan == 8) {
							color="purple";
						} else if (dan == 9) {
							color="gray";
						}
						
						if (i == 0) {
				%>
							<th class="<%=color%>"><%=dan%>단</th>
				<%
							} else {
				%>		
							<td class="<%=color%>"><%=dan%> * <%=i%> = <%=dan * i%></td>
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