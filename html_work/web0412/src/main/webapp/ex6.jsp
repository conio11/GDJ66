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
	int x = 0; // 다른 부분에서 x값 변경 가능
	while (x < 5) {
		out.println("a");
		x++; // 없을 경우 무한루프
	}
%>
	<br>
<%
	for (int i = 0; i < 5; i = i + 1) { // ++i, i++, i += 1
		out.println("b");
	}
%>
	<br>
<%
	// 1부터 10까지의 합
	int n = 1;
	int sum = 0;
	for (int i = 0; i < 10; i = i + 1) {
		sum = sum + n;
		n = n + 1;
	}
	out.print(sum);
%>
	<br>
<%
	// 1부터 10까지의 합
	int sum2 = 0;
	for (int i = 1; i <= 10; i = i + 1) {
		sum2 += i;
	}
	out.print(sum2);
%>
	<br>
<%
	// 1부터 10까지 짝수의 합
	int sum3 = 0;
	for (int i = 1; i <= 10; i = i + 1) {
		if (i % 2 == 0) {
			sum3 += i;
		}
	}
	out.print(sum3);
%>
	<br>
<%
	// 1부터 10까지 홀수의 합
	int sum4 = 0;
	for (int i = 1; i <= 10; i++) {
		if (i % 2 != 0) {
			sum4 += i;
		}
	}
	out.print(sum4);
%>
</body>
</html>