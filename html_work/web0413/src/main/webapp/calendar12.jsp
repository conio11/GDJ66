<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>23년 12월</title>
		<style>
			table, th, td {
				border-collapse: collapse;
			}
			table {width: 50%;}
		</style>
	</head>
	<body>
		<h1>2023.12</h1> 
		<table border="1">
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
		
		<table border="1">
			<tr>
			<% 		
				int minDate = 1;
				int maxDate = 31;
		
				for (int i = 0; i < 42; i += 1) {
					if (i % 7 == 0) { // i 값이 7의 배수일 때 줄바꿈		
			%>			
						<tr></tr>
			<% 	
					}
					if ((i - 4) >= minDate && (i - 4) <= maxDate) {
						if (i % 7 == 0 || (i - 4) == 25) { // 일요일 또는 크리스마스 빨간색
			%>				
							<td style="color: #FF0000;"><%=i-4%></td>		
			<%
						} else { 		
			%>				
							<td><%=i-4%></td>
			<%				
						}
					} else { // (i - 4)값이 날짜 범위 초과 
			%>		
						<td>&nbsp;</td>	
			<%
					}
				}
			%>
			<tr>
		</table>
	</body>
</html>