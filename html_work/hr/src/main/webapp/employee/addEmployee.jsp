<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="vo.*" %>
<%
	// 입력(C/insert): 사원만 입력 가능 -> 세션 있는 경우에(로그인 상태)만 입력 가능(입력 버튼 보임)
	// Employee 클래스 11개 항목 입력
	
	// 인코딩 설정
	response.setCharacterEncoding("UTF-8");
	
	// 세션 유효성 확인 - 세션 없으면(로그인 상태가 아니면) home.jsp로 이동
	// loginAction.jsp 구현 후 주석 해제
/* 	String msg = "";
	if (session.getAttribute("loginEmployee") == null) {
		msg = URLEncoder.encode("잘못된 접근입니다. 로그인 후 이용 가능합니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/home.jsp?msg=" + msg);
		return;
	} */
	
	// loginAction.jsp 구현 후 디버깅 코드 작성
	// int empID = 0;
	// String empFName = "";
	// empFName = (String) session.getAttribute(loginEmployee.getEmployee());
	// String empLName = "";
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addEmployee</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div class="text-center">
			<h1>사원 정보 입력</h1>
		</div>
		<div>
			<h6>employeesID, salary, managerID, departmentID 값은 숫자로 입력해주세요.</h6>
		</div>
	<%
		if (request.getParameter("msg") != null) { // 다른 페이지에서 넘어오는 값이 있을 경우 출력
	%>
			<%=request.getParameter("msg")%>
	<%
		}
	%>
		<form action="<%=request.getContextPath()%>/employee/addEmployeeAction.jsp" method="post">
			<table class="table table-hover">
				<tr>
					<th>employeeID</th>
					<td><input type="text" name="employeeID"></td>
				</tr>
				<tr>
					<th>firstName</th>
					<td><input type="text" name="firstName"></td>
				</tr>
				<tr>
					<th>lastName</th>
					<td><input type="text" name="lastName"></td>
				</tr>
				<tr>
					<th>email</th>
					<td><input type="text" name="email"></td>
				</tr>
				<tr>
					<th>phoneNumber</th>
					<td><input type="text" name="phoneNumber"></td>
				</tr>
				<tr>
					<th>hireDate</th>
					<td><input type="text" name="hireDate"></td>
				</tr>
				<tr>
					<th>jobID</th>
					<td><input type="text" name="jobID"></td>
				</tr>
				<tr>
					<th>salary</th>
					<td><input type="text" name="salary"></td>
				</tr>
				<tr>
					<th>commissionPct</th>
					<td><input type="text" name="commissionPct"></td>
				</tr>
				<tr>
					<th>managerID</th>
					<td><input type="text" name="managerID"></td>
				</tr>
				<tr>
					<th>departmentID</th>
					<td><input type="text" name="departmentID"></td>
				</tr>
			</table>
			<button type="submit" class="btn btn-outline-secondary">사원 정보 등록</button>
		</form>
	</body>
</html>