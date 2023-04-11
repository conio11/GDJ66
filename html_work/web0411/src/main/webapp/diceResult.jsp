<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>diceResult</title>
</head>
<body>
<%
	int d1 = 0; // 1 ~ 6 
	int d2 = 0; // 1 ~ 6

	d1 = (int) ((Math.random() * 6)) + 1; // Math.random(); -> 0.000 ~ 0.999 -> 0 ~ 0.9
	d2 = (int) ((Math.random() * 6)) + 1; // 0 ~ 5까지의 값 + 1
	
	int sum = d1 + d2;
%>
	<div>
		<%
			if (d1 == 1) {
		%>
				<img src="./img/1.jpg" width="200" height="200">
		<% 		
			} else if (d1 == 2) {
		%> 
				<img src="./img/2.jpg" width="200" height="200">
		<%	
			} else if (d1 == 3) {
		%>
				<img src="./img/3.jpg" width="200" height="200">
		<%	
			} else if (d1 == 4) {
		%>
				<img src="./img/4.jpg" width="200" height="200">
				
		<%	
			} else if (d1 == 5) {
		%>
		
				<img src="./img/5.jpg" width="200" height="200">
		<%	
			} else {
		%>
				<img src="./img/6.jpg" width="200" height="200">
		<% } %>
				
					
		<%
			if (d2 == 1) {
		%>
				<img src="./img/1.jpg" width="200" height="200">
		<% 		
			} else if (d2 == 2) {
		%> 
				<img src="./img/2.jpg" width="200" height="200">
		<%	
			} else if (d2 == 3) {
		%>
				<img src="./img/3.jpg" width="200" height="200">
		<%	
			} else if (d2 == 4) {
		%>
				<img src="./img/4.jpg" width="200" height="200">
				
		<%	
			} else if (d2 == 5) {
		%>
		
				<img src="./img/5.jpg" width="200" height="200">
		<%	
			} else {
		%>
				<img src="./img/6.jpg" width="200" height="200">
		<% }%>
	</div>
	<div>주사위 결과 : <%=sum%></div>

</body>
</html>