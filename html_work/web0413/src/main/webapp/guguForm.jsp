<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>guguForm.jsp</title>
</head>
<body>
	<form action="./guguAction.jsp" method="post">
	<h1>구구단 요청</h1>
		<div>
			<select name="dan">
				<%
					for (int i = 2; i <= 9; i = i + 1) {	
				%>
					<option value="<%=i%>"><%=i%>단</option>
				<% 
				}
				%>
			</select>
		</div>
		<div>
			<button type="submit">구구단 출력</button>
		</div>
	</form>
</body>
</html>