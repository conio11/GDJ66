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
	// 변수 생명주기(variale scope)
	// 1. 변수 선언 후 사용 가능
	// out.print(x); // error
	int x = 1;
	out.println(x);
	
	// 2.자바 언어의 변수 생명주기는 블록({})
	{
		int a = 2;
		a = 7;
		out.println(a);
		
	}
	// a = 10; // error
	
	int b = 3;
	{
		b = 5;
		out.println(b);
		int c = 6;
		{
			out.println(b);
			out.println(c);
			int d = 9;
		}
		// out.print(d); // error
	}
%>
</body>
</html>