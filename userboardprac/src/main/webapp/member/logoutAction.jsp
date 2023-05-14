<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.invalidate(); // 기존 세션 삭제
	response.sendRedirect(request.getContextPath()+ "/home.jsp"); // 로그아웃 후 홈으로 이동
%>
