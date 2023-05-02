<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ex2</title>
</head>
<body>
	ex2.jsp session id: <%=session.getId()%>
	<!-- ex1과 같은 세션 -->
	<!-- 30분(디폴트) 후 다른 세션  -->
	
	<a href="./logout.jsp">로그아웃</a>
	<!-- 로그아웃 링크 클릭 시 ex1.jsp에 새로운 세션 부여  -->
</body>
</html>