<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
 <%
 	int[] ball = new int[45]; // 0, 0, ..., 0
 	// 1 ~ 45 값을 대입
 	for (int i = 0; i < ball.length; i += 1) {
 		ball[i] = i + 1;
 	}
 	
 	// 디버깅 (오류 확인용 코드)
 	// 페이지가 아닌 콘솔에 출력
 	for (int n : ball) {
 		System.out.print(n + " ");
 	}
 	
 	System.out.println(); // 콘솔 줄바꿈
 	
 	// shuffle
 	for (int i = 0; i < 100000; i += 1) {
 		int targetIndex = (int) (Math.random() * 45); // 0 ~ 45
 	 	int temp = ball[0];
 	 	ball[0] = ball[targetIndex];
 	 	ball[targetIndex] = temp;
 	}
 	
 	// 디버깅 (오류 확인용 코드)
	for (int n : ball) {
 		System.out.print(n + " ");
	}
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lotto</title>
</head>
<body>
	<h1>로또번호</h1>
	<%
		for (int i = 0; i < 6; i += 1) {
	%>
			<%=ball[i]%>
	<%	
		}
	%>
</body>
</html>