<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>attribute2</title>
	</head>
	<body>
		<!-- attribute1.jsp의 name 변수 사용 시 컴파일 에러 -->
		<div>페이지 속성 변수 - <%=pageContext.getAttribute("x")%></div> <!-- attribute1.jsp에서만 사용 가능 -->
		<div>세션 속성 변수 - <%=session.getAttribute("y1")%></div>
		<div>세션 속성 변수(RandomNum) - <%=session.getAttribute("y2")%></div>
		<div>어플리케이션 속성 변수 - <%=application.getAttribute("z")%></div>
	</body>
</html>