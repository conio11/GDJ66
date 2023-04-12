<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.lang.*"%> <!-- 자동 실행, String 타입 사용 가능 -->   
<%@ page import="gdj66.Person"%> <!-- 패키지명 없이 클래스 사용 가능 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	gdj66.Person kyh;
	kyh	= new gdj66.Person();
	kyh.no = 1;
	kyh.age = 29;
	kyh.married = false;
	
	out.print(kyh); // 참조값 
	
	gdj66.Person ksj;
	ksj = new gdj66.Person();
	ksj.no = 2;
	ksj.age = 30;
	ksj.married = false;
	
	Person p = new Person();
	p.no = 3;
	p.age = 0;
	p.married = false;
%>
	<h2>김영훈</h2>
	<div>번호 : <%=kyh.no%></div>
	<div>나이 : <%=kyh.age%></div>
	<div>결혼 유무 : <%=kyh.married%></div>
	
	<h2>김승준</h2>
	<div>번호 : <%=ksj.no%></div>
	<div>나이 : <%=ksj.age%></div>
	<div>결혼 유무 : <%=ksj.married%></div>
	
</body>
</html>