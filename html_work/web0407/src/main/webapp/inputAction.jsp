<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>inputAction.jsp</title>
		<style>
			table, th, td {border: 1px solid #343434;}
		</style>
	</head>
	<body>
		<%
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String gender = request.getParameter("gender");
			String country = request.getParameter("country");
			String likeColor = request.getParameter("likeColor");
		%>
		<%-- <div><% out.print(id); %></div> --%>
		<div><%=id%></div> <!-- 변수 id값 출력 -->
		
		<h1>출력</h1>
		<table>	
			<tr>
				<th>아이디</th>
				<%-- <td><input type="text" value="<%=id%>" readonly="readonly"></td> --%>
				<td><%=id%></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" value="<%=pw%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td><%=gender%></td>
			</tr>
			<tr>
				<th>국적</th>
				<td><%=country%></td>
			</tr>
			<tr>
				<th>좋아하는 색상</th>
				<%-- <td><%=likeColor%></td> --%>
				<td>
					<input type="color" value="<%=likeColor%>" disabled="disabled">
				</td>
			</tr>
		</table>
	</body>
</html>