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
	// 배열 : 동일한 타입 여러 개를 참조하는 참조 타입
	int[] a = null;
	a = new int[3]; // a[0]->0 a[1]->0 a[2]->0
	
	// 배열호출: 참조변수[인덱스]
	a[0] = 7;
	a[1] = 2;
	a[2] = 10;
	// a[3] = 1; // 실행 시 예외(런타임 오류) 발생 -> ArrayIndexOutOfBoundsException (인덱스가 범위 벗어남)
	
	int[] b = new int[3];
	
	int[] c = new int[]{7, 9, 10};
	
	int[] d = {8, 10};
	
	int[] e = null;
	// e = {8, 10}; // 에러
	
	out.print(a.length); // 3 // .length : 배열의 길이
%>
	<br>
<%
	int[] arr = {2, 5, 7, 10}; // length 4
%>
	
	<div>
		<%=arr[0]%>
		<%=arr[1]%>
		<%=arr[2]%>
		<%=arr[3]%>
	</div>
<%
	for (int i = 0; i < arr.length; i += 1) { // 값보다 변수 사용하기(length) 
%>		
		<%=arr[i]%>
<%
	}
%>
	<br>
<%
	// for-each, 값 변경 불가
	// 배열(arr)의 모든 내용 출력
	for (int n : arr) {
%>
		<%=n%>
<%
	}
%>

<%
	// for문: 읽기, 쓰기 가능
	for (int i = 0; i < arr.length; i += 1) { // 값보다 변수 사용하기(length) 
		arr[i] = arr[i] * 10;
	}
%>
</body>
</html>