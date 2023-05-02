<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>ex1</title>
	</head>
	<body>
		<!-- 웹 어플리케이션 사용자 
			클라이언트(웹 브라우저) -> 서버(웹 서버 or WAS)
			톰캣: 웹 서버, WAS 둘 다 갖고 있음(웹 서비스가 가능하도록 html 단으로 변경)
			세션 - 서버가 사용자를 기억하고 있는 상태 (상태 정보 유지). 클라이언트별로 부여
		  -->
		  ex1.jsp session id: <%=session.getId()%>	<!-- 다른 웹 브라우저에서 주소창 복사 후 실행 시 세션 아이디 다름 -->
	</body>
</html>