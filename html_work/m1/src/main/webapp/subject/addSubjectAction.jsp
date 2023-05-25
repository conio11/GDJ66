<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>   
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="util.*" %>
<%
	// controller

	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// 입력값 유효성 확인
	// 과목 이름, 시간 값 중 하나라도 null 또는 공백값이 입력되면
	if (request.getParameter("subjectName") == null
	|| request.getParameter("subjectName").equals("")
	|| request.getParameter("subjectTime") == null
	|| request.getParameter("subjectTime").equals("")) {
		response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp");
		return;
	}

	String subjectName = request.getParameter("subjectName");
	int subjectTime = Integer.parseInt(request.getParameter("subjectTime"));
		
	// 디버깅
	System.out.println(subjectName + " <-- subjectName(addSubjectAction)");
	System.out.println(subjectTime + " <-- subjectTime(addSubjectAction)");
	
	// model
	SubjectDao subDao = new SubjectDao();
	
	Subject subject = new Subject();
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);
	
	int row = subDao.insertSubject(subject);
	
	if (row == 1) {
		System.out.println("입력 성공");
		
	} else {
		System.out.println("입력 실패");
	}
	
	// 입력 성공 여부 관계없이 메인 페이지로 이동
	response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp");
	
	System.out.println("=============addSubjectAction=============");
%>