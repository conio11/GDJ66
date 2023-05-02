<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인하지 않은 사용자만 접근해야 함
	if (session.getAttribute("loginID") != null) { // 현재 사용자 브라우저에서 로그인 발생한 경우 (이미 로그인된 경우)
		response.sendRedirect(request.getContextPath() + "/home.jsp"); // home.jsp 페이지로 이동
		return; // 실행 종료 // return 사용하지 않을 시 else 없으므로 해당 파일 계속 실행 
	}
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>loginForm</title>
	</head>
	<body>
		<h1>로그인 폼</h1>
		<%
			if (request.getParameter("msg") != null) { // msg 값이 있을 경우 (loginAction.jsp에서 로그인 실패했을 경우 / home에서 로그인 정보 없을 경우)
		%>
				<div><%=request.getParameter("msg")%></div>  <!-- 해당 페이지의 msg의 값을 받아옴 -->
		<%
			}
		%>
		<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post"> <!-- 절대 주소로 작성 - "/web0502/loginAction.jsp"  -->
		<table border="1">
			<tr>
				<td>아이디</td>
				<td><input type="text" name="id"></td>
			</tr>
			<tr>
				<td>패스워드</td>
				<td><input type="password" name="pw"></td>
			</tr>
		</table>
		<button type="submit">로그인</button>
		</form>
	</body>
</html>