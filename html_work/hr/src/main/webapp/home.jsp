<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 세션 유효성 검사 
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>home</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<!-- 로그인 폼  -->
		<!-- employee_id, first_name, last_name 컬럼을 이용하여 로그인  -->
	<%
		if (session.getAttribute("loginEmployee") == null) { // 세션 id값이 없을 때만 (로그인하지 않았을 때) 로그인 폼 출력
	%>
		
		<h1>로그인</h1>
	<%
			if (request.getParameter("msg") != null) { // 넘어온 msg값 있으면 테이블 위에 출력
	%>
				<%=request.getParameter("msg")%>
	<%
			}
	%>
		<form action="<%=request.getContextPath()%>/employee/loginAction.jsp" method="post">
		<table class="table table-hover">
			<tr>
				<th>employeeID</th>
				<td><input type="text" name="empID"></td>
			</tr>
			<tr>
				<th>firstName</th>
				<td><input type="text" name="empFName"></td>
			</tr>
			<tr>
				<th>lastName</th>
				<td><input type="text" name="empLName"></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-outline-secondary">로그인</button>
		<a href="<%=request.getContextPath()%>/employee/employeeList.jsp" class="btn btn-outline-secondary">비회원으로 사원 정보 조회</a>
		</form>
	<%
		}
	%>
	</body>
</html>