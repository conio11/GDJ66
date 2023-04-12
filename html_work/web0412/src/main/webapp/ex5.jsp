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
	// 조건문 : if / switch
	
	// 값 분기
	int score = 70;

	if (score  == 100) {
		out.print("A");
	} else if (score  == 90){
		out.print("B");
	} else if (score  == 80) {
		out.print("C");
	} else {
		out.print("D");
	}
%>
	<br>
<%
	switch (score) {
	case 100:
		out.print("A");
		break;
	case 90:
		out.print("B");
		break;
	case 80:
		out.print("C");
		break;
	default:
		out.print("D");
	}
%>
	<br>
<%
	// 범위 분기
	int score2 = 96;
	
	if (score2  == 100) {
		out.print("A");
	} else if (score2  >= 90){
		out.print("B");
	} else if (score2  >= 80) {
		out.print("C");
	} else {
		out.print("D");
	}
	
	// switch문으로 범위 분기 구현 어려움
%>
</body>
</html>