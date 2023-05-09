<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="vo.*"%>
<%
	// 필드(속성)가 정보은닉되지 않은 Data 클래스
	Data d = new Data();
	d.x = 7;
	d.y = 10;
	System.out.println(d.x);
	System.out.println(d.y);
	
	Data2 d2 = new Data2();
	d2.x = 27;
	// d2.y = 10; // private 접근 제한자 사용 불가 (y 필드 정보은닉)
	System.out.println(d2.x);
%>