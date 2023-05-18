<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%
	// request.getParameter("name");
	// enctype: application/x-www-form-urlencoded인 폼에서 name = name인 문자열값을 받는 API

	System.out.println(request.getParameter("id") + " <-- name");
	System.out.println(request.getParameter("pic") + " <-- pic");
	
	// enctype : multipart/form-data인 form 값을 받으려면?
	InputStream is = request.getInputStream();
	System.out.println(is); // 해시코드값 출력
	
	
	int result = 0;
	while ((result = is.read()) != -1) {
		System.out.print((char)result);
	}
	
	System.out.println("===========================");
%>