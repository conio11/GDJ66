<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>

<%
	// controller
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// update 유효성 관련 내용 추가

	if (request.getParameter("subjectNo") == null
	|| request.getParameter("subjectNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp");
		return;
	}
	
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	String subjectName = request.getParameter("subjectName");
	String subjectTime = request.getParameter("subjectTime");
	
	System.out.println(subjectNo + " <-- subjectNo(modifySubjectAction)");
	System.out.println(subjectName + " <-- subjectName(modifySubjectAction)");
	System.out.println(subjectTime + " <-- subjectTime(modifySubjectAction)");

	// model
	SubjectDao subDao = new SubjectDao();
	
	Subject subject = new Subject();
	subject.setSubjectNo(subjectNo);
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);
	
	String msg = "";
	
	
	System.out.println("=============modifySubjectAction=============");
%>