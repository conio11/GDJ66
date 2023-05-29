<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.InputStream"%>
<%
	// request.getParameter는 enctype="application/x-www-form-urlencoded" 값을 받는 API
	// request.getParameter는 multipart/form-data를 받을 수 없다.
	// System.out.println(request.getParameter("msg"));

	InputStream is = request.getInputStream(); // 다형성
	System.out.println(is);
	
	int i = 0;
	while((i = is.read()) != -1) { // -1: 입력 스트림의 끝 (더 이상 읽을 데이터가 없음)
		System.out.print((char)i);
	}
	
	System.out.println("==============action2==============");
%>