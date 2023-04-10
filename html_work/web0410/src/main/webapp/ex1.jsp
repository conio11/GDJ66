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
	/* 1, 1L
	3.5, 3.5F
	true(false)
	'a' */
	
	// 자바의 기본타입 8가지
	// byte, short, int, long, float, double, boolean, char 
	
	byte a = 1; // 1 byte
	// a = 1000;
	short b = 2; // 2 byte(양수)
	int c = 3;
	long d = 4L;
	float e = 3.1F;
	double f = 3.1;
	boolean g = true;
	boolean h = false;
	char i = '구';
	
	System.out.println(g); // true
	System.out.println(i); // false
	// int, double, boolean
	
	// 문자열 타입과 값
	String s = "구디아카데미";
	System.out.println(s);
	
%>
</body>
</html>