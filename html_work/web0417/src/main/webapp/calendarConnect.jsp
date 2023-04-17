<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int targetYear = Integer.parseInt(request.getParameter("targetYear"));
	int targetMonth = Integer.parseInt(request.getParameter("targetMonth"));
	int targetDate = Integer.parseInt(request.getParameter("targetDate"));
%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>ConnectForm</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<form action="./calendar.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth%>" method="post">
			<div class="container">
			<h1>새 일정 입력</h1>
			<h4>
				<%=targetYear%>년 <%=targetMonth + 1%>월 <%=targetDate%>일 일정 
			</h4>
			
			<table border="1">
				<tr>
					<th>새 일정</th>	
				</tr>
				<tr>
					<td><input type="text"></td>	
				</tr>
			</table>
			<button type="sumbit">입력</button>
		</form>
	</body>
</html>