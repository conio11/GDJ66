<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@page import="good.Student"%>
<%@page import="good.Function"%> --%>
<%@page import="good.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// 클래스: 1) 사용자 정의 데이터 타입 
	Student s = new Student();  // new 연산자: 데이터 저장할 메모리 공간 확보 및 초기화
	s.no = 7;
	s.age = 28;
	s.name = "홍길동";
	s.gender = '남';
%>
	<div><%=s.name%></div>
	
<%
	// 2) 메소드의 컨테이너
	Function f = null;
	f = new Function();
	f.add(1,2); // 변수 없이 사용하면 값 저장되지 않음
	int result = f.add(1,2); // 3
	int k = 7;
	result = f.add(k, 7 / 3); // f.add(7, 2) -> 9
	
	int result2 = Function.minus(5, 2); // static 메소드는 객체 생성 없이 호출 가능
	// result = Function.add(5, 2); // 객체 생성 없이 호출 불가
	
	// JSP 안에 내장된 객체, static 메소드의 예
	Math.random();
	// out.print();
	request.getParameter("");
	
	
	String s1 = new String("abc");
	s1.substring(1, 2); // String 타입 리턴값
%>
</body>
</html>