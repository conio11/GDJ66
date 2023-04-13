<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>23년 4월 달력</title>
		<style>
			table, th, td {border: 1px solid gray;}
			table {border-collapse: collapse; width: 90%;}
		</style>
	</head>
	<body>
		<h1>2023.4</h1>
		<table>
			<tr>
				<th>일</th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th>토</th>
			</tr>	
		</table>
		
		<table>
			<tr>
			<%
				int minDate = 1;
				int maxDate = 30;
				
				for (int i = 0; i < 42; i += 1) { // i += 1 -> i = i = 1
					if (i % 7 == 0) {
			%>		
						</tr><tr>
			<% 			
					}
					if ((i - 5) >= minDate && (i - 5) <= maxDate) { 
						if (i % 7 == 0) {
			%>		
						<td style="color: #FF0000;"><%=i - 5%></td>
			<%			
						} else {
			%>			
							<td><%=i-5%></td>
			<%
						}
					} else {
			%>
						<td>&nbsp</td>
			<%	
					} 	
				} 
			%>
			</tr>
		</table>
	</body>
</html>