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
	//자바의 주석
	
	// 값, 식, 연산자
	int age = 0; // 변수 대입연산자 값; // 기본 타입에 null 사용 불가
	// int age = 777; // 변수 중복선언 불가
	age = 777; // age 변수 내 0 사라지고 777이 남음 (덮어쓰기)
	age = 10 * 5; // 우측 표현식 먼저 연산 후 age = 50; 실행
	age = 10 / 2;
	age = 10 % 4;
	age = 10 / 3; // 정수 나누기 정수 연산: 정수만 계산
	
	// 실수연산을 하고 싶은 경우
	double x = 10.0 / 3.0;
	
	// System.out.println(); : 콘솔에 출력하는 명령어
	out.println(x); // 웹페이지에 출력하는 명령어
	
	age = 7;
	int limitAge = age; // 우측 변수는 표현식 -> limitAge = 7;
	limitAge = limitAge + 10; // limitAge = 7 + 10;
	
	int y = 1;
	y = y + 1;
	y += 1;
	y++;
	
	boolean f = 3 > 20; // f = false
	out.println(f);
	
	f = (3 > 2) && (10 == 9); // f = true && false -> false
	out.println(f);
			
	f = (3 != 2) || (10 <= 9); // f = true;
	out.println(f);
			
			
	// 메소드 호출코드(식)도 표현식
	double r = Math.random(); // 0.0000 ~ 0.9999 사이의 값 랜덤으로 발생
	out.println(r);
	
	String a = "구디";
	String b = "아카데미";
	String c = a + b; // 문자열 연결 연산자
	out.println(c);
	out.println('가' + '나');
	out.println('A' + 'B'); // 65 + 66 = 131
%>

</body>
</html>