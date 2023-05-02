<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인된 상태이면 home.jsp로 이동
	if (session.getAttribute("memberID") != null) {
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return; // 실행 종료
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertMemberForm</title>
	</head>
	<body>
		<h1>회원가입</h1>
		<form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="memberID"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="memberPW"></td>
				</tr>
			</table>
			<button type="submit">회원가입</button>
		</form>
	</body>
</html>