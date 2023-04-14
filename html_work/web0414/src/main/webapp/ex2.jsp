<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// ArrayList 클래스 (기본 라이브러리 / API)
	// 1) 풀네임 : java.util.ArrayList
	// 2) 자바(1.5 = 15) 제네릭(Generic) 문법 사용
	// 3) 동적 배열의 장점 : 자바 언어가 제공하는 배열은 정적 배열

	// 배열 
	String[] pirate = new String[3]; // 문자열 데이터 3개 X, 문자열 
	// pirate[0] = new String("루피"); // 표현 가능
	pirate[0] = "루피"; // 표현 가능
	pirate[1] = "조로";
	pirate[2] = "나미";
	// pirate[3] = "상디"; // 범위 초과, 정적 배열 error
	System.out.println(pirate.length); // 3
	
	// ArrayList
	ArrayList<String> list = new java.util.ArrayList<String>(3);
	// 제네릭 : 타입을 지정하는 문법, 참조 타입만 사용 가능
	list.add("루피");
	list.add("조로");
	list.add("나미");
	list.add("상디"); // 동적 배열: 메모리 공간이 부족하면 다른 더큰 공간의 메모리영역으로 이동시킴(자동)
	System.out.println(list.size() + " <-- list.size()"); // list.size() : null 값을 제외한 데이터 크기
%>
</body>
</html>