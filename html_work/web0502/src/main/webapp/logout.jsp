<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 톰캣 서버 on, off 시 세션 새로 부여
	session.invalidate(); // 이전 세션 종료, 새로운 세션 부여
	response.sendRedirect("./ex1.jsp"); // 로그아웃 후 ex1.jsp로 이동
%>