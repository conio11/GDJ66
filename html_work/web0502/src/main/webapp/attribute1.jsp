<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>attribute1</title>
	</head>
	<body>
	<%
		// 페이지 변수는 다른 페이지에서 호출 불가 -> 컴파일 에러
		String name = "page local variable: gdj66";
		// 페이지 속성 변수는 다른 페이지에서 호출 가능하나 null값으로 호출 (값이 넘어가지 않음)
		pageContext.setAttribute("x", "pageContext: gdj66");	
		
	%>
		<div><%=name%></div> <!-- 다른 페이지에서 호출 불가 -->
		<div>페이지 속성 변수 - <%=pageContext.getAttribute("x")%></div>
	<%
		// 세션 속성 변수
		session.setAttribute("y1", "session: gdj66");
		session.setAttribute("y2", Math.random());
	%>
		<div>세션 속성 변수 - <%=session.getAttribute("y1")%></div>
		<div>세션 속성 변수(Random) - <%=session.getAttribute("y2")%></div>
		
	<%
		// 어플리케이션 속성 변수
		// 모든 사용자에게 공통으로 적용되는 전역 객체
		// 웹 애플리케이션 전체에서 공유해야 하는 정보, 데이터 저장 가능
		application.setAttribute("z", Math.random());
		
	%>
		<div>어플리케이션 속성 변수 - <%=application.getAttribute("z")%></div>
		
		<div><a href="./attribute2.jsp">attribute2</a></div>
	</body>
	<!--
		세션 - 메모리 소모
		중요한 부분은 세션에 포함X
	  -->
</html>