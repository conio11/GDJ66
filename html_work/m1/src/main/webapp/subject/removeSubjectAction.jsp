<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// controller

	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 입력값 유효성 확인
	// 과목 이름, 과목 시수 값 중 하나라도 null 또는 공백값이 입력되면
	String msg = "";
	if (request.getParameter("subjectName") == null
	|| request.getParameter("subjectName").equals("")
	|| request.getParameter("subjectTime") == null
	|| request.getParameter("subjectTime").equals("")) {
		
	}


	// model

%>