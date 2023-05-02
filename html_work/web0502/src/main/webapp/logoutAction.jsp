<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.invalidate(); // 세션 종료(무효화)
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp?"); // 로그아웃 후 로그인 화면으로 이동
%>