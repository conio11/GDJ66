<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String pic = null;
	pic = request.getParameter("pic");
	System.out.println(pic);
	
	
	// 한 줄 주석:
	/* 여러 줄 
	주석 */ 
	//  = : 왼쪽 변수에 오른쪽 값을 대입하는 연산자
	// ; (세미콜론) : 명령의 끝
	// 변수 = 값;
	
	// 페이지 간 데이터를 주고받는 방식(GET/POST)
	
	// 액션 JSP에서 한글데이터를 받는 방법
	request.setCharacterEncoding("UTF-8");
	
	String name = null;
	name = request.getParameter("name");
	System.out.println(name);
			
%>

</body>
</html>