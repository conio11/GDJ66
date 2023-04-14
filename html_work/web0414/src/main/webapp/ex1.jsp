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
	// 기본타입 간 형변환 가능 (boolean 제외)
	// 참조타입 간 형변환 가능
	// 기본타입 <-> 참조타입 형변환 불가
	// ex) int x = Integer.parseInt("14"); <-- 형변환 X
	
	// 기본타입 형변환
	int x = 10;
	// double y = (double) x;
	double dx = x; // 데이터 손실 X -> 자동 형변환, 형변환 연산자 생략 가능
	
	double dy = 3.0;
	int y = (int) dy; // 데이터 손실 O -> 자동 형변환 불가, 형변환 연산자 생략 불가(강제 형변환)

	float fz = 3.14F;
	long z = (long) fz; // 자동 형변환 불가 -> 논리적 저장 범위 다름
	// float가 long보다 물리적 크기는 작지만 값을 표현하는 범위가 큼
	// float 값 표현방식에 오차를 허용하는 "부동소수점 방식" 사용하기 때문
%>
</body>
</html>