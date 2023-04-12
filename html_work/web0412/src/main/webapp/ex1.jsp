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
	// 기본타입(8개) : 정수(byte, short, int, long) 실수(float, double), boolean, char
	// 참조타입 : String, 배열, class 등
	 
	String name = new String("김미진"); // 힙 영역
	// String name = "김미진"; // 문자열 상수를 사용하는 방법, 코드 영역
	out.println(name);
	out.println(name.hashCode());
	
	int[] arr = null; // 가리키는 값 없음
	arr = new int[3];
	out.println(arr);
	arr[0] = 7;
	arr[1] = 6;
	arr[2] = 3;
	
%>
	<br>
<%
	out.println(arr[0]); // 7
	out.println(arr[1]); // 6
	out.println(arr[2]); // 3
%>

</body>
</html>