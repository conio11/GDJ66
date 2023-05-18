<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- multipart 폼 데이터를 처리하기 위해서 기본 API(request) 대신 외부 API를 사용  -->
<!-- 기본 API(request) 사용 시 코드가 복잡해짐 -->
<%@ page import ="com.oreilly.servlet.*"%>
<%@ page import ="com.oreilly.servlet.multipart.*"%>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
	String dir = request.getServletContext().getRealPath("/upload");
	System.out.println(dir);
	
	DefaultFileRenamePolicy po = new DefaultFileRenamePolicy();
	
	MultipartRequest req = new MultipartRequest(request, dir, 1024 * 1024 * 100, "UTF-8", po);
	
%>